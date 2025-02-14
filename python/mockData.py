import random
import csv
from datetime import datetime, timedelta
import json

# Sample data from your inserts
driver_ids = ['D001', 'D002', 'D003', 'D004', 'D005', 'D006', 'D007', 'D008', 'D009', 'D010', 'D011', 'D012']
bus_ids = ['B001', 'B002', 'B003', 'B004', 'B005', 'B006', 'B007', 'B008', 'B009', 'B010', 'B011', 'B012', 'B013', 'B014', 'B015']
route_ids = ['R001', 'R002', 'R003', 'R004', 'R005', 'R006', 'R007', 'R008', 'R009', 'R010', 'R011', 'R012']

# Load the SAS URL from the JSON file
with open("secrets.json", "r") as file:
    config = json.load(file)

currentDate = config["lastDate"]
csv_filename = "mock_performance_data.csv"

# Function to generate mock performance data
def generate_mock_data(currentDate):
    performance_data = []
    
    for driver_id in driver_ids:
        # Randomly allocate a bus and route for each driver
        bus_id = random.choice(bus_ids)
        route_id = random.choice(route_ids)
        
        # Generate a random fuel efficiency between 3.2 and 4
        fuel_efficiency = round(random.uniform(3.2, 4.0), 2)
        
        # Create the record with today's date
        performance_data.append([driver_id, route_id, bus_id, fuel_efficiency, currentDate])
    
    return performance_data

data = generate_mock_data(currentDate)

# Write the data to a CSV file
with open(csv_filename, mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["DriverID", "RouteID", "BusID", "ActualFuelEfficiency", "TripDate"])  # Header
    writer.writerows(data)

print(f"Mock data written to {csv_filename}")