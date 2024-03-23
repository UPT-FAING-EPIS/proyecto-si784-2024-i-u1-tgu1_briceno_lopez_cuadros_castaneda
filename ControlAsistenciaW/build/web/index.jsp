<%-- 
    Document   : index
    Created on : 31 oct. 2023, 08:58:32
    Author     : Jorge
--%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Control de Asistencia</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f2f2f2;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #4CAF50;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease-in-out;
        }

        .navbar:hover {
            background-color: #45a049;
        }

        .navbar-brand img {
            max-height: 30px;
            margin-right: 10px;
        }

        .navbar-brand,
        .navbar-nav a {
            color: #000 !important;
        }

        .jumbotron {
            background-size: cover;
            color: #fff;
            text-align: center;
            padding: 80px 5px;
            margin-bottom: 0;
            position: relative;
            overflow: hidden;
            background-color: #3498db;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .jumbotron::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            background: linear-gradient(to bottom right, #4CAF50, #3498db);
            opacity: 0.9;
            background-attachment: fixed;
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
        }

        .jumbotron h1,
        .jumbotron p {
            position: relative;
            z-index: 1;
        }

        .features-bar {
            background-color: #f8f9fa;
            padding: 30px 0;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .feature {
            text-align: center;
            margin: 30px 0; 
            border-radius: 10px; 
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
            background-color: #fff; 
            padding: 20px;
        }

        .feature h3 {
            font-size: 1.5rem;
            color: #333; 
        }

        .feature p {
            color: #666;
            margin-bottom: 15px; 
        }

        .feature img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
            margin-top: 20px;
            transition: transform 0.3s ease-in-out;
        }

        .feature img:hover {
            transform: scale(1.1);
        }

        .btn-iniciar {
            font-size: 1.2rem;
            margin-top: 20px;
            background-color: #3498db;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out, transform 0.3s ease-in-out;
        }

        .btn-iniciar:hover {
            background-color: #2980b9;
            transform: scale(1.05);
        }

        .feature h2 {
            color: #333;
        }

        .feature p {
            color: #555;
        }

        .feature img {
            max-width: 75%;
            height: auto;
            border-radius: 8px;
            margin-top: 20px;
            transition: transform 0.3s ease-in-out;
        }

        .feature img:hover {
            transform: scale(1.1);
        }

        .btn-iniciar {
            font-size: 1.2rem;
            margin-top: 20px;
        }

        .btn-admin,
        .btn-empleado {
            width: 200px;
            margin: 10px;
        }

        .dropdown-menu {
            background-color: #4CAF50;
        }

        .dropdown-item {
            color: #fff !important;
        }

        .btn-download {
            margin-top: 20px;
            background-color: #3498db;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out, transform 0.3s ease-in-out;
            background-color: #3498db;
        }

        .btn-download:hover {
            background-color: #2980b9;
            transform: scale(1.05);
        }
    
        .section {
            padding: 80px 0;
        }

        .section-title {
            text-align: center;
            margin-bottom: 50px;
        }

        .feature-icon {
            font-size: 2rem;
            margin-bottom: 20px;
        }

        .contact-form {
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        .btn-primary {
            background-color: #3498db;
            border-color: #3498db;
        }

        .btn-primary:hover {
            background-color: #2980b9;
        }
    </style>
</head>

<body>

    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="Imagenes/logo.png" alt="Logo del Sistema">
                Control de Asistencia
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="https://wa.me/+51900858470" target="_blank">
                            <i class="fab fa-whatsapp"></i> Contactanos
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Ingresar
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="inicioSesion.jsp">
                                <i class="fas fa-user-shield"></i> Administrador
                            </a>
                            <a class="dropdown-item" href="inicioSesionEmpleado.jsp">
                                <i class="fas fa-user"></i> Empleado
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="jumbotron text-center bg-primary text-white">
        <h1 class="display-4 font-weight-bold">Bienvenido al Sistema de Control de Asistencia</h1>
        <p class="lead">Optimiza la gestión de la asistencia de tus empleados de manera eficiente y precisa.</p>
    </div>



    <div class="container">
        <!-- New Features Section -->
        <div class="section">
            <h2 class="section-title">NUESTRAS FUNCIONALIDADES</h2>
            <div class="row">
                <!-- Feature 1 -->
                <div class="col-md-4">
                    <div class="feature">
                        <i class="fas fa-desktop feature-icon"></i>
                        <h3>ESCRITORIO</h3>
                        <a data-toggle="modal" data-target="#desktopModal">
                            <img src="Imagenes/escritorio.png" alt="Funcionalidad 1" class="img-fluid">
                        </a>
                    </div>
                </div>

                <!-- Desktop Modal -->
                <div class="modal fade" id="desktopModal" tabindex="-1" role="dialog" aria-labelledby="desktopModalLabel"
                    aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="desktopModalLabel">Información del Programa de Escritorio</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p>
                                    Nuestra aplicación de escritorio es una herramienta poderosa diseñada para simplificar el registro
                                    de asistencias de tus empleados. Con características avanzadas y una interfaz fácil de usar, esta
                                    aplicación garantiza una gestión eficiente del control de asistencia.
                                </p>
                                <p>
                                    Descarga ahora para aprovechar todas las funcionalidades y mejorar la productividad en tu empresa.
                                </p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                                <a href="/ControlAsistenciaW/AplicacionEscritorio/ProgramaEscritorio.zip"
                                    id="downloadBtn" class="btn btn-primary" onclick="handleDownload()">
                                    Descargar Aplicación
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Interactive Message -->
                <div id="successMessage" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-body">
                                <p class="text-success">¡La aplicación se ha descargado con éxito!</p>
                                <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Feature 2 -->
                <div class="col-md-4">
                    <div class="feature" data-toggle="modal" data-target="#asistenciasModal">
                        <i class="fas fa-clipboard-check feature-icon"></i>
                        <h3>ASISTENCIAS</h3>
                        <img src="Imagenes/asistencia.png" alt="Funcionalidad 2" class="img-fluid" data-toggle="modal"
                            data-target="#asistenciasModal">
                    </div>
                </div>

                <!-- Asistencias Modal -->
                <div class="modal fade" id="asistenciasModal" tabindex="-1" role="dialog" aria-labelledby="asistenciasModalLabel"
                    aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="asistenciasModalLabel">Información de Asistencias</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <img src="Imagenes/asistencia_modelo.png" alt="Modelo de Asistencias" class="img-fluid">
                                <p>
                                    Aquí puedes ver el reporte en línea de las asistencias realizadas mediante nuestra sistema web donde podras filtrar las asitencias por empleado, area o dia.
                                </p>
                                <!-- Add any additional information as needed -->
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Feature 3 -->
                <div class="col-md-4">
                    <div class="feature" data-toggle="modal" data-target="#reportesModal">
                        <i class="fas fa-chart-bar feature-icon"></i>
                        <h3>REPORTES</h3>
                        <img src="Imagenes/reporte.png" alt="Funcionalidad 3" class="img-fluid" data-toggle="modal"
                            data-target="#reportesModal">
                    </div>
                </div>

                <!-- Reportes Modal -->
                <div class="modal fade" id="reportesModal" tabindex="-1" role="dialog" aria-labelledby="reportesModalLabel"
                    aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="reportesModalLabel">Información de Reportes</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <img src="Imagenes/Grafico.png" alt="Modelo de Reportes" class="img-fluid">
                                <p>
                                    El sistema generará un informe detallado según el rango de fechas especificado, proporcionando datos por área de trabajo.
                                </p>
                                <!-- Add any additional information as needed -->
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>  
        </div>
    </div>
    <footer class="text-center py-3" style="background-color: #333; color: #fff;">
        <p>&copy; 2023 Control de Asistencia</p>
    </footer>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <script>
        function handleDownload() {
            // Add your logic here for any additional actions before the download

            // Hide the current modal
            $('#desktopModal').modal('hide');

            // Show the success message modal after a short delay (you can adjust the delay as needed)
            setTimeout(function () {
                $('#successMessage').modal('show');
            }, 500);
        }
    </script>
</body>
</html>












