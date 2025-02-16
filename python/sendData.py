from azure.storage.blob import BlobServiceClient
import json
import os
csv_filename = "mockDriverPerformanceData.csv"

# Load the SAS URL from the JSON file
with open("secrets.json", "r") as file:
    config = json.load(file)

sas_url = config["sas_urlLanding"]

blob_service_client = BlobServiceClient(account_url=sas_url)

# Define the container and blob name
container_name = "rawdata"
blob_name = csv_filename

# Upload the CSV file to Azure Blob Storage using SAS URL
try:
    # Get the blob client
    blob_client = blob_service_client.get_blob_client(container=container_name, blob=blob_name)

    # Upload the data from the file
    with open(csv_filename, "rb") as data_file:
        blob_client.upload_blob(data_file, overwrite=True)

    print(f"Successfully uploaded '{blob_name}' to container '{container_name}'.")

except Exception as e:
    print(f"Error: {e}")