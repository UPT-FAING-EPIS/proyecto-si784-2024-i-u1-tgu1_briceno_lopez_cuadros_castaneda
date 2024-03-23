<%-- 
    Document   : editarHorario
    Created on : 2 nov 2023, 10:50:33
    Author     : JORGE
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ModeloDAO.HorarioDAO"%>
<%@ page import="Modelo.Horario" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Horario</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
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

        .container {
            margin-top: 20px;
        }

        .card {
            margin: 0 auto;
            width: 70%;
            background-color: #f8f9fa;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        button {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div id="sidebar">
        <%@ include file="/BarraLateral.jsp" %>
    </div>
    
    <div id="container">
        <div class="container">
            <div class="card">
                <div class="container mt-5">
                    <header>
                        <h1 class="d-flex align-items-center">
                            <span class="fa fa-pencil mr-2"></span>
                            EDITAR HORARIO
                        </h1>
                    </header>
                    <form action="ControladorHorario?accion=editarHorario" method="post">
                        <input type="hidden" name="txtidHorario" value="${horario.idHorario}">
                        <div class="form-group">
                            <label for="txtIdHorario">ID de Horario</label>
                            <input type="text" class="form-control" id="txtIdHorario" name="txtIdHorario" value="${horario.idHorario}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="txtNombreHorario">Nombre de Horario</label>
                            <input type="text" class="form-control" id="txtNombreHorario" name="txtNombreHorario" value="${horario.nombreHorario}" required>
                        </div>
                        <div class="form-group">
                            <label for="txtFechaInicio">Fecha de Inicio</label>
                            <input type="date" class="form-control" id="txtFechaInicio" name="txtFechaInicio" value="${horario.fechaInicio}" required>
                        </div>
                        <div class="form-group">
                            <label for="txtFechaFin">Fecha de Fin</label>
                            <input type="date" class="form-control" id="txtFechaFin" name="txtFechaFin" value="${horario.fechaFin}" required>
                        </div>
                        <div class="form-group">
                            <label for="txtHoraEntrada">Hora de Entrada</label>
                            <input type="time" class="form-control" id="txtHoraEntrada" name="txtHoraEntrada" value="${horario.horaEntrada}" required>
                        </div>
                        <div class="form-group">
                            <label for="txtHoraSalida">Hora de Salida</label>
                            <input type="time" class="form-control" id="txtHoraSalida" name="txtHoraSalida" value="${horario.horaSalida}" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                        <a href="ControladorHorario?accion=listar" class="btn btn-secondary">Cancelar</a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>


