package org.example;

import javax.naming.directory.InvalidAttributesException;
import javax.persistence.*;
import java.util.Collection;
import java.util.HashSet;

@Entity
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int productID;
    private String ProductName;
    private int UnitsOnStock;

    @ManyToMany(mappedBy = "products", cascade = {CascadeType.PERSIST})
    private Collection<Invoice> invoices = new HashSet<>();

    public Product(){
    }

    public Product(String name, int number){
        this.ProductName = name;
        this.UnitsOnStock = number;
    }

    public String getName(){
        return this.ProductName;
    }

    public Collection<Invoice> getInvoice(){
        return this.invoices;
    }
    public int getUnitsOnStock(){
        return this.UnitsOnStock;
    }

    public void sellProduct(int wantsToBuy, Invoice invoice) throws InvalidAttributesException {
        if (wantsToBuy > this.UnitsOnStock){
            throw new InvalidAttributesException("Cannot sell more than it is available");
        }
        this.UnitsOnStock -= wantsToBuy;
        invoice.addProduct(this, wantsToBuy);
        invoices.add(invoice);
    }

}
