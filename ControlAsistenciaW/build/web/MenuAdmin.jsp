<%-- 
    Document   : MenuAdmin
    Created on : 31 oct 2023, 11:14:33
    Author     : JORGE
--%>

<%@page import="ModeloDAO.AsistenciaDAO"%>
<%@page import="ModeloDAO.TardanzaDAO"%>
<%@page import="ModeloDAO.HorarioDAO"%>
<%@page import="Modelo.Usuario"%>
<%@page import="ModeloDAO.AreaDAO"%>
<%@page import="ModeloDAO.EmpleadoDAO"%>
<%@page import="Modelo.Empleado"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    EmpleadoDAO empleadoDAO = new EmpleadoDAO();
    int cantidadEmpleados = empleadoDAO.contarEmpleados();
    
    AreaDAO areaDAO = new AreaDAO();
    int cantidadAreas = areaDAO.contarAreas();
    
    HorarioDAO horarioDAO = new HorarioDAO();
    int cantidadHorarios = horarioDAO.contarHorarios();
    
    TardanzaDAO tardanzaDAO = new TardanzaDAO();
    int cantidadTardanzas = tardanzaDAO.contarTardanzas();
    
    AsistenciaDAO asistenciaDAO = new AsistenciaDAO();
    int cantidadAsistencias = asistenciaDAO.contarAsistencias();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <title>Sistema Control de Asistencia</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            min-height: 100vh;
            margin: 0;
        }

        #sidebar {
            background-color: #343a40;
            color: #ffffff;
            padding-top: 20px;
            width: 250px;
        }

        #content {
            flex: 1;
            padding: 20px;
            margin-left: 250px;
            box-sizing: border-box;
        }

        .sidebar-heading {
            text-align: center;
            padding-bottom: 10px;
        }

        .nav-link {
            color: #ffffff !important;
        }

        .nav-link:hover {
            color: #ffc107 !important;
        }

        .dashboard-card {
            margin-bottom: 20px;
        }

        .rectangle {
            width: 80%;
            height: 150px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border-radius: 10px;
            box-shadow: 0px 0px 10px #888888;
        }

        .icon {
            font-size: 2.5rem;
            margin-bottom: 10px;
            color: #343a40;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3); 
        }

        .number {
            font-size: 2rem; 
            font-weight: bold;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            color: #fff; /* Color del texto */
            text-shadow: 4px 4px 6px rgba(0, 0, 0, 0.8);
        }

        
        .card-employees {
            background-color: #007bff;
        }

        .card-areas {
            background-color: #28a745;
        }

        .card-schedules {
            background-color: #ffc107;
        }

        .card-more-stats {
            background-color: #dc3545;
        }
        
        .card-tardiness {
            background-color: #17a2b8;
        }
        
        .card-attendance{
            background-color: #28a689;
        }
    </style>
</head>
<body>
    <!-- Barra lateral -->
    <div id="sidebar">
        <%@ include file="BarraLateral.jsp" %>
    </div>
    
    <!-- Contenido principal -->
    <div id="content">
        <h2 class="text-center mt-4">Dashboard</h2>
        <!-- Dashboard -->
        <div class="row">
            <div class="col-md-3 dashboard-card">
                <div class="rectangle card-employees text-white">
                    <div class="icon"><i class="fa fa-users"></i></div>
                    <div class="number"><%= cantidadEmpleados %></div>
                    <div>Empleados</div>
                </div>
            </div>

            <!-- Tarjeta de Áreas -->
            <div class="col-md-3 dashboard-card">
                <div class="rectangle card-areas text-white">
                    <div class="icon"><i class="fa fa-building"></i></div>
                    <div class="number"><%= cantidadAreas %></div>
                    <div>Áreas</div>
                </div>
            </div>

            <!-- Tarjeta de Horarios -->
            <div class="col-md-3 dashboard-card">
                <div class="rectangle card-schedules text-white">
                    <div class="icon"><i class="fa fa-cube"></i></div>
                    <div class="number"><%= cantidadHorarios %></div>
                    <div>Horarios</div>
                </div>
            </div>
                    
            <!-- Tarjeta de Asistencias -->
            <div class="col-md-3 dashboard-card">
                <div class="rectangle card-attendance text-white">
                    <div class="icon"><i class="fa fa-check-circle"></i></div> 
                    <div class="number"><%= cantidadAsistencias %></div>
                    <div>Asistencias</div>
                </div>
            </div>
                    
            <!-- Tarjeta de Tardanza -->
            <div class="col-md-3 dashboard-card">
                <div class="rectangle card-tardiness text-warning">
                    <div class="icon"><i class="fa fa-clock-o"></i></div> 
                    <div class="number"><%= cantidadTardanzas %></div>
                    <div>Tardanzas</div>
                </div>
            </div>

            <!-- Tarjeta de Otras Estadísticas -->
            <div class="col-md-3 dashboard-card">
                <div class="rectangle card-more-stats text-white">
                    <div class="icon"><i class="fa fa-bar-chart"></i></div>
                    <div class="number">75%</div>
                    <div>Otras estadísticas</div>
                </div>
            </div>
        </div>
                    
        
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
</body>
</html>





