<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Documento Viewer</title>
        <link rel="stylesheet" href="Bootstrap2024/assets/css/bootstrap-italia.min.css"/>
        <link rel="stylesheet" href="css/index.css"/>
        <link rel="stylesheet" href="css/dataTable/datatables.css"/>
        <script src="Bootstrap2024/assets/js/bootstrap-italia.min.js" ></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    </head>
    <body>

        <section class="background-radial-gradient overflow-hidden">
            <div class="container px-4 py-5 px-md-5 text-center text-lg-start my-5">
                <h1 style="text-align: center; color: rgba(173,31,255, 1.0);
                    text-shadow: 6px 6px 10px rgba(0, 0, 0, 1.4);
                    font-size: 2.9em;
                    animation: fadeIn 1.3s ease-in-out forwards;">Elenco file</h1>
                <div class="row gx-lg-5 align-items-center mb-5">
                    <div class="col-12" style="z-index: 10; background-color: white; min-height: 60vh;">

                        <div class="col-12" style="z-index: 10; background-color: white; min-height: 70vh;">

                            <table id="files" class="table table-hover table-striped table-bordered dt-responsive" style="width:100%;">
                                <thead>
                                    <tr>
                                        <th>Nome del file : </th>
                                        <th>Data di upload :</th>
                                        <th>Descrizione del file : </th>
                                        <th> Azione : </th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </div>
        </section>




        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="js/datatables.min.js"></script>
        <script src="js/files.js"></script>
        <script>

            function openDoc(filename, id) {
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


            }

        </script>

    </body>
</html>
