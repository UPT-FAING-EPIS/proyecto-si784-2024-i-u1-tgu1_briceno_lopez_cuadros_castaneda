package Controlador;

import Modelo.Usuario;
import ModeloDAO.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ControladorLogin", urlPatterns = {"/ControladorLogin"})
public class ControladorLogin extends HttpServlet {
    private UsuarioDAO usuarioDAO;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
    
    @Override
    public void init() throws ServletException {
        usuarioDAO = new UsuarioDAO();
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Recupera los parámetros del formulario
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("contrasena");

        // Validación de parámetros
        if (usuario == null || clave == null || usuario.isEmpty() || clave.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parámetros de formulario inválidos");
            return;
        }

        try {
            // Realiza la lógica de autenticación utilizando usuario y clave
            boolean usuarioAutenticado = usuarioDAO.iniciarSesion(usuario, clave, "Administrador");

            if (usuarioAutenticado) {
                // Si la autenticación es exitosa, redirige a una página exitosa
                HttpSession sesion = request.getSession();
                sesion.setAttribute("usuario", usuario);
                response.sendRedirect("MenuAdmin.jsp");
            } else {
                // Si la autenticación falla, envía una respuesta de error
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Error de inicio de sesión");
            }
        } catch (IOException e) {
            // Manejo de excepciones de manera más robusta
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error interno del servidor");
        }
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
