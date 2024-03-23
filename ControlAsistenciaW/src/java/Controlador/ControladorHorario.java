package Controlador;

import Modelo.Horario;
import ModeloDAO.HorarioDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalTime;

@WebServlet(name = "ControladorHorario", urlPatterns = {"/ControladorHorario"})
public class ControladorHorario extends HttpServlet {
    String listar = "VistaHorario/listarHorario.jsp";
    String add = "VistaHorario/agregarHorario.jsp";
    String edit = "VistaHorario/editarHorario.jsp";
    Horario horario = new Horario();
    HorarioDAO dao = new HorarioDAO();

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
        } else if (action.equalsIgnoreCase("add")) {
            acceso = add;
        } else if (action.equalsIgnoreCase("edit")) {
            acceso = edit;
            int idHorario = Integer.parseInt(request.getParameter("idHorario"));
            Horario hor = dao.list(idHorario);
            request.setAttribute("horario", hor);
        } else if (action.equalsIgnoreCase("eliminar")) {
            int idHorario = Integer.parseInt(request.getParameter("idHorario"));
            if (dao.eliminar(idHorario)) {
                response.sendRedirect(request.getContextPath() + "/ControladorHorario?accion=listar");
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
        if (action.equalsIgnoreCase("editarHorario")) {
            int idHorario = Integer.parseInt(request.getParameter("txtidHorario"));
            String nombreHorario = request.getParameter("txtNombreHorario");
            String fechaInicioStr = request.getParameter("txtFechaInicio");
            String fechaFinStr = request.getParameter("txtFechaFin");
            String horaEntradaStr = request.getParameter("txtHoraEntrada");
            String horaSalidaStr = request.getParameter("txtHoraSalida");

            // Convertir la fecha de inicio y fin a objetos Date
            Date fechaInicio = Date.valueOf(fechaInicioStr);
            Date fechaFin = Date.valueOf(fechaFinStr);

            // Convertir las horas de entrada y salida a objetos LocalTime
            LocalTime horaEntrada = LocalTime.parse(horaEntradaStr);
            LocalTime horaSalida = LocalTime.parse(horaSalidaStr);
            
            horario.setIdHorario(idHorario);
            horario.setNombreHorario(nombreHorario);
            horario.setFechaInicio(fechaInicio);
            horario.setFechaFin(fechaFin);
            horario.setHoraEntrada(horaEntrada);
            horario.setHoraSalida(horaSalida);

            if (dao.edit(horario)) {
                response.sendRedirect(request.getContextPath() + "/ControladorHorario?accion=listar");
            } else {
                response.getWriter().println("Error al editar el horario.");
            }
        } else if (action.equalsIgnoreCase("agregarHorario")) {
            String nombreHorario = request.getParameter("txtNombreHorario");
            String fechaInicioStr = request.getParameter("txtFechaInicio");
            String fechaFinStr = request.getParameter("txtFechaFin");
            String horaEntradaStr = request.getParameter("txtHoraEntrada");
            String horaSalidaStr = request.getParameter("txtHoraSalida");

            // Convertir la fecha de inicio y fin a objetos Date
            Date fechaInicio = Date.valueOf(fechaInicioStr);
            Date fechaFin = Date.valueOf(fechaFinStr);

            // Convertir las horas de entrada y salida a objetos LocalTime
            LocalTime horaEntrada = LocalTime.parse(horaEntradaStr);
            LocalTime horaSalida = LocalTime.parse(horaSalidaStr);

            horario.setNombreHorario(nombreHorario);
            horario.setFechaInicio(fechaInicio);
            horario.setFechaFin(fechaFin);
            horario.setHoraEntrada(horaEntrada);
            horario.setHoraSalida(horaSalida);

            // Guardar el horario
            if (dao.add(horario)) {
                response.sendRedirect(request.getContextPath() + "/ControladorHorario?accion=listar");
            } else {
                response.getWriter().println("Error al agregar el horario.");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

