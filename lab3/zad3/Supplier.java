package org.example;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Set;
import java.util.concurrent.ArrayBlockingQueue;

@Entity
public class Supplier {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long supplierID;

    private String CompanyName;
    private String Street;
    private String City;

    @OneToMany
    @JoinColumn(name="SUPPLIER_FK")
    private Collection<Product> products = new ArrayList<>();


    public Supplier(){

    }
    public Supplier(String name, String street, String city){
        this.CompanyName = name;
        this.Street = street;
        this.City = city;
    }

    public void setProducts(Product ...products){
        this.products.addAll(Arrays.asList(products));
    }

    public Collection<Product> getProducts(){
        return this.products;
    }
}
