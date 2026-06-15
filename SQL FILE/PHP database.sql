/* =========================
   PPP FULL DATABASE SCRIPT
   SINGLE RUN FILE
   ========================= */

-- CREATE DATABASE (optional)
CREATE DATABASE PPP_DB;
GO

USE PPP_DB;
GO

/* =========================
   1. TABLES
   ========================= */

CREATE TABLE Guest (
    GuestID VARCHAR(10) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Address VARCHAR(255),
    Phone VARCHAR(20),
    PassportNumber VARCHAR(20),
    HealthInfo TEXT
);

CREATE TABLE Party (
    PartyID VARCHAR(15) PRIMARY KEY,
    OrganiserID VARCHAR(10),
    CoordinatorID VARCHAR(10),
    StartDate DATE,
    Nights INT,
    BrideGroomContribution BIT
);

CREATE TABLE Supplier (
    SupplierID VARCHAR(10) PRIMARY KEY,
    SupplierName VARCHAR(100),
    SupplierType VARCHAR(50),
    ContactDetails VARCHAR(255)
);

CREATE TABLE Activity (
    ActivityID VARCHAR(10) PRIMARY KEY,
    SupplierID VARCHAR(10),
    ActivityName VARCHAR(100),
    BaseCost DECIMAL(6,2),
    Restrictions TEXT,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE ActivityType (
    ActivityTypeID VARCHAR(10) PRIMARY KEY,
    TypeName VARCHAR(50)
);

CREATE TABLE ActivityActivityType (
    ActivityID VARCHAR(10),
    ActivityTypeID VARCHAR(10),
    PRIMARY KEY (ActivityID, ActivityTypeID),
    FOREIGN KEY (ActivityID) REFERENCES Activity(ActivityID),
    FOREIGN KEY (ActivityTypeID) REFERENCES ActivityType(ActivityTypeID)
);

CREATE TABLE GuestActivity (
    GuestID VARCHAR(10),
    ActivityID VARCHAR(10),
    PartyID VARCHAR(15),
    ActivityDate DATETIME,
    Cost DECIMAL(6,2),
    PRIMARY KEY (GuestID, ActivityID, PartyID),
    FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
    FOREIGN KEY (ActivityID) REFERENCES Activity(ActivityID),
    FOREIGN KEY (PartyID) REFERENCES Party(PartyID)
);

CREATE TABLE Payment (
    PaymentID INT IDENTITY PRIMARY KEY,
    GuestID VARCHAR(10),
    PartyID VARCHAR(15),
    Amount DECIMAL(8,2),
    PaymentDate DATE,
    Paid BIT,
    FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
    FOREIGN KEY (PartyID) REFERENCES Party(PartyID)
);

GO

/* =========================
   2. SAMPLE DATA
   ========================= */

INSERT INTO Guest VALUES
('G001','John','Smith','London','0711111111','P12345','None'),
('G002','Emma','Brown','Bristol','0722222222','P23456','Nut allergy'),
('G003','Liam','Jones','Manchester','0733333333','P34567','Asthma');

INSERT INTO Party VALUES
('P2026-01','G001','C001','2026-06-20',2,1);

INSERT INTO Supplier VALUES
('S001','Adventure Co','Activity','contact@adventure.co.uk');

INSERT INTO Activity VALUES
('A001','S001','Kayaking',50.00,'Age 18+');

INSERT INTO ActivityType VALUES
('T001','Adventure');

INSERT INTO ActivityActivityType VALUES
('A001','T001');

INSERT INTO GuestActivity VALUES
('G001','A001','P2026-01','2026-06-21',50.00);

INSERT INTO Payment VALUES
('G001','P2026-01',50.00,'2026-06-10',1);

GO

/* =========================
   3. QUERIES
   ========================= */

-- ALL GUESTS
SELECT * FROM Guest;

-- ACTIVITY TYPES
SELECT A.ActivityName, T.TypeName
FROM Activity A
JOIN ActivityActivityType AT ON A.ActivityID = AT.ActivityID
JOIN ActivityType T ON AT.ActivityTypeID = T.ActivityTypeID;

-- DELETE BOOKING
DELETE FROM GuestActivity
WHERE GuestID = 'G001' AND ActivityID = 'A001';

-- PARTY DETAILS
SELECT G.FirstName, G.LastName, A.ActivityName
FROM GuestActivity GA
JOIN Guest G ON GA.GuestID = G.GuestID
JOIN Activity A ON GA.ActivityID = A.ActivityID
WHERE GA.PartyID = 'P2026-01';

-- OUTSTANDING PAYMENTS
SELECT * FROM Payment
WHERE Paid = 0;

-- AVERAGE SPEND
SELECT AVG(Amount) AS AvgSpend FROM Payment;

GO

/* =========================
   4. STORED PROCEDURE
   ========================= */

CREATE PROCEDURE GetPartyTotal
@PartyID VARCHAR(15)
AS
BEGIN
    SELECT PartyID, SUM(Amount) AS Total
    FROM Payment
    WHERE PartyID = @PartyID
    GROUP BY PartyID;
END;

GO

/* =========================
   5. TRIGGER
   ========================= */

CREATE TRIGGER PreventDuplicateBooking
ON GuestActivity
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM GuestActivity GA
        JOIN inserted I
        ON GA.GuestID = I.GuestID
        AND GA.ActivityID = I.ActivityID
        AND GA.PartyID = I.PartyID
    )
    BEGIN
        RAISERROR('Duplicate booking not allowed',16,1);
    END
    ELSE
    BEGIN
        INSERT INTO GuestActivity
        SELECT * FROM inserted;
    END
END;

GO

/* =========================
   6. VIEW
   ========================= */

CREATE VIEW CoordinatorOverview AS
SELECT 
    P.PartyID,
    COUNT(DISTINCT GA.GuestID) AS TotalGuests,
    SUM(GA.Cost) AS TotalRevenue
FROM Party P
JOIN GuestActivity GA ON P.PartyID = GA.PartyID
GROUP BY P.PartyID;

GO

/* =========================
   DONE
   ========================= */