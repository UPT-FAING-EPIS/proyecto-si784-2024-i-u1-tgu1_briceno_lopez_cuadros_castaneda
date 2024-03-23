<%-- 
    Document   : EditarArea
    Created on : 1 nov 2023, 11:05:34
    Author     : JORGE
--%>

<%@ page import="ModeloDAO.AreaDAO"%>
<%@ page import="ModeloDAO.HorarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Modelo.Area" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.Horario" %>



<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Área</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="Estilos/Agregar.css" rel="stylesheet">
</head>
<body>
    <%@ include file="/BarraLateral.jsp" %>
    <div class="container mt-5">
        <div class="card mx-auto">
            <div class="container mt-5">
                <h1 class="d-flex align-items-center">
                    <span class="fa fa-plus mr-2"></span>
                    EDITAR ÁREA
                </h1>
                <form action="ControladorArea?accion=editarArea" method="post">
                    <%
                        int idArea = Integer.parseInt(request.getParameter("IdArea"));
                        AreaDAO areadao = new AreaDAO();
                        Area area = areadao.list(idArea);

                        if (area != null) {
                    %>
                    <div class="form-group">
                        <label for="txtIdArea">ID de Área</label>
                        <input type="text" class="form-control" id="txtIdArea" name="txtIdArea" value="<%= area.getIdArea() %>" readonly>
                    </>
                    <div class="form-group">
                        <label for="selectHorario">Horario</label>
                        <select class="form-control" id="selectHorario" name="selectHorario" required>
                            <option value="">Seleccionar Horario</option>
                            <% 
                                HorarioDAO dao = new HorarioDAO();
                                List<Horario> list = dao.listar();
                                for (Horario horario : list)  {
                                    String selected = (horario.getNombreHorario().equals(area.getNombreHorario())) ? "selected" : "";
                            %>
                            <option value="<%= horario.getNombreHorario() %>" <%= selected %>><%= horario.getNombreHorario() %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="txtNombreArea">Nombre de Area</label>
                        <input type="text" class="form-control" id="txtNombreArea" name="txtNombreArea" value="<%= area.getNombreArea() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="txtDescripcion">Descripción</label>
                        <input type="text" class="form-control" id="txtDescripcion" name="txtDescripcion" value="<%= area.getDescripcion() %>" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                    <a href="ControladorArea?accion=listar" class="btn btn-secondary">Cancelar</a>
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
</body>
</html>

