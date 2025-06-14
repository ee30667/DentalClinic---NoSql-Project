import pyodbc
from pymongo import MongoClient
import logging
from decimal import Decimal
from datetime import date, time, datetime

# Setup logging
logging.basicConfig(filename='migration.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Convert unsupported types for MongoDB
def convert_for_mongo(obj):
    if isinstance(obj, Decimal):
        return float(obj)
    elif isinstance(obj, (date, time, datetime)):
        return obj.isoformat()
    elif isinstance(obj, dict):
        return {k: convert_for_mongo(v) for k, v in obj.items()}
    elif isinstance(obj, list):
        return [convert_for_mongo(i) for i in obj]
    else:
        return obj

try:
    # Connect to SQL Server
    sql_conn = pyodbc.connect(
        "DRIVER={ODBC Driver 17 for SQL Server};"
        "SERVER=ERAS-PROBOOK\\SQLEXPRESS;"
        "DATABASE=DentalClinic1;"
        "Trusted_Connection=yes;"
    )
    cursor = sql_conn.cursor()
    logging.info("Connected to SQL Server.")

    # Connect to MongoDB
    mongo_client = MongoClient("mongodb://localhost:27017/")
    mongo_db = mongo_client["DentalClinic"]
    patients_col = mongo_db["patients"]
    employees_col = mongo_db["employees"]
    dentists_col = mongo_db["dentists"]
    nurses_col = mongo_db["nurses"]
    techstaff_col = mongo_db["tech_staff"]
    logging.info("Connected to MongoDB.")

    # MIGRATE PATIENTS + Embedded Data
    cursor.execute("SELECT * FROM Patient")
    columns = [column[0] for column in cursor.description]
    patients = [dict(zip(columns, row)) for row in cursor.fetchall()]
    logging.info(f"Fetched {len(patients)} patients.")

    for patient in patients:
        pid = patient["PID"]

        # Get all appointments related to the patient
        cursor.execute("SELECT * FROM Appointment WHERE PID = ?", pid)
        appointments = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]

        # Get bills related to the patient
        cursor.execute("SELECT * FROM Bill WHERE PID = ?", pid)
        bills = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]

        # Get single medical history record
        cursor.execute("SELECT * FROM MedicalHistory WHERE PID = ?", pid)
        row = cursor.fetchone()
        med_history = dict(zip([col[0] for col in cursor.description], row)) if row else None

        # Get all insurance entries for the patient
        cursor.execute("SELECT * FROM Insurance WHERE PID = ?", pid)
        insurances = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]

        # Construct the MongoDB patient document
        document = {
            "pid": pid,
            "name": patient["Pname"],
            "surname": patient["Psurname"],
            "age": patient["Ppage"],
            "gender": patient["Pgender"],
            "contact": patient["Pcontact"],
            "appointments": appointments,
            "bills": bills,
            "medical_history": med_history,
            "insurances": insurances
        }

        # Insert the document into MongoDB
        patients_col.insert_one(convert_for_mongo(document))
        print(f"Inserted patient {pid} into MongoDB.")
        logging.info(f"Inserted patient {pid} into MongoDB.")

    # MIGRATE EMPLOYEES
    cursor.execute("SELECT * FROM Employee")
    columns = [column[0] for column in cursor.description]
    employees = [dict(zip(columns, row)) for row in cursor.fetchall()]
    for emp in employees:
        employees_col.insert_one(convert_for_mongo(emp))

    logging.info(f"Inserted {len(employees)} employees.")

    # MIGRATE DENTISTS
    cursor.execute("SELECT * FROM Dentist")
    columns = [column[0] for column in cursor.description]
    dentists = [dict(zip(columns, row)) for row in cursor.fetchall()]
    for d in dentists:
        dentists_col.insert_one(convert_for_mongo(d))

    logging.info(f"Inserted {len(dentists)} dentists.")

    # MIGRATE NURSES
    cursor.execute("SELECT * FROM Nurse")
    columns = [column[0] for column in cursor.description]
    nurses = [dict(zip(columns, row)) for row in cursor.fetchall()]
    for n in nurses:
        nurses_col.insert_one(convert_for_mongo(n))

    logging.info(f"Inserted {len(nurses)} nurses.")

    # MIGRATE TECH STAFF
    cursor.execute("SELECT * FROM TechStaff")
    columns = [column[0] for column in cursor.description]
    techs = [dict(zip(columns, row)) for row in cursor.fetchall()]
    for t in techs:
        techstaff_col.insert_one(convert_for_mongo(t))

    logging.info(f"Inserted {len(techs)} tech staff.")

    print("Full migration completed including bonus collections.")
    logging.info("Full migration completed successfully.")

except Exception as e:
    logging.error(f"Error during migration: {e}")
    print(f"Migration failed: {e}")

finally:
    try:
        cursor.close()
        sql_conn.close()
        logging.info("SQL Server connection closed.")
    except:
        pass
