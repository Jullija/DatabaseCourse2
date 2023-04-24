package org.example;

import javax.persistence.*;

@Entity
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int productID;
    private String ProductName;
    private int UnitsOnStock;

    @Column(name="SUPPLIER_FK")
    private int supplierFK;

    public Product(){
    }

    public Product(String name, int number){
        this.ProductName = name;
        this.UnitsOnStock = number;
    }

}
