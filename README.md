# 🦷 DentalClinic – NoSQL Database Migration Project

## 📌 Project Title
**Migration of Data from a Relational Database to a NoSQL Database**

## 🎯 Project Objective
This project demonstrates the migration of a structured relational database (SQL Server) to a NoSQL database (MongoDB). 
It reflects our understanding of data modeling in both systems and includes a working script for extracting, transforming, 
and loading (ETL) patient and staff data from SQL Server into MongoDB.

---

## 📁 Relational Database Schema (SQL Server)
The database `DentalClinic` contains the following tables:

- `Patient`
- `Appointment`
- `Bill`
- `MedicalHistory`
- `Insurance`
- `Employee` (with subtypes: `Dentist`, `Nurse`, `TechStaff`)

Relationships were maintained using primary and foreign keys. Tables were populated with meaningful records (≥ 20 per table).

---

## 🚀 NoSQL Database Structure (MongoDB)

In MongoDB, we designed the following collections:

- `patients` – includes embedded subdocuments: `appointments`, `bills`, `medical_history`, `insurances`
- `employees` – generic data for all staff
- `dentists`, `nurses`, `tech_staff` – specific employee roles for separation of duties

This document-based model reduces the need for joins and improves performance for read-heavy operations.

---

## 🔄 Migration Process

A Python script we made handles the data migration from SQL Server to MongoDB. The script:

- Connects to SQL Server using `pyodbc`
- Extracts records from each table
- Converts incompatible data types (`Decimal`, `Date`, `Time`) for MongoDB compatibility
- Inserts transformed documents into MongoDB using `pymongo`
- Logs all operations and errors into `migration.log`

---

## ⚙️ Setup & Installation Instructions

### 🔧 Prerequisites
Make sure the following are installed:

- Python 3.10+
- SQL Server with populated `DentalClinic` database
- MongoDB or MongoDB Compass running on `localhost`
- ODBC Driver 17 for SQL Server

---

### 📦 Install Dependencies

''bash
pip install pyodbc pymongo

---

🚀 Running the Migration Script

1. Clone the repository:

git clone https://github.com/ee30667/DentalClinic---NoSql-Project.git
cd DentalClinic---NoSql-Project

2. Ensure the database connection in migrate_dentalclinic.py matches your local setup

3. Run the migration script:

python migrate_dentalclinic.py

4. Open MongoDB Compass or use Mongo shell to verify the following collections:

- `patients`
- `employees`
- `dentists`
- `nurses`
- `tech_staff`

---

🧩 Dependencies

Library -	Use: 
- `pyodbc` - Connect and query SQL Server
- `pymongo`	- Insert and manage MongoDB data
- `decimal` - Handle Decimal to float conversion
- `datetime` - Convert date, time to ISO format
- `logging` - Log migration activity and errors

---

  ✅ Project Completed By
- Era Emurli & Jona Sela
- As part of the NoSQL Database course
- Faculty of Contemporary Sciences and Technologies, SEEU – 2025
