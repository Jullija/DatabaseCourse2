package org.example;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Supplier {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int supplierID;

    private String CompanyName;
    private String Street;
    private String City;

    public Supplier(){

    }
    public Supplier(String name, String street, String city){
        this.CompanyName = name;
        this.Street = street;
        this.City = city;
    }
}
