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
        <script src="Bootstrap2024/assets/js/bootstrap-italia.min.js" ></script>
    </head>
    <body>
        <section class="background-radial-gradient overflow-hidden">


            <div class="container px-4 py-5 px-md-5 text-center text-lg-start my-5">
                <div class="row gx-lg-5 align-items-center mb-5">
                    <div class="col-lg-6 mb-5 mb-lg-0" style="z-index: 10">

                        <table id="fileTable" style="width: 50%" class="responsive"> 

                        </table>

                    </div>

                    <div class="col-lg-6 mb-5 mb-lg-0 position-relative" >
                        <div id="radius-shape-1" class="position-absolute rounded-circle shadow-5-strong"></div>
                        <div id="radius-shape-2" class="position-absolute shadow-5-strong"></div>

                        <div class="card bg-glass">
                            <div class="card-body px-4 py-5 px-md-5"  style="
                                 box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
                                <form action="SubmitFormDataServlet" method="POST" id="entryDataDoc_form">

                                    <div class="row">
                                        <!-- Email input -->
                                        <div class="form-group">
                                            <input type="email" id="input1" class="form-control" name="input1"/>
                                            <label class="form-label" for="input1">Username</label>
                                        </div>

                                        <!-- Password input -->
                                        <div class="form-group">
                                            <input type="password" id="input2" class="form-control" name="input2" />
                                            <label class="form-label" for="input2">Password</label>
                                        </div>

                                        <div class="form-group">
                                            <input type="text" id="input3" class="form-control" name="input3" />
                                            <label class="form-label" for="input3">Password</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <input type="text" id="input4" class="form-control" name="input4" />
                                            <label class="form-label" for="input4">Password</label>
                                        </div>
                                        <div class="form-group">
                                            <input type="text" id="input5" class="form-control" name="input5" />
                                            <label class="form-label" for="input5">Password</label>
                                        </div>
                                        <div class="form-group">
                                            <input type="text" id="input6" class="form-control" name="input6" />
                                            <label class="form-label" for="input6">Password</label>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="form-group">
                                            <input type="text" id="input7" class="form-control" name="input7" />
                                            <label class="form-label" for="input7">Password</label>
                                        </div>
                                        <div class="form-group">
                                            <input type="text" id="input8" class="form-control" name="input8" />
                                            <label class="form-label" for="input8">Password</label>
                                        </div>
                                        <div class="form-group">
                                            <input type="text" id="input9" class="form-control" name="input9" />
                                            <label class="form-label" for="input9">Password</label>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="form-group">
                                            <input type="text" id="input10" class="form-control" name="input10" />
                                            <label class="form-label" for="input10">Password</label>
                                        </div>
                                    </div>




                                    <!-- Submit button -->
                                    <button type="submit" class="btn btn-primary btn-block mb-4" style="background-color: rgba(173,31,255, 1.0);">
                                        Invia
                                    </button>


                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- <div id="container">
            <div id="file-container">

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

        </div> -->




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
