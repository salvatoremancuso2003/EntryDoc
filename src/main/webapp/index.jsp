<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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

    <body class="app-default" data-kt-app-page-loading-enabled="true" data-kt-app-page-loading="on">

        <!--begin::Page loading(append to body)-->
        <div class="page-loader flex-column bg-dark bg-opacity-25">
            <span class="spinner-border text-primary" role="status"></span>
            <span class="text-gray-800 fs-6 fw-semibold mt-5">Loading...</span>
        </div>
        <!--end::Page loading-->

        <section class="background-radial-gradient overflow-hidden">
            <div class="container px-4 py-5 px-md-5 text-center text-lg-start my-5">
                <h1>Elenco file</h1>
                <div class="row gx-lg-5 align-items-center mb-5">
                    <div class="col-12" style="z-index: 10; background-color: white; min-height: 60vh;">

                        <div class="col-12" style="z-index: 10; background-color: white; min-height: 70vh;">

                            <div class="table-responsive">
                                <table id="files" class="table table-striped table-row-bordered gy-5 gs-7" style="width:100%;">
                                    <thead>
                                        <tr>
                                            <th>Tipologia documentale : </th>
                                            <th>Nome del file : </th>
                                            <th>Data di upload :</th>
                                            <th> Azione : </th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </section>




        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="js/files.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment-with-locales.min.js"></script>

        <!--begin::Javascript-->
        <!--begin::Global Javascript Bundle(mandatory for all pages)-->
        <script src="assets/plugins/global/plugins.bundle.js"></script>
        <script src="assets/js/scripts.bundle.js"></script>
        <!--end::Global Javascript Bundle-->

        <!--begin::Vendors Javascript(used for this page only)-->
        <script src="assets/plugins/custom/datatables/datatables.bundle.js"></script>
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
            // Toggle
            const button = document.querySelector("#kt_page_loading_overlay");

// Handle toggle click event
            button.addEventListener("click", function () {
                // Populate the page loading element dynamically.
                // Optionally you can skipt this part and place the HTML
                // code in the body element by refer to the above HTML code tab.
                const loadingEl = document.createElement("div");
                document.body.prepend(loadingEl);
                loadingEl.classList.add("page-loader");
                loadingEl.classList.add("flex-column");
                loadingEl.classList.add("bg-dark");
                loadingEl.classList.add("bg-opacity-25");
                loadingEl.innerHTML = `
        <span class="spinner-border text-primary" role="status"></span>
        <span class="text-gray-800 fs-6 fw-semibold mt-5">Loading...</span>
    `;

                // Show page loading
                KTApp.showPageLoading();

                // Hide after 3 seconds
                setTimeout(function () {
                    KTApp.hidePageLoading();
                    loadingEl.remove();
                }, 5000);
            });
        </script>




        <script>

            function openDoc(filename, id) {
                if (filename.toLowerCase().endsWith(".pdf")) {
                    var form = document.createElement('form');
                    form.setAttribute('method', 'POST');
                    form.setAttribute('action', 'compilaDocumenti.jsp');

                    var idInput = document.createElement('input');
                    idInput.setAttribute('type', 'hidden');
                    idInput.setAttribute('name', 'id');
                    idInput.setAttribute('value', id);
                    form.appendChild(idInput);

                    var filenameInput = document.createElement('input');
                    filenameInput.setAttribute('type', 'hidden');
                    filenameInput.setAttribute('name', 'filename');
                    filenameInput.setAttribute('value', filename);
                    form.appendChild(filenameInput);

                    document.body.appendChild(form);

                    form.submit();
                    updateFileStatus(id);
                } else if (filename.toLowerCase().endsWith(".png")) {
                    var form = document.createElement('form');
                    form.setAttribute('method', 'POST');
                    form.setAttribute('action', 'compilaImg.jsp');

                    var idInput = document.createElement('input');
                    idInput.setAttribute('type', 'hidden');
                    idInput.setAttribute('name', 'id');
                    idInput.setAttribute('value', id);
                    form.appendChild(idInput);

                    var filenameInput = document.createElement('input');
                    filenameInput.setAttribute('type', 'hidden');
                    filenameInput.setAttribute('name', 'filename');
                    filenameInput.setAttribute('value', filename);
                    form.appendChild(filenameInput);

                    document.body.appendChild(form);

                    form.submit();
                    updateFileStatus(id);
                } else if (filename.toLowerCase().endsWith(".jpeg")) {
                    var form = document.createElement('form');
                    form.setAttribute('method', 'POST');
                    form.setAttribute('action', 'compilaImg.jsp');

                    var idInput = document.createElement('input');
                    idInput.setAttribute('type', 'hidden');
                    idInput.setAttribute('name', 'id');
                    idInput.setAttribute('value', id);
                    form.appendChild(idInput);

                    var filenameInput = document.createElement('input');
                    filenameInput.setAttribute('type', 'hidden');
                    filenameInput.setAttribute('name', 'filename');
                    filenameInput.setAttribute('value', filename);
                    form.appendChild(filenameInput);

                    document.body.appendChild(form);

                    form.submit();
                    updateFileStatus(id);
                } else {
                    console.error("Formato del file non supportato");
                }
                function updateFileStatus(id) {
                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "UpdateFilesStatus", true);
                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            console.log("File status updated successfully");
                        }
                    };
                    xhr.send("id=" + id);
                }
            }

        </script>

    </body>
</html>
