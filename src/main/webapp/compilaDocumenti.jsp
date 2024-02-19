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
        <div class="container" style="display: flex; justify-content: center; width: 60vw; height: 100vh;">
            <iframe src="data:application/pdf;base64,<%= base64EncodedPDF%>" style="width: 100%; height: 100%;"></iframe>
        </div>


        <%
            } else {
                out.println("PDF not found");
            }
        %>
    </body>
</html>
