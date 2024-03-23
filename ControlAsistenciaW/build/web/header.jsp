

<div class="sidebar">
    <h2 style="color: white; text-align: center;">Empresa</h2>
    <a href="#" class="menu-item" onclick="cargarDashboard()"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
    <h3 style="color: white; padding-left: 20px;">ZONA EMPLEADO</h3>
    <a href="${pageContext.request.contextPath}/VistaEmpleadoMenu/asistenciaEmpleado.jsp" class="menu-item" onclick="cargarContenido('asistencias.html', 'asistenciasCard', 'asistenciasContent')"><i class="far fa-calendar-check"></i> Asistencias</a>
    <a href="${pageContext.request.contextPath}/VistaEmpleadoMenu/permisosEmpleado.jsp" class="menu-item" onclick="cargarContenido('permisos.html', 'permisosCard', 'permisosContent')"><i class="far fa-file-alt"></i> Permisos</a>
    <a href="${pageContext.request.contextPath}/VistaEmpleadoMenu/perfilEmpleado.jsp" class="menu-item" onclick="cargarContenido('reportes.html', 'reportesCard', 'reportesContent')"><i class="fas fa-chart-line"></i> Perfil</a>
    <a href="index.jsp" class="menu-item"><i class="fas fa-sign-out-alt"></i> Cerrar Sesión</a>
</div>


