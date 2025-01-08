package com.ulfg2.prison.persistence;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Table(name = "users")
@Setter
@Getter
public class UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @NonNull
    private String firstName;
    @NonNull
    private String lastName;
    @NonNull
    private String email;
    @NonNull
    private String password;
    @NonNull
    private String ssn;
    @NonNull
    private LocalDate dateOfBirth;
    @NonNull
    private String phoneNumber;
    @OneToOne
    @JoinColumn(name = "inmate_id", nullable = false)
    private InmateEntity inmate;
}
