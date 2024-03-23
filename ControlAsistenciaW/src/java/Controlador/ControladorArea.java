package Controlador;

import Modelo.Area;
import ModeloDAO.AreaDAO;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author JORGE
 */
@WebServlet(name = "ControladorArea", urlPatterns = {"/ControladorArea"})
public class ControladorArea extends HttpServlet {
    String listar = "VistaArea/listarArea.jsp";
    String add = "VistaArea/agregarArea.jsp";
    String edit = "VistaArea/editarArea.jsp";
    Area area = new Area();
    AreaDAO dao = new AreaDAO();

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
            int IdArea = Integer.parseInt(request.getParameter("IdArea"));
            Area ar = dao.list(IdArea);
            request.setAttribute("area", ar);
        } else if (action.equalsIgnoreCase("eliminar")) {
            int IdArea = Integer.parseInt(request.getParameter("IdArea"));
            if (dao.eliminar(IdArea)) {
                response.sendRedirect(request.getContextPath() + "/ControladorArea?accion=listar");
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
        if (action.equalsIgnoreCase("editarArea")) {
            
            area.setIdArea(Integer.parseInt(request.getParameter("txtIdArea")));
            area.setNombreHorario(request.getParameter("selectHorario"));
            area.setNombreArea(request.getParameter("txtNombreArea"));
            area.setDescripcion(request.getParameter("txtDescripcion"));
            if (dao.edit(area)) {
                response.sendRedirect(request.getContextPath() + "/ControladorArea?accion=listar");
            }
        } else if (action.equalsIgnoreCase("agregarArea")) {
            
            area.setIdArea(Integer.parseInt(request.getParameter("txtIdArea"))); 
            area.setNombreHorario(request.getParameter("selectHorario"));
            area.setNombreArea(request.getParameter("txtNombreArea"));
            area.setDescripcion(request.getParameter("txtDescripcion"));
            System.out.println("ID de Área: " + area.getIdArea());
            System.out.println("Nombre de Horario: " + area.getNombreHorario());
            System.out.println("Nombre de Área: " + area.getNombreArea());
            System.out.println("Descripción: " + area.getDescripcion());
            if (dao.add(area)) {
                response.sendRedirect(request.getContextPath() + "/ControladorArea?accion=listar");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
