package com.ulfg2.prison.repo;

import com.ulfg2.prison.persistence.LawyerEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LawyerRepository extends JpaRepository<LawyerEntity, Integer> {
}
