/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import entity.FileEntity;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Salvatore
 */
@WebServlet(name = "FilesServlet", urlPatterns = {"/FilesServlet"})
public class FilesServlet extends HttpServlet {

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

            try {

                List<FileEntity> files = em.createNamedQuery("FileEntity.findAll", FileEntity.class).getResultList();

                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("iTotalRecords", files.size());
                jsonResponse.addProperty("iTotalDisplayRecords", files.size());
                int sEchoValue = sEchoCounter.incrementAndGet();
                jsonResponse.addProperty("sEcho", sEchoValue);

                JsonArray data = new JsonArray();
                for (FileEntity e : files) {
                    if (e.getStatus() != 1) {
                        JsonObject filesData = new JsonObject();
                        filesData.addProperty("eventId", e.getId());
                        filesData.addProperty("fileName", e.getFilename());
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        String formattedDate = dateFormat.format(e.getUploadDate());
                        filesData.addProperty("uploadDate", formattedDate);
                        filesData.addProperty("filePath", e.getFilepath());
                        filesData.addProperty("fileSize", e.getFileSize());
                        filesData.addProperty("description", e.getDescription());
                        String gestisci = "<button class=\"custom-btn\" title='GESTISCI FILE'  onclick=\"openDoc('" + e.getFilename() + "');\">Gestisci</button>";
                        filesData.addProperty("gestisci", gestisci);
                        String fileContentBase64 = "";
                        byte[] fileContent = e.getFileContent();
                        if (fileContent != null) {
                            fileContentBase64 = Base64.getEncoder().encodeToString(fileContent);
                        }
                        filesData.addProperty("fileContent", fileContentBase64);

                        data.add(filesData);
                        System.out.println(filesData);
                    }
                }

                jsonResponse.add("aaData", data);

                response.setContentType("application/json");
                try (PrintWriter out = response.getWriter()) {
                    out.print(jsonResponse.toString());
                }
            } catch (NumberFormatException e) {
            }

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
