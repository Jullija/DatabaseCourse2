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

        Supplier supplier1 = new Supplier("FikuMiku", "Warszawa", "Miła");
        Supplier supplier2 = new Supplier("Chałka", "Kraków", "Całka");

        em.persist(supplier1);
        em.persist(supplier2);


        etx.commit();
        em.close();

    }
}
