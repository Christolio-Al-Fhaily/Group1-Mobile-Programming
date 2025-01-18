package com.ulfg2.prison.repo;

import com.ulfg2.prison.persistence.NotificationsEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NotificationsRepository extends JpaRepository<NotificationsEntity, Integer> {
    List<NotificationsEntity> findAllByUserId(int userId);

}
