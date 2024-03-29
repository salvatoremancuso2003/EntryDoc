<%-- 
    Document   : fileUpload
    Created on : 18 feb 2024, 15:44:53
    Author     : Salvatore
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Documento Viewer</title>
        <!--begin::Fonts(mandatory for all pages)-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700" />
        <!--end::Fonts-->

        <!--begin::Vendor Stylesheets(used for this page only)-->
        <link href="assets/plugins/custom/datatables/datatables.bundle.css" rel="stylesheet" type="text/css" />
        <!--end::Vendor Stylesheets-->

        <!--begin::Global Stylesheets Bundle(mandatory for all pages)-->
        <link href="assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.bundle.css" rel="stylesheet" type="text/css" />
        <!--end::Global Stylesheets Bundle-->
        
    </head>
    <body>
        <section class="background-radial-gradient overflow-hidden">
            <div class="container px-4 py-5 px-md-5 text-center text-lg-start my-5">
                <div class="row gx-lg-5 align-items-center mb-5">
                    <div class="col-lg-6 mb-5 mb-lg-0 position-relative" >
                        <div id="radius-shape-1" class="position-absolute rounded-circle shadow-5-strong"></div>
                        <div id="radius-shape-2" class="position-absolute shadow-5-strong"></div>

                        <div class="card bg-glass">
                            <div class="card-body px-4 py-5 px-md-5"  style="
                                 box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); min-height: 65vh">

                                <form action="fileuploadservlet" method="POST" enctype="multipart/form-data" id="uploadForm">
                                    <div class="form-group">
                                        <label for="file" class="active label-for-file-upload">Carica :</label>
                                        <input type="file" class="form-control-file" id="file" name="file" required>
                                    </div>
                                    <button type="button" class="custom-btn" id="uploadButton">Upload</button>
                                    <div id="loadingIcon" class="loading-icon" style="display: none;">
                                        <i class="fas fa-spinner fa-spin"></i> Caricamento in corso...
                                    </div>
                                    <br>
                                    <br>
                                    <div id="successMessage" style="display: none;" class="alert alert-success" role="alert">
                                        File caricato con successo!
                                    </div>
                                    <div id="uploadedFile" style="display: none;"></div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>







        <!--begin::Javascript-->
        <!--begin::Global Javascript Bundle(mandatory for all pages)-->
        <script src="assets/plugins/global/plugins.bundle.js"></script>
        <script src="assets/js/scripts.bundle.js"></script>
        <!--end::Global Javascript Bundle-->

        <!--begin::Vendors Javascript(used for this page only)-->

        <!--end::Vendors Javascript-->

        <!--begin::Custom Javascript(used for this page only)-->
        <script src="assets/js/widgets.bundle.js"></script>
        <script src="assets/js/custom/widgets.js"></script>
        <script src="assets/js/custom/apps/chat/chat.js"></script>
        <script src="assets/js/custom/utilities/modals/upgrade-plan.js"></script>
        <script src="assets/js/custom/utilities/modals/create-app.js"></script>
        <script src="assets/js/custom/utilities/modals/new-target.js"></script>
        <script src="assets/js/custom/utilities/modals/users-search.js"></script>
        <!--end::Custom Javascript-->
        <!--end::Javascript-->

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
                                alert("file caricato con successo");
                            },
                            error: function (error) {
                                console.error('Errore durante la richiesta Ajax:', error);
                                alert("file caricato con successo");
                            }
                        });
                    });
                });
            });

            let arrowLeft = document.getElementById('arrowLeft');
            arrowLeft.addEventListener('click', function () {
                window.location.href = "index.jsp";

            });
        </script>
    </body>
</html>
