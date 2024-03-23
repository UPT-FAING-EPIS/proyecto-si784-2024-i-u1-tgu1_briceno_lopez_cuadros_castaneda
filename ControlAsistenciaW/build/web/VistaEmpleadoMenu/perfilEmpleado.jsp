<%-- 
    Document   : perfilEmpleado
    Created on : Dec 8, 2023, 1:19:16 AM
    Author     : LENOVO
--%>
<%@page import="ModeloDAO.AsistenciaDAO"%>
<%@page import="Modelo.Asistencia"%>
<%@page import="java.util.List"%>

<% 
    String nombreApellido = (String)session.getAttribute("nombreApellido");
    String nombreCompleto = (nombreApellido != null) ? nombreApellido : "Invitado";
    String dniEmpleado = (String)session.getAttribute("dniEmpleado");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dashboard Empleado</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body, html {
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            transition: background-color 0.5s;
        }
        .sidebar {
            background-color: #34495e;
            color: white;
            width: 250px;
            height: 100vh;
            position: fixed;
            transition: width 0.5s;
        }
        .sidebar .menu-item {
            padding: 10px 20px;
            display: block;
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            margin: 5px 0;
            transition: color 0.3s;
        }
        .sidebar .menu-item:hover {
            color: white;
        }
        .sidebar .menu-item i {
            margin-right: 10px;
        }
        .main-content {
            
            padding: 20px;
            transition: margin-left 0.5s;
        }
        .main-content .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #3f51b5;
            color: white;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            transition: background-color 0.5s;
        }
        .user-info {
            display: flex;
            align-items: center;
        }
        .user-info > * {
            margin-left: 10px;
        }
        .user-info img {
            border-radius: 50%;
            width: 30px;
            height: 30px;
        }
        .user-info .fa-envelope {
            font-size: 1.5rem;
            cursor: pointer;
        }
        .user-info .user-name {
            font-size: 1rem;
            margin-left: 5px;
        }
        .main-content .card {
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
            transition: 0.3s;
            border-radius: 5px;
            background-color: #f1f1f1;
            padding: 20px;
            margin-bottom: 20px;
            overflow: hidden;
            opacity: 0;
            transform: translateY(-20px);
            transition: opacity 0.5s, transform 0.5s;
        }
        .card-header {
            color: white;
            border-radius: 5px 5px 0 0;
            padding: 10px;
            background-color: #e74c3c;
        }
        .card-header.blue {
            background-color: #3498db;
        }
        .card:hover {
            opacity: 1;
            transform: translateY(0);
        }
        
        .card-content {
            overflow-x: auto;
        }

        .asistencias-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .asistencias-table th, .asistencias-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .asistencias-table th {
            background-color: #3498db;
            color: white;
        }

        .asistencias-table tbody tr:hover {
            background-color: #f5f5f5;
        }
        .app{
            margin-left: 250px;
        }
    </style>
</head>
<body>
  <%@ include file="../header.jsp" %>
  <main class="app">
      <div class="main-content">
    <div class="header">
        <span id="dashboardTitle"> Bienvenido: <%= nombreCompleto %></span>
        <div class="user-info">
            <i class="fas fa-envelope"></i>
            <span class="user-name"><%= nombreCompleto %></span>
            <img src="" alt="Perfil" style="border-radius: 50%; width: 30px; height: 30px; margin-left: 10px;">
        </div>
    </div>
    
    <div class="card" id="asistenciasCard">
        <div class="card-header blue">
            Perfil del Empleado
    
        </div>

  </main>

      
    </body>
</html>

