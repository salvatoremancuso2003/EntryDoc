package servlet;

import entity.DataForm;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;

public class SubmitDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("entryDoc");

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Ottieni i parametri inviati dal form
        String name = request.getParameter("input1");
        String email = request.getParameter("input2");
        String phone = request.getParameter("input3");
        String address = request.getParameter("input4");
        String city = request.getParameter("input5");
        String zip = request.getParameter("input6");
        String country = request.getParameter("input7");
        String dobString = request.getParameter("input8");
        String gender = request.getParameter("input9");
        String occupation = request.getParameter("input10");

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
        /*response.setContentType("text/html");
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
        response.getWriter().println("</body></html>");*/
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

