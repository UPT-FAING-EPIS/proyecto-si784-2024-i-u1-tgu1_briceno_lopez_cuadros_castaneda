package Controlador;

import Modelo.Asistencia;
import ModeloDAO.AsistenciaDAO;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.LocalTime;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author JORGE
 */
@WebServlet(name = "ControladorAsistencia", urlPatterns = {"/ControladorAsistencia"})
public class ControladorAsistencia extends HttpServlet {
    String marcar = "index.jsp";
    String listar = "VistaAsistencia/listarAsistencia.jsp";
    String add = "VistaAsistencia/agregarAsistencia.jsp";
    String edit = "VistaAsistencia/editarAsistencia.jsp";
    Asistencia asistencia = new Asistencia();
    AsistenciaDAO dao = new AsistenciaDAO();

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acceso = "";
        String action = request.getParameter("accion");
        if (action.equalsIgnoreCase("listar")) {
            acceso = listar;
        } else if (action.equalsIgnoreCase("marcar")) {
            acceso = marcar; 
        }else if (action.equalsIgnoreCase("add")) {
            acceso = add; 
        } else if (action.equalsIgnoreCase("edit")) {
            acceso = edit; 
            int IdAsistencia = Integer.parseInt(request.getParameter("IdAsistencia"));
            Asistencia as = dao.list(IdAsistencia);
            request.setAttribute("asistencia", as);
        } else if (action.equalsIgnoreCase("eliminar")) {
            int IdAsistencia = Integer.parseInt(request.getParameter("IdAsistencia"));
            if (dao.eliminar(IdAsistencia)) {
                response.sendRedirect(request.getContextPath() + "/ControladorAsistencia?accion=listar");
                return;
            }
            acceso = listar;
        }

        if (acceso != null) {
            RequestDispatcher vista = request.getRequestDispatcher(acceso);
            vista.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String action = request.getParameter("accion");

        if (action.equalsIgnoreCase("marcarEntrada")) {
            // Obtener el DNI del empleado desde el formulario
            String dniEmpleado = request.getParameter("dni");
            // Crear una instancia de Asistencia
            Asistencia nuevaAsistencia = new Asistencia();
            // Obtener la fecha y hora actuales
            LocalDateTime now = LocalDateTime.now();
            java.sql.Date sqlDate = java.sql.Date.valueOf(now.toLocalDate());
            
            LocalTime horaEntrada = LocalTime.now();
             // Obtén el horario del empleado


            nuevaAsistencia.setDniEmpleado(dniEmpleado);
            nuevaAsistencia.setFechaAsistencia(sqlDate);
            nuevaAsistencia.setHoraEntrada(now.toLocalTime());
            

            boolean resultadoEntrada = dao.marcarEntrada(nuevaAsistencia, horaEntrada);

            // Obtener el mensaje específico
            String mensajeEntrada = resultadoEntrada ? "Entrada marcada con éxito hoy." : "Ya ha marcado entrada para este día.";

            // Devolver una respuesta JSON con el resultado y mensaje específicos
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"result\": \"" + (resultadoEntrada ? "success" : "failure") + "\", \"message\": \"" + mensajeEntrada + "\"}");
        } else if (action.equalsIgnoreCase("marcarSalida")) {
            // Obtener el DNI del empleado desde el formulario
            String dniEmpleado = request.getParameter("dni");
            // Crear una instancia de Asistencia
            Asistencia nuevaAsistencia = new Asistencia();
            // Obtener la fecha y hora actuales
            LocalDateTime now = LocalDateTime.now();
            java.sql.Date sqlDate = java.sql.Date.valueOf(now.toLocalDate());

            nuevaAsistencia.setDniEmpleado(dniEmpleado);
            nuevaAsistencia.setFechaAsistencia(sqlDate);
            nuevaAsistencia.setHoraSalida(now.toLocalTime());
  
            dao.marcarSalida(nuevaAsistencia);

            // Devolver una respuesta indicando que la acción fue exitosa o no
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"result\": \"success\", \"message\": \"Salida marcada con éxito hoy.\"}");
        }
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
