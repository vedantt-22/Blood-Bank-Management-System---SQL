-- Create a new database for the blood bank
CREATE DATABASE BLOOD_BANK;

-- Drop the database if it already exists (cleaning up)
DROP DATABASE BLOOD_BANK;

-- Clean up by dropping child tables first to avoid foreign key conflicts
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS Nurse;
DROP TABLE IF EXISTS Hospital;
DROP TABLE IF EXISTS Blood;
DROP TABLE IF EXISTS Donerphone;
DROP TABLE IF EXISTS Receivephone;
DROP TABLE IF EXISTS Receiver;
DROP TABLE IF EXISTS Doner;
DROP TABLE IF EXISTS Blood_Bank;
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS Users;


-- Create the Doner table to store donor details
CREATE TABLE Doner (
  donerID INT PRIMARY KEY,          -- Unique ID for each donor
  gender CHAR(1),                   -- Gender of the donor (M/F)
  name VARCHAR(20) UNIQUE,                 -- Name of the donor
  date_of_birth DATE UNIQUE,               -- Date of birth of the donor
  age TINYINT,                          -- Age of the donor
  Blood_type VARCHAR(4)             -- Blood type of the donor
);

-- Create the Donerphone table to store phone numbers of donors
CREATE TABLE Donerphone (
  phone_number VARCHAR(10) CHECK (phone_number REGEXP '^[0-9]{10}$'),         -- Donor's phone number
  donerID INT,                      -- Donor's ID as a foreign key
  PRIMARY KEY (phone_number, donerID), -- Composite primary key
  FOREIGN KEY (donerID) REFERENCES Doner(donerID) -- Foreign key referencing Doner table
);

-- Create the Receiver table to store receiver details
CREATE TABLE Receiver (
    receiverID INT PRIMARY KEY,      -- Unique ID for each receiver
    name VARCHAR(20) UNIQUE,                -- Name of the receiver
    gender CHAR(1),                  -- Gender of the receiver (M/F)
    date_of_birth DATE UNIQUE,              -- Date of birth of the receiver
    age TINYINT,                         -- Age of the receiver
    Blood_type VARCHAR(4)            -- Blood type of the receiver
);

-- Create the Receivephone table to store phone numbers of receivers
CREATE TABLE Receivephone (
  phone_number VARCHAR(10) CHECK (phone_number REGEXP '^[0-9]{10}$'),          -- Receiver's phone number
  receiverID INT,                    -- Receiver's ID as a foreign key
  PRIMARY KEY (phone_number, receiverID), -- Composite primary key
  FOREIGN KEY (receiverID) REFERENCES Receiver(receiverID) -- Foreign key referencing Receiver table
);

-- Create the Blood_Bank table to store blood bank details
CREATE TABLE Blood_Bank (
  bank_id CHAR(4) PRIMARY KEY,       -- Unique bank ID for each blood bank
  phone_num CHAR(10),                -- Phone number of the blood bank
  address VARCHAR(15)                -- Address of the blood bank
);

-- Create the Blood table to store blood donation details
CREATE TABLE Blood (
  serial_code CHAR(5) PRIMARY KEY,   -- Unique serial code for blood
  donerID INT,                       -- Donor ID as a foreign key
  receiverID INT,                    -- Receiver ID as a foreign key
  bank_id CHAR(4),                   -- Blood bank ID as a foreign key
  Blood_type VARCHAR(3),             -- Blood type of the donation
  amount DECIMAL(6, 2) CHECK (amount > 0),              -- Amount of blood donated in liters
  FOREIGN KEY (donerID) REFERENCES Doner(donerID), -- Foreign key for donor
  FOREIGN KEY (bank_id) REFERENCES Blood_Bank(bank_id), -- Foreign key for blood bank
  FOREIGN KEY (receiverID) REFERENCES Receiver(receiverID) -- Foreign key for receiver
);

-- Create the Hospital table to store hospital details
CREATE TABLE Hospital (
  hosp_id CHAR(4) PRIMARY KEY,       -- Unique ID for each hospital
  name VARCHAR(100),                 -- Hospital name
  phone_number VARCHAR(15) NOT NULL, -- Hospital phone number
  nurseID VARCHAR(4),                -- Nurse ID as a foreign key
  address VARCHAR(100) NOT NULL,     -- Address of the hospital
  bank_id CHAR(4),                   -- Blood bank ID as a foreign key
  FOREIGN KEY (bank_id) REFERENCES Blood_Bank(bank_id) -- Foreign key for blood bank
);

