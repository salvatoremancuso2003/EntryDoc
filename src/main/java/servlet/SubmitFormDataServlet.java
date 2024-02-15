package servlet;

import entity.DataForm;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/SubmitFormDataServlet")
public class SubmitFormDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("PU");

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Ottieni i parametri inviati dal form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String zip = request.getParameter("zip");
        String country = request.getParameter("country");
        String dobString = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String occupation = request.getParameter("occupation");

        // Effettua il parsing della data di nascita
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date dob = null;
        try {
            dob = dateFormat.parse(dobString);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        // Crea un'istanza di DataForm e imposta i valori
        DataForm dataForm = new DataForm();
        dataForm.setInpu1(name);
        dataForm.setInput2(email);
        dataForm.setInput3(phone);
        dataForm.setInput4(address);
        dataForm.setInput5(city);
        dataForm.setInput6(zip);
        dataForm.setInput7(country);
        dataForm.setDob(dob);
        dataForm.setInput8(gender);
        dataForm.setInput9(occupation);

        // Salva i dati nel database
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(dataForm);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }

        // Invia una risposta al client
        response.setContentType("text/html");
        response.getWriter().println("<html><head><title>Form Submitted</title></head><body>");
        response.getWriter().println("<h1>Dati Ricevuti:</h1>");
        response.getWriter().println("<p>Nome: " + name + "</p>");
        response.getWriter().println("<p>Email: " + email + "</p>");
        response.getWriter().println("<p>Telefono: " + phone + "</p>");
        response.getWriter().println("<p>Indirizzo: " + address + "</p>");
        response.getWriter().println("<p>Città: " + city + "</p>");
        response.getWriter().println("<p>CAP: " + zip + "</p>");
        response.getWriter().println("<p>Paese: " + country + "</p>");
        response.getWriter().println("<p>Data di nascita: " + dobString + "</p>");
        response.getWriter().println("<p>Genere: " + gender + "</p>");
        response.getWriter().println("<p>Occupazione: " + occupation + "</p>");
        response.getWriter().println("</body></html>");
    }
}
