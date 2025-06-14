USE master
GO

-- e fshijme data bazen nese ekziston
IF(DB_ID('DentalClinic1') IS NOT NULL)
DROP DATABASE DentalClinic1
GO

-- e rikrijojme data bazen
CREATE DATABASE DentalClinic1
GO

-- PERDORIMI I DATA BAZES
USE DentalClinic1
GO

CREATE TABLE Patient(
PID varchar(10) constraint Patient_PK Primary Key,
Pname varchar(15) NOT NULL,
Psurname varchar(15) NOT NULL,
Ppage NUMERIC(3),
Pgender CHAR(1) CONSTRAINT Pgender_V CHECK(Pgender in('M','m','F','f')),
Pcontact varchar(15)
);
GO

 CREATE TABLE Employee
 (
EID varchar(10) constraint Employee_PK Primary Key,
Ename varchar(15) NOT NULL,
Esurname varchar(15) NOT NULL,
Eaddress varchar(30),
Econtact varchar(15),
Elisencenum varchar(15)
 );
 GO
 
 -- nenklasat
  CREATE TABLE Dentist
 (
 DID varchar(10) constraint Dentist_PK Primary Key,
 Dspecialization varchar(20) NOT NULL
 );
 GO
 CREATE TABLE Nurse
 (
 NID varchar(10) constraint Nurse_PK Primary Key,
 DID varchar(10) NOT NULL,
 constraint Dentist_unique unique(DID)

 );
 GO

 CREATE TABLE TechStaff
 (
 TID varchar(10) constraint Tech_PK Primary Key
 );
 GO
 -- entitete te dobeta
 CREATE TABLE MedicalHistory
 (
 MID varchar(10) NOT NULL,
 Mmed varchar(20),
 Msurgery varchar(15),
 Mcodnition varchar(40),
 Mallergies varchar(50),
 PID varchar(10),
constraint MedicalH_PK Primary Key(MID,PID),
 constraint Patient_unique unique(PID) 
 );
 GO

 CREATE TABLE Insurance
 (
 IID varchar(10) NOT NULL,
 PolicyNum varchar(20) NOT NULL,
 Insurance_provider varchar(20) NOT NULL,
 PID varchar(10),
 constraint Insureance_PK Primary Key(IID,PID)
 );
 GO

 CREATE TABLE Appointment
 (
 AID varchar(10) constraint Appointment_PK Primary Key,
 Aduration varchar(15) NOT NULL,
 PID varchar(10) NOT NULL,
 TID varchar(10) NOT NULL,
 DID varchar(10) NOT NULL,
 Diagnosis varchar(40),
 Perception varchar(40),
 Date date NOT NULL,
 Time TIME NOT NULL
 );
 GO

 CREATE TABLE Bill
 (
 BID varchar(10) constraint Bill_PK Primary Key,
 Bamount numeric(10,2) NOT NULL,
 Bdate date NOT NULL,
 BMethod varchar(15) NOT NULL,
 PID varchar(10) NOT NULL,
 IID varchar(10) NOT NULL,
 TID varchar(10) NOT NULL
 );
 GO

 ALTER TABLE MedicalHistory ADD CONSTRAINT MedicalHistory_Patient_FK Foreign Key(PID)
 references Patient ON UPDATE CASCADE ON DELETE CASCADE
 GO

 ALTER TABLE Dentist ADD CONSTRAINT Dentist_Employee_FK Foreign Key(DID)
 references Employee ON UPDATE CASCADE ON DELETE CASCADE
 GO

ALTER TABLE Nurse ADD CONSTRAINT Nurse_Employee_FK Foreign Key(NID)
references Employee ON UPDATE CASCADE ON DELETE CASCADE
GO

ALTER TABLE Nurse ADD CONSTRAINT Nurse_Dentist_FK Foreign Key(DID)
references Dentist ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE TechStaff ADD CONSTRAINT Tech_Employee_FK Foreign Key(TID)
references Employee ON UPDATE CASCADE ON DELETE CASCADE
GO

ALTER TABLE Insurance ADD CONSTRAINT Insurance_Patient_FK Foreign Key(PID)
references Patient ON UPDATE CASCADE ON DELETE CASCADE
GO

ALTER TABLE Bill ADD CONSTRAINT Bill_Patient_FK Foreign Key(PID)
references Patient ON UPDATE CASCADE ON DELETE CASCADE
GO

