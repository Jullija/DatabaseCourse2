package org.example;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;

@Entity
public class Invoice {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int invoiceNumber;

    private int quantity;

    @ManyToMany
    private Collection<Product> products = new HashSet<>();

    public Invoice(){
    }

    public void addProduct(Product product, int quantity){
        products.add(product);
        this.quantity += quantity;
    }

    public int getInvoiceNumber(){
        return this.invoiceNumber;
    }

    public int getQuantity(){
        return this.quantity;
    }

    public Collection<String> getProducts(){
        ArrayList<String> names = new ArrayList<>();
        for (Product prod: products){
            names.add(prod.getName());
        }
        return names;
    }

}
