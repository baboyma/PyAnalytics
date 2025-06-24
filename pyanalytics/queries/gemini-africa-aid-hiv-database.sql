-- SQL Script for AfricaAID PEPFAR/HIV Treatment Programs Database
-- Designed to demonstrate Common Table Expressions (CTEs)

-- 1. Create Tables

-- Table for Countries involved in PEPFAR programs
CREATE TABLE Countries (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL,
    continent VARCHAR(50)
);

-- Table for Implementing Partners
CREATE TABLE Partners (
    partner_id INT PRIMARY KEY,
    partner_name VARCHAR(255) NOT NULL,
    partner_type VARCHAR(100) -- e.g., 'Local NGO', 'International NGO', 'Government Agency'
);

-- Table for Program Sites where services are delivered
CREATE TABLE ProgramSites (
    site_id INT PRIMARY KEY,
    site_name VARCHAR(255) NOT NULL,
    country_id INT,
    partner_id INT,
    site_type VARCHAR(100), -- e.g., 'Hospital', 'Clinic', 'Community Center'
    latitude DECIMAL(9, 6),
    longitude DECIMAL(9, 6),
    FOREIGN KEY (country_id) REFERENCES Countries(country_id),
    FOREIGN KEY (partner_id) REFERENCES Partners(partner_id)
);

-- Table for HIV Treatment Enrollments
CREATE TABLE TreatmentEnrollments (
    enrollment_id INT PRIMARY KEY,
    site_id INT,
    enrollment_date DATE NOT NULL,
    patient_age INT,
    patient_gender VARCHAR(10), -- 'Male', 'Female', 'Other'
    treatment_status VARCHAR(50), -- e.g., 'Active', 'Lost to Follow-up', 'Deceased'
    FOREIGN KEY (site_id) REFERENCES ProgramSites(site_id)
);

-- Table for PEPFAR Funding Allocations
CREATE TABLE FundingAllocations (
    funding_id INT PRIMARY KEY,
    partner_id INT,
    country_id INT,
    fiscal_year INT NOT NULL,
    allocated_amount DECIMAL(18, 2) NOT NULL,
    fund_category VARCHAR(100), -- e.g., 'Prevention', 'Treatment', 'Care & Support', 'Lab Services'
    FOREIGN KEY (partner_id) REFERENCES Partners(partner_id),
    FOREIGN KEY (country_id) REFERENCES Countries(country_id)
);

-- 2. Insert Synthetic Data (2023-2024)

-- Countries
INSERT INTO Countries (country_id, country_name, continent) VALUES
(1, 'South Africa', 'Africa'),
(2, 'Kenya', 'Africa'),
(3, 'Uganda', 'Africa'),
(4, 'Tanzania', 'Africa'),
(5, 'Zambia', 'Africa');

-- Partners
INSERT INTO Partners (partner_id, partner_name, partner_type) VALUES
(101, 'Global Health Initiative', 'International NGO'),
(102, 'African AIDS Network', 'Local NGO'),
(103, 'Ministry of Health - Kenya', 'Government Agency'),
(104, 'Youth Empowerment Foundation', 'Local NGO'),
(105, 'Disease Control Alliance', 'International NGO');

-- ProgramSites
INSERT INTO ProgramSites (site_id, site_name, country_id, partner_id, site_type, latitude, longitude) VALUES
(1001, 'Pretoria General Hospital', 1, 101, 'Hospital', -25.747868, 28.229271),
(1002, 'Nairobi Community Clinic', 2, 103, 'Clinic', -1.292066, 36.821946),
(1003, 'Kampala Central Health Center', 3, 102, 'Community Center', 0.347596, 32.582520),
(1004, 'Dar es Salaam Urban Clinic', 4, 101, 'Clinic', -6.792354, 39.208328),
(1005, 'Lusaka Regional Hospital', 5, 105, 'Hospital', -15.387520, 28.322817),
(1006, 'Cape Town HIV Wellness Center', 1, 102, 'Community Center', -33.924900, 18.424100),
(1007, 'Kisumu Referral Hospital', 2, 101, 'Hospital', -0.091700, 34.767900),
(1008, 'Mbarara District Clinic', 3, 104, 'Clinic', -0.604800, 30.655800),
(1009, 'Dodoma Regional Clinic', 4, 103, 'Clinic', -6.163100, 35.751900),
(1010, 'Ndola Urban Health Post', 5, 102, 'Community Center', -12.981800, 28.636600);