ALTER TABLE Bill ADD CONSTRAINT Bill_Tech_FK Foreign Key(TID)
references TechStaff ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE Bill ADD CONSTRAINT Bill_Insurance_FK  FOREIGN KEY (IID, PID) 
REFERENCES Insurance (IID, PID) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE Appointment ADD CONSTRAINT Appointment_Patient_FK FOREIGN KEY(PID) 
REFERENCES Patient ON UPDATE CASCADE ON DELETE CASCADE
GO

ALTER TABLE Appointment ADD CONSTRAINT Appointment_Dentist_FK FOREIGN KEY(DID)
REFERENCES Dentist ON UPDATE CASCADE ON DELETE CASCADE
GO

ALTER TABLE Appointment ADD CONSTRAINT Appointment_Tech_FK FOREIGN KEY(TID)
REFERENCES TechStaff ON DELETE NO ACTION ON UPDATE NO ACTION
GO


ALTER TABLE Patient NOCHECK CONSTRAINT ALL 
INSERT INTO Patient
VALUES
    ('0001', 'Jona', 'Sela', 20, 'F', '777-777-777'),
    ('0002', 'Era', 'Sela', 21, 'F', '222-222-222'),
    ('0003', 'Ajeta', 'Dauti', 21, 'F', '444-444-444'),
    ('0004', 'Gjilizar', 'Zhuta', 20, 'F',  '333-333-333'),
    ('0005', 'Jon', 'Ziba', 25, 'M',  '111-111-111'),
    ('0006', 'Jeta', 'Sela', 20, 'F',  '666-666-666'),
    ('0007', 'Lin', 'Nushi', 50, 'M', '345-983-123'),
    ('0008', 'Melisa', 'Kaba', 23, 'F', '999-999-999'),
    ('0009', 'Gerti', 'Oda', 60, 'M', '504-503-403'),
    ('0010', 'Gerta', 'Ismaili', 28, 'F','700-893-010'),
	('0011', 'Jana', 'Sela', 20, 'F', '777-777-777'),
    ('0012', 'Erra', 'Sela', 21, 'F', '222-222-222'),
    ('0013', 'Aieta', 'Dauti', 21, 'F', '444-444-444'),
    ('0014', 'Gilizar', 'Zhuta', 20, 'F',  '333-333-333'),
    ('0015', 'Ron', 'Ziba', 25, 'M',  '111-111-111'),
    ('0016', 'Leta', 'Sela', 20, 'F',  '666-666-666'),
    ('0017', 'Len', 'Nushi', 50, 'M', '345-983-123'),
    ('0018', 'Merlisa', 'Kaba', 23, 'F', '999-999-999'),
    ('0019', 'Gert', 'Oda', 60, 'M', '504-503-403'),
    ('0020', 'Gerald', 'Ismaili', 28, 'F','700-893-010')
	;
ALTER TABLE Patient CHECK CONSTRAINT ALL

ALTER TABLE Employee NOCHECK CONSTRAINT ALL
INSERT INTO Employee
VALUES      
    ('D0001', 'Lyra', 'Vita', 'Toronto, Canada, Red st', '534-503-403', 'F1111'),
    ('D0002', 'Kela', 'Zhuta',  'Marks Engels st', '604-453-403', 'A7777'),
    ('D0003', 'Albulena', 'Jonuzi', '722 East St', '004-503-8893', 'X1717'),
    ('D0004', 'Kaltrina', 'Bilali',  '111 Beka St', '504-503-097', 'E2032'),
    ('D0005', 'Ardian', 'Vrenezi',  '202 Elz St', '500-233-403', 'D0393'),
    ('D0006', 'Hanife', 'Vinca',  '303 Orbit St', '474-503-403', 'L7070'),
    ('D0007', 'Armend', 'Jakupi',  '404 Star St', '564-903-403', 'D1010'),
    ('D0008', 'Eva', 'Poposka', '505 Moon St', '504-503-403', 'K2322'),
    ('D0009', 'Ajan', 'Zuta',  '606 New St', '777-503-403', 'T7373'),
    ('D0010', 'Leon', 'Lila',  '707 Stella St', '564-666-403', 'P6661'),
	('D0011', 'Lira', 'Vita', 'Toronto, Canada, Red st', '534-503-403', 'F1111'),
    ('D0012', 'Keta', 'Zhuta',  'Marks Engels st', '604-453-403', 'A7777'),
    ('D0013', 'Arlbulena', 'Jonuzi', '722 East St', '004-503-8893', 'X1717'),
    ('D0014', 'Katalea', 'Bilali',  '111 Beka St', '504-503-097', 'E2032'),
    ('D0015', 'Adrian', 'Vrenezi',  '202 Elz St', '500-233-403', 'D0393'),
    ('D0016', 'Anife', 'Vinca',  '303 Orbit St', '474-503-403', 'L7070'),
    ('D0017', 'Admend', 'Jakupi',  '404 Star St', '564-903-403', 'D1010'),
    ('D0018', 'Eta', 'Poposka', '505 Moon St', '504-503-403', 'K2322'),
    ('D0019', 'Ajani', 'Zuta',  '606 New St', '777-503-403', 'T7373'),
    ('D0020', 'Leoni', 'Lila',  '707 Stella St', '564-666-403', 'P6661');
