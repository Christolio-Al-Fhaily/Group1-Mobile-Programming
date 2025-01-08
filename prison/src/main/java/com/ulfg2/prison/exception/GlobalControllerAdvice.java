package com.ulfg2.prison.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.NoSuchElementException;

@ControllerAdvice
public class GlobalControllerAdvice {

    @ExceptionHandler(exception = NoSuchElementException.class)
    public ResponseEntity<String> handleNoSuchElementException(){
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No such element");
    }
}