-- Create the Nurse table to store nurse details
CREATE TABLE Nurse (
  nurseID VARCHAR(4) PRIMARY KEY,    -- Unique ID for each nurse
  name VARCHAR(20),                  -- Name of the nurse
  hosp_id CHAR(4),                   -- Hospital ID as a foreign key
  FOREIGN KEY (hosp_id) REFERENCES Hospital(hosp_id) -- Foreign key for hospital
);

-- Create the Appointment table to store appointment details
CREATE TABLE Appointment (
  AppID CHAR(4) PRIMARY KEY,         -- Unique ID for each appointment
  donerID INT,                       -- Donor ID as a foreign key
  nurseID VARCHAR(4),                -- Nurse ID as a foreign key
  receiverID INT,                    -- Receiver ID as a foreign key
  hosp_id CHAR(4),                   -- Hospital ID as a foreign key
  appdate DATE,                      -- Appointment date
  apptime TIME,                      -- Appointment time
  FOREIGN KEY (donerID) REFERENCES Doner(donerID), -- Foreign key for donor
  FOREIGN KEY (receiverID) REFERENCES Receiver(receiverID), -- Foreign key for receiver
  FOREIGN KEY (nurseID) REFERENCES Nurse(nurseID), -- Foreign key for nurse
  FOREIGN KEY (hosp_id) REFERENCES Hospital(hosp_id) -- Foreign key for hospital
);

CREATE TABLE Roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, -- Store hashed passwords
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

-- Insert sample data into Doner table
INSERT INTO Doner (donerID, gender, name, date_of_birth, age, Blood_type) 
VALUES 
(1, 'M', 'Vedant Karekar', '2004-12-22', 20, 'O+'),
(2, 'M', 'Soham Vichare', '2004-12-27', 20, 'A+'),
(3, 'M', 'Adams Pitt', '1992-12-17', 20, 'A-'),
(4, 'F', 'Devas Prabha', '1986-05-11', 31, 'B-'),
(5, 'F', 'Arya Raut', '2003-09-06', 43, 'B+'),
(6, 'M', 'Kaustubh Rits', '2001-09-12', 58, 'AB-'),
(7, 'F', 'AKshayya Patil', '1985-01-19', 22, 'AB+'),
(8, 'F', 'bhavika More', '1967-04-26', 28, 'A-'),
(9, 'F', 'Priya Sharma', '1995-03-15', 29, 'B+'),
(10, 'M', 'Rahul Deshmukh', '1990-08-09', 34, 'O-'),
(11, 'M', 'Nikhil Joshi', '1988-11-23', 35, 'A+'),
(12, 'F', 'Anjali Mehta', '1992-02-11', 32, 'AB+'),
(13, 'M', 'Rohit Patil', '1980-06-30', 44, 'B-'),
(14, 'F', 'Pooja Gupta', '1998-04-05', 26, 'AB-'),
(15, 'M', 'Vishal Patankar', '1975-07-22', 49, 'O+');

-- Insert sample data into Receiver table
INSERT INTO Receiver (receiverID, gender, name, date_of_birth, age, Blood_type) 
VALUES 
(1, 'M', 'Vinod Karekar', '2004-12-22', 19, 'O+'),
(2, 'M', 'Manish Vichare', '2003-12-27', 27, 'A+'),
(3, 'M', 'Yash Pitt', '1992-02-12', 20, 'A-'),
(4, 'F', 'Kimaya Prabha', '1997-06-18', 31, 'B-'),
(5, 'F', 'Janhavi Raut', '1999-11-21', 43, 'B+'),
(6, 'M', 'Aditya Rits', '1979-09-29', 58, 'AB-'),
(7, 'F', 'Srushti Patil', '1983-04-01', 22, 'AB+'),
(8, 'F', 'Nidhi More', '1997-03-10', 28, 'A-'),
(9, 'F', 'Shreya Naik', '1995-09-21', 29, 'B+'),
(10, 'M', 'Siddharth Rane', '1985-10-18', 39, 'O-'),
(11, 'F', 'Neha Singhania', '1991-03-05', 33, 'A+'),
(12, 'M', 'Amit Kulkarni', '1989-12-12', 34, 'AB+'),
(13, 'F', 'Simran Desai', '1982-11-30', 41, 'B-'),
(14, 'M', 'Karan Joshi', '1993-01-22', 31, 'AB-'),
(15, 'F', 'Divya Puri', '1990-08-10', 34, 'O+');


