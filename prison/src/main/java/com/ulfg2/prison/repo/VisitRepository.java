package com.ulfg2.prison.repo;

import com.ulfg2.prison.persistence.VisitEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VisitRepository extends JpaRepository<VisitEntity, Integer> {
    List<VisitEntity> findAllByUserId(int userId);
}
