package org.example;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Entity
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int categoryID;

    private String name;

    @OneToMany
    private Collection<Product> products = new ArrayList<>();

    public Category(){

    }

    public Category(String name){
        this.name = name;
    }

    public void addProduct(Product product){
        products.add(product);
    }

    public ArrayList<String> getProducts(){
        ArrayList<String> names = new ArrayList<>();
        for (Product prod: products){
            names.add(prod.getName());
        }
        return names;
    }
    public String getName(){
        return this.name;
    }
}
