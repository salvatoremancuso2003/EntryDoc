<%-- 
    Document   : compilaDocumenti
    Created on : 19 feb 2024, 10:09:42
    Author     : Salvatore
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.12.313/pdf.min.js"></script>
    </head>
    <body>
        <%
            String filename = request.getParameter("filename");
            String idString = request.getParameter("id");
            Long id = Long.parseLong(idString);
            FileEntityUtils fileEntityUtils = new FileEntityUtils();
            FileEntity fileEntity = fileEntityUtils.getFileByIdAndFilename(id, filename);
        %>



    </body>
</html>
