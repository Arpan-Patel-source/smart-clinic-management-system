package com.ibm.clinic.service;

import com.ibm.clinic.entity.Doctor;
import com.ibm.clinic.repository.DoctorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class DoctorService {

    private final DoctorRepository doctorRepository;
    private final TokenService tokenService;

    public List<Doctor> getAllDoctors() {
        return doctorRepository.findAll();
    }

    public Optional<Doctor> getDoctorById(Long id) {
        return doctorRepository.findById(id);
    }

    public Doctor saveDoctor(Doctor doctor) {
        return doctorRepository.save(doctor);
    }

    public void deleteDoctor(Long id) {
        doctorRepository.deleteById(id);
    }

    public List<String> getAvailableTimeSlots(LocalDate date, Long doctorId) {
        return doctorRepository.findById(doctorId)
                .map(Doctor::getAvailableTimes)
                .orElse(Collections.emptyList());
    }

    public String validateCredentials(String email, String password) {
        Optional<Doctor> doctorOpt = doctorRepository.findByEmail(email);
        if (doctorOpt.isPresent() && doctorOpt.get().getPassword().equals(password)) {
            return tokenService.generateToken(email);
        }
        throw new RuntimeException("Invalid credentials");
    }
}
