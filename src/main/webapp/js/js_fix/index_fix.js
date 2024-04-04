/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

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
                if (filename.toLowerCase().endsWith(".tif") || filename.toLowerCase().endsWith(".tiff")) {
                    window.location.href = "compilaDocumenti.jsp?filename=" + filename + "&id=" + id;
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
        } else if (filename.toLowerCase().endsWith(".tif") || filename.toLowerCase().endsWith(".tiff")) {
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

function viewDoc(filename, id) {
    Swal.fire({
        text: "Vuoi visualizzare i dati di questo file?",
        icon: "info",
        buttonsStyling: false,
        confirmButtonText: "Sì",
        customClass: {
            confirmButton: "btn btn-info"
        }
    }).then((result) => {
        if (result.isConfirmed) {
            if (filename.toLowerCase().endsWith(".tif") || filename.toLowerCase().endsWith(".tiff")) {
                window.location.href = "compilaDocumenti.jsp?filename=" + filename + "&id=" + id + "&visualizza=" + true;
            } else if ((filename.toLowerCase().endsWith(".pdf"))) {
                window.location.href = "compilaDocumenti.jsp?filename=" + filename + "&id=" + id + "&visualizza=" + true;
            }
        }
    });
}
;

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
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "index.jsp";
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
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "index.jsp";
            }
        });
    }
});

$(document).ready(function () {
    $("#logoutButton").click(function (event) {
        event.preventDefault();
        window.location.href = "Logout";
    });
}
);

