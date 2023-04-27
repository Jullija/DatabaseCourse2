package org.example;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;


import javax.naming.directory.InvalidAttributesException;
import javax.persistence.*;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.Collection;
import java.util.List;

public class Main {
    private static final SessionFactory ourSessionFactory;

    static {
        try {
            Configuration configuration = new Configuration();
            configuration.configure();

            ourSessionFactory = configuration.buildSessionFactory();
        } catch (Throwable ex) {
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static Session getSession() throws HibernateException {
        return ourSessionFactory.openSession();
    }

    public static void main(final String[] args) throws InvalidAttributesException {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("JuliaSmerdel");
        EntityManager em = emf.createEntityManager();
        EntityTransaction etx = em.getTransaction();
        etx.begin();

        Product prod1 = new Product("Zegarek", 34);
        Product prod2 = new Product("Łódka", 1);
        Product prod3 = new Product("Myszka", 20);
        Product prod4 = new Product("Butelka", 100);

        Invoice invoice1 = new Invoice();
        Invoice invoice2 = new Invoice();

        prod1.sellProduct(14, invoice1);
        prod2.sellProduct(1, invoice1);
        prod1.sellProduct(15, invoice2);
        prod4.sellProduct(33, invoice2);


        em.persist(prod1);
        em.persist(prod2);
        em.persist(prod3);
        em.persist(prod4);
        em.persist(invoice1);
        em.persist(invoice2);

        Invoice invoice = em.find(Invoice.class, 1);
        System.out.println("Invoice number: " + invoice.getInvoiceNumber() + ", items: " + invoice.getProducts());
        Product product = em.find(Product.class, 1);
        System.out.println("Product: " + product.getName() + ", invoices: ");
        Collection<Invoice> invoices = product.getInvoice();
        for (Invoice inv : invoices){
            System.out.println(inv.getInvoiceNumber());
        }

        etx.commit();
        em.close();

    }
}
