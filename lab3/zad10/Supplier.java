package org.example;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Set;
import java.util.concurrent.ArrayBlockingQueue;

@Entity
@DiscriminatorValue(value="Supplier")
public class Supplier extends Company{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String bankAccountNumber;

    public Supplier(){
    }
    public Supplier(String nameS, String street, String city, String code, String bank){
        super(nameS, street, city, code);
        this.bankAccountNumber = bank;
    }

}
