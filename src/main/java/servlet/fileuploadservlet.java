/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import entity.FileEntity;
import entity.InfoTrack;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.sql.Timestamp;
import java.util.Date;
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
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFPictureData;

/**
 *
 * @author Salvatore
 */
@WebServlet(name = "fileuploadservlet", urlPatterns = {"/fileuploadservlet"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 100
)
public class fileuploadservlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Part filePart = request.getPart("file");
            String originalFileName = filePart.getSubmittedFileName();
            String baseName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
            String extension = originalFileName.substring(originalFileName.lastIndexOf("."));

            String fileName = originalFileName;
            String filePath = "C:\\Users\\Salvatore\\Desktop\\" + fileName;
            File file = new File(filePath);

            int counter = 1;
            while (file.exists()) {
                fileName = baseName + "_" + counter + extension;
                filePath = "C:\\Users\\Salvatore\\Desktop\\" + fileName;
                file = new File(filePath);
                counter++;
            }

            file.getParentFile().mkdirs();
            filePart.write(filePath);

            FileEntity fileEntity = new FileEntity();
            fileEntity.setFilename(fileName);
            fileEntity.setFilepath(filePath);
            fileEntity.setFileSize(filePart.getSize());
            fileEntity.setUploadDate(new Timestamp(new Date().getTime()));

            if (fileName.endsWith(".pdf")) {
                PDDocument document = PDDocument.load(file);
                PDFTextStripper pdfTextStripper = new PDFTextStripper();
                String text = pdfTextStripper.getText(document);
                document.close();

                byte[] bytes = text.getBytes(StandardCharsets.UTF_8);

                fileEntity.setFileContent(bytes);
            } else if (fileName.endsWith(".docx")) {
                XWPFDocument document = new XWPFDocument(new FileInputStream(file));
                byte[] bytes = new byte[0];

                for (XWPFPictureData picture : document.getAllPictures()) {
                    bytes = picture.getData();
                }
                document.close();

                fileEntity.setFileContent(bytes);
            }

            EntityManagerFactory emf = Persistence.createEntityManagerFactory("entryDoc");
            EntityManager em = emf.createEntityManager();
            em.getTransaction().begin();
            em.persist(fileEntity);
            //InfoTrack.newFileTrack(request.getAttribute("username").toString(), fileEntity.getEvent(), fileEntity);
            em.getTransaction().commit();
            em.close();
            emf.close();

            response.setContentType("text/plain;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print("Il file è stato caricato con successo!");
        } catch (Exception e) {
            System.out.println(e);

            response.setContentType("text/plain;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print("File non supportato o dimensioni del file da ridurre ");
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
