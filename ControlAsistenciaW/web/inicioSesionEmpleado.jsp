<%-- 
    Document   : inicioSesionEmpleado
    Created on : 17 nov 2023, 12:04:20
    Author     : JORGE
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Iniciar Sesión</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #343a40;
            color: #f8f9fa;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .card {
            background-color: #f8f9fa;
            color: #343a40;
            border: none;
            border-radius: 40px;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            padding: 40px;
            text-align: left;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-control {
            border-radius: 10px;
            border: 2px solid #343a40;
            padding: 15px;
        }

        .btn-iniciar-sesion,
        .btn-cancelar {
            font-weight: bold;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            padding: 7px;
            transition: background-color 0.3s ease;
        }

        .btn-iniciar-sesion {
            background-color: #28a745; /* Green color for ACCEDER */
            color: #f8f9fa;
            margin-bottom: 10px; /* Added margin to separate buttons */
        }

        .btn-cancelar {
            background-color: #dc3545; /* Red color for CANCELAR */
            color: #f8f9fa;
        }

        .btn-iniciar-sesion:hover {
            background-color: #218838; /* Darker green on hover */
        }

        .btn-cancelar:hover {
            background-color: #c82333; /* Darker red on hover */
        }

        .icono {
            font-size: 2em;
            margin-right: 10px;
        }

        .titulo {
            font-size: 2em;
            margin-bottom: 20px;
        }

        #captchaContainer {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        #captcha {
            display: flex;
            align-items: center; /* Alinea los elementos en el contenedor captcha */
            background-color: #f8f9fa;
            border-radius: 10px;
            border: 2px solid #343a40;
            padding: 8px;
            width: 100%;
            margin-bottom: 10px;
        }

        #captchaIcon {
            font-size: 1.5em;
            color: #343a40;
            cursor: pointer;
            margin-right: 10px; /* Añade un espacio entre el icono y el texto */
        }

        #captchaText {
            flex: 1;
            padding: 8px;
            border: 2px solid #343a40;
            border-radius: 10px;
            margin-right: 10px;
            font-size: 1.2em;
            color: #007bff; 
        }

        #captchaInput {
            flex: 1;
            padding: 8px;
            border: 2px solid #343a40;
            border-radius: 10px;
            outline: none;
        }
    </style>
</head>
<body>
    <div class="card">
        <form id="loginForm" method="post" accept-charset="UTF-8" onsubmit="enviarFormulario(event)">
            <h1 class="titulo"><i class="fas fa-user-secret icono"></i>Iniciar Sesión Empleado</h1>
            
            <div class="form-group">
                <label for="usuario"><i class="fas fa-user icono"></i>Usuario:</label>
                <input type="text" id="usuario" name="usuario" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="contrasena"><i class="fas fa-lock icono"></i>Contraseña:</label>
                <input type="password" id="contrasena" name="contrasena" class="form-control" required>
            </div>

            <div id="captchaContainer" class="form-group">
                <label for="captcha"><i class="fas fa-shield-alt icono"></i>CAPTCHA:</label>
                <div id="captcha" style="display: flex; align-items: center;">
                    <i id="captchaIcon" class="fas fa-sync-alt" onclick="generarCaptcha()"></i>
                    <span id="captchaText"></span>
                    <div style="display: flex; align-items: center;">
                        <input type="text" id="captchaInput" name="captcha" required>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <button type="submit" class="btn btn-iniciar-sesion"><i class="fas fa-sign-in-alt icono"></i> ACCEDER</button>
                <a href="index.jsp" class="btn btn-cancelar"><i class="fas fa-times icono"></i> CANCELAR</a>
            </div>
        </form>
    </div>
    <script>
        function generarCaptcha() {
            var numeros = '0123456789';
            var captcha = '';
            for (var i = 0; i < 6; i++) {
                captcha += numeros.charAt(Math.floor(Math.random() * numeros.length));
            }
            document.getElementById('captchaText').textContent = captcha;
        }

        function enviarFormulario(event) {
            event.preventDefault();
            var usuario = document.getElementById('usuario').value;
            var contrasena = document.getElementById('contrasena').value;
            var captchaIngresado = document.getElementById('captchaInput').value;
            var captchaGenerado = document.getElementById('captchaText').textContent;

            if (captchaIngresado === captchaGenerado) {
                // Coloca tu lógica de autenticación aquí
                var nivelRequerido = "Empleado"; // Puedes ajustar esto según tu necesidad
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            // Autenticación exitosa, realiza las acciones necesarias
                            alert('Autenticación exitosa. Redireccionando...');

                            // Redirige a MenuAdmin.jsp
                            window.location.href = 'MenuEmpleado.jsp';

                            // Restablece el formulario
                            document.getElementById('loginForm').reset();
                            generarCaptcha();
                        } else {
                            alert('Error: Usuario o contraseña incorrectos.');
                        }
                    }
                };

                // Aquí establece la URL del servlet o controlador que maneja la autenticación
                var url = 'ControladorLoginEmpleado';
                xhr.open('POST', url, true);
                xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
                xhr.send('usuario=' + encodeURIComponent(usuario) + '&contrasena=' + encodeURIComponent(contrasena) + '&nivelRequerido=' + encodeURIComponent(nivelRequerido));
            } else {
                alert('Error: CAPTCHA incorrecto. Intenta de nuevo.');
            }
        }

        // Genera el CAPTCHA al cargar la página
        window.onload = function() {
            generarCaptcha();
        };
    </script>
</body>
</html>