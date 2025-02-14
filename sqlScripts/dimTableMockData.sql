INSERT INTO Bus (BusID, Make, FuelEfficiency) 
VALUES 
    ('B001', 'Volvo 9400', 4.0),
    ('B002', 'Volvo 9400', 4.0),
    ('B003', 'Volvo 9400', 4.0),
    ('B004', 'Volvo 9400', 4.0),
    ('B005', 'Volvo 9400', 4.0),
    ('B006', 'Volvo 9400', 4.0),
    ('B007', 'Volvo 9400', 4.0),
    ('B008', 'Volvo 9400', 4.0),
    ('B009', 'Volvo 9400', 4.0),
    ('B010', 'Volvo 9400', 4.0),
    ('B011', 'Volvo 9400', 4.0),
    ('B012', 'Volvo 9400', 4.0),
    ('B013', 'Volvo 9400', 4.0),
    ('B014', 'Volvo 9400', 4.0),
    ('B015', 'Volvo 9400', 4.0);

INSERT INTO Driver (DriverID, FirstName, LastName)
VALUES 
    ('D001', 'John', 'Doe'),
    ('D002', 'Jane', 'Doe'),
    ('D003', 'Alice', 'Smith'),
    ('D004', 'Bob', 'Smith'),
    ('D005', 'Charlie', 'Brown'),
    ('D006', 'Daisy', 'Brown'),
    ('D007', 'Eve', 'Johnson'),
    ('D008', 'Frank', 'Johnson'),
    ('D009', 'Grace', 'Williams'),
    ('D010', 'Harry', 'Williams'),
    ('D011', 'Ivy', 'Davis'),
    ('D012', 'Jack', 'Davis');

-- Insert 12 routes with distances between 400 km and 500 km
INSERT INTO Route (RouteID, Distance, ExpectedFuelEfficiency) 
VALUES 
    ('R001', 420, 3.8),
    ('R002', 450, 3.8),
    ('R003', 475, 3.8),
    ('R004', 430, 3.8),
    ('R005', 490, 3.8),
    ('R006', 460, 3.8),
    ('R007', 485, 3.8),
    ('R008', 415, 3.8),
    ('R009', 470, 3.8),
    ('R010', 480, 3.8),
    ('R011', 425, 3.8),
    ('R012', 495, 3.8);

    