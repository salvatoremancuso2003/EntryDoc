package entity;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.TypedQuery;
import org.mindrot.jbcrypt.BCrypt;

public class AuthService {

    public static User authenticate_US(String username, String enteredPassword) {
        try {
            EntityManagerFactory entityManagerFactory = HibernateUtil.getEntityManagerFactory();
            EntityManager entityManager = entityManagerFactory.createEntityManager();

            TypedQuery<User> query = entityManager.createNamedQuery("getUtenteUSPASS", User.class);
            query.setParameter("username", username);
            query.setMaxResults(1);
            List<User> resultList = query.getResultList();
            if (!resultList.isEmpty()) {
                User user = resultList.get(0);
                String hashedPasswordFromDatabase = user.getPassword();
                boolean isPasswordValid = BCrypt.checkpw(enteredPassword, hashedPasswordFromDatabase);
                if (isPasswordValid) {
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Autenticazione fallita
    }
    public static int authenticate(String username, String enteredPassword) {
        try {
            EntityManagerFactory entityManagerFactory = HibernateUtil.getEntityManagerFactory();
            EntityManager entityManager = entityManagerFactory.createEntityManager();

            TypedQuery<User> query = entityManager.createNamedQuery("getUtenteUSPASS", User.class);
            query.setParameter("username", username);
            query.setMaxResults(1);
            List<User> resultList = query.getResultList();
            if (!resultList.isEmpty()) {
                User user = resultList.get(0);
                String hashedPasswordFromDatabase = user.getPassword();
                boolean isPasswordValid = BCrypt.checkpw(enteredPassword, hashedPasswordFromDatabase);
                if (isPasswordValid) {
                    return user.getRuolo().getId();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // Autenticazione fallita
    }

    public static boolean isPasswordValid(String username, String enteredPassword) {
        try {
            EntityManagerFactory entityManagerFactory = HibernateUtil.getEntityManagerFactory();
            EntityManager entityManager = entityManagerFactory.createEntityManager();

            TypedQuery<User> query = entityManager.createNamedQuery("getUtenteUSPASS", User.class);
            query.setParameter("username", username);
            query.setMaxResults(1);
            List<User> resultList = query.getResultList();

            if (!resultList.isEmpty()) {
                User user = resultList.get(0);
                String hashedPasswordFromDatabase = user.getPassword();

                return BCrypt.checkpw(enteredPassword, hashedPasswordFromDatabase);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Password non valida o errore
    }
}
