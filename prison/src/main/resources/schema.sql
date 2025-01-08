-- Create schema for the prison database
CREATE SCHEMA IF NOT EXISTS prison;

-- Use the prison schema
SET SCHEMA prison;


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

-- Create the users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,         -- Unique identifier for each user
    first_name VARCHAR(100) NOT NULL,          -- User's first name
    last_name VARCHAR(100) NOT NULL,           -- User's last name
    email VARCHAR(255) UNIQUE NOT NULL,        -- Email of the user (must be unique)
    password VARCHAR(255) NOT NULL,            -- Encrypted password of the user
    ssn VARCHAR(11) UNIQUE NOT NULL,           -- Social Security Number (unique)
    date_of_birth DATE NOT NULL,               -- User's date of birth
    phone_number VARCHAR(15) NOT NULL,         -- Phone number of the user
    inmate_id INT,                             -- The inmate associated with this user
    FOREIGN KEY (inmate_id) REFERENCES inmates(id)
);

-- CREATE visits table
CREATE TABLE IF NOT EXISTS visits (
    id INT AUTO_INCREMENT PRIMARY KEY,         -- Unique identifier
    inmate_id INT NOT NULL,                    -- Foreign key: Inmate ID
    user_id INT NOT NULL,                      -- Foreign key: User ID
    visit_date DATE NOT NULL,                  -- Date of the visit
    visit_time TIME NOT NULL,                  -- Time of the visit
    duration INT NOT NULL,                     -- Duration of the visit in minutes
    room INT DEFAULT NULL,                     -- Room number (optional)
    status VARCHAR(255) DEFAULT NULL,          -- Status of the visit (optional)
    FOREIGN KEY (inmate_id) REFERENCES inmates(id),  -- Foreign key constraint
    FOREIGN KEY (user_id) REFERENCES users(id)         -- Foreign key constraint
);