#!/usr/bin/env python3
import http.server
import socketserver
from urllib.parse import urlparse, parse_qs
import subprocess
import threading
import logging
import json

# Configure logging
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(message)s")

# Configuration constants
PORT = 808          # Port for the instance manager to listen on
PORT_BASE = 7000    # Base port for game instances

class InstanceManager:
    def __init__(self, port_base):
        self.instance_counter = 0
        self.next_port = port_base
        self.processes = []           # List of tuples: (instance_id, port, process)
        self.terminal_outputs = {}    # instance_id -> list of output lines
        self.available_ports = []     # List of ports available for reuse
        self.instance_players = {}    # instance_id -> number of players (max 2)
        self.lock = threading.Lock()  # Thread-safe lock

    def monitor_instance(self, instance_data):
        """Monitor the output of a game instance and handle errors."""
        instance_id, instance_port, process = instance_data
        for line in iter(process.stdout.readline, b""):
            decoded_line = line.decode('utf-8', errors='replace')
            with self.lock:
                self.terminal_outputs.setdefault(instance_id, []).append(decoded_line)
            if "ERROR: Couldn't create an ENet host." in decoded_line:
                logging.error(
                    f"Error detected in instance {instance_id} on port {instance_port}: {decoded_line.strip()}"
                )
                process.terminate()
                process.wait()
                self._cleanup_instance(instance_data)
                break

    def start_new_instance(self):
        """Start a new game instance and return its ID and port."""
        with self.lock:
            self.instance_counter += 1
            instance_id = self.instance_counter
            # Reuse available port if present; otherwise assign next new port.
            if self.available_ports:
                instance_port = self.available_ports.pop(0)
            else:
                instance_port = self.next_port
                self.next_port += 1

        # Build the command to start the game instance
        cmd = [
            '/home/ec2-user/linux/linux.x86_64',
            '--server', '--headless', '--port', str(instance_port)
        ]
        try:
            process = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT
            )
        except Exception as e:
            logging.error(f"Failed to start instance: {e}")
            # Rollback changes
            with self.lock:
                self.instance_counter -= 1
                if instance_port == self.next_port - 1:
                    self.next_port -= 1
                else:
                    self.available_ports.append(instance_port)
            return None, None

        instance_data = (instance_id, instance_port, process)
        with self.lock:
            self.processes.append(instance_data)
            self.terminal_outputs[instance_id] = []
        # Start monitoring the instance in a separate thread
        threading.Thread(target=self.monitor_instance, args=(instance_data,), daemon=True).start()
        logging.info(f"Started instance {instance_id} on port {instance_port}")
        return instance_id, instance_port

    def join_instance(self):
        """Join an instance that is not full (max 2 players)."""
        with self.lock:
            for inst in self.processes:
                inst_id = inst[0]
                # Check if the instance is still running and not full
                if inst[2].poll() is None:
                    current_players = self.instance_players.get(inst_id, 0)
                    if current_players < 2:
                        self.instance_players[inst_id] = current_players + 1
                        logging.info(f"Joining instance {inst_id} as player {self.instance_players[inst_id]}")
                        return inst_id, inst[1]
        # No available instance found; create a new one.
        instance_id, instance_port = self.start_new_instance()
        if instance_id is not None:
            with self.lock:
                self.instance_players[instance_id] = 1
            logging.info(f"Created new instance {instance_id} for first player")
        return instance_id, instance_port

    def _cleanup_instance(self, instance_data):
        """Clean up resources for a terminated instance."""
        instance_id, instance_port, _ = instance_data
        with self.lock:
            if instance_data in self.processes:
                self.processes.remove(instance_data)
            if instance_port not in self.available_ports:
                self.available_ports.append(instance_port)
            if instance_id in self.instance_players:
                del self.instance_players[instance_id]
            logging.info(f"Cleaned up instance {instance_id} and released port {instance_port}")

    def terminate_instance(self, instance_id):
        """Gracefully terminate a specific instance."""
        with self.lock:
            target = next((inst for inst in self.processes if inst[0] == instance_id), None)
        if target:
            _, instance_port, process = target
            if process.poll() is None:
                process.terminate()
                process.wait()
            self._cleanup_instance(target)
            logging.info(f"Terminated instance {instance_id}")
            return True
        logging.warning(f"Instance {instance_id} not found for termination")
        return False

    def kill_instance(self, instance_id):
        """Force kill a specific instance."""
        with self.lock:
            target = next((inst for inst in self.processes if inst[0] == instance_id), None)
        if target:
            _, instance_port, process = target
            if process.poll() is None:
                process.kill()
                process.wait()
            self._cleanup_instance(target)
            logging.info(f"Force killed instance {instance_id}")
            return True
        logging.warning(f"Instance {instance_id} not found for killing")
        return False

    def terminate_all_instances(self):
        """Gracefully terminate all instances."""
        with self.lock:
            current_processes = list(self.processes)
        for inst in current_processes:
            _, _, process = inst
            if process.poll() is None:
                process.terminate()
                process.wait()
            self._cleanup_instance(inst)
        logging.info("Terminated all instances")

    def kill_all_instances(self):
        """Force kill all instances."""
        with self.lock:
            current_processes = list(self.processes)
        for inst in current_processes:
            _, _, process = inst
            if process.poll() is None:
                process.kill()
                process.wait()
            self._cleanup_instance(inst)
        logging.info("Force killed all instances")

    def fetch_used_ports(self):
        """Fetch all used ports on the system."""
        try:
            output = subprocess.check_output("netstat -tuln", shell=True, stderr=subprocess.DEVNULL)
            output = output.decode('utf-8', errors='replace')
            used = set()
            for line in output.splitlines():
                parts = line.split()
                if len(parts) >= 4 and parts[0].startswith("tcp"):
                    addr = parts[3]
                    if ":" in addr:
                        port_str = addr.split(":")[-1]
                        try:
                            used.add(int(port_str))
                        except ValueError:
                            continue
            return sorted(used)
        except subprocess.CalledProcessError:
            return []

    def generate_html_body(self):
        """Generate the dynamic portion (body) of the HTML page."""
        with self.lock:
            if self.processes:
                rows = "\n".join(
                    f"<tr>"
                    f"<td>{inst[0]}</td>"
                    f"<td>{inst[1]}</td>"
                    f"<td>{'running' if inst[2].poll() is None else 'terminated'}</td>"
                    f"<td>{self.instance_players.get(inst[0], 0)} players</td>"
                    f"<td><a href='/terminate?instance={inst[0]}'>Terminate</a></td>"
                    f"<td><a href='/kill?instance={inst[0]}'>Kill</a></td>"
                    f"<td><a href='/view_output?instance={inst[0]}'>View Output</a></td>"
                    f"</tr>"
                    for inst in self.processes
                )
            else:
                rows = "<tr><td colspan='7'>No running instances.</td></tr>"

        body = f"""
  <h1>Instance Manager</h1>
  <p>
    <a href="/start">Start New Instance</a> | 
    <a href="/terminate_all">Terminate All Instances</a> | 
    <a href="/kill_all">Kill All Instances</a> | 
    <a href="/refresh">Refresh</a>
  </p>
  <h2>Running Instances</h2>
  <table border="1" cellpadding="5">
    <tr>
      <th>Instance ID</th>
      <th>Port</th>
      <th>Status</th>
      <th>Players</th>
      <th>Terminate</th>
      <th>Kill</th>
      <th>View Output</th>
    </tr>
    {rows}
  </table>
  <p>
    <a href="/available_ports">View Available Ports</a> | 
    <a href="/used_ports">View Used Ports (System)</a>
  </p>
  <p><strong>Note:</strong> To force kill instances or free ports owned by other processes, run this program with sudo.</p>
        """
        return body

    def generate_html(self):
        """Generate the full HTML page with JavaScript polling."""
        body = self.generate_html_body()
        html = f"""<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Instance Manager</title>
  <script>
    function refreshContent() {{
      fetch('/refresh')
        .then(response => response.text())
        .then(html => {{
          document.getElementById('content').innerHTML = html;
        }})
        .catch(err => console.error('Error refreshing content:', err));
    }}
    setInterval(refreshContent, 5000);
  </script>
</head>
<body>
  <div id="content">
    {body}
  </div>
</body>
</html>"""
        return html

