-- Insert lawyers
INSERT INTO lawyers (first_name, last_name, firm, email, phone_number) VALUES
('John', 'Smith', 'Smith & Co.', 'john.smith@smithco.com', '123-456-7890'),
('Jane', 'Doe', 'Doe Legal Services', 'jane.doe@doelegal.com', '234-567-8901'),
('Robert', 'Johnson', 'Johnson Partners', 'robert.johnson@johnsonpartners.com', '345-678-9012'),
('Emily', 'Davis', 'Davis Law Firm', 'emily.davis@davislaw.com', '456-789-0123'),
('Michael', 'Brown', 'Brown & Brown LLP', 'michael.brown@brownllp.com', '567-890-1234'),
('Sarah', 'Miller', 'Miller Legal Group', 'sarah.miller@millerlegal.com', '678-901-2345'),
('David', 'Wilson', 'Wilson Attorneys', 'david.wilson@wilsonattorneys.com', '789-012-3456'),
('Laura', 'Taylor', 'Taylor & Associates', 'laura.taylor@taylorassoc.com', '890-123-4567'),
('James', 'Anderson', 'Anderson Law Group', 'james.anderson@andersonlaw.com', '901-234-5678'),
('Olivia', 'Martinez', 'Martinez & Partners', 'olivia.martinez@martinezpartners.com', '012-345-6789');

-- Insert inmates
INSERT INTO inmates (first_name, last_name) VALUES
('Michael', 'Johnson'),
('Sarah', 'Smith'),
('David', 'Brown'),
('Emily', 'Davis'),
('James', 'Wilson'),
('Laura', 'Taylor'),
('Robert', 'Miller'),
('Olivia', 'Martinez'),
('John', 'Anderson'),
('Sophia', 'Garcia');

-- Insert default admin user
INSERT INTO users (first_name, last_name, email, password, ssn, date_of_birth, phone_number, inmate_id)
VALUES ('admin', 'admin', 'admin@prison.com','admin_password_hash', '123456789', '2002-11-17', '71134227', 1),
       ('jean', 'aad', 'jean@prison.com','jeanjean', '123456789', '2000-07-9', '123456', 2);