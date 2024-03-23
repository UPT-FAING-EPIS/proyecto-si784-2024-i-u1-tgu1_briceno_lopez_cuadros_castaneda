<%@page import="ModeloDAO.AreaDAO"%>
<%@page import="Modelo.Area"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Agregar Empleado</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="Estilos/Agregar.css" rel="stylesheet">
    <style>
        #preview {
            max-width: 100%;
            max-height: 200px;
            margin: 10px 0;
        }
    </style>
</head>

<body>
    <%@ include file="/BarraLateral.jsp" %>
    <div class="container mt-5">
        <div class="card mx-auto">
            <div class="container mt-5">
                <h1 class="d-flex align-items-center">
                    <span class="fa fa-plus mr-2"></span>
                    AGREGAR EMPLEADO
                </h1>
                <form action="ControladorEmpleado?accion=agregarEmpleado" method="post" >
                    <div class="row">
                        <!-- Información Personal -->
                        <div class="col-md-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    Información Personal
                                </div>
                                <div class="card-body">
                                    <!-- DNI, Teléfono, Género -->
                                    <div class="form-group">
                                        <label for="txtdniEmpleado">DNI Empleado</label>
                                        <input type="text" class="form-control" id="txtdniEmpleado" name="txtdniEmpleado" pattern="[0-9]{1,8}" title="Ingrese hasta 8 números" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtnombre">Nombre</label>
                                        <input type="text" class="form-control" id="txtnombre" name="txtnombre" pattern="[A-Za-zñÑáéíóúÁÉÍÓÚ\s]+" title="Ingrese solo letras" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtapellido">Apellido</label>
                                        <input type="text" class="form-control" id="txtapellido" name="txtapellido" pattern="[A-Za-zñÑáéíóúÁÉÍÓÚ\s]+" title="Ingrese solo letras" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="txttelefono">Teléfono</label>
                                        <input type="tel" class="form-control" id="txttelefono" name="txttelefono" pattern="[0-9]{1,9}" title="Ingrese hasta 9 números" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="selectGenero">Género</label>
                                        <select class="form-control" id="selectGenero" name="selectGenero" required>
                                            <option value="" selected disabled>Seleccionar Género</option>
                                            <option value="Masculino">Masculino</option>
                                            <option value="Femenino">Femenino</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Información de Trabajo -->
                        <div class="col-md-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    Información de Trabajo
                                </div>
                                <div class="card-body">
                                    <!-- Área, Puesto, Estado -->
                                    <div class="form-group">
                                        <label for="selectArea">Área</label>
                                        <select class="form-control" id="selectArea" name="selectArea" required>
                                            <option value="">Seleccionar Área</option>
                                            <% 
                                                AreaDAO areaDAO = new AreaDAO();
                                                List<Area> areas = areaDAO.listar();
                                                for (Area area : areas) {
                                            %>
                                            <option value="<%= area.getIdArea() %>"><%= area.getNombreArea() %></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtpuesto">Puesto</label>
                                        <input type="text" class="form-control" id="txtpuesto" name="txtpuesto" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtestado">Estado</label>
                                        <input type="text" class="form-control" id="txtestado" name="txtestado" required>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Botones -->
                    <div class="row">
                        <div class="col-md-6">
                            <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                        </div>
                        <div class="col-md-6 text-right">
                            <a href="ControladorEmpleado?accion=listar" class="btn btn-secondary">Cancelar</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script>
        
        // Agregar evento de input para validar mientras se escribe
        document.getElementById('txtnombre').addEventListener('input', function() {
            this.value = this.value.replace(/[^A-Za-zñÑáéíóúÁÉÍÓÚ\s]/g, '');
        });

        document.getElementById('txtapellido').addEventListener('input', function() {
            this.value = this.value.replace(/[^A-Za-zñÑáéíóúÁÉÍÓÚ\s]/g, '');
        });

        document.getElementById('txtdniEmpleado').addEventListener('input', function() {
            this.value = this.value.replace(/\D/g, '').slice(0, 8);
        });
        
        document.getElementById('txttelefono').addEventListener('input', function() {
            this.value = this.value.replace(/\D/g, '').slice(0, 9);
        });
    </script>
</body>

</html>


