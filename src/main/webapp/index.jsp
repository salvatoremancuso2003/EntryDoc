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
        <link rel="stylesheet" href="css/dataTable/datatables.css"/>
        <script src="Bootstrap2024/assets/js/bootstrap-italia.min.js" ></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    </head>
    <body>

        <section class="background-radial-gradient overflow-hidden">
            <div class="container px-4 py-5 px-md-5 text-center text-lg-start my-5">
                <h1 style="text-align: center; color: rgba(173,31,255, 1.0);
                    text-shadow: 6px 6px 10px rgba(0, 0, 0, 1.4);
                    font-size: 2.9em;
                    animation: fadeIn 1.3s ease-in-out forwards;">Elenco file</h1>
                <div class="row gx-lg-5 align-items-center mb-5">
                    <div class="col-12" style="z-index: 10; background-color: white; min-height: 60vh;">


                        <table id="files" class="table table-hover table-striped table-bordered dt-responsive" style="width:100%;">
                            <thead>
                                <tr>
                                    <th>Nome del file : </th>
                                    <th>Data di upload :</th>
                                    <th>Descrizione del file : </th>
                                    <th> Azione : </th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>

                    <!--            <div class="col-lg-6 mb-5 mb-lg-0 position-relative" >
                        <div id="radius-shape-1" class="position-absolute rounded-circle shadow-5-strong"></div>
                        <div id="radius-shape-2" class="position-absolute shadow-5-strong"></div> -->

                    <!-- <div class="card bg-glass">
                        <div class="card-body px-4 py-5 px-md-5"  style="
                             box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
                            <form action="SubmitFormDataServlet" method="POST" id="entryDataDoc_form">

                                <div class="row">
                    <!-- Email input 
                    <div class="form-group">
                        <input type="email" id="input1" class="form-control" name="input1"/>
                        <label class="form-label" for="input1">Username</label>
                    </div>

                    <!-- Password input 
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




                    <!-- Submit button 
                    <button type="submit" class="btn btn-primary btn-block mb-4" style="background-color: rgba(173,31,255, 1.0);">
                        Invia
                    </button>


                </form>

            </div>
        </div> -->

                </div>
            </div>
        </section>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="js/datatables.min.js"></script>
        <script src="js/files.js"></script>
        <script>


            function openDoc(filename, id) {
                var url = 'compilaDocumenti.jsp?filename=' + encodeURIComponent(filename) + '&id=' + encodeURIComponent(id);
                window.open(url, '_blank');
            }

        </script>
    </body>
</html>
