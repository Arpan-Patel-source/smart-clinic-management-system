# 🏥 Smart Clinic Management System

A Spring Boot REST API backend for managing a smart clinic — built as part of the IBM Capstone Project.

## 🚀 Tech Stack

- **Backend:** Java 17, Spring Boot 4.0.6
- **Database:** MySQL 8
- **Security:** Spring Security + JWT (jjwt)
- **ORM:** Spring Data JPA / Hibernate
- **Build Tool:** Maven
- **Containerization:** Docker

## 📁 Project Structure

```
clinic/
├── src/main/java/com/ibm/clinic/
│   ├── config/          # Security configuration
│   ├── controller/      # REST API controllers
│   ├── entity/          # JPA entities
│   ├── repository/      # Spring Data repositories
│   └── service/         # Business logic
├── Dockerfile
└── pom.xml
```

## 🔗 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/patients` | Get all patients |
| POST | `/api/patients` | Add a new patient |
| GET | `/api/doctors` | Get all doctors |
| POST | `/api/doctors` | Add a new doctor |
| GET | `/api/doctors/availability` | Get doctor availability (JWT required) |
| GET | `/api/appointments` | Get all appointments |
| POST | `/api/appointments` | Book an appointment |
| POST | `/api/prescriptions` | Save a prescription (JWT required) |

## ⚙️ Setup & Run

1. **Clone the repo**
   ```bash
   git clone https://github.com/Arpan-Patel-source/smart-clinic-management-system.git
   cd smart-clinic-management-system/clinic
   ```

2. **Configure MySQL** — Create a database named `clinicdb` and update `application.properties` if needed.

3. **Run the app**
   ```bash
   ./mvnw spring-boot:run
   ```

4. **Run with Docker**
   ```bash
   docker build -t smart-clinic .
   docker run -p 8080:8080 smart-clinic
   ```

## 🗄️ Database

- Schema and stored procedures: [`db_setup.sql`](db_setup.sql)
- Schema design documentation: [`schema-design.md`](schema-design.md)

### Tables
| Table | Description |
|-------|-------------|
| `patient` | Stores patient personal info |
| `doctor` | Stores doctor profiles and specialties |
| `doctor_available_times` | Stores available time slots per doctor |
| `appointment` | Links patients to doctors with a scheduled time |
| `prescription` | Stores prescriptions issued by doctors |

### Stored Procedures
- `GetDailyAppointmentReportByDoctor()` — Daily appointment counts per doctor
- `GetDoctorWithMostPatientsByMonth(month, year)` — Top doctor for a given month
- `GetDoctorWithMostPatientsByYear(year)` — Top doctor for a given year

## 📋 User Stories

See [`user-stories.md`](user-stories.md) for full role-based user stories (Patient, Doctor, Admin).

## 🔒 Authentication

JWT-based token authentication. Generate a token via doctor login and pass it in the `Authorization: Bearer <token>` header for protected endpoints.

## ✅ CI/CD

GitHub Actions workflow automatically compiles and tests the project on every push and pull request. See [`.github/workflows/build.yml`](.github/workflows/build.yml).

## 📸 Portals

| Portal | File |
|--------|------|
| Admin Portal | [`admin-portal.html`](admin-portal.html) |
| Doctor Portal | [`doctor-portal.html`](doctor-portal.html) |
| Patient Portal | [`patient-portal.html`](patient-portal.html) |
