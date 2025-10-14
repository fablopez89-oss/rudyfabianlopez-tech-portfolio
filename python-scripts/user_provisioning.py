# user_provisioning.py
# Creates users and assigns them to groups automatically (Windows AD)

import subprocess

users = [
    {"name": "John Doe", "username": "jdoe", "group": "Support"},
    {"name": "Jane Smith", "username": "jsmith", "group": "IT"},
]

for user in users:
    print(f"Creating user {user['name']}...")
    subprocess.run(["net", "user", user["username"], "Passw0rd!", "/add"])
    subprocess.run(["net", "localgroup", user["group"], user["username"], "/add"])

print("All users created successfully.")
