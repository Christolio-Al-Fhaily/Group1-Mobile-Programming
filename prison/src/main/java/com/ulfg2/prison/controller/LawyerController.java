package com.ulfg2.prison.controller;

import com.ulfg2.prison.persistence.LawyerEntity;
import com.ulfg2.prison.repo.LawyerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("")
public class LawyerController {

    @Autowired
    private LawyerRepository repo;

    @RequestMapping(method = RequestMethod.GET, path = "/lawyers")
    public List<LawyerEntity> getAll(){
        return repo.findAll();
    }

    @RequestMapping(method = RequestMethod.GET, path = "/lawyers/{id}")
    public LawyerEntity getById(@PathVariable int id){
        return repo.findById(id).orElseThrow();
    }

}
