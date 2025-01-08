package com.ulfg2.prison.controller;

import com.ulfg2.prison.persistence.LawyerEntity;
import com.ulfg2.prison.repo.LawyerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("")
public class LawyerController {

    @Autowired
    private LawyerRepository repo;

    @RequestMapping(method = RequestMethod.GET, path = "/lawyers")
    public ResponseEntity<List<LawyerEntity>> getAll(){
        return ResponseEntity.ok(repo.findAll());
    }

    @RequestMapping(method = RequestMethod.GET, path = "/lawyers/{id}")
    public ResponseEntity<LawyerEntity> getById(@PathVariable int id){
        return ResponseEntity.ok(repo.findById(id).orElseThrow());
    }

}