# Create a global instance manager
instance_manager = InstanceManager(PORT_BASE)

class MyRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        parsed = urlparse(self.path)
        # Normalize path by removing trailing slashes, except for the root
        path = parsed.path.rstrip("/")
        if not path:
            path = "/"
        query = parse_qs(parsed.query)
        
        logging.info(f"Received request for path: {path}")
        
        if path == "/api/start":
            instance_id, instance_port = instance_manager.start_new_instance()
            if instance_id is None:
                self.send_response(500)
                self.send_header("Content-Type", "application/json")
                self.end_headers()
                self.wfile.write(json.dumps({"error": "Failed to start instance"}).encode())
            else:
                self.send_response(200)
                self.send_header("Content-Type", "application/json")
                self.end_headers()
                response = json.dumps({
                    "instance_id": instance_id,
                    "port": instance_port
                })
                self.wfile.write(response.encode())
        
        elif path == "/api/join":
            instance_id, instance_port = instance_manager.join_instance()
            if instance_id is None:
                self.send_response(500)
                self.send_header("Content-Type", "application/json")
                self.end_headers()
                self.wfile.write(json.dumps({"error": "Failed to join instance"}).encode())
            else:
                self.send_response(200)
                self.send_header("Content-Type", "application/json")
                self.end_headers()
                response = json.dumps({
                    "instance_id": instance_id,
                    "port": instance_port
                })
                self.wfile.write(response.encode())
        
        elif path == "/refresh":
            # Return only the dynamic HTML body for AJAX polling
            body = instance_manager.generate_html_body()
            self.send_response(200)
            self.send_header("Content-Type", "text/html")
            self.end_headers()
            self.wfile.write(body.encode('utf-8'))
        
        elif path == "/":
            # Return the full HTML page
            html = instance_manager.generate_html()
            self.send_response(200)
            self.send_header("Content-Type", "text/html")
            self.end_headers()
            self.wfile.write(html.encode('utf-8'))
        
        elif path == "/start":
            instance_manager.start_new_instance()
            self.send_response(302)
            self.send_header("Location", "/")
            self.end_headers()
        
        elif path == "/terminate":
            try:
                inst_id = int(query.get("instance", [0])[0])
                instance_manager.terminate_instance(inst_id)
            except ValueError:
                logging.error("Invalid instance id for termination.")
            self.send_response(302)
            self.send_header("Location", "/")
            self.end_headers()
        
        elif path == "/kill":
            try:
                inst_id = int(query.get("instance", [0])[0])
                instance_manager.kill_instance(inst_id)
            except ValueError:
                logging.error("Invalid instance id for kill.")
            self.send_response(302)
            self.send_header("Location", "/")
            self.end_headers()
        
        elif path == "/terminate_all":
            instance_manager.terminate_all_instances()
            self.send_response(302)
            self.send_header("Location", "/")
            self.end_headers()
        
        elif path == "/kill_all":
            instance_manager.kill_all_instances()
            self.send_response(302)
            self.send_header("Location", "/")
            self.end_headers()
        
        elif path == "/view_output":
            try:
                inst_id = int(query.get("instance", [0])[0])
            except ValueError:
                inst_id = 0
            with instance_manager.lock:
                output_lines = instance_manager.terminal_outputs.get(inst_id, [])
            log_html = "<br>".join(output_lines) if output_lines else "No output available."
            html = f"""<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Terminal Output for Instance {inst_id}</title>
</head>
<body>
  <h1>Terminal Output for Instance {inst_id}</h1>
  <pre>{log_html}</pre>
  <p><a href="/">Back</a></p>
</body>
</html>"""
            self.send_response(200)
            self.send_header("Content-Type", "text/html")
            self.end_headers()
            self.wfile.write(html.encode('utf-8'))
        
        elif path == "/available_ports":
            with instance_manager.lock:
                ports = sorted(instance_manager.available_ports)
            html = f"""<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Available Ports</title>
</head>
<body>
  <h1>Available Ports</h1>
  <p>{ports if ports else "No available ports."}</p>
  <p><a href="/">Back</a></p>
</body>
</html>"""
            self.send_response(200)
            self.send_header("Content-Type", "text/html")
            self.end_headers()
            self.wfile.write(html.encode('utf-8'))
        
        elif path == "/used_ports":
            used = instance_manager.fetch_used_ports()
            html = f"""<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Used Ports</title>
</head>
<body>
  <h1>Used Ports (System)</h1>
  <p>{used if used else "No used ports found."}</p>
  <p><a href="/">Back</a></p>
</body>
</html>"""
            self.send_response(200)
            self.send_header("Content-Type", "text/html")
            self.end_headers()
            self.wfile.write(html.encode('utf-8'))
        
        else:
            self.send_error(404, "Not Found")

if __name__ == "__main__":
    try:
        with socketserver.TCPServer(("", PORT), MyRequestHandler) as httpd:
            logging.info(f"Server running at http://localhost:{PORT}")
            httpd.serve_forever()
    except KeyboardInterrupt:
        logging.info("KeyboardInterrupt received, shutting down.")
        instance_manager.terminate_all_instances()
        httpd.server_close()
        logging.info("Server stopped.")
