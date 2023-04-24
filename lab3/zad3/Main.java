package org.example;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

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

    public static void main(final String[] args) throws Exception {
        try (Session session = getSession()){
            Transaction tx = session.beginTransaction();

            Product product1 = new Product("Pomidor", 10);
            Product product2 = new Product("Gruszka", 1);
            Product product3 = new Product("Sałata", 12);
            Product product4 = new Product("Jabłko", 4);

            Supplier supplier1 = new Supplier("FikuMiku", "Miła", "Wrocław");
            Supplier supplier2 = new Supplier("Frutki", "Owocowa", "Kraków");
            Supplier supplier3 = new Supplier("PoraNaPomidora", "Pomidorowa", "Warszawa");


            session.save(product1);
            session.save(product2);
            session.save(product3);
            session.save(product4);
            session.save(supplier1);
            session.save(supplier2);
            session.save(supplier3);

            supplier1.setProducts(product4);
            supplier2.setProducts(product2);
            supplier3.setProducts(product1, product3);


            tx.commit();
            session.close();
        }
    }
}
