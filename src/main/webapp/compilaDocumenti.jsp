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
        <title>JSP Page</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.11.338/pdf.min.js"></script>
        <script src="Bootstrap2024/assets/js/bootstrap-italia.min.js"></script>
        <link rel="stylesheet" href="Bootstrap2024/assets/css/bootstrap-italia.min.css"/>

        <style>
            .selected-page {
                display: none;
            }

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
        <%
            String filename = request.getParameter("filename");
            String idParam = request.getParameter("id");
            Long id = Long.parseLong(idParam);

            FilesUtils fileUtils = new FilesUtils();
            byte[] pdfContent = fileUtils.getFileContentByIdAndFilename(id, filename);

            if (pdfContent != null) {
                String base64EncodedPDF = new String(Base64.encodeBase64(pdfContent));

        %>


        <section class="background-radial-gradient overflow-hidden" style="min-height: 100vh;">

            <div class="container px-4 py-5 px-md-5 text-center text-lg-start my-5">
                <div class="row gx-lg-5 align-items-center mb-5">
                    <div class="col-6" style="z-index: 10; background-color: white; min-height: 60vh; width: 50%;">
                        <div>
                            <button style="background-color: rgba(173,31,255, 1.0)" class="btn btn-primary" onclick="goPrevious()">Precedente</button>
                            <button style="background-color: rgba(173,31,255, 1.0)" class="btn btn-primary" onclick="goNext()">Successivo</button>
                            <span>Pagina: <input type="text" id="pageNumberInput" value="1"></span>
                            <button style="background-color: rgba(173,31,255, 1.0)" class="btn btn-primary" onclick="goToPage()">Vai</button>
                            <span id="pageCount"></span>
                        </div>
                        <canvas id="pdfViewer" style="width: 100%; height: 100%;"></canvas>
                    </div>
                    <div id="thumbnailsContainer" style="display: none !important; background-color: lightgray; width: 8%; height: auto; display: flex; position: fixed; top:0; left: 50%; justify-content: flex-start; padding-left: 20px; flex-direction: column; border: 2px solid;"></div>
                </div>
            </div>

        </section>





        
        

        
        
        
        
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
                var pageNumberLabel = document.createElement('div');
                pageNumberLabel.textContent = 'Pagina ' + pageNumber;
                pageNumberLabel.classList.add('thumbnail-page-number');
                thumbnailContainer.appendChild(pageNumberLabel);
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
                            if (index + 1 !== pageNum) {
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
                                    thumbnailImg.addEventListener('click', function (event) {
                                        var clickedThumbnail = event.target;
                                        var clickedPageNumber = parseInt(clickedThumbnail.getAttribute('data-page'));
                                        goToPage(clickedPageNumber);
                                    });
                                    addPageNumber(thumbnailContainer, pageNumber);
                                    thumbnailContainer.appendChild(thumbnailImg);
                                    thumbnailsContainer.appendChild(thumbnailContainer);
                                });
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
