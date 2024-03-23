<%-- 
    Document   : reportesEmpleado
    Created on : Dec 8, 2023, 1:18:50 AM
    Author     : LENOVO
--%>
<%@page import="java.util.HashMap"%>
<%@page import="ModeloDAO.AsistenciaDAO"%>
<%@page import="Modelo.Asistencia"%>
<%@page import="java.util.List"%>
<%@page import="ModeloDAO.ReporteDAO"%>
<%@page import="java.util.Map"%>

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
            Reportes de Empleados
    
        </div>
     
        <div class="card-content">
            <canvas id="reporteEmpleadoChart"></canvas>
        </div>
        <%
    // Obtener instancia del DAO
    ReporteDAO reporteDAO = new ReporteDAO(); // Reemplaza con el nombre correcto de tu clase DAO

    // Obtener datos de faltas y retrasos por mes para el empleado actual
//    String dniEmpleado = (String) session.getAttribute("dniEmpleado");
    Map<String, Integer[]> datosFaltasRetrasos = reporteDAO.obtenerFaltasRetrasosPorMes("44444444");

    // Preparar los datos para la gráfica
    StringBuilder mesesScript = new StringBuilder();
    StringBuilder faltasPorMesScript = new StringBuilder();
    StringBuilder retrasosPorMesScript = new StringBuilder();

    for (Map.Entry<String, Integer[]> entry : datosFaltasRetrasos.entrySet()) {
        String mes = entry.getKey();
        Integer[] datos = entry.getValue();
        
        // Agregar los datos a los strings para el script
        mesesScript.append("'").append(mes).append("',");
        faltasPorMesScript.append(datos[0]).append(",");
        retrasosPorMesScript.append(datos[1]).append(",");
    }

    // Eliminar la coma final de los strings
    if (mesesScript.length() > 0) {
        mesesScript.setLength(mesesScript.length() - 1);
    }
    if (faltasPorMesScript.length() > 0) {
        faltasPorMesScript.setLength(faltasPorMesScript.length() - 1);
    }
    if (retrasosPorMesScript.length() > 0) {
        retrasosPorMesScript.setLength(retrasosPorMesScript.length() - 1);
    }
%>
    </div>

    <!-- Resto de tu contenido HTML -->

    <!-- Script para cargar y mostrar la gráfica -->
   
  </main>
             <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
  <script>
    var meses = [<%= mesesScript %>];
    var faltasPorMes = [<%= faltasPorMesScript %>];
    var retrasosPorMes = [<%= retrasosPorMesScript %>];

    // Configurar y mostrar la gráfica de barras
    var ctx = document.getElementById('reporteEmpleadoChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: meses,
            datasets: [{
                label: 'Faltas por Mes',
                data: faltasPorMes,
                backgroundColor: 'rgba(255, 99, 132, 0.5)',
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 1
            }, {
                label: 'Retrasos por Mes',
                data: retrasosPorMes,
                backgroundColor: 'rgba(54, 162, 235, 0.5)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>

      
    </body>
</html>
