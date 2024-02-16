/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import com.google.gson.JsonObject;
import entity.Attachments;
import entity.InfoTrack;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;

/**
 *
 * @author Aldo
 */
@WebServlet(name = "AttachmentUploadServlet", urlPatterns = {"/AttachmentUploadServlet"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AttachmentUploadServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AttachmentUploadServlet.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        if (ServletFileUpload.isMultipartContent(request)) {
            List<FileItem> formItems;
            try {
                formItems = upload.parseRequest(request);

                if (formItems != null && formItems.size() > 0) {
                    for (FileItem item : formItems) {
                        System.out.println(item.isFormField() + "servlet.AttachmentUploadServlet.processRequest() " + item.getName());
                        if (!item.isFormField()) {

                        } else {

                        }
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        Part filePart = request.getPart("file");

        if (filePart == null || filePart.getSize() == 0) {
            LOGGER.severe("No file selected");
            sendErrorResponse(response, "file non selezionato");
            return;
        }

        String fileName = getFileName(filePart);

        if (fileName == null || fileName.isEmpty()) {
            LOGGER.severe("Invalid file name");
            sendErrorResponse(response, "invalid name");
            return;
        }

        InputStream fileContent = filePart.getInputStream();
        byte[] fileBytes = IOUtils.toByteArray(fileContent);

        EntityManagerFactory emf = null;
        EntityManager em = null;

        try {
            emf = Persistence.createEntityManagerFactory("entryDoc");
            em = emf.createEntityManager();

            em.getTransaction().begin();

            String fileExtension = getFileExtension(fileName);

            Attachments attachment = new Attachments();
            attachment.setFilename(fileName);
            attachment.setUploadDate(new Timestamp(new Date().getTime()));
            attachment.setFileContent(fileBytes);

            String fileDescription = getFileDescription(fileExtension);
            attachment.setDescription(fileDescription);

            em.persist(attachment);
            em.getTransaction().commit();

            InfoTrack.attachmentTrackUpdate(request.getSession().getAttribute("us_name").toString(), attachment);

            response.sendRedirect("user.jsp");

        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "An error occurred", e);
            sendErrorResponse(response, "errore");
        } finally {
            if (em != null) {
                em.close();
            }
            if (emf != null) {
                emf.close();
            }
        }
    }

    private String getFileName(final Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    private void sendSuccessResponse(HttpServletResponse response, String message) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("message", message);
        out.print(jsonResponse.toString());
        out.flush();

    }

    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("error", message);
        out.print(jsonResponse.toString());
        out.flush();
    }

    private String getFileExtension(String fileName) {
        return fileName.substring(fileName.lastIndexOf(".") + 1);
    }

    private String getFileDescription(String fileExtension) {
        // Esempio: restituisci una descrizione in base all'estensione del file
        switch (fileExtension.toLowerCase()) {
            case "pdf":
                return "Documento PDF";
            case "doc":
            case "docx":
                return "Documento Word";
            // Aggiungi altri casi per le estensioni dei file supportate
            default:
                return "Altro documento";
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
