CREATE TABLE Bus (
    BusID CHAR(4) PRIMARY KEY,
    Make VARCHAR(50) NOT NULL,
    FuelEfficiency FLOAT DEFAULT 4.0  -- Default efficiency: 4 km/l
);

CREATE TABLE Driver (
    DriverID  CHAR(4) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL
);

CREATE TABLE Route (
    RouteID CHAR(4) PRIMARY KEY,
    Distance FLOAT NOT NULL, -- Distance in km
    ExpectedFuelEfficiency FLOAT DEFAULT 3.8  -- Expected efficiency: 3.8 km/l
);

CREATE TABLE Performance (
    PerformanceID INT IDENTITY(1,1) PRIMARY KEY, -- Corrected syntax for auto-increment
    DriverID CHAR(4) NOT NULL,
    RouteID CHAR(4) NOT NULL,
    BusID CHAR(4) NOT NULL,
    ActualFuelEfficiency FLOAT NOT NULL, -- Actual fuel efficiency from file
    TripDate DATE NOT NULL DEFAULT GETDATE(), -- Uses GETDATE() instead of CURDATE()
    FOREIGN KEY (DriverID) REFERENCES Driver(DriverID),
    FOREIGN KEY (RouteID) REFERENCES Route(RouteID),
    FOREIGN KEY (BusID) REFERENCES Bus(BusID),
);