package com.ulfg2.prison.domain;

import com.ulfg2.prison.persistence.UserEntity;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class LoginResponse {
    private int id;
    private String firstName;
    private String lastName;
    private String email;
    private int inmateId;

    public LoginResponse(UserEntity entity) {
        this.id = entity.getId();
        this.firstName = entity.getFirstName();
        this.lastName = entity.getLastName();
        this.email = entity.getEmail();
        this.inmateId = entity.getInmateId();
    }
}
