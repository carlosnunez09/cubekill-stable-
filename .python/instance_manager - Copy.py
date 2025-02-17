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
PORT = 808
PORT_BASE = 7000

class InstanceManager:
    def __init__(self, port_base):
        self.instance_counter = 0
        self.next_port = port_base
        self.processes = []  # (instance_id, port, process, active_players)
        self.terminal_outputs = {}
        self.available_ports = []
        self.lock = threading.Lock()

    def monitor_instance(self, instance_data):
        instance_id, instance_port, process, _ = instance_data
        for line in iter(process.stdout.readline, b""):
            decoded_line = line.decode('utf-8', errors='replace')
            with self.lock:
                self.terminal_outputs.setdefault(instance_id, []).append(decoded_line)
            if "ERROR: Couldn't create an ENet host." in decoded_line:
                logging.error(f"Error in instance {instance_id}: {decoded_line.strip()}")
                process.terminate()
                process.wait()
                self._cleanup_instance(instance_data)
                break

    def start_new_instance(self):
        with self.lock:
            self.instance_counter += 1
            instance_id = self.instance_counter
            if self.available_ports:
                instance_port = self.available_ports.pop(0)
            else:
                instance_port = self.next_port
                self.next_port += 1

        cmd = [
            '/mnt/c/Users/carlo/Desktop/cubekill-stable--main/export/linux/linux.x86_64',
            '--server', '--headless', '--port', str(instance_port)
        ]
        try:
            process = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        except Exception as e:
            logging.error(f"Start failed: {e}")
            with self.lock:
                self.instance_counter -= 1
                if instance_port == self.next_port - 1:
                    self.next_port -= 1
                else:
                    self.available_ports.append(instance_port)
            return None, None

        instance_data = (instance_id, instance_port, process, 0)
        with self.lock:
            self.processes.append(instance_data)
            self.terminal_outputs[instance_id] = []
        
        threading.Thread(target=self.monitor_instance, args=(instance_data,), daemon=True).start()
        logging.info(f"Started instance {instance_id} on port {instance_port}")
        return instance_id, instance_port

    def get_available_lobby(self):
        with self.lock:
            for inst in self.processes:
                iid, port, proc, players = inst
                if players < 2:
                    self.processes[self.processes.index(inst)] = (iid, port, proc, players + 1)
                    return iid, port
            return self.start_new_instance()

    def player_disconnected(self, instance_id):
        with self.lock:
            for inst in self.processes:
                if inst[0] == instance_id:
                    iid, port, proc, players = inst
                    self.processes[self.processes.index(inst)] = (iid, port, proc, max(0, players - 1))
                    break

    def _cleanup_instance(self, instance_data):
        iid, port, _, _ = instance_data
        with self.lock:
            if instance_data in self.processes:
                self.processes.remove(instance_data)
            if port not in self.available_ports:
                self.available_ports.append(port)
            logging.info(f"Cleaned up instance {iid}")

    def terminate_instance(self, instance_id):
        with self.lock:
            target = next((inst for inst in self.processes if inst[0] == instance_id), None)
        if target:
            _, port, process, _ = target
            if process.poll() is None:
                process.terminate()
                process.wait()
            self._cleanup_instance(target)
            return True
        return False

    def kill_instance(self, instance_id):
        with self.lock:
            target = next((inst for inst in self.processes if inst[0] == instance_id), None)
        if target:
            _, port, process, _ = target
            if process.poll() is None:
                process.kill()
                process.wait()
            self._cleanup_instance(target)
            return True
        return False

    def terminate_all_instances(self):
        with self.lock:
            current_processes = list(self.processes)
        for inst in current_processes:
            self.terminate_instance(inst[0])

    def kill_all_instances(self):
        with self.lock:
            current_processes = list(self.processes)
        for inst in current_processes:
            self.kill_instance(inst[0])

    def fetch_used_ports(self):
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

    def generate_html(self):
        with self.lock:
            if self.processes:
                rows = "\n".join(
                    f"<tr>"
                    f"<td>{inst[0]}</td>"
                    f"<td>{inst[1]}</td>"
                    f"<td>{'running' if inst[2].poll() is None else 'stopped'}</td>"
                    f"<td>{inst[3]}</td>"
                    f"<td><a href='/terminate?instance={inst[0]}'>Terminate</a></td>"
                    f"<td><a href='/kill?instance={inst[0]}'>Kill</a></td>"
                    f"<td><a href='/view_output?instance={inst[0]}'>View Output</a></td>"
                    f"</tr>"
                    for inst in self.processes
                )
            else:
                rows = "<tr><td colspan='7'>No running instances</td></tr>"

        return f"""<!DOCTYPE html>
<html>
<head>
  <title>Instance Manager</title>
  <meta charset="UTF-8">
  <style>
    table {{ border-collapse: collapse; margin: 20px 0; }}
    td, th {{ border: 1px solid #ddd; padding: 8px; }}
    tr:nth-child(even){{background-color: #f2f2f2;}}
  </style>
</head>
<body>
  <h1>Game Instance Manager</h1>
  <p>
    <a href="/start">Start New Instance</a> | 
    <a href="/terminate_all">Terminate All</a> | 
    <a href="/kill_all">Kill All</a> | 
    <a href="/refresh">Refresh</a>
  </p>
  <table>
    <tr>
      <th>ID</th><th>Port</th><th>Status</th><th>Players</th>
      <th colspan="3">Actions</th>
    </tr>
    {rows}
  </table>
  <p>
    <a href="/available_ports">Available Ports</a> | 
    <a href="/used_ports">System Used Ports</a>
  </p>
</body>
</html>"""

