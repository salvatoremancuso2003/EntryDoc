package servlet;

import entity.AuthService;
import entity.InfoTrack;
import entity.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (AuthService.isPasswordValid(username, password)) {
            
            
            User userloggato = AuthService.authenticate_US(username, password);
            
            
            if (userloggato != null) {

                request.getSession().setAttribute("us_name", username);
                request.getSession().setAttribute("us_user", userloggato);

                InfoTrack.loginTrack(username);
                redirectToPageByRole(response, userloggato.getRuolo().getId());
            } else {
                response.sendRedirect("login.jsp?esito=KO1");
            }
        } else {
            response.sendRedirect("login.jsp?esito=KO");
        }
    }

    private void redirectToPageByRole(HttpServletResponse response, int roleId) throws IOException {
        String targetPage;

        switch (roleId) {
            case 1:
                targetPage = "index.jsp";
                break;
            case 2:
                targetPage = "fileUpload.jsp";
                break;
            case 3:
                targetPage = "";
                break;
            default:
                targetPage = "";
                break;
        }

        response.sendRedirect(targetPage);
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
