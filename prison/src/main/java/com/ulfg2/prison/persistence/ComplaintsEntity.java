package com.ulfg2.prison.persistence;

import com.ulfg2.prison.domain.ComplaintType;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

import java.time.LocalDate;


@Entity
@Table(name = "complaints")
@Getter
@Setter
public class ComplaintsEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @NonNull
    private int userId;

    @Enumerated(EnumType.STRING)
    @NonNull
    private ComplaintType complaintType = ComplaintType.OTHER;

    @NonNull
    private LocalDate incidentDate;

    @NonNull
    private String description;
}