ALTER TABLE Employee CHECK CONSTRAINT ALL

ALTER TABLE Bill
ALTER COLUMN Bdate date NULL;
GO
ALTER TABLE Bill NOCHECK CONSTRAINT ALL
INSERT INTO Bill (BID, Bamount, Bdate, BMethod, PID, IID, TID)
VALUES
    ('B0007', 111.00, '2024-01-05', 'Cash', '0001', 'I0001', 'T0001'),
	('B0001', 111.00, '2024-01-05', 'Cash', '0001', 'I0001', 'T0001'),
    ('B0008', 150.50, '2024-05-06', 'CreditCard', '0002', 'I0002', 'T0002'),
    ('B0009', 222.00, '2024-02-07', 'DebitCard', '0003', 'I0003', 'T0003'),
    ('B0010', 777.25, '2024-01-05', 'Cash', '0004', 'I0004', 'T0004'),
    ('B0055', 420.00, '2024-08-09', 'CreditCard', '0005', 'I0005', 'T0005'),
	('B0011', 310.00, '2024-06-01', 'CreditCard', '0006', 'I0006', 'T0006'),
    ('B0012', 200.00, '2024-06-02', 'Cash', '0007', 'I0007', 'T0007'),
    ('B0013', 555.50, '2024-06-03', 'DebitCard', '0008', 'I0008', 'T0008'),
    ('B0014', 399.99, '2024-06-04', 'CreditCard', '0009', 'I0009', 'T0009'),
    ('B0015', 150.00, '2024-06-05', 'Cash', '0010', 'I0010', 'T0010'),
    ('B0016', 180.75, '2024-06-06', 'DebitCard', '0011', 'I0011', 'T0011'),
    ('B0017', 220.00, '2024-06-07', 'Cash', '0012', 'I0012', 'T0012'),
    ('B0018', 325.00, '2024-06-08', 'CreditCard', '0013', 'I0013', 'T0013'),
    ('B0019', 405.25, '2024-06-09', 'Cash', '0014', 'I0014', 'T0014'),
    ('B0020', 505.00, '2024-06-10', 'CreditCard', '0015', 'I0015', 'T0015'),
    ('B0021', 275.00, '2024-06-11', 'DebitCard', '0016', 'I0016', 'T0016'),
    ('B0022', 345.75, '2024-06-12', 'Cash', '0017', 'I0017', 'T0017'),
    ('B0023', 290.00, '2024-06-13', 'CreditCard', '0018', 'I0018', 'T0018'),
    ('B0024', 399.50, '2024-06-14', 'DebitCard', '0019', 'I0019', 'T0019');
ALTER TABLE Bill CHECK CONSTRAINT ALL 

SELECT * FROM Dentist;


