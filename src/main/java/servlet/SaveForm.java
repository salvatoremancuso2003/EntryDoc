/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import entity.CampoFileValue;
import entity.Campo_form;
import entity.FileEntity;
import entity.User;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;

/**
 *
 * @author Salvatore
 */
public class SaveForm extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long idFileEntity = Long.parseLong(request.getParameter("idFileEntity"));
        String[] campi = request.getParameterValues("campo[]");
        String[] idCampi = request.getParameterValues("idCampo[]");
        String selectedPages = request.getParameter("selectedPages");
        String totalPages = request.getParameter("totalPages");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("us_user");

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("entryDoc");
        EntityManager em = emf.createEntityManager();

        try {
            EntityTransaction et = em.getTransaction();
            et.begin();

            FileEntity fileEntity = em.find(FileEntity.class, idFileEntity);

            JsonObject json = new JsonObject();

            for (int i = 0; i < campi.length; i++) {
                Campo_form campoForm = em.find(Campo_form.class, Long.parseLong(idCampi[i]));

                String campoValue = "Nome campo: " + campoForm.getNome()
                        + ", Valore campo: " + campi[i]
                        + ", Tipologia campo: " + campoForm.getTipologia_campo();

                json.addProperty("Campo_" + (i + 1), campoValue);

            }

            json.addProperty("filename", fileEntity.getFilename());
            json.addProperty("user", user.getUsername());

            Timestamp dataDiCompletamento = new Timestamp(new Date().getTime());

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String dataDiCompletamentoString = sdf.format(dataDiCompletamento);

            json.addProperty("data completamento", dataDiCompletamentoString);

            String jsonString = json.toString();
            fileEntity.setStatus(3);
            fileEntity.setUser(user);

            if (selectedPages != null && selectedPages.equals("[]")) {
                fileEntity.setPageSelected(totalPages);
            } else {
                fileEntity.setPageSelected(selectedPages);
            }
            fileEntity.setTotalPages(totalPages);

            for (int i = 0; i < campi.length; i++) {
                CampoFileValue campoFileValue = new CampoFileValue();
                campoFileValue.setUser(user);
                campoFileValue.setJson(jsonString);
                campoFileValue.setDataDiCompletamento(new Timestamp(new Date().getTime()));
                campoFileValue.setFileEntity(fileEntity);
                campoFileValue.setFieldValue(campi[i]);
                Campo_form campoForm = em.find(Campo_form.class, Long.parseLong(idCampi[i]));
                campoFileValue.setCampoForm(campoForm);
                em.persist(campoFileValue);
            }

            et.commit();
            response.sendRedirect("index.jsp?esito=OK");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?esito=ERROR");
        } finally {
            em.close();
            emf.close();
        }
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
