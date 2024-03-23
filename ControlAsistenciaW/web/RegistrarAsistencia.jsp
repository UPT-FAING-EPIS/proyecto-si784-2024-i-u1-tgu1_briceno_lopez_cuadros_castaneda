<%-- 
    Document   : RegistrarAsistencia
    Created on : 4 dic 2023, 5:45:02
    Author     : JORGE
--%>

<%@page import="Modelo.Empleado"%>
<%@page import="ModeloDAO.EmpleadoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Control de Asistencia</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="Estilos/MarcarAsistencia.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="card mx-auto" style="max-width: 600px;">
            <div class="card-header bg-secondary text-right">
                <a href="inicioSesionEmpleado.jsp" class="btn btn-iniciar-sesion">Empleado <i class="fas fa-sign-in-alt"></i></a>
                <a href="inicioSesion.jsp" class="btn btn-iniciar-sesion">Administrador <i class="fas fa-sign-in-alt"></i></a>
            </div>
            <div class="card-body">
                <h1 class="text-center mb-4">MARCAR ASISTENCIA <i class="fas fa-user-check"></i></h1>
                <h2 class="text-center mb-4 hora hora-grande" id="hora"></h2>
                <h3 class="text-center mb-4 fecha" id="fecha"></h3>
                <form id="marcarAsistenciaForm">
                    <div class="form-group">
                        <label for="dni">DNI Empleado</label>
                        <input type="text" class="form-control" id="dni" name="dni" required>
                    </div>
                    <div class="form-group">
                        <label for="nombre">Nombre Empleado</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" readonly>
                    </div>
                    <button type="button" class="btn btn-success btn-block" onclick="marcarAsistencia('marcarEntrada')">Marcar Entrada <i class="fas fa-check"></i></button>
                    <button type="button" class="btn btn-danger btn-block" onclick="marcarAsistencia('marcarSalida')">Marcar Salida <i class="fas fa-sign-out-alt"></i></button>
                </form>
                <div class="mt-3" id="mensaje"></div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script>
        function mostrarFechaHora() {
            var ahora = new Date();
            var opcionesFecha = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            var opcionesHora = { hour: 'numeric', minute: 'numeric', second: 'numeric', hour12: false };
            var fecha = ahora.toLocaleDateString('es-ES', opcionesFecha);
            var hora = ahora.toLocaleTimeString('es-ES', opcionesHora);
            document.getElementById('hora').innerHTML = hora;
            document.getElementById('fecha').innerHTML = fecha;
        }
        setInterval(mostrarFechaHora, 1000);
        
        function buscarNombrePorDNI(dni) {
            // Crear una instancia de XMLHttpRequest
            var xhr = new XMLHttpRequest();

            // Configurar la solicitud
            xhr.open('POST', 'ControladorEmpleado', true);

            // Establecer el encabezado Content-Type para la solicitud POST
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

            // Definir la función que manejará la respuesta
            xhr.onload = function () {
                if (xhr.status === 200) {
                    try {
                        var jsonResponse = JSON.parse(xhr.responseText);

                        // Verificar si se encontró el nombre en la respuesta
                        if (jsonResponse.nombre) {
                            // Establecer el valor en el campo correspondiente
                            document.getElementById('nombre').value = jsonResponse.nombre;
                        } else {
                            // Si no se encontró el nombre, puedes manejarlo de acuerdo a tus necesidades
                            console.log("Nombre no encontrado");
                        }
                    } catch (e) {
                        console.error("Error al analizar la respuesta JSON:", e);
                    }
                } else {
                    console.error("Error en la solicitud al servidor. Código de estado:", xhr.status);
                }
            };

            // Manejar errores de red
            xhr.onerror = function () {
                console.error("Error en la solicitud al servidor.");
            };

            // Enviar la solicitud con los datos del formulario
            var formData = 'accion=listarPorDNI&dni=' + encodeURIComponent(dni);
            xhr.send(formData);
        }

        document.getElementById('dni').addEventListener('input', function () {
            var dni = this.value.slice(0, 8);
            this.value = dni;

            // Verifica si se ingresaron los 8 dígitos del DNI
            if (/^\d{8}$/.test(dni)) {
                // Busca el nombre en la lista de empleados
                buscarNombrePorDNI(dni, function (nombre, apellido) {
                    // Coloca el nombre en el campo correspondiente
                    document.getElementById('nombre').value = nombre + ' ' + apellido;
                });
            } else {
                // Limpiar el campo si el DNI no es válido
                document.getElementById('nombre').value = '';
            }
        });

        document.getElementById('marcarBtn').addEventListener('click', function() {
            // Obtener el DNI del campo correspondiente
            var dni = document.getElementById('dni').value;

            // Realizar una solicitud al backend para marcar la asistencia
            marcarAsistencia(dni);
        });
        
        function marcarAsistencia(accion) {
        var dni = document.getElementById('dni').value;

        // Realizar una solicitud AJAX al backend
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'ControladorAsistencia?accion=' + accion, true);

        // Establecer el encabezado Content-Type para la solicitud POST
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        xhr.onload = function() {
            if (xhr.status === 200) {
                try {
                    var jsonResponse = JSON.parse(xhr.responseText);
                    console.log("jsonResponse:", jsonResponse);

                    // Mostrar mensaje de éxito o error
                    mostrarMensaje(jsonResponse.message, jsonResponse.result === "success");
                } catch (e) {
                    console.error("Error al analizar la respuesta JSON:", e);
                }
            } else {
                console.error("Error en la solicitud al servidor. Código de estado:", xhr.status);
                // Mostrar mensaje de error
                mostrarMensaje('Error al marcar la asistencia', false);
            }
        };

        // Enviar el DNI como datos del formulario
        var formData = 'dni=' + encodeURIComponent(dni);
        xhr.send(formData);
    }

    function mostrarMensaje(mensaje, exito) {
        // Obtener la clase de alerta dependiendo del resultado
        var alertClass = exito ? 'alert-success' : 'alert-danger';

        // Mostrar el mensaje
        document.getElementById('mensaje').innerHTML = '<div class="alert ' + alertClass + '">' + mensaje + '</div>';

        // Limpiar el mensaje después de 5 segundos
        setTimeout(function() {
            document.getElementById('mensaje').innerHTML = '';
        }, 5000);
    }

    </script>
</body>
</html>