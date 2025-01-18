package com.ulfg2.prison.controller;

import com.ulfg2.prison.persistence.NotificationsEntity;
import com.ulfg2.prison.repo.NotificationsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/")
public class NotificationsController {
    @Autowired
    private NotificationsRepository repo;

    @RequestMapping(method = RequestMethod.GET, path = "/notifications/{userId}")
    public ResponseEntity<List<NotificationsEntity>> getNotificationsByUserId(@PathVariable int userId){
        return ResponseEntity.ok(repo.findAllByUserId(userId));
    }


}
