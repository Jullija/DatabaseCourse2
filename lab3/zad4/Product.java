package org.example;

import javax.persistence.*;

@Entity
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int productID;
    private String ProductName;
    private int UnitsOnStock;

    @ManyToOne
    private Supplier supplier;

    public Product(){
    }

    public Product(String name, int number){
        this.ProductName = name;
        this.UnitsOnStock = number;
    }

    public void setSupplier(Supplier supplier){
        this.supplier = supplier;
    }

}