-- Insert sample data into Doner's Phone table
INSERT INTO Donerphone (phone_number, donerID) 
VALUES 
('0507274988', 1),
('0508643561', 2),
('0509737434', 3),
('0537439298', 4),
('8283737272', 5),
('7173728333', 6),
('6184726383', 7),
('9273828374', 8),
('9356893472', 9),
('9378479232', 10),
('9783125476', 11),
('9823356789', 12),
('9234567890', 13),
('9182736450', 14),
('9254782369', 15);

-- Insert sample data into Receive's Phone table
INSERT INTO Receivephone (phone_number, receiverID) 
VALUES 
('7393837492', 1),
('9283728374', 2),
('0193873723', 3),
('1927372283', 4),
('0283893828', 5),
('9283929293', 6),
('0373382723', 7),
('1838279249', 8),
('8263718235', 9),
('8392784623', 10),
('8456237198', 11),
('8596457345', 12),
('8293764821', 13),
('8123456789', 14),
('8675309112', 15);

-- Insert sample data into Blood_bank table
INSERT INTO Blood_Bank (bank_id, phone_num, address) 
VALUES 
('4253', '0507274988', 'Varansi'),
('8744', '0508643561', 'Kolkata'),
('6317', '0537439298', 'Mumbai'),
('8679', '0509737434', 'Panaji'),
('7543', '0559341408', 'Pune'),
('8688', '0566778899', 'banglore'),
('6316', '0509737434', 'Chennai'),
('1234', '0559341408', 'Ahmedabad'),
('9851', '0678889991', 'Delhi'),
('8745', '0785456789', 'Hyderabad'),
('1367', '0678356198', 'Chennai'),
('5489', '0789654321', 'Bengaluru'),
('6352', '0678345671', 'Ahmedabad'),
('9653', '0787563412', 'Lucknow'),
('2456', '0679112345', 'Indore'),
('8564', '0788456162', 'Jaipur');


-- Insert sample data into Blood table
INSERT INTO Blood (serial_code, donerID, receiverID, bank_id, Blood_type, amount) 
VALUES 
('B0001', 2, 5, '4253', 'A+', 0.34), 
('B0002', 6, 3, '8744', 'AB+', 0.75),
('B0003', 4, 1, '6316', 'A+', 0.02),
('B0004', 7, 8, '6317', 'O-', 0.92),
('B0005', 5, 2, '8679', 'A-', 0.76), 
('B0006', 8, 6, '1234', 'B-', 0.23),
('B0007', 3, 7, '7543', 'B+', 0.1),
('B0008', 1, 4, '8688', 'O+', 0.99),
('B0009', 9, 11, '9851', 'B+', 0.65),
('B0010', 10, 12, '8745', 'O-', 0.55),
('B0011', 11, 13, '1367', 'A+', 0.70),
('B0012', 12, 14, '5489', 'AB+', 0.90),
('B0013', 13, 15, '6352', 'B-', 0.45),
('B0014', 14, 9, '9653', 'AB-', 0.32),
('B0015', 15, 10, '2456', 'O+', 0.99);


-- Insert sample data into Hospital table
INSERT INTO Hospital (hosp_id, name, phone_number, nurseID, address, bank_id) 
VALUES 
('H001', 'Sanjivani Hospital', '05244889', 'N001', 'Mumbai', '4253'),
('H002', 'Lilavati Hospital', '05233881', 'N005', 'Thane', '8744'),
('H003', 'Jupiter Hospital', '05277893', 'N003', 'Manglore', '7543'),
('H004', 'Mariana Hospital', '05244889', 'N007', 'Nagpur', '1234'),
('H005', 'Kalpana Hospital', '05233881', 'N002', 'Bhopal', '6316'),
('H006', 'AIMS Hospital', '05277893', 'N006', 'Udaipur', '6317'),
('H007', 'Vedant Hospital', '05244889', 'N004', 'Delhi', '8688'),
('H008', 'K.E.M Hospital', '05233881', 'N008', 'Dehradun', '8679'),
('H009', 'Heart Care Hospital', '0544678910', 'N009', 'Kolkata', '9851'),
('H010', 'City Medical Center', '0544678911', 'N010', 'Bengaluru', '8745'),
('H011', 'Lifesaver Hospital', '0544678912', 'N011', 'Delhi', '1367'),
('H012', 'Hope Hospital', '0544678913', 'N012', 'Chennai', '5489'),
('H013', 'Wellness Clinic', '0544678914', 'N013', 'Jaipur', '9653'),
('H014', 'Family Health Hospital', '0544678915', 'N014', 'Lucknow', '2456');


