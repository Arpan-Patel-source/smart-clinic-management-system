# MySQL Schema Design

This document outlines the MySQL database schema design for the Smart Clinic Management System. The schema consists of four well-defined tables with appropriate fields, data types, and foreign key relationships.

## 1. Table: `patient`
Stores the personal and contact information of the clinic's patients.

| Column Name     | Data Type    | Constraints                  | Description                          |
|-----------------|--------------|------------------------------|--------------------------------------|
| `id`            | BIGINT       | PRIMARY KEY, AUTO_INCREMENT  | Unique identifier for the patient.   |
| `name`          | VARCHAR(255) | NOT NULL                     | Full name of the patient.            |
| `email`         | VARCHAR(255) | UNIQUE                       | Contact email address.               |
| `phone`         | VARCHAR(255) |                              | Contact phone number.                |
| `date_of_birth` | DATE         |                              | Patient's date of birth.             |

## 2. Table: `doctor`
Stores information about the doctors working at the clinic.

| Column Name | Data Type    | Constraints                  | Description                          |
|-------------|--------------|------------------------------|--------------------------------------|
| `id`        | BIGINT       | PRIMARY KEY, AUTO_INCREMENT  | Unique identifier for the doctor.    |
| `name`      | VARCHAR(255) | NOT NULL                     | Full name of the doctor.             |
| `specialty` | VARCHAR(255) |                              | Medical specialty (e.g., Cardiology).|

## 3. Table: `doctor_available_times`
Stores the available time slots for doctors. This represents a one-to-many relationship mapping for the doctor's availability.

| Column Name       | Data Type    | Constraints                                  | Description                          |
|-------------------|--------------|----------------------------------------------|--------------------------------------|
| `doctor_id`       | BIGINT       | NOT NULL, FOREIGN KEY REFERENCES `doctor(id)`| Reference to the associated doctor.  |
| `available_times` | VARCHAR(255) | NOT NULL                                     | The specific available time block.   |

## 4. Table: `appointment`
Stores appointment bookings, linking patients to doctors for specific times.

| Column Name        | Data Type    | Constraints                                   | Description                               |
|--------------------|--------------|-----------------------------------------------|-------------------------------------------|
| `id`               | BIGINT       | PRIMARY KEY, AUTO_INCREMENT                   | Unique identifier for the appointment.    |
| `appointment_time` | DATETIME(6)  | NOT NULL                                      | The scheduled date and time.              |
| `doctor_id`        | BIGINT       | FOREIGN KEY REFERENCES `doctor(id)`           | Reference to the doctor.                  |
| `patient_id`       | BIGINT       | FOREIGN KEY REFERENCES `patient(id)`          | Reference to the patient.                 |

## Relationships Summary
- **Appointment to Doctor**: Many-to-One (`appointment.doctor_id` -> `doctor.id`)
- **Appointment to Patient**: Many-to-One (`appointment.patient_id` -> `patient.id`)
- **Doctor to Available Times**: One-to-Many (`doctor_available_times.doctor_id` -> `doctor.id`)
