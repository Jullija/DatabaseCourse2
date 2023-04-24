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

            Product product = session.get(Product.class, 1);
            Supplier supplier = new Supplier("FikuMiku", "Miła", "Wrocław");

            product.setSupplier(supplier);

            session.save(product);
            session.save(supplier);
            tx.commit();
            session.close();
        }
    }
}
