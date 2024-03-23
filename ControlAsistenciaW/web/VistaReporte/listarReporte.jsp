<%-- 
    Document   : listarReportes
    Created on : 18 nov 2023, 23:01:18
    Author     : JORGE
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelo.Reporte"%>
<%@page import="ModeloDAO.ReporteDAO"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Listar Reportes</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            flex-direction: column;
            height: 100vh;
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
            text-align: center; /* Centro el texto del header */
        }

        .btn-container {
            margin-bottom: 20px;
            
        }

        .table-container {
            overflow-y: auto;
            flex: 1;
        }

        .table-custom {
            background-color: #ffffff;
            border-radius: 5px;
            margin-top: 20px;
        }

        .table-custom th,
        .table-custom td {
            text-align: center;
            vertical-align: middle; /* Centro el contenido verticalmente */
        }

        .table-custom img {
            border-radius: 50%;
        }

        .acciones a {
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <div id="sidebar">
        <%@ include file="/BarraLateral.jsp" %>
    </div>
    <div id="container" class="container">
        <header>
            <h1 class="d-flex align-items-center">
                <span class="fa fa-file-alt mr-2"></span>
                LISTA DE REPORTES
            </h1>
            <div class="btn-container">
                <a href="ControladorReporte?accion=add" class="btn btn-primary btn-margin">
                    <i class="fa fa-file"></i> NUEVO REPORTE
                </a>
                <a href="/ControlAsistenciaW/MenuAdmin.jsp" class="btn btn-secondary">
                    <i class="fa fa-home"></i> MENU PRINCIPAL
                </a>
            </div>
        </header>

        <div class="table-container">
        <table class="table table-custom">
            <thead class="thead-dark">
                <tr>
                    <th>Numero de Reporte</th>
                    <th>Fecha Inicio</th>
                    <th>Fecha Fin</th>
                    <th>Nombre del Área</th>
                    <th>Total Asistencias</th>
                    <th>Total Tardanzas</th>
                    <th>Total Faltas</th>
                    <th>Operaciones</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    ReporteDAO dao = new ReporteDAO();
                    List<Reporte> listaReportes = dao.Listar();
                    for (Reporte reporte : listaReportes) {
                %>
                <tr>
                    <td><%= reporte.getIdReporte() %></td>
                    <td><%= reporte.getFechaInicio() %></td>
                    <td><%= reporte.getFechaFin() %></td>
                    <td><%= reporte.getNombreArea() %></td>
                    <td><%= reporte.getTotalAsistencias() %></td>
                    <td><%= reporte.getTotalTardanzas() %></td>
                    <td><%= reporte.getTotalFaltas() %></td>
                    <td class="acciones">
                        <a href="ControladorReporte?accion=verDetalle&id=<%= reporte.getIdReporte() %>"
                            class="btn btn-sm btn-info">
                            <i class="fas fa-eye"></i> Ver Detalle
                        </a>
                        <button class="btn btn-sm btn-success" onclick="imprimirReporte(<%= reporte.getIdReporte() %>)">
                            <i class="fas fa-print"></i> Imprimir
                        </button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>














