package org.example;

import javax.persistence.Embeddable;

@Embeddable
public class Address {
    private String city;
    private String street;

    public Address(){}

    public Address(String city, String street){
        this.city = city;
        this.street = street;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCity() {
        return city;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getStreet() {
        return street;
    }
}
