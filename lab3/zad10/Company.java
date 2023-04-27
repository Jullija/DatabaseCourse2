package org.example;

import javax.persistence.*;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="companyType")
public abstract class Company {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String companyName;
    private String street;
    private String city;
    private String zipCode;

    public Company(){}

    public Company(String name, String street, String city, String zipCode){
        this.companyName = name;
        this.street = street;
        this.city = city;
        this.zipCode = zipCode;
    }

    public String getStreet() {
        return street;
    }

    public String getCity() {
        return city;
    }

    public int getCompanyID() {
        return id;
    }

    public String getCompanyName() {
        return companyName;
    }

    public String getZipCode() {
        return zipCode;
    }

}

