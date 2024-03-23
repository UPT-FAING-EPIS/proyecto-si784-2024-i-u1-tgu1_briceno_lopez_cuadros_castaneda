<%-- 
    Document   : BarraLateral
    Created on : 18 nov 2023, 19:20:36
    Author     : JORGE
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body, html {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        .d-flex {
            display: flex;
        }

        #wrapper {
            min-height: 100vh;
        }

        #sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            background-color: #343a40;
            color: #ffffff;
            padding-top: 20px;
            width: 250px;
            overflow-x: hidden;
            transition: width 0.3s ease;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.75);
        }

        #sidebar.retracted {
            width: 50px;
        }

        .sidebar-heading {
            text-align: center;
            padding-bottom: 10px;
            color: #ffc107;
            transition: opacity 0.3s ease;
        }
        
        .sidebar-heading img {
            max-width: 200px;
            margin-right: 20px;
        }

        .list-group {
            width: 100%;
        }

        .list-group-item {
            background-color: #343a40 !important;
            color: #ffffff !important;
            border: none;
            border-radius: 0;
            transition: background-color 0.3s ease;
            box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.75);
        }

        .list-group-item i {
            margin-right: 10px;
            transition: color 0.3s ease;
        }

        .list-group-item:hover {
            background-color: #ffc107 !important;
        }

        .list-group-item i:hover {
            color: #ffc107; 
        }

        #toggleSidebar {
            background-color: #343a40;
            color: #ffffff;
            border: none;
            padding: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.75);
        }

        #toggleSidebar:hover {
            background-color: #ffc107;
        }

        #wrapper.retracted #sidebar {
            width: 50px;
        }

        #wrapper.retracted #content {
            margin-left: 50px;
        }

        .text-center {
            transition: margin-left 0.3s ease, opacity 0.3s ease;
        }

        #wrapper.retracted .text-center {
            margin-left: 50px;
            opacity: 0;
        }
        #sidebar, #sidebar a, #sidebar .list-group-item {
            color: #ffffff;
        }

        #toggleSidebar {
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="d-flex" id="wrapper">
        <!-- Barra lateral -->
        <div class="bg-dark border-right" id="sidebar">
            <div class="sidebar-heading">
                <img src="Imagenes/logo.png" alt="Sistema Image">
                <h1>SISTEMA</h1>
            </div>
            
            <div class="list-group list-group-flush">
                <a href="ControladorEmpleado?accion=listar" class="list-group-item list-group-item-action">
                    <i class="fa fa-users"></i>
                    <span class="sidebar-text">Gestion de Empleados</span>
                </a>
                <a href="ControladorArea?accion=listar" class="list-group-item list-group-item-action">
                    <i class="fa fa-building"></i>
                    <span class="sidebar-text">Gestión de Áreas</span>
                </a>
                <a href="ControladorHorario?accion=listar" class="list-group-item list-group-item-action">
                    <i class="fa fa-cube"></i>
                    <span class="sidebar-text">Gestion de Horarios</span>
                </a>
                <a href="ControladorAsistencia?accion=listar" class="list-group-item list-group-item-action">
                    <i class="fa fa-calendar"></i>
                    <span class="sidebar-text">Asistencias</span>
                </a>
                <a href="ControladorReporte?accion=listar" class="list-group-item list-group-item-action">
                    <i class="fa fa-line-chart"></i>
                    <span class="sidebar-text">Reportes</span>
                </a>
                <a href="#" class="list-group-item list-group-item-action">
                    <i class="fa fa-bell"></i>
                    <span class="sidebar-text">Notificaciones</span>
                </a>
                <a href="VistaUsuarios/listarUsuarios.jsp" class="list-group-item list-group-item-action">
                    <i class="fa fa-cogs"></i>
                    <span class="sidebar-text">Gestion de Usuarios</span>
                </a>
                <a href="RegistrarAsistencia.jsp" class="list-group-item list-group-item-action">
                    <i class="fa fa-calendar"></i>
                    <span class="sidebar-text">Marcar Asistencias</span>
                </a>
                <a href="index.jsp" class="list-group-item list-group-item-action">
                    <i class="fa fa-sign-out"></i>
                    <span class="sidebar-text">Cerrar Sesión</span>
                </a>
            </div>
        </div>
        
    </div>
    <div style="position: fixed; bottom: 20px; right: 20px; z-index: 999;">
        <a href="https://api.whatsapp.com/send?phone=+51900858470&text=Hola%20necesito%20ayuda" target="_blank" style="display: flex; align-items: center; background-color: #25D366; color: #fff; padding: 10px 15px; border-radius: 5px; text-decoration: none;">
            <i class="fa fa-whatsapp" style="font-size: 24px; margin-right: 10px;"></i>
            ¿Necesitas ayuda?
        </a>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script>
        $(document).ready(function () {
            // Selector del botón que abrirá/cerrará la barra lateral
            var $sidebarToggle = $('#sidebar-toggle');
            // Selector de la barra lateral
            var $sidebar = $('#sidebar');

            // Función para abrir/cerrar la barra lateral
            $sidebarToggle.click(function () {
                $sidebar.toggleClass('active');
            });
        });
    </script>
</body>
</html>

