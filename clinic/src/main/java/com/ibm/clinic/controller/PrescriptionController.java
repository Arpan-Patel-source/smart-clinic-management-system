package com.ibm.clinic.controller;

import com.ibm.clinic.entity.Prescription;
import com.ibm.clinic.repository.PrescriptionRepository;
import com.ibm.clinic.service.TokenService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/prescriptions")
@RequiredArgsConstructor
public class PrescriptionController {

    private final PrescriptionRepository prescriptionRepository;
    private final TokenService tokenService;

    @PostMapping
    public ResponseEntity<?> savePrescription(
            @RequestHeader(value = "Authorization", required = false) String token,
            @Valid @RequestBody Prescription prescription) {

        if (token == null || !token.startsWith("Bearer ") || !tokenService.validateToken(token.substring(7))) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid or missing token");
        }

        try {
            Prescription saved = prescriptionRepository.save(prescription);
            return ResponseEntity.status(HttpStatus.CREATED).body(saved);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to save prescription: " + e.getMessage());
        }
    }
}