-- Insert sample data into Nurse table
INSERT INTO Nurse (nurseID, name, hosp_id) 
VALUES 
('N001', 'Mariyam Anaa', 'H004'),
('N002', 'Clara Barton', 'H003'),
('N003', 'Margaret Sanger', 'H007'),
('N004', 'Dorothea Dix', 'H001'),
('N005', 'Mary Seacol' , 'H005'),
('N006', 'Martha Ballard', 'H008'),
('N007', 'Vera Brittain', 'H002'),
('N008', 'Anna Broms', 'H006'),
('N009', 'Sophia Turner', 'H009'),
('N010', 'Ella Watson', 'H010'),
('N011', 'Mia Brown', 'H011'),
('N012', 'Olivia Smith', 'H012'),
('N013', 'Ava Davis', 'H013'),
('N014', 'Isabella Johnson', 'H002');

-- Insert sample data into Appointment table
INSERT INTO Appointment (AppID, donerID, nurseID, receiverID, hosp_id, appdate, apptime) 
VALUES 
('A001', 1, 'N001', 3, 'H003', '2020-12-12', '05:30:00'),
('A002', 2, 'N006', 5, 'H001', '2021-01-22', '03:45:00'),
('A003', 5, 'N003', 8, 'H005', '2021-01-25', '06:45:00'),
('A004', 1, 'N008', 2, 'H002', '2020-12-12', '05:30:00'),
('A005', 3, 'N002', 3, 'H007', '2021-01-22', '03:45:00'),
('A006', 7, 'N004', 4, 'H006', '2021-01-25', '06:45:00'),
('A007', 6, 'N005', 1, 'H008', '2020-12-12', '05:30:00'),
('A008', 4, 'N007', 7, 'H004', '2021-01-22', '03:45:00'),
('A009', 9, 'N009', 11, 'H009', '2021-03-01', '10:30:00'),
('A010', 10, 'N010', 12, 'H010', '2021-03-02', '14:00:00'),
('A011', 11, 'N011', 13, 'H011', '2021-03-03', '15:30:00'),
('A012', 12, 'N012', 14, 'H012', '2021-03-04', '16:00:00'),
('A013', 13, 'N013', 9, 'H013', '2021-03-05', '09:15:00'),
('A014', 14, 'N014', 10, 'H014', '2021-03-06', '11:45:00');

INSERT INTO Roles (role_name) 
VALUES 
('Admin'),
('Donor'),
('Receiver'),
('Staff');

INSERT INTO Users (username, password, role_id) 
VALUES 
('admin_user', '12345678', 1), -- Admin
('donor_user', '87654321', 2), -- Donor
('receiver_user', 'qwertyuiop', 3), -- Receiver
('staff_user', 'asdfghjkl', 4); -- Staff

-- Adding indexes to optimize query performance
CREATE INDEX idx_doner_blood_type ON Doner(Blood_type);
CREATE INDEX idx_receiver_blood_type ON Receiver(Blood_type);
CREATE INDEX idx_doner_age ON Doner(age);
CREATE INDEX idx_receiver_age ON Receiver(age);
CREATE INDEX idx_doner_phone_number ON Donerphone(phone_number);
CREATE INDEX idx_receiver_phone_number ON Receivephone(phone_number);
CREATE INDEX idx_blood_bank_address ON Blood_Bank(address);
CREATE INDEX idx_hospital_phone_number ON Hospital(phone_number);

-- Create the users with their usernames and passwords
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY '12345678';
CREATE USER 'donor_user'@'localhost' IDENTIFIED BY '87654321';
CREATE USER 'receiver_user'@'localhost' IDENTIFIED BY 'qwertyuiop';
CREATE USER 'staff_user'@'localhost' IDENTIFIED BY 'asdfghjkl';


-- Grant All The Permissions
-- Grant privileges to Admin role
GRANT ALL PRIVILEGES ON Blood_Bank.* TO 'admin_user'@'localhost';
FLUSH PRIVILEGES;

-- Grant permissions to Donor role
GRANT SELECT, INSERT ON Doner TO 'donor_user'@'localhost';
FLUSH PRIVILEGES;

