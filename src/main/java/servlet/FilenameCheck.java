/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import Utils.FilesUtils;
import entity.FileEntity;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Salvatore
 */
public class FilenameCheck extends HttpServlet {

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

        try (PrintWriter pw = response.getWriter()) {
            HttpSession httpSession = request.getSession();
            User user = (User) httpSession.getAttribute("us_user");
            String fileEntityIdParam = request.getParameter("id");
            FilesUtils filesUtils = new FilesUtils();
            System.out.println("servlet.FilenameCheck.processRequest() " + fileEntityIdParam);
            FileEntity fileEntity = filesUtils.getFiles(fileEntityIdParam);
            if (fileEntity == null) {

            } else if (fileEntity.getUser() == null) {
                //QUERY SU USER
                FileEntity assegnatoutente = filesUtils.getFilesWithUser(user);

                if (assegnatoutente == null) {
                    //OK
                    pw.print("OK");
                } else if (assegnatoutente != null && assegnatoutente.getStatus() == 3) {
                    pw.print("OK");

                } else {
                    // CAMBIARE FILENTITY E FILENAME
                    pw.print(assegnatoutente.getFilename() + ";" + assegnatoutente.getId());
                }
            } else if (fileEntity.getUser().getId() != user.getId()) {
                // KO
                pw.print("KO");
            } else {
                //OK
                pw.print("OK");
            }
            pw.flush();
        } catch (Exception ex) {
            ex.printStackTrace();
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
