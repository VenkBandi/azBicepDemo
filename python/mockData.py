import random
import csv,os
from datetime import datetime, timedelta
import json

# Sample data from your inserts
driver_id = ['D001', 'D002', 'D003', 'D004', 'D005', 'D006', 'D007', 'D008', 'D009', 'D010', 'D011', 'D012']
bus_id = ['B001', 'B002', 'B003', 'B004', 'B005', 'B006', 'B007', 'B008', 'B009', 'B010', 'B011', 'B012', 'B013', 'B014', 'B015']
route_id = ['R001', 'R002', 'R003', 'R004', 'R005', 'R006', 'R007', 'R008', 'R009', 'R010', 'R011', 'R012']

file_path = "numbers.txt"

def read_numbers_from_file(file_path):
    """Read numbers from a text file and return them as a list of integers."""
    try:
        with open(file_path, "r") as file:
            numbers = [int(line.strip()) for line in file if line.strip()]
        return numbers
    except FileNotFoundError:
        raise FileNotFoundError(f"File '{file_path}' not found.")
    except ValueError:
        raise ValueError(f"Invalid data in '{file_path}'. Ensure all lines are integers.")

serial_id = read_numbers_from_file(file_path)

# Ensure there are enough buses and routes to allocate
assert len(driver_id) <= len(bus_id), "Not enough buses to allocate!"
assert len(driver_id) <= len(route_id), "Not enough routes to allocate!"

# Randomly shuffle the bus IDs and route IDs
random.shuffle(bus_id)
random.shuffle(route_id)
random.shuffle(serial_id)

allocations = []
for i in range(len(driver_id)):
    allocation = {
        'DriverID': driver_id[i],
        'BusID': bus_id[i],
        'RouteID': route_id[i],
        'serialID': serial_id[i]
    }
    allocations.append(allocation)

# Load the SAS URL from the JSON file
with open("secrets.json", "r") as file:
    config = json.load(file)

currentDate = config["lastDate"]
csv_filename = "mockDriverPerformanceData.csv"

# Create a list to store mock data
mock_data = []
    
# Generating mock data for each allocation
for i in range(len(driver_id)):
    # Create an allocation
    allocation = {
        'serialID': serial_id[i],
        'DriverID': driver_id[i],
        'BusID': bus_id[i],
        'RouteID': route_id[i],
        'ActualFuelEfficiency': random.uniform(3.5, 4.5),  # Random fuel efficiency between 3.5 and 4.5 km/l
        'TripDate': currentDate
        }
    mock_data.append(allocation)

file_exists = os.path.isfile(csv_filename)

with open(csv_filename, mode='a', newline='') as file:
    writer = csv.DictWriter(file, fieldnames=mock_data[0].keys())
    
    # Write the header only if the file does not exist
    if not file_exists:
        writer.writeheader()
    
    for data in mock_data:
        writer.writerow(data)

print(f"Mock data appended to {csv_filename}")