<%-- 
    Document   : listarEmpleados
    Created on : 19 oct 2023, 17:59:37
    Author     : HP
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelo.Empleado"%>
<%@page import="ModeloDAO.EmpleadoDAO"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>

<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lista de Empleados</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap4.min.css">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            flex-direction: column;
            height: auto;
        }

        #sidebar {
            background-color: #343a40;
            color: #ffffff;
            padding-top: 20px;
            width: 250px;
            height: 100%;
            position: fixed;
            z-index: 1;
        }

        #container {
            display: flex;
            flex-direction: column;
            padding: 10px;
            box-sizing: border-box;
            flex: 1;
            margin-left: 250px;
        }

        header {
            background-color: #343a40;
            color: #ffffff;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
            width: 100%;
            z-index: 2;
        }

        .table-container {
            overflow-y: auto;
            flex: 1;
        }

        .table-custom {
            background-color: #f8f9fa;
            border-radius: 10px;
            margin-top: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .table-custom th,
        .table-custom td {
            text-align: center;
            padding: 12px;
        }

        .table-custom img {
            border-radius: 50%;
        }

        .acciones a {
            margin-right: 5px;
        }

        .btn-container {
            margin-bottom: 20px;
        }

        /* Estilo específico para la tabla de empleados */
        .table-empleados th,
        .table-empleados td {
            text-align: center;
            padding: 12px;
        }

        /* Solución para el diseño de la tabla */
        .table-container {
            flex: 1;
            overflow-y: auto;
        }
    </style>
</head>
<body>
    
    <div id="sidebar">
        <%@ include file="/BarraLateral.jsp" %>
    </div>
    
    <div id="container">
        <div class="container mt-5">
            <header>
                <h1 class="d-flex align-items-center">
                    <span class="fa fa-users mr-2"></span>
                    GESTION DE EMPLEADOS
                </h1>
                <div class="btn-container">
                    <a href="ControladorEmpleado?accion=add" class="btn btn-primary btn-margin">
                        <i class="fa fa-user-plus"></i> AGREGAR EMPLEADO
                    </a>
                    <a href="/ControlAsistenciaW/MenuAdmin.jsp" class="btn btn-secondary">
                        <i class="fa fa-home"></i> MENU PRINCIPAL
                    </a>
                </div>

                <!-- Sección de Carga Masiva -->
                <div class="row mt-3">
                    <div class="col-md-12">
                        <form method="post" action="ControladorEmpleado?accion=procesarDatos" enctype="multipart/form-data">
                            <div class="form-group mb-2">
                                <label for="archivo" class="mr-2">
                                    <i class="fas fa-file-upload"></i> Selecciona un archivo CSV
                                </label>
                                <div class="input-group">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="archivo" name="archivo" onchange="updateFileName()">
                                        <label class="custom-file-label" for="archivo">Elegir archivo</label>
                                    </div>
                                    <div class="input-group-append">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-upload"></i> Subir Archivo
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <script>
                    function updateFileName() {
                        var fileName = document.getElementById("archivo").files[0].name;
                        var label = document.querySelector(".custom-file-label");
                        label.innerHTML = fileName;
                    }
                </script>
            </header>
            <div class="table-container mt-4">
                <table class="table table-custom table-empleados" id="tablaEmpleados">
                    <thead class="thead-dark">
                        <tr>
                            <th>DNI Empleado</th>
                            <th>Area</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Puesto</th>
                            <th>Telefono</th>
                            <th>Genero</th>
                            <th>Estado</th>
                            <th>Foto</th>
                            <th>ACCIONES</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% EmpleadoDAO dao = new EmpleadoDAO();
                            List<Empleado> list = dao.listar();
                            for (Empleado emp : list) { %>
                        <tr>
                            <td><%= emp.getDniEmpleado() %></td>
                            <td><%= emp.getIdArea() %></td>
                            <td><%= emp.getNombre() %></td>
                            <td><%= emp.getApellido() %></td>
                            <td><%= emp.getPuesto() %></td>
                            <td><%= emp.getTelefono() %></td>
                            <td><%= emp.getGenero() %></td>
                            <td><%= emp.getEstado() %></td>
                            <td><img src="<%= emp.getFoto() %>" alt="Imagen de perfil" width="80" height="80"></td>
                            <td class="acciones">
                                <a href="ControladorEmpleado?accion=edit&vdniEmpleado=<%= emp.getDniEmpleado() %>"
                                    class="btn btn-sm btn-info">
                                    <i class="fas fa-edit"></i> 
                                </a>
                                <a href="ControladorEmpleado?accion=eliminar&vdniEmpleado=<%= emp.getDniEmpleado() %>"
                                    class="btn btn-sm btn-danger">
                                    <i class="fas fa-trash-alt"></i>
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap4.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#tablaEmpleados').DataTable({
                "lengthMenu": [10, 25, 50, 75, 100],
                "language": {
                    "sProcessing": "Procesando...",
                    "sLengthMenu": "Mostrar _MENU_ registros por página",
                    "sZeroRecords": "No se encontraron resultados",
                    "sInfo": "Mostrando _START_ a _END_ de _TOTAL_ registros",
                    "sInfoEmpty": "Mostrando 0 a 0 de 0 registros",
                    "sInfoFiltered": "(filtrado de _MAX_ registros en total)",
                    "sInfoPostFix": "",
                    "sSearch": "Buscar:",
                    "sUrl": "",
                    "oPaginate": {
                        "sFirst": "Primero",
                        "sPrevious": "Anterior",
                        "sNext": "Siguiente",
                        "sLast": "Último"
                    },
                    "oAria": {
                        "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                    }
                },
                "dom": '<"top"lf>rt<"bottom"ip><"clear">',
                "pagingType": "full_numbers",
                "order": [[0, "desc"]],
                "columnDefs": [{
                    "targets": 'no-sort',
                    "orderable": false
                }],
                "initComplete": function () {
                    $('.dataTables_length select').removeClass('custom-select custom-select-sm');
                }
            });
        });
    </script>
</body>
</html>






