/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import entity.Pagina;
import java.security.SecureRandom;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Aldo
 */
public class Utils {

    // Metodo per sanitificare gli input
    public static String sanitizeInput(String input) {
        // Rimuovi i caratteri che non sono lettere, numeri o underscore
        String sanitizedInput = input.replaceAll("[^a-zA-Z0-9_]", "");

        // Aggiungi un controllo per i caratteri HTML riservati
        sanitizedInput = sanitizedInput.replaceAll("&", "&amp;")
                .replaceAll("<", "&lt;")
                .replaceAll(">", "&gt;")
                .replaceAll("\"", "&quot;")
                .replaceAll("'", "&#39;");

        return sanitizedInput;
    }

    // Generatore di password sicuro
    public static String generatePassword(int length) {

        Random RANDOM = new SecureRandom();
        String POSSIBLE_CHARACTERS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-+=!@#$%&*()[]{}<>:.,?";

        StringBuilder password = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            password.append(POSSIBLE_CHARACTERS.charAt(RANDOM.nextInt(POSSIBLE_CHARACTERS.length())));
        }
        return password.toString();
    }

    // Controllo per utente della sessione
    public static Boolean isVisible(String ruolo, String page) {
        if (ruolo == null || ruolo.isEmpty() || page == null || page.isEmpty()) {
            return false;
        }

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("entryDoc");
        EntityManager em = emf.createEntityManager();

        try {
            String jpql = "SELECT p FROM Pagina p WHERE p.nome = :page";
            TypedQuery<Pagina> query = em.createQuery(jpql, Pagina.class);
            query.setParameter("page", page);

            Pagina pagina = query.getSingleResult();

            String[] permessi = pagina.getPermessi().split("-");

            for (String permesso : permessi) {
                if (permesso.equals(ruolo)) {
                    return true;
                }
            }

        } catch (NoResultException e) {
            return false;
        } catch (Exception e) {
            Logger.getLogger(Utils.class.getName()).log(Level.SEVERE, "Errore durante l'esecuzione del metodo ", e);
            return false;
        } finally {
            em.close();
            emf.close();
        }

        return false;
    }

    public static String checkAttribute(HttpSession session, String attribute) {
        try {
            if (session.getAttribute(attribute) != null) {
                return String.valueOf(session.getAttribute(attribute));
            }
        } catch (Exception e) {
        }
        return "";
    }
    
    
    
    
    
    
}
