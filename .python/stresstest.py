import subprocess
import time

while True:
    # Execute the command to run test_dispatch.py with Python
    subprocess.run(["python3", "test_dispatch.py"])
    time.sleep(0.1)