-- TreatmentEnrollments (Synthetic data for 2023-2024)
INSERT INTO TreatmentEnrollments (enrollment_id, site_id, enrollment_date, patient_age, patient_gender, treatment_status) VALUES
-- 2023 Enrollments
(1, 1001, '2023-01-15', 35, 'Female', 'Active'),
(2, 1002, '2023-02-01', 28, 'Male', 'Active'),
(3, 1003, '2023-03-10', 42, 'Female', 'Active'),
(4, 1004, '2023-04-05', 19, 'Male', 'Active'),
(5, 1005, '2023-05-20', 50, 'Female', 'Active'),
(6, 1001, '2023-06-01', 22, 'Male', 'Active'),
(7, 1002, '2023-07-11', 30, 'Female', 'Active'),
(8, 1003, '2023-08-19', 45, 'Male', 'Lost to Follow-up'),
(9, 1004, '2023-09-02', 26, 'Female', 'Active'),
(10, 1005, '2023-10-14', 38, 'Male', 'Active'),
(11, 1006, '2023-11-20', 31, 'Female', 'Active'),
(12, 1007, '2023-12-05', 24, 'Male', 'Active'),
(13, 1008, '2023-12-25', 55, 'Female', 'Active'),
-- 2024 Enrollments
(14, 1001, '2024-01-08', 29, 'Female', 'Active'),
(15, 1002, '2024-02-18', 33, 'Male', 'Active'),
(16, 1003, '2024-03-01', 40, 'Female', 'Active'),
(17, 1004, '2024-04-12', 21, 'Male', 'Active'),
(18, 1005, '2024-05-01', 48, 'Female', 'Active'),
(19, 1006, '2024-06-10', 27, 'Male', 'Active'),
(20, 1007, '2024-07-01', 36, 'Female', 'Active'),
(21, 1008, '2024-08-15', 52, 'Male', 'Deceased'),
(22, 1009, '2024-09-01', 23, 'Female', 'Active'),
(23, 1010, '2024-10-20', 39, 'Male', 'Active'),
(24, 1001, '2024-11-05', 30, 'Female', 'Active'),
(25, 1002, '2024-12-10', 25, 'Male', 'Active');


-- FundingAllocations (Synthetic data for 2023-2024)
INSERT INTO FundingAllocations (funding_id, partner_id, country_id, fiscal_year, allocated_amount, fund_category) VALUES
-- 2023 Allocations
(10001, 101, 1, 2023, 500000.00, 'Treatment'),
(10002, 103, 2, 2023, 300000.00, 'Prevention'),
(10003, 102, 3, 2023, 250000.00, 'Care & Support'),
(10004, 101, 4, 2023, 400000.00, 'Treatment'),
(10005, 105, 5, 2023, 350000.00, 'Lab Services'),
(10006, 102, 1, 2023, 150000.00, 'Prevention'),
(10007, 101, 2, 2023, 200000.00, 'Care & Support'),
-- 2024 Allocations
(10008, 101, 1, 2024, 550000.00, 'Treatment'),
(10009, 103, 2, 2024, 320000.00, 'Prevention'),
(10010, 102, 3, 2024, 270000.00, 'Care & Support'),
(10011, 101, 4, 2024, 420000.00, 'Treatment'),
(10012, 105, 5, 2024, 380000.00, 'Lab Services'),
(10013, 104, 3, 2024, 100000.00, 'Prevention'),
(10014, 103, 4, 2024, 180000.00, 'Care & Support');

-- Prompt: write a query using cte to calculate the percentage of patients by country and by treatment status

-- SQL Query to calculate the percentage of patients by country and treatment status using CTEs

WITH
-- CTE 1: Count enrollments per country and treatment status
EnrollmentsByCountryAndStatus AS (
    SELECT
        c.country_name,
        te.treatment_status,
        COUNT(te.enrollment_id) AS num_enrollments
    FROM
        TreatmentEnrollments te
    JOIN
        ProgramSites ps ON te.site_id = ps.site_id
    JOIN
        Countries c ON ps.country_id = c.country_id
    GROUP BY
        c.country_name,
        te.treatment_status
),
-- CTE 2: Count total enrollments per country
TotalEnrollmentsByCountry AS (
    SELECT
        c.country_name,
        COUNT(te.enrollment_id) AS total_enrollments_country
    FROM
        TreatmentEnrollments te
    JOIN
        ProgramSites ps ON te.site_id = ps.site_id
    JOIN
        Countries c ON ps.country_id = c.country_id
    GROUP BY
        c.country_name
)
-- Main query: Calculate percentage
SELECT
    ecas.country_name,
    ecas.treatment_status,
    ecas.num_enrollments,
    tebc.total_enrollments_country,
    (CAST(ecas.num_enrollments AS REAL) * 100.0 / tebc.total_enrollments_country) AS percentage_of_patients
FROM
    EnrollmentsByCountryAndStatus ecas
JOIN
    TotalEnrollmentsByCountry tebc ON ecas.country_name = tebc.country_name
ORDER BY
    ecas.country_name,
    ecas.treatment_status;

-- Prompt: Is there another way to write this with only 1 CTE?

-- SQL Query to calculate the percentage of patients by country and treatment status using a single CTE

WITH
-- CTE: Calculate enrollments per country and status, and total enrollments per country using a window function
EnrollmentsData AS (
    SELECT
        c.country_name,
        te.treatment_status,
        COUNT(te.enrollment_id) AS num_enrollments,
        -- Calculate total enrollments for each country using a window function
        SUM(COUNT(te.enrollment_id)) OVER (PARTITION BY c.country_name) AS total_enrollments_country
    FROM
        TreatmentEnrollments te
    JOIN
        ProgramSites ps ON te.site_id = ps.site_id
    JOIN
        Countries c ON ps.country_id = c.country_id
    GROUP BY
        c.country_name,
        te.treatment_status
)
-- Main query: Calculate percentage using the results from the single CTE
SELECT
    country_name,
    treatment_status,
    num_enrollments,
    total_enrollments_country,
    (CAST(num_enrollments AS REAL) * 100.0 / total_enrollments_country) AS percentage_of_patients
FROM
    EnrollmentsData
ORDER BY
    country_name,
    treatment_status;
