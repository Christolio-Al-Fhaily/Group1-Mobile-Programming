-- Create schema for the prison database
CREATE SCHEMA IF NOT EXISTS prison;

-- Use the prison schema
SET SCHEMA prison;

-- Create the users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,         -- Unique identifier for each user
    first_name VARCHAR(100) NOT NULL,          -- User's first name
    last_name VARCHAR(100) NOT NULL,           -- User's last name
    email VARCHAR(255) UNIQUE NOT NULL,        -- Email of the user (must be unique)
    password VARCHAR(255) NOT NULL,            -- Encrypted password of the user
    ssn VARCHAR(11) UNIQUE NOT NULL,           -- Social Security Number (unique)
    date_of_birth DATE NOT NULL,               -- User's date of birth
    phone_number VARCHAR(15) NOT NULL          -- Phone number of the user
);

-- Create lawyers table
CREATE TABLE IF NOT EXISTS lawyers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    firm VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,        -- Email of the user (must be unique)
    phone_number VARCHAR(15) NOT NULL
);

-- Create inmates table
CREATE TABLE IF NOT EXISTS inmates(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);