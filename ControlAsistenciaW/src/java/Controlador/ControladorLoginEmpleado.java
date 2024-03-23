package Controlador;

import Modelo.Empleado;
import Modelo.Usuario;
import ModeloDAO.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author JORGE
 */
@WebServlet(name = "ControladorLoginEmpleado", urlPatterns = {"/ControladorLoginEmpleado"})
public class ControladorLoginEmpleado extends HttpServlet {
    private UsuarioDAO usuarioDAO;
    
    @Override
    public void init() throws ServletException {
        usuarioDAO = new UsuarioDAO();
    }
    
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
         // Recupera los parámetros del formulario
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("contrasena");

        // Realiza la lógica de autenticación utilizando usuario y clave
        boolean usuarioAutenticado = usuarioDAO.iniciarSesion(usuario, clave, "Empleado");

        if (usuarioAutenticado) {
            Empleado empleado = usuarioDAO.obtenerDatosEmpleadoPorNombreUsuario(usuario);

            if (empleado != null) {
                // Guarda el nombre, apellido y DNI en la sesión
                HttpSession sesion = request.getSession();
                sesion.setAttribute("nombreApellido", empleado.getNombre() + " " + empleado.getApellido());
                sesion.setAttribute("dniEmpleado", empleado.getDniEmpleado());

                // Redirige a la página de Menú Empleado
                response.sendRedirect("MenuEmpleado.jsp");
            } else {
                // Manejo si no se pudo obtener los datos del empleado
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al obtener datos del empleado");
            }
        } else {
            // Si la autenticación falla, envía una respuesta de error
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Error de inicio de sesión");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
