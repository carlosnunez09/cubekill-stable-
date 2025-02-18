import requests
import uuid

def test_dispatch():
    # Request to join an instance from the instance manager
    try:
        response = requests.get("http://localhost:808/api/join")
        if response.status_code == 200:
            data = response.json()
            lobby_id = str(uuid.uuid4())  # Generate a unique lobby ID
            print("Successfully joined lobby:")
            print("Lobby ID:", lobby_id)
            print("Instance Port:", data['port'])
            print("Instance ID:", data['instance_id'])
        else:
            print("Failed to join instance. Status code:", response.status_code)
    except requests.ConnectionError:
        print("Could not connect to instance manager. Is it running on port 808?")

if __name__ == "__main__":
    test_dispatch()
