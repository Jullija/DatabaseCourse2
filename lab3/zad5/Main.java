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

            Product p1 = session.get(Product.class, 5);
            Product p2 = session.get(Product.class, 6);
            Product p3 = session.get(Product.class, 7);
            Product p4 = session.get(Product.class, 8);

            Category category1 = new Category("Warzywa");
            Category category2 = new Category("Owoce");

            category1.addProduct(p1);
            category1.addProduct(p3);
            category2.addProduct(p2);
            category2.addProduct(p4);


            Category category = session.get(Category.class, 1);
            System.out.println("Category: " + category.getName() + ", Products in category: " + category.getProducts());

            Product product = session.get(Product.class, 5);
            System.out.println("Product: " + product.getName() + ", Category: " + product.getCategory().getName());

            tx.commit();
            session.close();
        }
    }
}
