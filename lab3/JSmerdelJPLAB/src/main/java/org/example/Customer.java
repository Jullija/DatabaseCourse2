package org.example;

import javax.persistence.*;

@Entity
@DiscriminatorValue(value="Customer")
public class Customer extends Company{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private double discount;

    public Customer(){}

    public Customer(String name, String street, String city, String code, double dis){
        super(name, street, city, code);
        this.discount = dis;
    }
}
