<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Documento Viewer</title>
        <link rel="stylesheet" href="Bootstrap2024/assets/css/bootstrap-italia.min.css"/>
        <link rel="stylesheet" href="css/index.css"/>
    </head>
    <body>
        <%@include file="Bootstrap2024/index/login/Header_login.jsp" %>
        
        <div id="container">
            <div id="iframe-container">
                <iframe id="document-iframe" src="documento.html"></iframe>
            </div>
            <div id="form-container">
                <form id="data-form">
                    <label for="name">Nome:</label>
                    <input type="text" id="name" name="name">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email">
                    <label for="phone">Telefono:</label>
                    <input type="tel" id="phone" name="phone">
                    <label for="address">Indirizzo:</label>
                    <input type="text" id="address" name="address">
                    <label for="city">Città:</label>
                    <input type="text" id="city" name="city">
                    <label for="zip">CAP:</label>
                    <input type="text" id="zip" name="zip">
                    <label for="country">Paese:</label>
                    <input type="text" id="country" name="country">
                    <label for="dob">Data di nascita:</label>
                    <input type="date" id="dob" name="dob">
                    <label for="gender">Genere:</label>
                    <select id="gender" name="gender">
                        <option value="male">Maschio</option>
                        <option value="female">Femmina</option>
                        <option value="other">Altro</option>
                    </select>
                    <label for="occupation">Occupazione:</label>
                    <input type="text" id="occupation" name="occupation">
                    <button class="btn btn-primary" type="submit">Invia</button>
                </form>
            </div>
           
        </div>
        <%@include file="Bootstrap2024/index/login/Footer_login.jsp" %>
        
        
        
        
        
        <script>
            // Aggiungi event listener per inviare i dati del form
            document.getElementById("data-form").addEventListener("submit", function (event) {
                event.preventDefault(); // Previeni il comportamento predefinito del submit
                // Puoi gestire l'invio dei dati qui, ad esempio con AJAX
                // Esempio di invio tramite fetch API:
                // fetch("url_del_tuo_backend", {
                //   method: "POST",
                //   body: new FormData(this)
                // }).then(response => {
                //   if (response.ok) {
                //     // Gestisci la risposta
                //   } else {
                //     // Gestisci l'errore
                //   }
                // }).catch(error => {
                //   console.error("Errore durante l'invio dei dati:", error);
                // });
            });
        </script>
    </body>
</html>
