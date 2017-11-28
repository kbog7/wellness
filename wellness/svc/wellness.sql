SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Contact CASCADE;
CREATE TABLE Contact (
    contactId int AUTO_INCREMENT PRIMARY KEY,
    phoneNumber varchar(50),
    typeOfContact ENUM('Home', 'Emergency', 'Cell', 'Work')
);
DROP TABLE IF EXISTS Insurance CASCADE;
CREATE TABLE Insurance (
    insuranceId int AUTO_INCREMENT PRIMARY KEY,
    brand varchar(200),
    plan varchar(200),
    termExpiration Date NULL
);
DROP TABLE IF EXISTS User CASCADE;
CREATE TABLE User (
    userId int AUTO_INCREMENT PRIMARY KEY,
    insuranceId int NOT NULL,
    addressId int NOT NULL,
    contactId int NOT NULL,
    emergencyContactId int NOT NULL,
    healthId int NOT NULL,
    firstName varchar(200),
    lastName varchar(200),
    gender varchar(50),
    dateOfBirth DATE NULL,
    FOREIGN KEY (insuranceId) REFERENCES Insurance(insuranceId),
    FOREIGN KEY (addressId) REFERENCES Address(addressId),
    FOREIGN KEY (contactId) REFERENCES Contact(contactId),
    FOREIGN KEY (emergencyContactId) REFERENCES Contact(contactId),
    FOREIGN KEY (healthId) REFERENCES Health(healthId)
);
DROP TABLE IF EXISTS Health CASCADE;
CREATE TABLE Health (
    healthId int AUTO_INCREMENT PRIMARY KEY,
    userId int NOT NULL,
    heightInches int,
    weightInPounds int,
    bodyMassIndex int,
    FOREIGN KEY (userId) REFERENCES User(userId)
);
DROP TABLE IF EXISTS Procedures CASCADE;
CREATE TABLE Procedures (
    proceduresId int AUTO_INCREMENT PRIMARY KEY,
    appointmentId int NOT NULL,
    medicalReportId int NOT NULL,
    proceduresType ENUM('General', 'Surgery', 'Psychiatrist'),
    proceduresDesc varchar(500),
    cost decimal(10,2),
    FOREIGN KEY (appointmentId) REFERENCES Appointment(appointmentId),
    FOREIGN KEY (medicalReportId) REFERENCES MedicalReport(medicalReportId)
);
DROP TABLE IF EXISTS Appointment CASCADE;
CREATE TABLE Appointment (
    appointmentId int AUTO_INCREMENT PRIMARY KEY,
    userId int NOT NULL,
    addressId int NOT NULL,
    proceduresId int NOT NULL,
    reason varchar(500),
    dateOfAppointment Timestamp NULL,
    FOREIGN KEY (userId) REFERENCES User(userId),
    FOREIGN KEY (addressId) REFERENCES Address(addressId),
    FOREIGN KEY (proceduresId) REFERENCES Procedures(proceduresId)
);
DROP TABLE IF EXISTS Address CASCADE;
CREATE TABLE Address (
    addressId int AUTO_INCREMENT PRIMARY KEY,
    zipCode int,
    stateAbbr varchar(2),
    city varchar(200),
    building ENUM('Home', 'Hospital')
);
DROP TABLE IF EXISTS Providers CASCADE;
CREATE TABLE Providers (
    providersId int AUTO_INCREMENT PRIMARY KEY,
    contactId int NOT NULL,
    addressId int NOT NULL,
    proceduresId int NULL,
    firstName varchar(200),
    lastName varchar(200),
    specialty ENUM('General', 'Surgery', 'Psychiatrist'),
    FOREIGN KEY (contactId) REFERENCES Contact(contactId),
    FOREIGN KEY (addressId) REFERENCES Address(addressId),
    FOREIGN KEY (proceduresId) REFERENCES Procedures(proceduresId)
);
DROP TABLE IF EXISTS Prescription CASCADE;
CREATE TABLE Prescription (
    prescriptionId int AUTO_INCREMENT PRIMARY KEY,
    proceduresId int NULL,
    nameOfPrescription varchar(200),
    dosage varchar(200),
    directions varchar(500),
    cost decimal(10,2),
    FOREIGN KEY (proceduresId) REFERENCES Procedures(proceduresId)
);
DROP TABLE IF EXISTS MedicalReport CASCADE;
CREATE TABLE MedicalReport (
    medicalReportId int AUTO_INCREMENT PRIMARY KEY,
    proceduresId int NOT NULL,
    dateOfReport Date NULL,
    report varchar(500),
    FOREIGN KEY (proceduresId) REFERENCES Procedures(proceduresId)
);
SET FOREIGN_KEY_CHECKS=1;

-- Seeding Data
INSERT INTO Contact (phoneNumber, typeOfContact) VALUES
    ('(215) 111-1111', 'Work'),
    ('(215) 222-2222', 'Work'),
    ('(215) 333-3333', 'Work');

INSERT INTO Address (zipCode, stateAbbr, city, building) VALUES
    (19102, 'PA', 'Philadelphia', 'Hospital'),
    (15106, 'PA', 'Pittsburgh', 'Hospital');

INSERT INTO Providers (contactId, addressId, proceduresId, firstName, lastName, specialty) VALUES
    (1, 1, NULL, 'Saurin', 'Shah', 'General'),
    (2, 2, NULL, 'James', 'Smith', 'Psychiatrist'),
    (3, 1, NULL, 'Jane', 'Doe', 'Surgery');
