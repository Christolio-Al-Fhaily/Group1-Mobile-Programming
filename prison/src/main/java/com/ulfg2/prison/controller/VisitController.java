package com.ulfg2.prison.controller;

import com.ulfg2.prison.domain.VisitStatus;
import com.ulfg2.prison.persistence.VisitEntity;
import com.ulfg2.prison.repo.VisitRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/")
public class VisitController {

    @Autowired
    private VisitRepository repo;

    @RequestMapping(method = RequestMethod.GET, path = "/visits/{userId}")
    public ResponseEntity<List<VisitEntity>> getUserVisits(@PathVariable int userId){
        return ResponseEntity.ok(repo.findAllByUserId(userId));
    }

    @RequestMapping(method = RequestMethod.POST, path = "/visits")
    public ResponseEntity<Void> createVisit(@RequestBody VisitEntity visit){
        repo.save(visit);
        return ResponseEntity.ok().build();
    }

    @RequestMapping(method= RequestMethod.GET, path = "/visits/{visitId}/cancel")
    public ResponseEntity<VisitEntity> cancelVisit(@PathVariable int visitId){
        VisitEntity visitEntity = repo.findById(visitId).orElseThrow();
        visitEntity.setStatus(VisitStatus.CANCELLED);
        repo.save(visitEntity);
        return ResponseEntity.ok(visitEntity);
    }
}
