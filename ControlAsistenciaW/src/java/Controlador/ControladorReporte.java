package Controlador;

import Modelo.Reporte;
import ModeloDAO.ReporteDAO;
import java.io.IOException;
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
@WebServlet(name = "ControladorReporte", urlPatterns = {"/ControladorReporte"})
public class ControladorReporte extends HttpServlet {
    String listar = "VistaReporte/listarReporte.jsp";
    String add = "VistaReporte/agregarReporte.jsp";
    ReporteDAO dao = new ReporteDAO();

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
        }

        if (acceso != null) {
            RequestDispatcher vista = request.getRequestDispatcher(acceso);
            vista.forward(request, response);
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
