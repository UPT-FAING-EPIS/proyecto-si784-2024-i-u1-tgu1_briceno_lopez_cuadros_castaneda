<%-- 
    Document   : agregarHorario
    Created on : 2 nov 2023, 10:49:48
    Author     : JORGE
--%>

<%@page import="ModeloDAO.HorarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.Horario" %>

<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Agregar Horario</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            min-height: 100vh;
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

        .container {
            margin-top: 20px;
            margin-left: 250px;
            flex-direction: column;
        }

        .card {
            width: 70%;
            margin: auto;
            padding: 20px;
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 8px;
            transition: box-shadow 0.3s ease;
            margin-left: 250px;
        }

        .card:hover {
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        .title-bar {
            background-color: #000;
            padding: 10px;
            border-radius: 8px 8px 0 0;
            margin: -20px -20px 20px -20px;
        }

        .title-bar h1 {
            color: #fff;
            margin: 0;
        }

        label {
            font-weight: bold;
            margin-top: 10px;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
            transition: background-color 0.3s ease;
        }

        .btn-secondary {
            background-color: #6c757d;
            border: none;
            transition: background-color 0.3s ease;
        }

        .btn-primary, .btn-secondary {
            color: #ffffff;
            margin-top: 10px;
        }

        .btn-primary:hover, .btn-secondary:hover {
            filter: brightness(90%);
        }

        .form-group {
            transition: margin-top 0.3s ease;
        }

        .form-group:hover {
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div id="sidebar">
        <%@ include file="/BarraLateral.jsp" %>
    </div>
    <div class="container">
        <div class="card">
            <div class="title-bar">
                <h1 class="d-flex align-items-center">
                    <span class="fa fa-plus mr-2"></span>
                    AGREGAR HORARIO
                </h1>
            </div>
            <form action="ControladorHorario?accion=agregarHorario" method="post">
                <div class="form-group">
                    <label for="txtNombreHorario">Nombre de Horario</label>
                    <input type="text" class="form-control" id="txtNombreHorario" name="txtNombreHorario" required>
                </div>
                <div class="form-group">
                    <label for="txtFechaInicio">Fecha de Inicio</label>
                    <input type="date" class="form-control" id="txtFechaInicio" name="txtFechaInicio" required>
                </div>
                <div class="form-group">
                    <label for="txtFechaFin">Fecha de Fin</label>
                    <input type="date" class="form-control" id="txtFechaFin" name="txtFechaFin" required>
                </div>
                <div class="form-group">
                    <label for="txtHoraEntrada">Hora de Entrada</label>
                    <input type="time" class="form-control" id="txtHoraEntrada" name="txtHoraEntrada" required>
                </div>
                <div class="form-group">
                    <label for="txtHoraSalida">Hora de Salida</label>
                    <input type="time" class="form-control" id="txtHoraSalida" name="txtHoraSalida" required>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Agregar Horario</button>
                    <a href="ControladorHorario?accion=listar" class="btn btn-secondary ml-2">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
    

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
