<%-- 
    Document   : listarUsuarios
    Created on : 7 dic 2023, 12:41:22
    Author     : JORGE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Modelo.Usuario"%>
<%@page import="ModeloDAO.UsuarioDAO"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Usuarios</title>
        <!-- Include necessary CSS and JavaScript libraries -->
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

            #content {
                display: flex;
                flex-direction: column;
                padding: 20px;
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

            .acciones a {
                margin-right: 5px;
            }

            .btn-container {
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <div id="sidebar">
            <%@ include file="/BarraLateral.jsp" %>
        </div>

        <div id="content">
            <div class="container">
                <header>
                    <h1 class="d-flex align-items-center">
                        <span class="fa fa-users mr-2"></span>
                        LISTA DE USUARIOS
                    </h1>
                    <div class="btn-container">
                        <!-- Add any additional buttons or links here -->
                    </div>
                </header>
                <div class="table-container mt-4">
                    <table class="table table-custom" id="tablaUsuarios">
                        <thead class="thead-dark">
                            <tr>
                                <th>ID Usuario</th>
                                <th>Nombre</th>
                                <th>Clave</th>
                                <th>Nivel</th>
                                
                                <th>ACCIONES</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                UsuarioDAO usuarioDAO = new UsuarioDAO();
                                List<Usuario> usuarios = usuarioDAO.obtenerTodosLosUsuarios();
                                for (Usuario usuario : usuarios) {
                            %>
                            <tr>
                                <td><%= usuario.getIdUsuario() %></td>
                                <td><%= usuario.getNombre() %></td>
                                <td><%= usuario.getClave() %></td>
                                <td><%= usuario.getNivel() %></td>
                                <!-- Add more cells as needed -->
                                <td class="acciones">
                                    <a href="ControladorUsuario?accion=edit&idUsuario=<%= usuario.getIdUsuario() %>" class="btn btn-sm btn-info">
                                        <i class="fas fa-edit"></i> Editar
                                    </a>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Include necessary JavaScript libraries -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap4.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#tablaUsuarios').DataTable({
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