-- Grant permissions to Receiver role
GRANT SELECT, INSERT ON Receiver TO 'receiver_user'@'localhost';
FLUSH PRIVILEGES;

-- Grant permissions to Staff role
GRANT SELECT, INSERT, UPDATE ON Appointment TO 'staff_user'@'localhost';
FLUSH PRIVILEGES;

-- Revoke All The Permissions
-- Revoke all privileges from the Admin role
REVOKE SELECT, INSERT ON Blood_Bank.* FROM 'admin_user'@'localhost';

-- Revoke permissions from Donor role
REVOKE SELECT, INSERT ON Doner FROM 'donor_user'@'localhost';

-- Revoke permissions from Receiver role
REVOKE SELECT, INSERT ON Receiver FROM 'receiver_user'@'localhost';

-- Revoke permissions from Staff role
REVOKE SELECT, INSERT, UPDATE ON Appointment FROM 'staff_user'@'localhost';

-- Admin Access
-- Admin selects all donors
SELECT * FROM Doner;  -- Allowed
SELECT * FROM Receiver;  -- Allowed
SELECT * FROM Appointment;  -- Allowed

-- Doner Access
-- Donor adds themselves
INSERT INTO Doner (donerID, gender, name, date_of_birth, age, Blood_type) 
VALUES (16, 'F', 'Chhaya Karekar', '2001-10-18', 21, 'O-');  -- Allowed
-- Donor tries to view appointments
SELECT * FROM Appointment;  -- Not allowed

-- Receiver Access
-- Receiver adds themselves
INSERT INTO Receiver (receiverID, gender, name, date_of_birth, age, Blood_type) 
VALUES (16, 'M', 'Chetan Karekar', '2002-11-20', 22, 'A+');  -- Allowed
-- Receiver tries to access donor info
SELECT * FROM Receiver;  -- Not allowed-- 

-- Staff Access
-- Staff adds an appointment
INSERT INTO Appointment (AppID, donerID, nurseID, receiverID, hosp_id, Hospital_name, appdate, apptime) 
VALUES('A016', 1, 'N001', 3, 'H003', 'K.E.M Hospital', '2020-12-12', '05:30:00');  -- Allowed
-- Staff tries to view donors
SELECT * FROM Appointment;  -- Not allowed

-- Select a custom label for each blood type based on the donor's blood type
SELECT
  CASE
    WHEN Blood_type = 'A+' THEN 'Blood Type A+'
    WHEN Blood_type = 'B+' THEN 'Blood Type B+'
    WHEN Blood_type = 'AB+' THEN 'Blood Type AB+'
    WHEN Blood_type = 'O+' THEN 'Blood Type O+'
    WHEN Blood_type = 'A-' THEN 'Blood Type A-'
    WHEN Blood_type = 'B-' THEN 'Blood Type B-'
    WHEN Blood_type = 'AB-' THEN 'Blood Type AB-'
    ELSE 'Blood Type O-' -- Default case for 'O-' if no other match is found
  END AS Blood_Type
FROM Blood
WHERE donerID = 1;  -- Condition to fetch blood type for donor with ID 1


-- Create a trigger that checks the donor's age before inserting a record into the Doner table
DELIMITER //

CREATE TRIGGER CheckAge
BEFORE INSERT ON Doner
FOR EACH ROW
BEGIN
  -- If the donor's age is less than 18, an error is raised
  IF NEW.age < 18 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Age should be greater than 18';
  END IF;
END //

DELIMITER ;


-- Create a trigger that checks the validity of the blood type before inserting a record into the Blood table
DELIMITER //

CREATE TRIGGER CheckBloodType
BEFORE INSERT ON Blood
FOR EACH ROW
BEGIN
  -- If the blood type is not one of the valid options, an error is raised
  IF NEW.Blood_type NOT IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The blood type entered is incorrect. It should be A+, A-, B+, B-, AB+, AB-, O+, O-';
  END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER PreventDuplicateAppointments
BEFORE INSERT ON Appointment
FOR EACH ROW
BEGIN
    DECLARE existing_count INT;
    SELECT COUNT(*) INTO existing_count 
    FROM Appointment 
    WHERE donerID = NEW.donerID AND appdate = NEW.appdate AND apptime = NEW.apptime;
    
    IF existing_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate appointment exists for this donor.';
    END IF;
END //

DELIMITER ;


