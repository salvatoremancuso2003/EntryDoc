<%-- 
    Document   : compilaDocumenti
    Created on : 19 feb 2024, 10:09:42
    Author     : Salvatore
--%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="entity.FileEntity"%>
<%@page import="Utils.FilesUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <!--end::Global Stylesheets Bundle-->
        
        <style>
            .selected-page {
                display: none;
            }

            .thumbnail-page-container {
                display: flex;
                align-items: center;
            }

            .thumbnail-page-number, .custom-checkbox {
                margin-right: 10px;
            }


        </style>

    </head>
    <body>
        <%
            String filename = request.getParameter("filename");
            String idParam = request.getParameter("id");
            Long id = Long.parseLong(idParam);

            FilesUtils fileUtils = new FilesUtils();
            byte[] pdfContent = fileUtils.getFileContentByIdAndFilename(id, filename);

            if (pdfContent != null) {
                String base64EncodedPDF = new String(Base64.encodeBase64(pdfContent));

        %>


        <div class="container px-4 py-5 px-md-5 text-center text-lg-start my-5">
            <div class="row gx-lg-5 align-items-center mb-5">
                <div class="col-6" style="z-index: 10; background-color: white; min-height: 60vh; width: 50%;">
                    <div>
                        <button class="btn btn-secondary" onclick="goPrevious()">Precedente</button>
                        <button class="btn btn-secondary" onclick="goNext()">Successivo</button>
                        <span>Pagina: <input type="text" id="pageNumberInput" value="1"></span>
                        <button class="btn btn-secondary" onclick="goToPage()">Vai</button>
                        <span id="pageCount"></span>
                    </div>
                    <canvas id="pdfViewer" style="width: 100%; height: 100%;"></canvas>
                </div>
                <div id="thumbnailsContainer" style="display: none !important; background-color: lightgray; width: 8%; height: auto; display: flex; position: fixed; top:0; left: 50%; justify-content: flex-start; padding-left: 20px; flex-direction: column; border: 2px solid;"></div>
            </div>

        </div>
        
        
        
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
                                    thumbnailContainer.style.boxShadow = '0 0 5px rgba(0, 0, 0, 0.5)';
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

        <%
            } else {
                out.println("PDF not found");
            }
        %>
    </body>
</html>
