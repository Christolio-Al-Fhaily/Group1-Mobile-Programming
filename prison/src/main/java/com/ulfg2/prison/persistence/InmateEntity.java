package com.ulfg2.prison.persistence;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

@Entity
@Table(name = "inmates")
@Getter
@Setter
public class InmateEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @NonNull
    private String firstName;
    @NonNull
    private String lastName;
}
