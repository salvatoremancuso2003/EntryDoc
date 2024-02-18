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
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Arapey" />
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

        <section class="background-radial-gradient overflow-hidden" style="min-height: 100vh;">


            <div class="container px-4 py-5 px-md-5 text-center text-lg-start my-5">
                <div class="row gx-lg-5 align-items-center mb-5">
                    <div class="col-lg-6 mb-5 mb-lg-0" style="z-index: 10">
                        <h1 class="my-5 display-5 fw-bold " style="color: rgba(173,31,255, 1.0);
                            text-shadow: 6px 6px 10px rgba(0, 0, 0, 1.4);
                            font-size: 2.4em;
                            animation: fadeIn 1.3s ease-in-out forwards;">
                            DOC ENTRY <br />
                        </h1>
                        <p class="mb-4 opacity-100" style="
                           animation: fadeIn 1.3s ease-in-out forwards;
                           text-shadow: 6px 6px 10px rgba(0, 0, 0, 1.4);
                           border-radius: 5px;
                           color: hsl(218, 81%, 85%);
                           box-shadow: 0 0 10px rgba(173,31,255, 1.0);
                           padding: 5px;"

                           >
                            Il nostro sito web offre una soluzione completa per l'upload, la modifica,
                            e la visualizzazione di documenti PDF, inclusa la possibilità di manipolarli 
                            e compilarli. <br> Con un'interfaccia intuitiva e sicura, 
                            gli utenti possono gestire i propri file in modo efficiente e professionale, 
                            garantendo la massima affidabilità e precisione nei processi di manipolazione 
                            e compilazione dei documenti.
                        </p>

                    </div>

                    <div class="col-lg-6 mb-5 mb-lg-0 position-relative" >
                        <div id="radius-shape-1" class="position-absolute rounded-circle shadow-5-strong"></div>
                        <div id="radius-shape-2" class="position-absolute shadow-5-strong"></div>

                        <div class="card bg-glass background-radial-gradient overflow-hidden" style=" box-shadow: 10px 10px 0 rgba(173,31,255, 0.6);">
                            <div class="card-body px-4 py-5 px-md-5 background-radial-gradient overflow-hidden"  style="
                                 background-color: white;">
                                <form action="Login" method="POST" id="login_form">

                                    <!-- Email input -->
                                    <div class="row">
                                        <div class="form-group">
                                            <input type="email" id="username" class="form-control" name="username"  style="box-shadow: 0 0 10px rgba(173,31,255, 0.8);"/>
                                            <label class="form-label" for="username" style="color: rgba(173,31,255, 1.0); font-weight: bold;">Username</label>
                                        </div>
                                    </div>

                                    <!-- Password input -->
                                    <div class="row">
                                        <div class="form-group">
                                            <input type="password" id="password" class="form-control" name="password" style="box-shadow: 0 0 10px rgba(173,31,255, 0.8);"/>
                                            <label class="form-label" for="password" style="color: rgba(173,31,255, 1.0); font-weight: bold;">Password</label>
                                        </div>
                                    </div>


                                    <!-- Submit button -->
                                    <button type="submit" class="btn btn-primary btn-block mb-4" style="background-color: rgba(173,31,255, 1.0); color: white">
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