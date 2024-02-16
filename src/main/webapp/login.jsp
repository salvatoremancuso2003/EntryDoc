<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>DOC ENTRY</title>
        <link rel="stylesheet" href="Bootstrap2024/assets/css/bootstrap-italia.min.css"/>
        <link rel="stylesheet" href="css/login.css"/>
        <style>
            .background-radial-gradient {
                background-color: #ad1fff;
                background-image: radial-gradient(650px circle at 0% 0%,
                    hsl(218, 41%, 35%) 15%,
                    hsl(218, 41%, 30%) 35%,
                    hsl(218, 41%, 20%) 75%,
                    hsl(218, 41%, 19%) 80%,
                    transparent 100%),
                    radial-gradient(1250px circle at 100% 100%,
                    hsl(218, 41%, 45%) 15%,
                    hsl(218, 41%, 30%) 35%,
                    hsl(218, 41%, 20%) 75%,
                    hsl(218, 41%, 19%) 80%,
                    transparent 100%);
            }


            .bg-glass {
                background-color: hsla(0, 0%, 100%, 0.9) !important;
                backdrop-filter: saturate(200%) blur(25px);
            }
        </style>
    </head>
    <body>

        <section class="background-radial-gradient overflow-hidden">


            <div class="container px-4 py-5 px-md-5 text-center text-lg-start my-5">
                <div class="row gx-lg-5 align-items-center mb-5">
                    <div class="col-lg-6 mb-5 mb-lg-0" style="z-index: 10">
                        <h1 class="my-5 display-5 fw-bold ls-tight" style="color: hsl(218, 81%, 95%); box-shadow: 0 0 10px rgba(173,31,255, 1.0);" id="entryDocTitle">
                            DOC ENTRY <br />
                            <span style="color: hsl(218, 81%, 75%)"></span>
                        </h1>
                        <p class="mb-4 opacity-70" id="customP" style="color: hsl(218, 81%, 85%);box-shadow: 0 0 10px rgba(173,31,255, 1.0); padding: 5px;" >
                            Il nostro sito web offre una soluzione completa per l'upload, la modifica,
                            e la visualizzazione di documenti PDF, inclusa la possibilità di manipolarli 
                            e compilarli. Con un'interfaccia intuitiva e sicura, 
                            gli utenti possono gestire i propri file in modo efficiente e professionale, 
                            garantendo la massima affidabilità e precisione nei processi di manipolazione 
                            e compilazione dei documenti.
                        </p>
                    </div>

                    <div class="col-lg-6 mb-5 mb-lg-0 position-relative" >
                        <div id="radius-shape-1" class="position-absolute rounded-circle shadow-5-strong"></div>
                        <div id="radius-shape-2" class="position-absolute shadow-5-strong"></div>

                        <div class="card bg-glass" >
                            <div class="card-body px-4 py-5 px-md-5"  style="
                                 background-color: white;">
                                <form action="Login" method="POST" id="login_form">

                                    <!-- Email input -->
                                    <div class="form-outline m-4">
                                        <input type="email" id="username" class="form-control" name="username"/>
                                        <label class="form-label" for="username">Username</label>
                                    </div>

                                    <!-- Password input -->
                                    <div class="form-outline m-4">
                                        <input type="password" id="password" class="form-control" name="password" />
                                        <label class="form-label" for="password">Password</label>
                                    </div>


                                    <!-- Submit button -->
                                    <button type="submit" class="btn btn-primary btn-block mb-4" style="background-color: rgba(173,31,255, 1.0);">
                                        Login
                                    </button>


                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Section: Design Block -->


        <script src="Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js"></script>
        <script>(function () {
                'use strict'

                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                var forms = document.querySelectorAll('.needs-validation')

                // Loop over them and prevent submission
                Array.prototype.slice.call(forms)
                        .forEach(function (form) {
                            form.addEventListener('submit', function (event) {
                                if (!form.checkValidity()) {
                                    event.preventDefault()
                                    event.stopPropagation()
                                }

                                form.classList.add('was-validated')
                            }, false)
                        })
            })()
        </script>
    </body>
</html>