-- Joining the Doner and Blood Table
SELECT 
  Doner.donerID, 
  Doner.name, 
  Blood.Blood_type
FROM Doner
JOIN Blood ON Doner.donerID = Blood.donerID;
 
-- Joining the Hospital and Nurse Table
SELECT 
   Hospital.name,
   Hospital.phone_number,
   Hospital.address,
   Hospital.nurseID,
   Hospital.bank_id,
   Hospital.hosp_id,
   nurse.name
FROM Hospital 
JOIN nurse 
ON Hospital.hosp_id = nurse.hosp_id;

-- Abstracting all the Information
SELECT 
	A.AppID, A.donerID, H.nurseID, A.receiverID, A.hosp_id, A.appdate, A.apptime, H.phone_number AS Patients_number, 
	H.address AS Hospital_address, H.bank_id, N.name AS Nurse_name, B.amount, B.serial_code, B.Blood_type, BB.address, BB.phone_num
FROM Appointment AS A
JOIN Hospital AS H
ON A.hosp_id = H.hosp_id
JOIN nurse AS N
ON H.nurseID = N.nurseID
JOIN Blood AS B
ON H.bank_id = B.bank_id
JOIN Blood_Bank AS BB
ON H.bank_id = BB.bank_id;

-- Receiver Contact Information
SELECT R.receiverID, R.name, R.gender, R.date_of_birth, R.age, R.Blood_type, RP.phone_number
FROM Receiver AS R
JOIN Receivephone AS RP
ON R.receiverID = RP.receiverID;

-- Doner Contact Information
SELECT D.donerID, D.name, D.gender, D.date_of_birth, D.age, D.Blood_type, DP.phone_number
FROM Doner AS D
JOIN Donerphone AS DP
ON D.donerID = DP.donerID;
    
-- Example maintenance task: analyze the tables for optimization
ANALYZE TABLE Doner;
ANALYZE TABLE Receiver;
ANALYZE TABLE Blood;



-- Insert a new record into the Doner table with donor details
INSERT INTO Doner (donerID, gender, name, date_of_birth, age, Blood_type) 
VALUES (9, 'M', 'Sanket Karekar', '2002-12-22', 22, 'O+');  -- Valid donor, age > 18

-- Insert a new record into the Blood table for the donation with valid blood type 'A+'
INSERT INTO Blood (serial_code, donerID, receiverID, bank_id, Blood_type, amount) 
VALUES ('B009', 2, 5, '4253', 'A+', 0.78);  -- Blood donation by donorID 2 with 0.78 liters of A+ blood


-- Insert a new donor who is underage (age 16) - This will trigger the 'CheckAge' trigger and fail
INSERT INTO Doner (donerID, gender, name, date_of_birth, age, Blood_type) 
VALUES (10, 'F', 'Shravani Karekar', '2008-02-21', 16, 'O-');  -- This will cause an error because of the age restriction

-- Insert a new blood donation with an invalid blood type 'C-' - This will trigger the 'CheckBloodType' trigger and fail
INSERT INTO Blood (serial_code, donerID, receiverID, bank_id, Blood_type, amount) 
VALUES ('B010', 2, 5, '4253', 'C-', 0.41);  -- This will cause an error due to invalid blood type 'C-'


-- Performing Data Analysis
-- the total number of donations received in a specific time frame
SELECT COUNT(*) AS total_donations
FROM Appointment
WHERE appdate BETWEEN '2020-12-01' AND '2021-01-22';

-- Analyzing the trend in donations over months to identify peak donation times.
SELECT MONTH(appdate) AS month, COUNT(*) AS total_donations
FROM Appointment
GROUP BY MONTH(appdate)
ORDER BY month;

-- Average Age of Donors
SELECT AVG(TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())) AS average_age
FROM Doner;

-- Total Blood Donated
SELECT Blood_type, SUM(amount) AS Total_Blood
FROM Blood
Group By Blood_type
Order By Blood_type;

-- Recent Donation
SELECT appdate, AppID
from Appointment
WHERE appdate <= CURDATE()
ORDER BY appdate DESC;

-- Count Number of Doners Grouped By Gender
SELECT gender, COUNT(donerID) AS total_donors
FROM Doner
GROUP BY gender;

-- Number Of Receivers By Blood Type
SELECT Blood_type, count(receiverID) AS Total_Receivers
FROM Receiver
Group BY Blood_type;

-- Average Age of Receivers
SELECT AVG(TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())) AS average_age
FROM Receiver;

