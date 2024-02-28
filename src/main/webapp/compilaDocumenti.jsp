<%-- 
    Document   : compilaDocumenti
    Created on : 19 feb 2024, 10:09:42
    Author     : Salvatore
--%>
<%@page import="java.sql.Timestamp"%>
<%@page import="entity.Campo_form"%>
<%@page import="entity.CampoTipologiaDocumento"%>
<%@page import="java.util.List"%>
<%@page import="entity.Tipologia_documento"%>
<%@page import="Utils.Form"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="entity.FileEntity"%>
<%@page import="Utils.FilesUtils"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Visualizza e Compila Documento</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.11.338/pdf.min.js"></script>

        <!--begin::Fonts(mandatory for all pages)-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700" />
        <!--end::Fonts-->

        <!--begin::Vendor Stylesheets(used for this page only)-->

        <!--end::Vendor Stylesheets-->

        <!--begin::Global Stylesheets Bundle(mandatory for all pages)-->
        <link href="assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.bundle.css" rel="stylesheet" type="text/css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <!--end::Global Stylesheets Bundle-->

        <style>
            .bg-01 {
                background-image: url('assets/media/auth/bg6.jpg');
                opacity: 0.9;
            }
        </style>

    </head>
    <body class="app-default" id="kt_app_body" data-kt-app-layout="dark-header" data-kt-app-toolbar-enabled="true">
        <%
            String filename = request.getParameter("filename");
            String idParam = request.getParameter("id");
            Long id = Long.parseLong(idParam);

            FilesUtils fileUtils = new FilesUtils();
            byte[] pdfContent = fileUtils.getFileContentByIdAndFilename(id, filename);

            Timestamp fileExpirationDate = fileUtils.getFileExpirationDate(id, filename);

            if (pdfContent != null) {
                String base64EncodedPDF = new String(Base64.encodeBase64(pdfContent));
                if (fileExpirationDate != null && fileExpirationDate.getTime() < System.currentTimeMillis()) {
        %>
        <script>
            alert("Il documento ? stato reimpostato! Il tempo per concludere il documento ? terminato!");
        </script>
        <%
            }
        %>

        <%
            String username = session.getAttribute("us_name").toString();
            String name = session.getAttribute("us_nome").toString();
            String surname = session.getAttribute("us_cognome").toString();
            String nomeCompleto = name + " " + surname;
            String name2 = session.getAttribute("us_nome").toString();
            String userIdParam = session.getAttribute("us_id").toString();


        %>


        <div class="d-flex flex-column flex-root app-root bg-01" id="kt_app_root">
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
                                                                            <span class="fs-6 fw-bold text-gray-800">Visualizzazione file</span>
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
                        <div class="app-navbar flex-shrink-0" style="padding: 20px;">
                            <!--begin::Theme mode-->
                            <div class="app-navbar-item ms-1 ms-md-4">
                                <!--begin::Menu toggle-->

                                <!--begin::Menu toggle-->
                                <!--begin::Menu-->

                            </div>
                            <!--end::Theme mode-->
                            <!--begin::User menu-->
                            <div class="app-navbar-item ms-1 ms-md-4" id="kt_header_user_menu_toggle">
                                <!--begin::Menu wrapper-->
                                <div class="cursor-pointer symbol symbol-35px" data-kt-menu-trigger="{default: 'click', lg: 'hover'}" data-kt-menu-attach="parent" data-kt-menu-placement="bottom-end">
                                    <div class="symbol symbol-50px" >
                                        <div class="symbol-label fs-2 fw-semibold text-primary"> <%= name2.charAt(0)%> </div>
                                    </div>                                </div>
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
                                    <div class="separator my-2"></div>
                                    <!--end::Menu separator-->
                                    <!--begin::Menu item-->
                                    <!--<div class="menu-item px-5 my-1">
                                        <a href="account/settings.html" class="menu-link px-5">Account Settings</a>
                                    </div>-->
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
                </div>
                <div class="container px-4 py-5 px-md-5 text-center text-lg-start my-5" >
                    <div class="row col-md-12">
                        <div class='border'  id="thumbnailsContainer" style="display: none !important; background-color: lightgray; width: 8%; height: auto; display: flex; position: fixed; top:10%; left: 5%; justify-content: flex-start; padding-left: 20px; flex-direction: column; border: 2px solid;"></div>
                        <div class="col-6" style="background-color: #ffff; border:solid 2px;">
                            <div>
                                <button class="btn btn-secondary" onclick="goPrevious()">Precedente</button>
                                <button class="btn btn-secondary" onclick="goNext()">Successivo</button>
                                <span>Pagina: <input type="text" id="pageNumberInput" value="1"></span>
                                <button class="btn btn-secondary" onclick="goToPage()">Vai</button>
                                <span id="pageCount"></span>
                            </div>
                            <canvas  id="pdfViewer" style="width: 100%; height: auto; border: 2px solid;"></canvas>
                        </div>

                        <% Form form = new Form();
                            Tipologia_documento tipologia_documento = form.findTipologiaDocumentoByFileEntityId(id);
                            List<CampoTipologiaDocumento> campoTipologiaDocumento = form.getCampoTipologiaDocumentoByTipologiaDocumento(tipologia_documento);
                            List<Tipologia_documento> tipologie = form.getTipologie(tipologia_documento);
                            String tipologia = tipologia_documento.getTipo();
                        %>
                        <div class="col-6" >
                            <!<!-- start form -->
                            <div class="container" style="background-color: #ffff; border:solid 2px;" >
                                <hr>
                                <form action="UpdateTipoDocumento" method="POST" id="updateForm">
                                    <input type="hidden" name="id" value="<%=id%>">
                                    <select name="tipoDocumento" id="tipoDocumento" class="form-select form-select-solid border" data-control="select2" data-placeholder="Select an option" data-allow-clear="true">
                                        <option value="<%=tipologia%>" class="selected"><%=tipologia%></option>
                                        <% for (Tipologia_documento tipo : tipologie) {%>
                                        <option value="<%=tipo.getId()%>"><%=tipo.getTipo()%></option>
                                        <% }%>
                                    </select>
                                    <hr>
                                    <button type="submit" class="btn btn-primary" id="submitUpdateForm">Salva</button>
                                    <button type="submit" class="btn btn-danger" id="submitUpdateForm">Salva</button>
                                </form>
                                <br>
                            </div>
                            <br>
                            <div class="container" style="background-color: #ffff; border:solid 2px; ">
                                <span id="countdown" style="font-size: 11px" ></span>
                                <br>
                                <h6>input form</h6>
                                <form action="" id="saveForm" method="POST">
                                    <div class="form-group" id="formFields">
                                        <% for (CampoTipologiaDocumento campo : campoTipologiaDocumento) { %>
                                        <% Campo_form campoForm = campo.getCampoForm();%>
                                        <div class="form-group">
                                            <label><%= campoForm.getEtichetta()%></label>
                                            <input type="<%= campoForm.getTipologia_campo()%>" id="input" name="<%= campoForm.getNome()%>" class="form-control">
                                        </div>
                                        <% }%>
                                        <br>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                </form>
                <script>
                    var countdownElement = document.getElementById('countdown');
                    var expirationTime = "<%= fileExpirationDate%>";
                    var id = "<%= id%>";
                    var isTimerExpired = false;

                    function startTimer(expirationDateTime, display) {
                        function updateDisplay() {
                            var currentTime = new Date();
                            var difference = expirationDateTime - currentTime;
                            var timer = Math.max(0, Math.floor(difference / 1000));

                            var minutes = Math.floor(timer / 60);
                            var seconds = timer % 60;

                            minutes = String(minutes).padStart(2, '0');
                            seconds = String(seconds).padStart(2, '0');

                            display.textContent = "Tempo rimasto prima della reimpostazione del documento: " + minutes + ":" + seconds;

                            if (timer <= 0 && !isTimerExpired) {
                                timerExpired();
                                isTimerExpired = true;
                            }
                        }

                        updateDisplay();
                        setInterval(updateDisplay, 1000);
                    }

                    function timerExpired() {
                        alert("Reimpostazione del documento effettuata");
                        updateFileStatus(id, true);
                    }

                    function updateFileStatus(id, timerScaduto) {
                        $.ajax({
                            type: "POST",
                            url: "UpdateFilesStatus",
                            data: {
                                id: id,
                                timerScaduto: timerScaduto
                            },
                            success: function (response) {
                                window.location.href = "index.jsp";
                            },
                            error: function (xhr, status, error) {
                                console.error("Error updating file status: " + error);
                            }
                        });
                    }

                    jQuery(function ($) {
                        var expirationDateTime = new Date(expirationTime);
                        startTimer(expirationDateTime, countdownElement);
                    });

                </script>





            </div>
        </div>

        <!--begin::Footer-->
        <div id="kt_app_footer" class="app-footer" style="background-color: #000 ;">
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
    </div>
</div>               
</div>
<!-- end form -->


<!--begin::Scrolltop-->
<div id="kt_scrolltop" class="scrolltop" data-kt-scrolltop="true" style="background-color: #1B84FF!important;">
    <i class="ki-duotone ki-arrow-up">
        <span class="path1"></span>
        <span class="path2"></span>
    </i>
</div>
<!--end::Scrolltop-->


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

                    let submitUpdateForm = document.getElementById('submitUpdateForm');
                    submitUpdateForm.addEventListener('click', function () {
                        Swal.fire({
                            text: "Tipologia Documentale Aggiornata!",
                            icon: "info",
                            buttonsStyling: false,
                            confirmButtonText: "OK",
                            customClass: {
                                confirmButton: "btn btn-primary"
                            }
                        }).then((result) => {
                            if (result.isConfirmed) {
                                location.reload();
                            }
                        });
                    });

                    $(document).ready(function () {
                        $('#updateForm').submit(function (event) {
                            event.preventDefault();

                            var form = $(this);

                            $.ajax({
                                type: form.attr('method'),
                                url: form.attr('action'),
                                data: form.serialize(),
                                success: function (data) {
                                },
                                error: function (xhr, status, error) {
                                    console.error('Si ? verificato un errore durante l\'invio del modulo:', error);
                                }
                            });
                        });
                    });
</script>

<script>
    var pdfDoc = null;
    var pageNum = 1;
    var scale = 1.5;
    function renderPage(num) {
        pdfDoc.getPage(num).then(function (page) {
            var canvas = document.getElementById('pdfViewer');
            var context = canvas.getContext('2d');
            var viewport = page.getViewport({scale: scale});
            canvas.height = viewport.height;
            canvas.width = viewport.width;
            var renderContext = {
                canvasContext: context,
                viewport: viewport
            };
            page.render(renderContext);
        });
        document.getElementById('pageNumberInput').value = num;
    }

    function goPrevious() {
        if (pageNum <= 1)
            return;
        pageNum--;
        renderPage(pageNum);
        loadAndRenderPDF(atob(base64EncodedPDF), pageNum);
    }

    function goNext() {
        if (pageNum >= pdfDoc.numPages)
            return;
        pageNum++;
        renderPage(pageNum);
        loadAndRenderPDF(atob(base64EncodedPDF), pageNum);
    }

    function goToPage(pageNumber) {
        if (pageNumber) {
            if (pageNumber >= 1 && pageNumber <= pdfDoc.numPages) {
                pageNum = pageNumber;
                renderPage(pageNum);
                loadAndRenderPDF(atob(base64EncodedPDF), pageNum);
            } else {
                alert('Numero di pagina non valido');
            }
        } else {
            var desiredPage = parseInt(document.getElementById('pageNumberInput').value);
            goToPage(desiredPage);
        }
    }

    function searchAndGoToPage() {
        goToPage();
    }
    function addPageNumber(thumbnailContainer, pageNumber) {
        var container = document.createElement('div');
        container.classList.add('thumbnail-page-container');

        var pageNumberLabel = document.createElement('div');
        pageNumberLabel.textContent = 'Pagina ' + pageNumber;
        pageNumberLabel.classList.add('thumbnail-page-number');

        var checkbox = document.createElement('input');
        checkbox.type = 'checkbox';
        checkbox.name = 'pageCheckbox';
        checkbox.className = 'custom-checkbox';
        checkbox.value = pageNumber;

        container.appendChild(pageNumberLabel);
        container.appendChild(checkbox);

        thumbnailContainer.appendChild(container);
    }

    var checkboxState = {};

    function saveCheckboxState() {
        var checkboxes = document.querySelectorAll('.custom-checkbox');
        checkboxes.forEach(function (checkbox) {
            checkboxState[checkbox.value] = checkbox.checked;
        });
    }
    function loadAndRenderPDF(base64Data) {
        pdfjsLib.getDocument({data: base64Data}).promise.then(function (pdf) {
            pdfDoc = pdf;
            document.getElementById('pageCount').textContent = ' / ' + pdfDoc.numPages;
            renderPage(pageNum);
            var numPages = pdf.numPages;
            if (numPages !== 1) {
                var thumbnailsContainer = document.getElementById('thumbnailsContainer');
                thumbnailsContainer.style.display = 'block';
            }
            var promises = [];
            for (var i = 1; i <= numPages; i++) {
                promises.push(pdf.getPage(i));
            }
            Promise.all(promises).then(function (pages) {
                var thumbnailsContainer = document.getElementById('thumbnailsContainer');
                thumbnailsContainer.innerHTML = '';
                pages.forEach(function (page, index) {
                    var thumbnailCanvas = document.createElement('canvas');
                    var ctx = thumbnailCanvas.getContext('2d');
                    var thumbnailWidth = 100;
                    var thumbnailHeight = 140;
                    var viewport = page.getViewport({scale: 1});
                    thumbnailCanvas.width = thumbnailWidth;
                    thumbnailCanvas.height = thumbnailHeight;
                    viewport = page.getViewport({scale: Math.min(thumbnailWidth / viewport.width, thumbnailHeight / viewport.height)});
                    var renderContext = {
                        canvasContext: ctx,
                        viewport: viewport
                    };
                    page.render(renderContext).promise.then(function () {
                        var thumbnail = thumbnailCanvas.toDataURL('image/png');
                        var thumbnailImg = document.createElement('img');
                        thumbnailImg.src = thumbnail;
                        var pageNumber = index + 1;
                        thumbnailImg.setAttribute('data-page', '' + pageNumber);
                        var thumbnailContainer = document.createElement('div');
                        thumbnailContainer.classList.add('thumbnail-container');
                        if (pageNumber === pageNum) {
                            thumbnailContainer.classList.add('current-page');
                            thumbnailContainer.style.border = "2px solid black";
                        }
                        thumbnailImg.addEventListener('click', function (event) {
                            var clickedThumbnail = event.target;
                            var clickedPageNumber = parseInt(clickedThumbnail.getAttribute('data-page'));
                            goToPage(clickedPageNumber);
                        });
                        addPageNumber(thumbnailContainer, pageNumber);
                        thumbnailContainer.appendChild(thumbnailImg);
                        thumbnailsContainer.appendChild(thumbnailContainer);
                    });
                });

                var checkboxes = document.querySelectorAll('.custom-checkbox');
                checkboxes.forEach(function (checkbox) {
                    if (checkboxState.hasOwnProperty(checkbox.value)) {
                        checkbox.checked = checkboxState[checkbox.value];
                    }
                });
            });
        });
    }

    var base64EncodedPDF = "<%= base64EncodedPDF%>";
    loadAndRenderPDF(atob(base64EncodedPDF));

</script>

<script>
    $(document).ready(function () {
        $("#logoutButton").click(function (event) {
            event.preventDefault();
            window.location.href = "Logout";
        });
    });
</script>

<%
    } else {
        out.println("PDF not found");
    }
%>
</body>
</html>

