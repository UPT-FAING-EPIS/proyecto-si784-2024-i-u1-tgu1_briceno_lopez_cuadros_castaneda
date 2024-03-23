package Controlador;

import Modelo.Reporte;
import ModeloDAO.AreaDAO;
import ModeloDAO.ReporteDAO;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author JORGE
 */
@WebServlet(name = "ControladorGenerarReporte", urlPatterns = {"/ControladorGenerarReporte"})
public class ControladorGenerarReporte extends HttpServlet {
    String marcar = "index.jsp";
    String listar = "VistaReporte/listarReporte.jsp";
    String add = "VistaReporte/agregarReporte.jsp";
    Reporte asistencia = new Reporte();
    ReporteDAO dao = new ReporteDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            // Set the content type of the response
            response.setContentType("text/html;charset=UTF-8");

        try {
            // Retrieve parameters from the request
            String startDateParam = request.getParameter("startDate");
            String endDateParam = request.getParameter("endDate");
            String areaNombre = request.getParameter("selectArea");

            if (startDateParam != null && endDateParam != null && areaNombre != null && !areaNombre.isEmpty()) {
                // Parse parameters
                Date startDate = Date.valueOf(startDateParam);
                Date endDate = Date.valueOf(endDateParam);
                
                boolean success = dao.generarReporte(startDate, endDate, areaNombre);

                if (success) {
                    // Redirect to the list report page on success
                    response.sendRedirect(request.getContextPath() + "/VistaReporte/listarReporte.jsp");
                } else {
                    // Handle the case when the procedure did not execute successfully
                    response.sendRedirect("/errorPage.jsp");
                }
            } 
        } catch (SQLException e) {
        }
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
