<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="Utils.FilesUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="js/tiff.min.js"></script>
        <!--begin::Fonts(mandatory for all pages)-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700" />
        <!--end::Fonts-->

        <!--begin::Vendor Stylesheets(used for this page only)-->

        <!--end::Vendor Stylesheets-->

        <!--begin::Global Stylesheets Bundle(mandatory for all pages)-->
        <link href="assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.bundle.css" rel="stylesheet" type="text/css" />
        <link href="assets/plugins/custom/datatables/datatables.bundle.css" rel="stylesheet" type="text/css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <!--end::Global Stylesheets Bundle-->
    </head>
    <body>
        <%
            String filename = request.getParameter("filename");
            String idParam = request.getParameter("id");
            Long id = Long.parseLong(idParam);

            FilesUtils fileUtils = new FilesUtils();
            byte[] fileContent = fileUtils.getFileContentByIdAndFilename(id, filename);

            if (fileContent != null) {
                String base64EncodedFile = new String(Base64.encodeBase64(fileContent));

                String fileExtension = filename.substring(filename.lastIndexOf(".") + 1);

                if (fileExtension.equalsIgnoreCase("tiff") || fileExtension.equalsIgnoreCase("tif")) {
        %>

        <div class="container">
            <div class="row">
                <div class="col-6">
                    <canvas id="tiffViewer" style="width: 40%; height: auto; border: 1px solid; image-rendering: pixelated;"></canvas>


                </div>
                <div class="col-6">
                    <div id="thumbnailsContainer" style="overflow-y: auto; max-height: 500px;"></div>
                </div>
            </div>
        </div>
        <script>
            var base64EncodedTIFF = "<%= base64EncodedFile%>";
            function base64ToArrayBuffer(base64) {
                var binary_string = atob(base64);
                var len = binary_string.length;
                var bytes = new Uint8Array(len);
                for (var i = 0; i < len; i++) {
                    bytes[i] = binary_string.charCodeAt(i);
                }
                return bytes.buffer;
            }

            function renderTIFFPage(tiff, pageNum) {
                var canvas = document.getElementById('tiffViewer');
                if (!canvas) {
                    console.error("Canvas element not found.");
                    return;
                }
                var context = canvas.getContext('2d');

                tiff.setDirectory(pageNum);

                context.drawImage(tiff.toCanvas(), 0, 0);
            }


            function renderTIFFThumbnail(tiff, pageNum, pageNumber) {
                var thumbnailsContainer = document.getElementById('thumbnailsContainer');

                var thumbnailCanvas = document.createElement('canvas');
                var ctx = thumbnailCanvas.getContext('2d');
                var thumbnailWidth = 200;
                var thumbnailHeight = 200;

                tiff.setDirectory(pageNum);

                var width = tiff.width();
                var height = tiff.height();

                var scale = Math.min(thumbnailWidth / width, thumbnailHeight / height);
                var thumbnailWidthScaled = width * scale;
                var thumbnailHeightScaled = height * scale;

                thumbnailCanvas.width = thumbnailWidthScaled;
                thumbnailCanvas.height = thumbnailHeightScaled;

                ctx.drawImage(tiff.toCanvas(), 0, 0, width, height, 0, 0, thumbnailWidthScaled, thumbnailHeightScaled);

                var thumbnailImg = document.createElement('img');
                thumbnailImg.src = thumbnailCanvas.toDataURL();

                thumbnailImg.setAttribute('data-page', pageNumber);

                thumbnailImg.addEventListener('click', function (event) {
                    var clickedThumbnail = event.target;
                    var clickedPageNumber = parseInt(clickedThumbnail.getAttribute('data-page'));
                    renderTIFFPage(tiff, clickedPageNumber - 1);
                });

                thumbnailsContainer.appendChild(thumbnailImg);
            }

            function loadAndRenderTIFF(base64Data) {
                Tiff.initialize({TOTAL_MEMORY: 16777216 * 10});
                var tiff = new Tiff({buffer: base64ToArrayBuffer(base64Data)});

                renderTIFFPage(tiff, 0);

                var numPages = tiff.countDirectory();
                if (numPages > 1) {
                    var thumbnailsContainer = document.getElementById('thumbnailsContainer');
                    for (var i = 0; i < numPages; i++) {
                        renderTIFFThumbnail(tiff, i, i + 1);
                    }
                }
            }

            loadAndRenderTIFF(base64EncodedTIFF);
        </script>
        <%
        } else {
        %>
        <img src="data:image/jpeg;base64,<%= base64EncodedFile%>" alt="<%= filename%>">
        <%
                }
            } else {
                out.println("File non trovato");
            }
        %>

        <!--begin::Javascript-->
        <!--begin::Global Javascript Bundle(mandatory for all pages)-->
        <script src="assets/plugins/global/plugins.bundle.js"></script>
        <script src="assets/js/scripts.bundle.js"></script>
        <!--end::Global Javascript Bundle-->

        <!--begin::Vendors Javascript(used for this page only)-->

        <!--end::Vendors Javascript-->
        <script src="assets/plugins/custom/datatables/datatables.bundle.js"></script>
        <!--begin::Custom Javascript(used for this page only)-->
        <script src="assets/js/widgets.bundle.js"></script>
        <script src="assets/js/custom/widgets.js"></script>
        <script src="assets/js/custom/apps/chat/chat.js"></script>
        <script src="assets/js/custom/utilities/modals/upgrade-plan.js"></script>
        <script src="assets/js/custom/utilities/modals/create-app.js"></script>
        <script src="assets/js/custom/utilities/modals/new-target.js"></script>
        <script src="assets/js/custom/utilities/modals/users-search.js"></script>
    </body>
</html>
