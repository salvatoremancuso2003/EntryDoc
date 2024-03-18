/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import Utils.FilesUtils;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import entity.CampoFileValue;
import entity.FileEntity;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Salvatore
 */
public class FilesServlet2 extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static AtomicInteger sEchoCounter = new AtomicInteger(0);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("servlet.FilesServlet.doPost() prova");
        EntityManagerFactory emf = null;
        EntityManager em = null;

        try {
            emf = Persistence.createEntityManagerFactory("entryDoc");
            em = emf.createEntityManager();

            String id = request.getParameter("id");
            FilesUtils filesUtils = new FilesUtils();
            FileEntity fileEntity = filesUtils.getFiles(id);

            List<CampoFileValue> campoFileValue = em.createQuery("SELECT cfv FROM CampoFileValue cfv WHERE cfv.fileEntity= :fileEntity", CampoFileValue.class)
                    .setParameter("fileEntity", fileEntity)
                    .getResultList();

            System.out.println("LISTA ------------ " + campoFileValue);

            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("iTotalRecords", campoFileValue.size());
            jsonResponse.addProperty("iTotalDisplayRecords", campoFileValue.size());
            int sEchoValue = sEchoCounter.incrementAndGet();
            jsonResponse.addProperty("sEcho", sEchoValue);

            JsonArray data = new JsonArray();
            for (CampoFileValue e : campoFileValue) {
                JsonObject campoFileValues = new JsonObject();
                campoFileValues.addProperty("tipologiaDocumentale", e.getFileEntity().getTipologia_documento().getTipo());
                campoFileValues.addProperty("user", e.getUser().getUsername());
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String formattedDate = dateFormat.format(e.getDataDiCompletamento());
                campoFileValues.addProperty("dataDiCompletamento", formattedDate);
                campoFileValues.addProperty("fileName", e.getFileEntity().getFilename());
                campoFileValues.addProperty("nomeCampo", e.getCampoForm().getNome());
                campoFileValues.addProperty("descrizioneCampo", e.getCampoForm().getOptions_description());
                campoFileValues.addProperty("valoreCampo", e.getFieldValue());

                data.add(campoFileValues);
            }

            jsonResponse.add("aaData", data);

            response.setContentType("application/json");
            try (PrintWriter out = response.getWriter()) {
                out.print(jsonResponse.toString());
            }
        } catch (NumberFormatException e) {
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (em != null) {
                em.close();
            }
            if (emf != null) {
                emf.close();
            }
        }

    }
    public static final String ITOTALRECORDS = "iTotalRecords";
    public static final String ITOTALDISPLAY = "iTotalDisplayRecords";
    public static final String SECHO = "sEcho";
    public static final String SCOLUMS = "sColumns";
    public static final String APPJSON = "application/json";
    public static final String CONTENTTYPE = "Content-Type";
    public static final String AADATA = "aaData";

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
