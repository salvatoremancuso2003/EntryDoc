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
                <div class="row gx-lg-5 align-items-center mb-5">
                    <div class="col-12" style="z-index: 10; background-color: white; min-height: 70vh;">

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


                </div>
            </div>
        </section>
        
        
        

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="js/datatables.min.js"></script>
        <script src="js/files.js"></script>
        <script>
            const uploadButton = document.getElementById('uploadButton');
            const successMessage = document.getElementById('successMessage');
            $(document).ready(function () {
                $('#uploadButton').click(function () {
                    var formData = new FormData($('#uploadForm')[0]);

                    setTimeout(function () {
                        $.ajax({
                            type: 'POST',
                            url: 'fileuploadservlet',
                            data: formData,
                            processData: false,
                            contentType: false,
                            beforeSend: function () {
                            },
                            success: function (response) {
                                console.log(response);
                            },
                            error: function (error) {
                                console.error('Errore durante la richiesta Ajax:', error);
                            }
                        });
                    }, 1500);
                });
            });

            let arrowRight = document.getElementById('arrowRight');
            arrowRight.addEventListener('click', function () {
                window.location.href = "fileUpload.jsp";

            });


        </script>

    </body>
</html>
