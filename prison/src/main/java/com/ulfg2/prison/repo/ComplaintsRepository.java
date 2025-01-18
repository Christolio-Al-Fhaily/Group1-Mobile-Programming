package com.ulfg2.prison.repo;

import com.ulfg2.prison.persistence.ComplaintsEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ComplaintsRepository extends JpaRepository<ComplaintsEntity, Integer> {

}