ALTER TABLE Appointment NOCHECK CONSTRAINT ALL
INSERT INTO Appointment (AID, Aduration, PID, TID, DID, Diagnosis, Perception, Date, Time)
VALUES
    ('A0001', '60 minutes', '0004', 'T0001', 'D0001', 'Regular check-up', 'Braces', '2024-05-05', '10:00:00'),
    ('A0002', '85 minutes', '0003', 'T0002', 'D0002', 'Tooth extraction', 'follow-up care', '2024-05-06', '11:00:00'),
    ('A0003', '70 minutes', '0001', 'T0003', 'D0003', 'Dental cleaning', 'oral hygiene', '2024-05-07', '12:00:00'),
    ('A0004', '40 minutes', '0004', 'T0004', 'D0004', 'Root canal treatment', 'post-treatment care', '2024-05-08', '13:00:00'),
    ('A0005', '90 minutes', '0002', 'T0005', 'D0005', 'Regular check-up', 'Medication', '2024-05-09', '14:00:00'),
	('A0006', '55 minutes', '0005', 'T0006', 'D0006', 'Teeth whitening', 'Sensitivity warning', '2024-05-10', '09:00:00'),
    ('A0007', '60 minutes', '0006', 'T0007', 'D0007', 'Cavity filling', 'Avoid sweets', '2024-05-11', '10:30:00'),
    ('A0008', '45 minutes', '0007', 'T0008', 'D0008', 'X-ray examination', 'Clear scan', '2024-05-12', '11:45:00'),
    ('A0009', '75 minutes', '0008', 'T0009', 'D0009', 'Tooth implant', 'Healing check', '2024-05-13', '14:00:00'),
    ('A0010', '80 minutes', '0009', 'T0010', 'D0010', 'Gum treatment', 'Antibiotics needed', '2024-05-14', '15:15:00'),
    ('A0011', '65 minutes', '0010', 'T0011', 'D0011', 'Dental bridge', 'Soft food advice', '2024-05-15', '09:30:00'),
    ('A0012', '90 minutes', '0011', 'T0012', 'D0012', 'Regular check-up', 'Maintain hygiene', '2024-05-16', '10:00:00'),
    ('A0013', '40 minutes', '0012', 'T0013', 'D0013', 'Braces adjustment', 'Pain relief tips', '2024-05-17', '11:00:00'),
    ('A0014', '50 minutes', '0013', 'T0014', 'D0014', 'Retainer fitting', 'Usage instructions', '2024-05-18', '12:00:00'),
    ('A0015', '70 minutes', '0014', 'T0015', 'D0015', 'Tooth polishing', 'Avoid coffee', '2024-05-19', '13:00:00'),
    ('A0016', '30 minutes', '0015', 'T0016', 'D0001', 'Initial consultation', 'X-ray scheduled', '2024-05-20', '14:00:00'),
    ('A0017', '45 minutes', '0016', 'T0017', 'D0002', 'Toothache', 'Painkillers prescribed', '2024-05-21', '15:00:00'),
    ('A0018', '35 minutes', '0017', 'T0018', 'D0003', 'Wisdom tooth pain', 'Surgery scheduled', '2024-05-22', '16:00:00'),
    ('A0019', '85 minutes', '0018', 'T0019', 'D0004', 'Mouth infection', 'Antibiotics treatment', '2024-05-23', '09:00:00'),
    ('A0020', '100 minutes', '0019', 'T0020', 'D0005', 'Full dental exam', 'Good condition', '2024-05-24', '10:00:00');
ALTER TABLE Appointment CHECK CONSTRAINT ALL 

ALTER TABLE Dentist
ALTER COLUMN Dspecialization VARCHAR(50);


ALTER TABLE Dentist NOCHECK CONSTRAINT ALL
INSERT INTO Dentist (DID, Dspecialization)
VALUES
    ('D0001', 'Orthodontics'),
    ('D0002', 'Endodontics'),
    ('D0003', 'Pediatric Dentistry'),
    ('D0004', 'Periodontics'),
    ('D0005', 'Oral Surgery'),
	('D0006', 'Prosthodontics'),
    ('D0007', 'Oral Pathology'),
    ('D0008', 'Public Health Dentistry'),
    ('D0009', 'Oral Radiology'),
    ('D0010', 'Implantology'),
    ('D0011', 'Cosmetic Dentistry'),
    ('D0012', 'Geriatric Dentistry'),
    ('D0013', 'Maxillofacial Surgery'),
    ('D0014', 'Laser Dentistry'),
    ('D0015', 'Restorative Dentistry'),
    ('D0016', 'Special Needs Dentistry'),
    ('D0017', 'Temporomandibular Disorders'),
    ('D0018', 'Oral Medicine'),
    ('D0019', 'Forensic Odontology'),
    ('D0020', 'Hospital Dentistry');

