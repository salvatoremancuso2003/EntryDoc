package servlet;

import Utils.FilesUtils;
import entity.AuthService;
import entity.FileEntity;
import entity.InfoTrack;
import entity.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        int roleId = AuthService.authenticate(username, password);
        if (roleId != -1) {
            User user = AuthService.getUserByUsername(username);
            if (request.getContextPath().contains("EntryDoc")) {
                request.getSession().setAttribute("src", "../..");
            }
            if (user != null) {
                request.getSession().setAttribute("us_name", username);
                request.getSession().setAttribute("us_user", user);
                request.getSession().setAttribute("us_nome", user.getNome());
                request.getSession().setAttribute("us_cognome", user.getCognome());
                request.getSession().setAttribute("us_id", user.getId());

                HttpSession session = request.getSession();
                session.setMaxInactiveInterval(1800);

                InfoTrack.loginTrack(username);
                

                FilesUtils filesUtils = new FilesUtils();
                FileEntity userFileEntity = filesUtils.getFilesWithUser(user);
                System.out.println("FILE ENTITY ------------ " + userFileEntity);

                if (userFileEntity != null) {
                    int status = userFileEntity.getStatus();
                    if (status == 2) {
                        String filename = userFileEntity.getFilename();
                        if (filename.endsWith("pdf")) {
                            response.sendRedirect("compilaDocumenti.jsp?filename=" + filename + "&id=" + userFileEntity.getId());
                        } else if (filename.endsWith("tiff") || filename.endsWith("tif")) {
                            response.sendRedirect("compilaDocumenti.jsp?filename=" + filename + "&id=" + userFileEntity.getId());
                        }
                    } else {
                        redirectToPageByRole(response, user.getRuolo().getId());
                    }
                } else {
                    redirectToPageByRole(response, user.getRuolo().getId());
                }
            }
        } else {
            response.sendRedirect("unauth.jsp");
        }
    }


    private void redirectToPageByRole(HttpServletResponse response, int roleId) throws IOException {
        String targetPage;

        switch (roleId) {
            case 1:
                targetPage = "index.jsp";
                break;
            case 2:
                targetPage = "index.jsp";
                break;
            case 3:
                targetPage = "";
                break;
            default:
                targetPage = "";
                break;
        }

        if (!targetPage.isEmpty()) {
            response.sendRedirect(targetPage);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
