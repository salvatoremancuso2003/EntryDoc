<%@page import="entity.FileEntity"%>
<%@page import="java.util.List"%>
<%@page import="Utils.FilesUtils"%>
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

    <body class="app-default" id="kt_app_body" data-kt-app-layout="dark-header" data-kt-app-toolbar-enabled="true">

        <div class="d-flex flex-column flex-root app-root" id="kt_app_root">
            <!--begin::Page-->
            <div class="app-page flex-column flex-column-fluid" id="kt_app_page">
                <!--begin::Header-->
                <div id="kt_app_header" class="app-header" data-kt-sticky="true" data-kt-sticky-activate="{default: true, lg: true}" data-kt-sticky-name="app-header-minimize" data-kt-sticky-offset="{default: '200px', lg: '0'}" data-kt-sticky-animation="false">
                    <!--begin::Header container-->
                    <div class="app-container container-fluid d-flex align-items-stretch justify-content-between" id="kt_app_header_container">
                        <!--begin::Sidebar mobile toggle-->
                        <div class="d-flex align-items-center d-lg-none ms-n3 me-1 me-md-2" title="Show sidebar menu">
                            <div class="btn btn-icon btn-active-color-primary w-35px h-35px" id="kt_app_sidebar_mobile_toggle">
                                <i class="ki-duotone ki-abstract-14 fs-2 fs-md-1">
                                    <span class="path1"></span>
                                    <span class="path2"></span>
                                </i>
                            </div>
                        </div>
                        <!--end::Sidebar mobile toggle-->
                        <!--begin::Mobile logo-->
                        <div class="d-flex align-items-center flex-grow-1 flex-lg-grow-0">

                        </div>
                        <!--end::Mobile logo-->
                        <!--begin::Header wrapper-->
                        <div class="d-flex align-items-stretch justify-content-between flex-lg-grow-1" id="kt_app_header_wrapper">
                            <!--begin::Menu wrapper-->
                            <div class="app-header-menu app-header-mobile-drawer align-items-stretch" data-kt-drawer="true" data-kt-drawer-name="app-header-menu" data-kt-drawer-activate="{default: true, lg: false}" data-kt-drawer-overlay="true" data-kt-drawer-width="250px" data-kt-drawer-direction="end" data-kt-drawer-toggle="#kt_app_header_menu_toggle" data-kt-swapper="true" data-kt-swapper-mode="{default: 'append', lg: 'prepend'}" data-kt-swapper-parent="{default: '#kt_app_body', lg: '#kt_app_header_wrapper'}">
                                <!--begin::Menu-->
                                <div class="menu menu-rounded menu-column menu-lg-row my-5 my-lg-0 align-items-stretch fw-semibold px-2 px-lg-0" id="kt_app_header_menu" data-kt-menu="true">
                                    <!--begin:Menu item-->
                                    <div data-kt-menu-trigger="{default: 'click', lg: 'hover'}" data-kt-menu-placement="bottom-start" class="menu-item menu-here-bg menu-lg-down-accordion me-0 me-lg-2">
                                        <!--begin:Menu link-->
                                        <span class="menu-link">
                                            <span class="menu-title" style="color: #1B84FF;">Menu</span>
                                            <span class="menu-arrow d-lg-none"></span>
                                        </span>
                                        <!--end:Menu link-->
                                        <!--begin:Menu sub-->
                                        <div class="menu-sub menu-sub-lg-down-accordion menu-sub-lg-dropdown p-0 w-100 w-lg-850px">
                                            <!--begin:Dashboards menu-->
                                            <div class="menu-state-bg menu-extended overflow-hidden overflow-lg-visible" data-kt-menu-dismiss="true">
                                                <!--begin:Row-->
                                                <div class="row">
                                                    <!--begin:Col-->
                                                    <div class="col-lg-8 mb-3 mb-lg-0 py-3 px-3 py-lg-6 px-lg-6">
                                                        <!--begin:Row-->
                                                        <div class="row">
                                                            <!--begin:Col-->
                                                            <div class="col-lg-6 mb-3">
                                                                <!--begin:Menu item-->
                                                                <div class="menu-item p-0 m-0">
                                                                    <!--begin:Menu link-->
                                                                    <a href="index.jsp" class="menu-link">
                                                                        <span class="menu-custom-icon d-flex flex-center flex-shrink-0 rounded w-40px h-40px me-3">
                                                                            <i class="ki-duotone ki-element-11 text-primary fs-1">
                                                                                <span class="path1"></span>
                                                                                <span class="path2"></span>
                                                                                <span class="path3"></span>
                                                                                <span class="path4"></span>
                                                                            </i>
                                                                        </span>
                                                                        <span class="d-flex flex-column">
                                                                            <span class="fs-6 fw-bold text-gray-800">Tabella file</span>
                                                                        </span>
                                                                    </a>
                                                                    <!--end:Menu link-->
                                                                </div>
                                                                <!--end:Menu item-->
                                                            </div>
                                                            <!--end:Col-->
                                                            <!--begin:Col-->
                                                            <div class="col-lg-6 mb-3">
                                                                <!--begin:Menu item-->
                                                                <div class="menu-item p-0 m-0">

                                                                </div>
                                                                <!--end:Menu item-->
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--begin::Navbar-->
                    <div class="app-navbar flex-shrink-0" style="padding: 20px;">
                        <!--begin::Theme mode-->
                        <div class="app-navbar-item ms-1 ms-md-4">
                            <!--begin::Menu toggle-->

                            <!--begin::Menu toggle-->
                            <!--begin::Menu-->
                            <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-title-gray-700 menu-icon-gray-500 menu-active-bg menu-state-color fw-semibold py-4 fs-base w-150px" data-kt-menu="true" data-kt-element="theme-mode-menu">
                                <!--begin::Menu item-->
                                <div class="menu-item px-3 my-0">

                                </div>
                                <!--end::Menu item-->
                                <!--begin::Menu item-->
                                <div class="menu-item px-3 my-0">

                                </div>
                                <!--end::Menu item-->
                                <!--begin::Menu item-->
                                <div class="menu-item px-3 my-0">

                                </div>
                                <!--end::Menu item-->
                            </div>
                            <!--end::Menu-->
                        </div>
                        <!--end::Theme mode-->
                        <!--begin::User menu-->
                        <%
                            String username = session.getAttribute("us_name").toString();
                            String name = session.getAttribute("us_nome").toString();
                            String surname = session.getAttribute("us_cognome").toString();
                            String nomeCompleto = name + " " + surname;
                            String name2 = session.getAttribute("us_nome").toString();
                            String userIdParam = session.getAttribute("us_id").toString();
                            FilesUtils filesUtils = new FilesUtils();


                        %>
                        <div class="app-navbar-item ms-1 ms-md-4" id="kt_header_user_menu_toggle">
                            <!--begin::Menu wrapper-->
                            <div class="cursor-pointer symbol symbol-35px" data-kt-menu-trigger="{default: 'click', lg: 'hover'}" data-kt-menu-attach="parent" data-kt-menu-placement="bottom-end">
                                <div class="symbol symbol-50px" >
                                    <div class="symbol-label fs-2 fw-semibold text-primary"> <%= name2.charAt(0)%> </div>
                                </div>
                            </div>
                            <!--begin::User account menu-->
                            <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-800 menu-state-bg menu-state-color fw-semibold py-4 fs-6 w-275px" data-kt-menu="true">
                                <!--begin::Menu item-->
                                <div class="menu-item px-3">
                                    <div class="menu-content d-flex align-items-center px-3">
                                        <!--begin::Avatar-->
                                        <div class="symbol symbol-50px me-5">
                                            <div class="symbol symbol-50px">
                                                <div class="symbol-label fs-2 fw-semibold text-primary"> <%= name2.charAt(0)%> </div>
                                            </div>
                                        </div>
                                        <!--end::Avatar-->
                                        <!--begin::Username-->

                                        <div class="d-flex flex-column">
                                            <div class="fw-bold d-flex align-items-center fs-5"><%=nomeCompleto%>
                                                <span class="badge badge-light-success fw-bold fs-8 px-2 py-1 ms-2">Utente</span></div>
                                            <a href="#" class="fw-semibold text-muted text-hover-primary fs-7"><%=username%></a>
                                        </div>
                                        <!--end::Username-->
                                    </div>
                                </div>
                                <!--end::Menu item-->
                                <!--begin::Menu separator-->
                                <div class="separator my-2"></div>
                                <!--end::Menu separator-->
                                <!--begin::Menu item-->
                                <!--<div class="menu-item px-5">
                                    <a href="account/overview.html" class="menu-link px-5">My Profile</a>
                                </div>-->
                                <!--end::Menu item-->
                                <!--begin::Menu separator-->
                                <!--end::Menu separator-->
                                <!--begin::Menu item-->
                                <!--   <div class="menu-item px-5 my-1">
                                    <a href="account/settings.html" class="menu-link px-5">Account Settings</a>
                                </div>--->
                                <!--end::Menu item-->
                                <!--begin::Menu item-->
                                <div class="menu-item px-5">
                                    <a id="logoutButton" class="menu-link px-5">Sign Out</a>
                                </div>
                                <!--end::Menu item-->
                            </div>
                            <!--end::User account menu-->
                            <!--end::Menu wrapper-->    
                        </div>
                        <!--end::User menu-->
                    </div>
                </div>
                <br>
                <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
                    <!--begin::Content wrapper-->
                    <div id="kt_app_content_container" class="container" >
                        <!--begin::Stats-->
                        <div class="row gx-6 gx-xl-9" style="display: flex; justify-content: flex-start">
                            <div class="col-lg-6 col-xxl-4">
                                <!--begin::Card-->
                                <div class="card h-100">
                                    <!--begin::Card body-->
                                    <%

                                        List<FileEntity> tutti = filesUtils.getAllFiles();

                                    %>
                                    <div class="card-body p-9" style="box-shadow: rgba(0,0,0,0.18) 0px 2px 4px;">
                                        <!--begin::Heading-->
                                        <div class="fs-2hx fw-bold"><%=tutti.size()%></div>
                                        <div class="fs-4 fw-semibold text-gray-500 mb-7">Documenti presenti</div>
                                        <!--end::Heading-->
                                        <!--begin::Wrapper-->
                                        <div class="d-flex flex-wrap">
                                            <!--begin::Chart-->
                                            <div class="d-flex flex-center h-100px w-100px me-9 mb-5">
                                                <canvas id="kt_project_list_chart"></canvas>
                                            </div>
                                            <!--end::Chart-->
                                            <%
                                                List<FileEntity> daModificare = filesUtils.getFilesWithStatus1();

                                                int daModificare2 = 0;
                                                if (!daModificare.isEmpty()) {
                                                    daModificare2 = daModificare.size();
                                                }

                                                List<FileEntity> attivi = filesUtils.getFilesWithStatus2();

                                                int attivi2 = 0;
                                                if (!attivi.isEmpty()) {
                                                    attivi2 = attivi.size();
                                                }

                                                List<FileEntity> completati = filesUtils.getFilesWithStatus3();

                                                int completati2 = 0;
                                                if (!completati.isEmpty()) {
                                                    completati2 = completati.size();
                                                }

                                            %>
                                            <!--begin::Labels-->
                                            <div class="d-flex flex-column justify-content-center flex-row-fluid pe-11 mb-5">
                                                <!--begin::Label-->
                                                <div class="d-flex fs-6 fw-semibold align-items-center mb-3">
                                                    <div class="bullet bg-gray-300 me-3"></div>
                                                    <div class="text-gray-500">Da prendere in carico</div>
                                                    <div class="ms-auto fw-bold text-gray-700"><%=daModificare2%></div>
                                                </div>
                                                <!--end::Label-->
                                                <!--begin::Label-->
                                                <div class="d-flex fs-6 fw-semibold align-items-center mb-3">
                                                    <div class="bullet bg-primary me-3"></div>
                                                    <div class="text-gray-500">Presi in carico</div>
                                                    <div class="ms-auto fw-bold text-gray-700"><%=attivi2%></div>
                                                </div>
                                                <!--end::Label-->
                                                <!--begin::Label-->
                                                <div class="d-flex fs-6 fw-semibold align-items-center">
                                                    <div class="bullet bg-success me-3"></div>
                                                    <div class="text-gray-500">Completati</div>
                                                    <div class="ms-auto fw-bold text-gray-700"><%=completati2%></div>
                                                </div>
                                                <!--end::Label-->
                                            </div>
                                            <!--end::Labels-->
                                        </div>
                                        <!--end::Wrapper-->
                                    </div>
                                    <!--end::Card body-->
                                </div>
                                <!--end::Card-->
                            </div>
                        </div>
                    </div>

                    <hr>

                    <div class="container px-4 py-5 px-md-5 text-center text-lg-start my-5">
                        <div class="container border px-4 py-5 px-md-5 text-center text-lg-start my-5" style="box-shadow: rgba(50,50,93,0.5) 0px 30px 60px -12px, rgba(0,0,0,0.3) 0px 18px 36px -18px;" >
                            <h1>Elenco documenti</h1>


                            <div class="col-12" style="z-index: 10; background-color: white; min-height: 70vh;">
                                <form action="FilesServlet" method="POST" class="form-horizontal" style="display: block">
                                    <div class="form-group">
                                        <label class="active" for="stato">Filtro Documenti</label>
                                        <select id="stato" class="form-control" name="stato">
                                            <option value="DaModificare">Da prendere in carico</option>
                                            <option value="Attivi">Presi in carico</option>
                                            <option value="Completati">Completati</option>
                                            <option value="Tutti">Tutti</option>
                                        </select>
                                    </div>
                                </form>
                                <div class="table-responsive">


                                    <table id="files" class="table table-striped table-row-bordered gy-5 gs-7" style="width:100%;">
                                        <thead>
                                            <tr>
                                                <th>Tipologia documentale : </th>
                                                <th>Nome del file : </th>
                                                <th>Data di upload :</th>
                                                <th>Stato :</th>
                                                <th>Azione : </th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <!--begin::Footer-->
        <div id="kt_app_footer" class="app-footer">
            <!--begin::Footer container-->
            <div class="app-container container-fluid d-flex flex-column flex-md-row flex-center flex-md-stack py-3">
                <!--begin::Copyright-->
                <div class="text-gray-900 order-2 order-md-1">
                    <span class="text-muted fw-semibold me-1">2024&copy;</span>
                    <a href="" target="_blank" class="text-gray-800 text-hover-primary">Keenthemes</a>
                </div>
                <!--end::Copyright-->
                <!--begin::Menu-->
                <ul class="menu menu-gray-600 menu-hover-primary fw-semibold order-1">
                    <li class="menu-item">
                        <a href="" target="_blank" class="menu-link px-2">About</a>
                    </li>
                    <li class="menu-item">
                        <a href="" target="_blank" class="menu-link px-2">Support</a>
                    </li>
                    <li class="menu-item">
                        <a href="" target="_blank" class="menu-link px-2">Purchase</a>
                    </li>
                </ul>
                <!--end::Menu-->
            </div>
            <!--end::Footer container-->
        </div>
        <!--end::Footer-->

        <!--begin::Scrolltop-->
        <div id="kt_scrolltop" class="scrolltop" data-kt-scrolltop="true" style="background-color: #1B84FF;">
            <i class="ki-duotone ki-arrow-up">
                <span class="path1"></span>
                <span class="path2"></span>
            </i>
        </div>
        <!--end::Scrolltop-->



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

        <script>
            function viewDoc(filename, id) {
                var esito;
                $.ajax({
                    type: "POST",
                    url: "FilenameCheck",
                    data: {
                        "id": id,
                        "azione" : viewDoc
                    },
                    async: false,
                    success: function (result) {
                        esito = result;
                    }
                });
            }
            function openDoc(filename, id) {
                // CONTROLLO
                var esito;
                $.ajax({
                    type: "POST",
                    url: "FilenameCheck",
                    data: {
                        "id": id
                    },
                    async: false,
                    success: function (result) {
                        esito = result;
                    }
                });
                if (esito === "KO") {
                    Swal.fire({
                        text: "Documento già preso in carico da un altro utente!",
                        icon: "error",
                        buttonsStyling: false,
                        confirmButtonText: "OK",
                        customClass: {
                            confirmButton: "btn btn-danger"
                        }
                    }).then((result) => {
                        if (result.isConfirmed) {
                            location.reload();
                        }
                    });
                } else if (esito.includes(";")) {
                    Swal.fire({
                        text: "Hai già un documento preso in carico. Premuto il tasto di conferma verrai reindirizzato a quel documento!",
                        icon: "warning",
                        buttonsStyling: false,
                        confirmButtonText: "OK",
                        customClass: {
                            confirmButton: "btn btn-warning"
                        }
                    }).then((result) => {
                        if (result.isConfirmed) {
                            var utenteAssociato = esito.split(";");
                            var id = utenteAssociato[1];
                            var filename = utenteAssociato[0];
                            if (filename.toLowerCase().endsWith(".png") || filename.toLowerCase().endsWith(".jpeg") || filename.toLowerCase().endsWith(".jpg") || filename.toLowerCase().endsWith(".img")) {
                                window.location.href = "compilaImg.jsp?filename=" + filename + "&id=" + id;
                            } else if ((filename.toLowerCase().endsWith(".pdf"))) {
                                window.location.href = "compilaDocumenti.jsp?filename=" + filename + "&id=" + id;
                            }
                        }
                    });

                } else if (esito === "OK") {
                    if (filename.toLowerCase().endsWith(".pdf")) {
                        updateFileStatus(id, function () {
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
                        });
                    } else if (filename.toLowerCase().endsWith(".png") || filename.toLowerCase().endsWith(".jpeg") || filename.toLowerCase().endsWith(".jpg")) {
                        updateFileStatus(id, function () {
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
                        });
                    } else {
                        console.error("Formato del file non supportato");
                    }
                }
            }

            function updateFileStatus(id, callback) {
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "UpdateFilesStatus", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        console.log("File status updated successfully");
                        callback();
                    }
                };
                xhr.send("id=" + id);
            }
        </script>

        <script>
            function getUrlParameter(name) {
                name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
                var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
                var results = regex.exec(location.search);
                return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
            }

            $(document).ready(function () {
                var esito = getUrlParameter('esito');
                if (esito === 'OK') {
                    Swal.fire({
                        text: 'Operazione completata con successo!',
                        icon: 'success',
                        buttonsStyling: false,
                        confirmButtonText: 'OK',
                        customClass: {
                            confirmButton: 'btn btn-success'
                        }
                    });
                } else if (esito === 'ERROR') {
                    Swal.fire({
                        text: 'Si è verificato un errore. Si prega di riprovare.',
                        icon: 'error',
                        buttonsStyling: false,
                        confirmButtonText: 'OK',
                        customClass: {
                            confirmButton: 'btn btn-danger'
                        }
                    });
                }
            });
        </script>


        <script>
            $(document).ready(function () {
                $("#logoutButton").click(function (event) {
                    event.preventDefault();
                    window.location.href = "Logout";
                });
            }
            );
        </script>
        <!--end::Javascript-->
    </body>
</html>