ALTER TABLE Dentist CHECK CONSTRAINT ALL

ALTER TABLE Nurse NOCHECK CONSTRAINT ALL
INSERT INTO Nurse (NID, DID)
VALUES
    ('N0001', 'D0001'),
    ('N0002', 'D0002'),
    ('N0003', 'D0003'),
    ('N0004', 'D0004'),
    ('N0005', 'D0005'),
	('N0006', 'D0006'),
    ('N0007', 'D0007'),
    ('N0008', 'D0008'),
    ('N0009', 'D0009'),
    ('N0010', 'D0010'),
    ('N0011', 'D0011'),
    ('N0012', 'D0012'),
    ('N0013', 'D0013'),
    ('N0014', 'D0014'),
    ('N0015', 'D0015'),
    ('N0016', 'D0016'),
    ('N0017', 'D0017'),
    ('N0018', 'D0018'),
    ('N0019', 'D0019'),
    ('N0020', 'D0020');

ALTER TABLE Nurse CHECK CONSTRAINT ALL

ALTER TABLE TechStaff NOCHECK CONSTRAINT ALL
INSERT INTO TechStaff (TID)
VALUES
	('T0001'),
    ('T0002'),
    ('T0003'),
    ('T0004'),
    ('T0005'),
	('T0006'),
    ('T0007'),
    ('T0008'),
    ('T0009'),
    ('T0010'),
	('T0011'),
    ('T0012'),
    ('T0013'),
    ('T0014'),
    ('T0015'),
	('T0016'),
    ('T0017'),
    ('T0018'),
    ('T0019'),
    ('T0020');
ALTER TABLE TechStaff CHECK CONSTRAINT ALL

ALTER TABLE MedicalHistory
ALTER COLUMN Msurgery VARCHAR(50);

ALTER TABLE MedicalHistory NOCHECK CONSTRAINT ALL
INSERT INTO MedicalHistory (MID, Mmed, Msurgery, Mcodnition, Mallergies, PID)
VALUES
    ('M0001', 'Ibuprofen', NULL, 'Toothache', 'None', '0001'),
    ('M0002', 'Lisinopril', NULL, 'Gum disease (Periodontitis)', 'Penicillin', '0002'),
    ('M0003', 'Salbutamol', NULL, 'Dry mouth due to inhaler use', 'Dust', '0003'),
    ('M0004', NULL, 'Tooth extraction', 'Severe tooth decay', 'None', '0004'),
    ('M0005', 'Metformin', NULL, 'Gingivitis (linked to diabetes)', 'Insulin', '0005'),
    ('M0006', 'Ibuprofen', 'Wisdom tooth removal', 'Impacted wisdom teeth', 'None', '0006'),
    ('M0007', 'Paracetamol', NULL, 'Tooth abscess', 'None', '0007'),
    ('M0008', 'Amoxicillin', NULL, 'Periodontitis', 'Penicillin', '0008'),
    ('M0009', NULL, 'Root canal', 'Pulpitis', 'Latex', '0009'),
    ('M0010', 'Chlorhexidine', NULL, 'Gingivitis', 'None', '0010'),
    ('M0011', NULL, NULL, 'Tooth decay', 'Peanuts', '0011'),
    ('M0012', 'Metronidazole', 'Dental implant', 'Tooth loss', 'None', '0012'),
    ('M0013', 'Ibuprofen', NULL, 'Jaw pain (TMJ disorder)', 'None', '0013'),
    ('M0014', NULL, NULL, 'Bruxism (teeth grinding)', 'None', '0014'),
    ('M0015', 'Clindamycin', NULL, 'Post-extraction infection', 'Sulfa drugs', '0015');
ALTER TABLE MedicalHistory CHECK CONSTRAINT ALL

ALTER TABLE Insurance NOCHECK CONSTRAINT ALL
INSERT INTO Insurance (IID, PolicyNum, Insurance_provider, PID)
VALUES
    ('I0011', 'POL001', 'ABC Insurance', '0001'),
    ('I0022', 'POL002', 'XYZ Insurance', '0002'),
    ('I0033', 'POL003', 'DEF Insurance', '0003'),
    ('I0044', 'POL004', 'GHI Insurance', '0004'),
    ('I0055', 'POL005', 'JKL Insurance', '0005');
ALTER TABLE Insurance CHECK CONSTRAINT ALL