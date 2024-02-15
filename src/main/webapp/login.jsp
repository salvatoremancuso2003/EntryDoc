<!DOCTYPE html>
<html lang="en">
    <%@ page contentType="text/html; charset=UTF-8" %>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="Bootstrap2024/assets/css/bootstrap-italia.min.css"/>
        <link rel="stylesheet" href="css/login.css"/>
        <title>Entry Doc</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" />
        <meta name="msapplication-TileColor" content="#da532c">
        <meta name="theme-color" content="#ffffff">


    </head>
    <body>


        <div class="it-header-center-wrapper" style="background-color: #660081; color: #fff; padding: 20px;">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-12 col-md-6">
                        <div class="it-brand-wrapper">
                            <h4 class= "row align-items-start" > Entry Doc</h4>
                        </div>
                    </div> 
                </div>  
            </div> 
        </div>



        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 login-container">
                    <%
                        String esito = request.getParameter("esito");
                        if (esito != null && esito.equals("KO")) {%>
                    <div class="alert alert-warning alert-dismissible fade show error-alert" role="alert" id="errorAlert">
                        <strong>Attenzione:</strong> Email o password errati.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Chiudi avviso">
                            <svg class="icon">
                            <use href="./svg/sprites.svg#it-close"></use>
                            </svg>
                        </button>
                    </div>
                    <%}
                    %>

                    <div class="card p-xl-5 mb-5">
                        <div class="card-body">
                            <h2 class="card-title text-center mb-4" onclick="focusOnInput('username')">Accedi</h2>

                            <form method="POST" action="Login" class="pe-xxl-5" style="max-width: 400px; margin: auto;">
                                <div class="form-group">
                                    <label for="username" id="usernameLabel">Username</label>
                                    <input type="text" class="form-control" id="username" name="username" required>
                                </div>
                                <div class="form-group">
                                    <label for="password" id="passwordLabel">Password</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="password" name="password" required />
                                        <span class="input-group-addon">
                                            <i class="bi bi-eye-slash" id="togglePassword"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group center-btn-container">
                                    <button type="submit" class="btn btn-primary btn-block btn-animated">Accedi</button>
                                </div>
                            </form>                         
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script src="Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js"></script>

        <script>
                                const togglePassword = document.querySelector('#togglePassword');
                                const password = document.querySelector('#password');
                                togglePassword.addEventListener('click', () => {
                                    const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                                    password.setAttribute('type', type);
                                    togglePassword.classList.toggle('bi-eye');
                                    togglePassword.classList.toggle('bi-eye-slash');
                                });
        </script>

        <script>
            function focusOnInput(fieldId) {
                var inputField = document.getElementById(fieldId);
                if (inputField && !inputField.value) {
                    inputField.focus();
                } else {
                    document.getElementById("password").focus();
                }
            }
        </script>
        <%@include file="Bootstrap2024/index/login/Footer_login.jsp" %>
    </body>
</html>