instance_manager = InstanceManager(PORT_BASE)

class RequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        parsed = urlparse(self.path)
        path = parsed.path
        query = parse_qs(parsed.query)
        
        # API Endpoints
        if path == "/api/start":
            self.handle_api_start()
        elif path == "/api/disconnect":
            self.handle_api_disconnect(query)
        
        # Web UI Endpoints
        elif path in ["/", "/refresh"]:
            self.handle_root()
        elif path == "/start":
            self.handle_start()
        elif path == "/terminate":
            self.handle_terminate(query)
        elif path == "/kill":
            self.handle_kill(query)
        elif path == "/terminate_all":
            self.handle_terminate_all()
        elif path == "/kill_all":
            self.handle_kill_all()
        elif path == "/view_output":
            self.handle_view_output(query)
        elif path == "/available_ports":
            self.handle_available_ports()
        elif path == "/used_ports":
            self.handle_used_ports()
        else:
            self.send_error(404, "Not Found")

    # API Handlers
    def handle_api_start(self):
        iid, port = instance_manager.get_available_lobby()
        if iid is None:
            self.send_response(500)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(json.dumps({"error": "Failed to start instance"}).encode())
        else:
            self.send_json_response({"instance_id": iid, "port": port})

    def handle_api_disconnect(self, query):
        try:
            iid = int(query.get("instance", [0])[0])
            instance_manager.player_disconnected(iid)
            self.send_json_response({"status": "success"})
        except:
            self.send_error(400, "Invalid instance ID")

    # Web UI Handlers
    def handle_root(self):
        html = instance_manager.generate_html()
        self.send_html_response(html)

    def handle_start(self):
        instance_manager.start_new_instance()
        self.redirect_to_root()

    def handle_terminate(self, query):
        try:
            iid = int(query.get("instance", [0])[0])
            instance_manager.terminate_instance(iid)
        except ValueError:
            logging.error("Invalid termination request")
        self.redirect_to_root()

    def handle_kill(self, query):
        try:
            iid = int(query.get("instance", [0])[0])
            instance_manager.kill_instance(iid)
        except ValueError:
            logging.error("Invalid kill request")
        self.redirect_to_root()

    def handle_terminate_all(self):
        instance_manager.terminate_all_instances()
        self.redirect_to_root()

    def handle_kill_all(self):
        instance_manager.kill_all_instances()
        self.redirect_to_root()

    def handle_view_output(self, query):
        try:
            iid = int(query.get("instance", [0])[0])
            with instance_manager.lock:
                output = instance_manager.terminal_outputs.get(iid, [])
            html = f"""<html><body>
                <h1>Instance {iid} Output</h1>
                <pre>{''.join(output)}</pre>
                <a href="/">Back</a>
            </body></html>"""
            self.send_html_response(html)
        except ValueError:
            self.send_error(400, "Invalid instance ID")

    def handle_available_ports(self):
        with instance_manager.lock:
            ports = sorted(instance_manager.available_ports)
        self.send_html_response(f"""
            <html><body>
                <h1>Available Ports</h1>
                <p>{ports or 'None'}</p>
                <a href="/">Back</a>
            </body></html>
        """)

    def handle_used_ports(self):
        ports = instance_manager.fetch_used_ports()
        self.send_html_response(f"""
            <html><body>
                <h1>System Used Ports</h1>
                <p>{ports or 'Failed to fetch'}</p>
                <a href="/">Back</a>
            </body></html>
        """)

    # Helper methods
    def send_json_response(self, data):
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(json.dumps(data).encode())

    def send_html_response(self, content):
        self.send_response(200)
        self.send_header("Content-Type", "text/html")
        self.end_headers()
        self.wfile.write(content.encode())

    def redirect_to_root(self):
        self.send_response(302)
        self.send_header("Location", "/")
        self.end_headers()

if __name__ == "__main__":
    try:
        with socketserver.TCPServer(("", PORT), RequestHandler) as httpd:
            logging.info(f"Instance manager running on port {PORT}")
            httpd.serve_forever()
    except KeyboardInterrupt:
        logging.info("Shutting down...")
        instance_manager.terminate_all_instances()