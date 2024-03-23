<%-- 
    Document   : agregarArea
    Created on : 1 nov 2023, 11:05:52
    Author     : JORGE
--%>

<%@page import="ModeloDAO.HorarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Modelo.Area" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.Horario" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Área</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
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

        textarea {
            height: 300px;
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
                    AGREGAR ÁREA
                </h1>
            </div>
            <form action="ControladorArea?accion=agregarArea" method="post">
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="txtIdArea">ID de Área</label>
                        <input type="text" class="form-control" id="txtIdArea" name="txtIdArea" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="selectHorario">Horario</label>
                        <select class="form-control" id="selectHorario" name="selectHorario" required>
                            <option value="">Seleccionar Horario</option>
                            <% 
                                HorarioDAO dao = new HorarioDAO();
                                List<Horario> list = dao.listar();
                                for (Horario horario : list)  {
                            %>
                            <option value="<%= horario.getNombreHorario() %>"><%= horario.getNombreHorario() %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="txtNombreArea">Nombre de Área</label>
                    <input type="text" class="form-control" id="txtNombreArea" name="txtNombreArea" required>
                </div>
                <div class="form-group">
                    <label for="txtDescripcion">Descripción</label>
                    <textarea class="form-control" id="txtDescripcion" name="txtDescripcion" required></textarea>
                </div>
                
                    <button type="submit" class="btn btn-primary">Agregar Área</button>
                    <a href="ControladorArea?accion=listar" class="btn btn-secondary ml-2">Cancelar</a>
                
            </form>
        </div>
    </div>
                        
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>






