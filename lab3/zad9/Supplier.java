package org.example;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Set;
import java.util.concurrent.ArrayBlockingQueue;

@Entity
@SecondaryTable(name="AddressTable")
public class Supplier {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int supplierID;

    private String CompanyName;

    @Column(table = "AddressTable")
    private String street;
    @Column(table = "AddressTable")
    private String city;

    public Supplier(){

    }
    public Supplier(String name, String city, String street){
        this.CompanyName = name;
        this.city = city;
        this.street = street;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }
}
