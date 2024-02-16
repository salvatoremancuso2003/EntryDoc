/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function openModalFile(practiceId) {
    $.ajax({
        url: 'AttachmentsServlet',
        method: 'POST',
        data: {practiceId: practiceId},
        success: function (response) {
            // Distruggi la DataTable esistente, se presente
            if ($.fn.DataTable.isDataTable('#fileTable')) {
                $('#fileTable').DataTable().destroy();
            }

            $(".attributipratica").val(practiceId);

            var table = $('#fileTable').DataTable({
                data: response,
                columns: [
                    {title: 'ID', data: 'id'},
                    {title: 'Nome File', data: 'filename', render: function (data, type, row) {
                            return '<a href="#" onclick="downloadFileAttach(' + row.id + ')">' + data + '</a>';
                        }},
                    {title: 'Descrizione', data: 'description'}
                ]
            });

            var fileModal = document.getElementById("fileModal");
            fileModal.style.display = "block";

            window.onclick = function (event) {
                if (event.target === fileModal) {
                    fileModal.style.display = "none";
                }
            };
        },
        error: function (xhr, status, error) {
            console.error('Errore durante il recupero dei file: ', status, error);
            alert('Errore durante il recupero dei file.');
        }
    });
}

function addFile(practiceId) {
    var fileInput = document.getElementById("fileInput");
    var file = fileInput.files[0];

    if (!file) {
        alert("Seleziona un file prima di caricare.");
        return;
    }

    var formData = new FormData();
    formData.append("practiceId", practiceId);
    formData.append("file", file);

    $.ajax({
        url: "AttachmentUploadServlet?practiceId=" + practiceId,
        type: "POST",
        data: formData,
        contentType: 'multipart/form-data',
        processData: false,
        success: function (data) {
            console.log(data);

            if (data.success) {
                alert('File caricato con successo!');
                closeFileModal();
            } else {
                alert('Errore durante l\'upload del file.');
            }
        },
        error: function (error) {
            console.error("Error:", error);
            alert(error.statusText + practiceId);
        }
    });
}


function downloadFileAttach(fileId) {
    window.location.href = 'DownloadFileServlet?fileId=' + fileId;
}

function closeFileModal() {

    document.getElementById("fileModal").style.display = "none";
}



