<%-- 
    Document   : GenerarReporte
    Created on : 30 nov 2023, 11:34:43
    Author     : JORGE
--%>

<%@page import="Modelo.Area"%>
<%@page import="java.util.List"%>
<%@page import="ModeloDAO.AreaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Generar Reporte</title>
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
            text-align: center; /* Centro los botones en el contenedor */
        }

        #container form {
            margin: 0; /* Remove default form margin */
        }

        #container label {
            margin-bottom: 8px;
            display: block;
        }

        #container input[type="date"],
        #container select {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
        }

        #container input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        #container input[type="submit"]:hover {
            background-color: #0056b3;
        }

        /* Add any additional styles for GenerarReporte.jsp here */
    </style>
</head>
<body>
    <div id="sidebar">
        <%@ include file="/BarraLateral.jsp" %>
    </div>

    <div id="container" class="container">
        <header>
            <h1>Generar Reporte</h1>
        </header>

        <form action="ControladorGenerarReporte" method="post">
            <label for="startDate"><i class="fas fa-calendar-alt"></i> Fecha Inicio:</label>
            <input type="date" id="startDate" name="startDate" required>
            
            <label for="endDate"><i class="fas fa-calendar-alt"></i> Fecha Fin:</label>
            <input type="date" id="endDate" name="endDate" required>
            
            <label for="area"><i class="fas fa-building"></i> Área:</label>
            <select class="form-control" id="selectArea" name="selectArea" required>
                <option value="">Seleccionar Área</option>
                <% 
                    AreaDAO areaDAO = new AreaDAO();
                    List<Area> areas = areaDAO.listar();
                    for (Area area : areas) {
                %>
                <option value="<%= area.getIdArea() %>"><%= area.getNombreArea() %></option>
                <%
                    }
                %>
            </select>
            
            <div class="btn-container">
                <input type="submit" value="Generar Reporte">
            </div>
        </form>
    </div>
</body>
</html>

