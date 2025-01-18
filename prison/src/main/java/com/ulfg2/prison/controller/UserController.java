package com.ulfg2.prison.controller;

import com.ulfg2.prison.domain.LoginRequest;
import com.ulfg2.prison.domain.LoginResponse;
import com.ulfg2.prison.persistence.UserEntity;
import com.ulfg2.prison.repo.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class UserController {

    @Autowired
    private UserRepository repo;

    @RequestMapping(method = RequestMethod.POST, path = "/signup")
    public ResponseEntity<String> signUp(@RequestBody UserEntity user) {
        try {
            repo.save(user);
        } catch (DataIntegrityViolationException e) {
            System.out.println(e.getMessage());
            return ResponseEntity.ok("Email already exists or inmate does not exist");
        }
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @RequestMapping(method = RequestMethod.POST, path = "/login")
    public ResponseEntity<LoginResponse> login(@RequestBody LoginRequest loginRequest) {
        UserEntity entity = repo.findByEmail(loginRequest.getEmail());
        if (entity == null || !entity.getPassword().equals(loginRequest.getPassword()))
            return ResponseEntity.notFound().build();
        return ResponseEntity.ok(new LoginResponse(entity));
    }
}
