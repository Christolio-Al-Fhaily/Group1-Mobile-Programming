package com.ulfg2.prison.persistence;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ulfg2.prison.domain.VisitStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "visits")
@Getter
@Setter
public class VisitEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @NonNull
    private int inmateId;

    @NonNull
    private int userId;

    @NonNull
    private LocalDate visitDate;

    @NonNull
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "hh:mm a")
    private LocalTime visitTime;

    @NonNull
    private int duration;

    @NonNull
    private Integer room;

    @Enumerated(EnumType.STRING)
    @NonNull
    private VisitStatus status = VisitStatus.PENDING;
}
