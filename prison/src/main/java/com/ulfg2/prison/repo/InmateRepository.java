package com.ulfg2.prison.repo;

import com.ulfg2.prison.persistence.InmateEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InmateRepository extends JpaRepository<InmateEntity, Integer> {
}
