package com.ulfg2.prison.controller;


import com.ulfg2.prison.persistence.ComplaintsEntity;
import com.ulfg2.prison.repo.ComplaintsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class ComplaintsController {

    @Autowired
    private ComplaintsRepository repo;

    @RequestMapping(method = RequestMethod.POST, path = "/complaints")
    public ResponseEntity<String> postComplaint(@RequestBody ComplaintsEntity complaint) {
        try {
            repo.save(complaint);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
        return new ResponseEntity<>(HttpStatus.CREATED);
    }
}
