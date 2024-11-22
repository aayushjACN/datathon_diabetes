-- Create the Database
CREATE DATABASE ProcessedDataset;

-- Use the Database
USE DATABASE ProcessedDataset;

-- Create a Schema
CREATE SCHEMA Public;

-- Use the Schema
USE SCHEMA Public;

-- Create a Table for the CSV File
CREATE TABLE Patients (
    PatientId INT AUTOINCREMENT PRIMARY KEY,
    Gender VARCHAR(50),
    Age INT, 
    Hypertension INT, 
    DiabetesPedigreeFunction INT, 
    DietType VARCHAR(50),
    BMI NUMBER,
    Weight NUMBER,
    FamilyDiabetesHistory INT,
    SocialMediaUsage VARCHAR(50),
    PhysicalActivityLevel VARCHAR(50),
    SleepDuration NUMBER,
    StressLevel VARCHAR(50),
    Pregnancies INT,
    AlcoholConsumption VARCHAR(50),
    Diabetes INT,
    AgeGroup VARCHAR(50),
    BMIGroup VARCHAR(50),
    Cluster NUMBER
);

CREATE OR REPLACE FILE FORMAT Public.CSV_FORMAT
TYPE = 'CSV'
SKIP_HEADER = 1
NULL_IF = ('NULL', 'null');

COPY INTO Patients
FROM @Public.GitHubStage/processed_dataset.csv
FILE_FORMAT = (FORMAT_NAME = Public.CSV_FORMAT);

SELECT TOP 20 * FROM Patients;