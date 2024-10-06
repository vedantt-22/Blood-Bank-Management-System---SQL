Blood Bank Management System - SQL

## Project Overview
The Blood Bank Management System is designed to efficiently manage donor and receiver details, appointments, blood inventory, and the relationships between hospitals, nurses, and blood banks. This project utilizes SQL to implement the database structure and offers functionalities for role-based access (Admin, Donor, Receiver, Staff) to ensure security and efficiency in managing a blood bank's operations.

## Features
- Donor Management: Track donor details like gender, blood type, phone number, and donation history.
- Receiver Management: Store receiver information, blood type, phone numbers, and their blood reception history.
- Blood Inventory: Maintain records of blood donations with serial codes, amounts, and associated donors and receivers.
- Hospital Management: Manage hospitals, including contact details, addresses, and associated nurses.
- Appointment Scheduling: Track appointments between donors, receivers, and nurses for efficient blood donation and transfusion.
- Role-Based Access: Secure role-based access control for users (Admin, Donor, Receiver, Staff).
- Optimized Performance: Indexes implemented for improved query performance on key fields (blood type, phone numbers, age, etc.).

## Database Schema
The project defines the following key tables:
1. Doner: Stores donor information including ID, gender, name, age, and blood type.
2. Receiver: Stores receiver details like ID, gender, and blood type.
3. Blood_Bank: Stores blood bank information such as address and phone number.
4. Blood: Tracks blood donations with serial codes and amount.
5. Hospital: Stores hospital information like name, phone number, and associated blood bank.
6. Nurse: Stores nurse information linked to hospitals.
7. Appointment: Stores appointment details between donors, receivers, and nurses.
8. Donerphone & Receivephone: Manage multiple phone numbers for donors and receivers.
9. Roles & Users: Manage user access based on roles (Admin, Donor, Receiver, Staff).

## Data Analysis

This system allows for a variety of data analysis queries to gain insights into blood bank operations, donor and receiver statistics, and more. Below are a few possible analyses:

1. Blood Type Distribution
Query to analyze the distribution of different blood types among donors and receivers:

-- Distribution of blood types among donors
 ```
SELECT Blood_type, COUNT(*) AS num_of_donors
FROM Doner
GROUP BY Blood_type;
 ```

-- Distribution of blood types among receivers
 ```
SELECT Blood_type, COUNT(*) AS num_of_receivers
FROM Receiver
GROUP BY Blood_type;
 ```

2. Average Age of Donors and Receivers
Query to calculate the average age of donors and receivers:

-- Average age of donors
 ```
SELECT AVG(age) AS avg_donor_age
FROM Doner;
 ```

-- Average age of receivers
 ```
SELECT AVG(age) AS avg_receiver_age
FROM Receiver;
 ```

3. Blood Donations by Blood Bank
Analyze the total amount of blood donated at each blood bank:

-- Total blood donations per blood bank
 ```
SELECT Blood_Bank.address, SUM(Blood.amount) AS total_blood_donated
FROM Blood
JOIN Blood_Bank ON Blood.bank_id = Blood_Bank.bank_id
GROUP BY Blood_Bank.address;
 ```

4. Appointment History
Query to retrieve a log of appointments, including the donor, receiver, nurse, and hospital involved:

-- Appointment details
 ```
SELECT Doner.name AS Donor, Receiver.name AS Receiver, Nurse.name AS Nurse, Hospital.name AS Hospital, Appointment.appdate, Appointment.apptime
FROM Appointment
JOIN Doner ON Appointment.donerID = Doner.donerID
JOIN Receiver ON Appointment.receiverID = Receiver.receiverID
JOIN Nurse ON Appointment.nurseID = Nurse.nurseID
JOIN Hospital ON Appointment.hosp_id = Hospital.hosp_id
ORDER BY Appointment.appdate;
 ```

5. Blood Stock per Blood Type
Query to check the amount of available blood for each blood type:

-- Total available blood per blood type
 ```
SELECT Blood_type, SUM(amount) AS total_amount
FROM Blood
GROUP BY Blood_type;
```

## User Roles

The system defines four user roles:
- Admin: Full access to all tables and operations.
- Donor: Limited access to their own donation and appointment data.
- Receiver: Access to their blood receipt and appointment history.
- Staff: Manage appointments and hospital operations.

## SQL Code Highlights
- Data Integrity: Use of foreign keys ensures the relationships between donors, receivers, blood banks, and hospitals are maintained.
- Role-Based Access: Users are assigned specific roles (`Admin`, `Donor`, `Receiver`, `Staff`) which manage permissions and access to database functionality.
- Sample Data: Pre-populated sample data for donors, receivers, blood banks, hospitals, nurses, and appointments for testing purposes.

## SQL Queries Used
- CREATE TABLE: To define all tables and their relationships.
- INSERT INTO: To insert sample data into the tables.
- FOREIGN KEY: To link data across tables and ensure referential integrity.
- CHECK: To enforce data validation, such as valid phone numbers.
- INDEXES: To optimize querying on common search fields like blood type, phone numbers, and age.

## Setup Instructions
1. Database Creation: Create the blood bank database using the command:
   ```
   CREATE DATABASE BLOOD_BANK;
   ```
2. Table Creation: Run the SQL script to create the necessary tables with all relationships and constraints.
3. Insert Sample Data: Insert predefined sample data to populate the tables with donor, receiver, and appointment information.
4. User Management: Create users with appropriate roles (Admin, Donor, Receiver, Staff) to manage permissions.
5. Indexing: Implement the indexing commands to optimize the database queries.

## Future Enhancements
- UI Integration: Develop a user-friendly interface to interact with the database.
- Real-Time Notifications: Implement a system to notify hospitals and blood banks when blood donations are made or when blood is required.
- Analytics: Integrate reports and dashboards for analyzing donor trends, blood demand, and supply.

## Conclusion
The Blood Bank Management System provides a comprehensive solution to manage the operations of blood banks, from tracking donations and receipts to managing appointments and staff. It ensures data integrity and efficient retrieval of information, essential for the smooth functioning of blood banks.

