<%-- 
    Document   : editarEmpleado
    Created on : 8 dic 2023, 1:54:19
    Author     : JORGE
--%>

<%@page import="Modelo.Area"%>
<%@page import="java.util.List"%>
<%@page import="ModeloDAO.AreaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelo.Empleado"%>
<%@page import="ModeloDAO.EmpleadoDAO"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Editar Empleado</title>
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
                    EDITAR EMPLEADO
                </h1>
                <form action="ControladorEmpleado?accion=editarEmpleado" method="post">
                    <%
                        String dniEmpleado = request.getParameter("vdniEmpleado");
                        EmpleadoDAO dao = new EmpleadoDAO();
                        Empleado empleado = dao.list(dniEmpleado);

                        if (empleado != null) {
                    %>
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
                                        <input type="text" class="form-control" id="txtdniEmpleado" name="txtdniEmpleado" pattern="[0-9]{1,8}" title="Ingrese hasta 8 números" value="<%= empleado.getDniEmpleado() %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="txtnombre">Nombre</label>
                                        <input type="text" class="form-control" id="txtnombre" name="txtnombre" pattern="[A-Za-zñÑáéíóúÁÉÍÓÚ\s]+" title="Ingrese solo letras" value="<%= empleado.getNombre() %>" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtapellido">Apellido</label>
                                        <input type="text" class="form-control" id="txtapellido" name="txtapellido" pattern="[A-Za-zñÑáéíóúÁÉÍÓÚ\s]+" title="Ingrese solo letras" value="<%= empleado.getApellido() %>" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="txttelefono">Teléfono</label>
                                        <input type="tel" class="form-control" id="txttelefono" name="txttelefono" pattern="[0-9]{1,9}" title="Ingrese hasta 9 números" value="<%= empleado.getTelefono() %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="selectGenero">Género</label>
                                    <select class="form-control" id="selectGenero" name="selectGenero" required>
                                        <option value="" selected disabled>Seleccionar Género</option>
                                        <% String generoEmpleado = empleado.getGenero(); %>
                                        <option value="Masculino" <%= (generoEmpleado.equals("Masculino")) ? "selected" : "" %>>Masculino</option>
                                        <option value="Femenino" <%= (generoEmpleado.equals("Femenino")) ? "selected" : "" %>>Femenino</option>
                                    </select>
                          
                                    </div>
                                    <div class="form-group">
                                        <label for="txtfoto">URL Foto</label>
                                        <input type="text" class="form-control" id="txtfoto" name="txtfoto" value="<%= empleado.getFoto() %>">
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
                                        <select class="form-control" id="selectArea" name="selectArea"  required>
                                            <option value="">Seleccionar Área</option>
                                            <% 
                                                AreaDAO areaDAO = new AreaDAO();
                                                List<Area> areas = areaDAO.listar();
                                                for (Area area : areas) {
                                                    String selected = (area.getIdArea() == empleado.getIdArea()) ? "selected" : "";
                                            %>
                                            <option value="<%= area.getIdArea() %>" <%= selected %>><%= area.getNombreArea() %></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtpuesto">Puesto</label>
                                        <input type="text" class="form-control" id="txtpuesto" name="txtpuesto" value="<%= empleado.getPuesto() %>" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtestado">Estado</label>
                                        <input type="text" class="form-control" id="txtestado" name="txtestado" value="<%= empleado.getEstado() %>">
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
                    <%
                        } else {
                    %>
                    <p>Empleado no encontrado.</p>
                    <%
                        }
                    %>
                </form>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script>
        function previewImage() {
            var preview = document.getElementById('preview');
            var fileInput = document.getElementById('foto');

            preview.style.display = 'block';

            var reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
            };

            reader.readAsDataURL(fileInput.files[0]);
        }
        
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
