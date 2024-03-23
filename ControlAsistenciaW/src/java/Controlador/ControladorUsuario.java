/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Modelo.Usuario;
import ModeloDAO.UsuarioDAO;
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
@WebServlet(name = "ControladorUsuario", urlPatterns = {"/ControladorUsuario"})
public class ControladorUsuario extends HttpServlet {
    String listar = "VistaUsuarios/listarUsuarios.jsp";
    String add = "VistaUsuarios/agregarUsuarios.jsp";
    String edit = "VistaUsuarios/editarUsuarios.jsp";
    Usuario usuario = new Usuario();
    UsuarioDAO dao = new UsuarioDAO();
    
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
            int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
            Usuario usu = dao.obtenerUsuarioPorId(idUsuario);
            request.setAttribute("usuario", usu);
        } else if (action.equalsIgnoreCase("eliminar")) {
            int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
            if (dao.eliminarUsuario(idUsuario)) {
                response.sendRedirect(request.getContextPath() + "/ControladorUsuario?accion=listar");
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
        processRequest(request, response);
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
