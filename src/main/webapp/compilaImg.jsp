<%-- 
    Document   : compilaImg
    Created on : 19 feb 2024, 15:30:19
    Author     : Salvatore
--%>

<%@page import="org.apache.commons.codec.binary.Base64"%>
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
            byte[] imgContent = fileUtils.getFileContentByIdAndFilename(id, filename);

            if (imgContent != null) {
                String base64EncodedImg = new String(Base64.encodeBase64(imgContent));
        %>
        <img src="data:image/jpeg;base64,<%= base64EncodedImg%>" alt="<%=filename%>">
        <%
            } else {
                out.println("Immagine non trovata");
            }
        %>
    </body>
</html>
