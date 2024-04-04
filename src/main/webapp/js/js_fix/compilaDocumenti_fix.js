/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


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

var pdfDoc = null;
var pageNum = 1;
var scale = 1.5;
var renderTask = null;

function renderPage(num) {
    if (renderTask) {
        renderTask.cancel();
    }

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

        renderTask = page.render(renderContext);

        renderTask.promise.then(function () {
            document.getElementById('pageNumberInput').value = num;
        }).catch(function (error) {
            console.error('Error rendering page:', error);
        });
    }).catch(function (error) {
        console.error('Error getting page:', error);
    });
}

function goPrevious() {
    if (pageNum <= 1)
        return;
    pageNum--;
    renderPage(pageNum);
}

function goNext() {
    if (pageNum >= pdfDoc.numPages)
        return;
    pageNum++;
    renderPage(pageNum);
}

function goToPage(pageNumber) {
    if (pageNumber) {
        if (pageNumber >= 1 && pageNumber <= pdfDoc.numPages) {
            pageNum = pageNumber;
            renderPage(pageNum);
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

var selectedPages = [];

function saveCheckboxState() {
    selectedPages = [];
    var checkboxes = document.querySelectorAll('.custom-checkbox:checked');
    checkboxes.forEach(function (checkbox) {
        selectedPages.push(checkbox.value);
    });
    updateHiddenInput();
}

function updateHiddenInput() {
    var hiddenInput = document.getElementById('selectedPagesInput');
    if (hiddenInput) {
        hiddenInput.value = JSON.stringify(selectedPages);
    }
}


document.getElementById('saveForm').addEventListener('submit', function (event) {
    saveCheckboxState();
});

$(document).ready(function () {
    $("#logoutButton").click(function (event) {
        event.preventDefault();
        window.location.href = "Logout";
    });
});