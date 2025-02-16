from azure.storage.blob import ContainerClient
import json

# Load the SAS URL from the JSON file
with open("secrets.json", "r") as file:
    config = json.load(file)

sas_url = config["sas_urlStaging"]  # SAS URL for your container
# Create the ContainerClient using the SAS URL
container_client = ContainerClient.from_container_url(sas_url)

# List all blobs in the container
blobs = container_client.list_blobs()

# Iterate over all blobs and delete them
for blob in blobs:
    try:
        print(f"Deleting blob: {blob.name}")
        container_client.delete_blob(blob.name)
    except Exception as e:
        print(f"Error deleting blob {blob.name}: {e}")

print("All blobs deleted successfully.")
