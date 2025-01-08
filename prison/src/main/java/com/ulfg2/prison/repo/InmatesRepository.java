package com.ulfg2.prison.repo;

import com.ulfg2.prison.persistence.InmateEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InmatesRepository extends JpaRepository<InmateEntity, Integer> {
}
