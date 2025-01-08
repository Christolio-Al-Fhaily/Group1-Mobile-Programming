package com.ulfg2.prison.controller;

import com.ulfg2.prison.persistence.InmateEntity;
import com.ulfg2.prison.repo.InmateRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class InmateController {

    @Autowired
    private InmateRepository repo;

    @RequestMapping(method = RequestMethod.GET, path = "/inmates/{id}")
    public ResponseEntity<InmateEntity> getById(@PathVariable int id) {
        return ResponseEntity.ok(repo.findById(id).orElseThrow());
    }
}
