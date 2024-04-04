/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

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
