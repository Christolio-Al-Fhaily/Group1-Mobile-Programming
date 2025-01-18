package com.ulfg2.prison.persistence;

import com.ulfg2.prison.domain.NotificationType;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

;

@Entity
@Table(name = "notifications")
@Getter
@Setter

public class NotificationsEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @NonNull
    private int userId;

    @Enumerated(EnumType.STRING)
    @NonNull
    private NotificationType notificationType = NotificationType.OTHER;

    @NonNull
    private String notificationMessage;
}
