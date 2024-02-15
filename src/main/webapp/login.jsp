<%-- 
    Document   : login
    Created on : 15 feb 2024, 15:12:35
    Author     : Salvatore
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>JSP Page</title>
        <link rel="stylesheet" href="Bootstrap2024/assets/css/bootstrap-italia.min.css"/>
        <link rel="stylesheet" href="css/login.css"/>
    </head>
    <body>

        <header> <%@include file="Bootstrap2024/index/login/Header_login.jsp" %> </header>

        <div class="container" style="display: flex; justify-content: center; align-items: center">
            <form action="Login" method="POST" id="loginForm">
                <div class="row">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" class="form-control">
                    </div>
                </div>
                <div class="row">
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password">
                    </div>
                </div>
            </form>
        </div>

        <footer> <%@include file="Bootstrap2024/index/login/Footer_login.jsp" %>  </footer>

    </body>
</html>
