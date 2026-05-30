USE clinicdb;

-- Insert Dummy Data
INSERT IGNORE INTO patient (id, name, email, phone, date_of_birth) VALUES 
(1, 'John Doe', 'john@example.com', '1234567890', '1990-01-01'),
(2, 'Jane Smith', 'jane@example.com', '0987654321', '1985-05-15'),
(3, 'Alice Johnson', 'alice@example.com', '5551112222', '1992-08-20'),
(4, 'Bob Brown', 'bob@example.com', '5553334444', '1978-11-30'),
(5, 'Charlie Davis', 'charlie@example.com', '5559998888', '2000-02-14');

INSERT IGNORE INTO doctor (id, name, email, password, specialty) VALUES 
(1, 'Dr. Gregory House', 'house@clinic.com', 'password', 'Diagnostic Medicine'),
(2, 'Dr. Allison Cameron', 'cameron@clinic.com', 'password', 'Immunology');

INSERT IGNORE INTO doctor_available_times (doctor_id, available_times) VALUES 
(1, '09:00-12:00'), (1, '13:00-17:00'),
(2, '10:00-14:00');

INSERT IGNORE INTO appointment (id, appointment_time, doctor_id, patient_id) VALUES 
(1, '2023-10-15 10:00:00', 1, 1),
(2, '2023-10-15 11:00:00', 1, 2),
(3, '2023-10-16 14:00:00', 2, 3),
(4, '2023-11-20 09:30:00', 1, 4),
(5, '2023-12-05 13:00:00', 2, 5);

-- Drop procedures if they exist
DROP PROCEDURE IF EXISTS GetDailyAppointmentReportByDoctor;
DROP PROCEDURE IF EXISTS GetDoctorWithMostPatientsByMonth;
DROP PROCEDURE IF EXISTS GetDoctorWithMostPatientsByYear;

DELIMITER //

-- Procedure 1
CREATE PROCEDURE GetDailyAppointmentReportByDoctor()
BEGIN
    SELECT d.name AS DoctorName, DATE(a.appointment_time) AS AppointmentDate, COUNT(a.id) AS TotalAppointments
    FROM doctor d
    JOIN appointment a ON d.id = a.doctor_id
    GROUP BY d.id, DATE(a.appointment_time)
    ORDER BY AppointmentDate DESC;
END //

-- Procedure 2
CREATE PROCEDURE GetDoctorWithMostPatientsByMonth(IN target_month INT, IN target_year INT)
BEGIN
    SELECT d.name AS DoctorName, COUNT(DISTINCT a.patient_id) AS UniquePatients
    FROM doctor d
    JOIN appointment a ON d.id = a.doctor_id
    WHERE MONTH(a.appointment_time) = target_month AND YEAR(a.appointment_time) = target_year
    GROUP BY d.id
    ORDER BY UniquePatients DESC
    LIMIT 1;
END //

-- Procedure 3
CREATE PROCEDURE GetDoctorWithMostPatientsByYear(IN target_year INT)
BEGIN
    SELECT d.name AS DoctorName, COUNT(DISTINCT a.patient_id) AS UniquePatients
    FROM doctor d
    JOIN appointment a ON d.id = a.doctor_id
    WHERE YEAR(a.appointment_time) = target_year
    GROUP BY d.id
    ORDER BY UniquePatients DESC
    LIMIT 1;
END //

DELIMITER ;
