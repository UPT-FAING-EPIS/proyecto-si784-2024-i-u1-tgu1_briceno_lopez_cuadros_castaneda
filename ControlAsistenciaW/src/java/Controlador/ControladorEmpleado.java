package Controlador;



import Modelo.Empleado;
import ModeloDAO.EmpleadoDAO;
import com.google.gson.Gson;
import java.io.BufferedReader;
import java.io.File;

import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


@WebServlet(name = "ControladorEmpleado", urlPatterns = {"/ControladorEmpleado"})
public class ControladorEmpleado extends HttpServlet {
    
    String listar = "VistaEmpleado/listarEmpleados.jsp";
    String add = "VistaEmpleado/agregarEmpleado.jsp";
    String edit = "VistaEmpleado/editarEmpleado.jsp";
    String procesar="VistaCliente/procesar.jsp";
    Empleado empleado = new Empleado();
    EmpleadoDAO dao = new EmpleadoDAO();
    
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
        } else if (action.equalsIgnoreCase("procesar")) {
            acceso = procesar;
        } else if (action.equalsIgnoreCase("add")) {
            acceso = add;
        } else if (action.equalsIgnoreCase("edit")) {
            acceso = edit;
            String dniEmpleado = request.getParameter("vdniEmpleado");
            Empleado emp = dao.list(dniEmpleado);
            request.setAttribute("empleado", emp);
        } else if (action.equalsIgnoreCase("eliminar")) {
            String dniEmpleado = request.getParameter("vdniEmpleado");
            if (dao.eliminar(dniEmpleado)) {
                response.sendRedirect(request.getContextPath() + "/ControladorEmpleado?accion=listar");
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

        if (action.equalsIgnoreCase("editarEmpleado")) {
            empleado.setDniEmpleado(request.getParameter("txtdniEmpleado"));
            empleado.setIdArea(Integer.parseInt(request.getParameter("selectArea")));
            empleado.setNombre(request.getParameter("txtnombre"));
            empleado.setApellido(request.getParameter("txtapellido"));
            empleado.setPuesto(request.getParameter("txtpuesto"));
            empleado.setTelefono(request.getParameter("txttelefono"));
            empleado.setGenero(request.getParameter("selectGenero"));
            empleado.setEstado(request.getParameter("txtestado"));
            empleado.setFoto(request.getParameter("txtfoto"));
            if (dao.edit(empleado)) {
                response.sendRedirect(request.getContextPath() + "/ControladorEmpleado?accion=listar");
            }

        } else if (action.equalsIgnoreCase("agregarEmpleado")) {
            empleado.setDniEmpleado(request.getParameter("txtdniEmpleado"));
            empleado.setIdArea(Integer.parseInt(request.getParameter("selectArea")));
            empleado.setNombre(request.getParameter("txtnombre"));
            empleado.setApellido(request.getParameter("txtapellido"));
            empleado.setPuesto(request.getParameter("txtpuesto"));
            empleado.setTelefono(request.getParameter("txttelefono"));
            empleado.setGenero(request.getParameter("selectGenero"));
            empleado.setEstado(request.getParameter("txtestado"));
            empleado.setFoto(request.getParameter("txtfoto"));
            if (dao.add(empleado)) {
                    response.sendRedirect(request.getContextPath() + "/ControladorEmpleado?accion=listar");
                }
        } else if (action.equalsIgnoreCase("listarPorDNI")) {
            // Obtener el DNI del empleado desde los parámetros del formulario
            String dniEmpleado = request.getParameter("dni");

            // Obtener el nombre del empleado directamente desde el DAO
            String nombreEmpleado = dao.listarPorDNI(dniEmpleado);

            // Crear un objeto para representar la respuesta JSON
            Map<String, String> responseMap = new HashMap<>();

            if (nombreEmpleado != null) {
                responseMap.put("nombre", nombreEmpleado);
            } else {
                responseMap.put("error", "No se encontró ningún empleado con el DNI proporcionado");
            }

            // Crear una instancia de Gson
            Gson gson = new Gson();

            // Convertir el objeto a una cadena JSON
            String jsonResponse = gson.toJson(responseMap);

            // Configurar la respuesta del servlet
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse);
        } else if (action.equalsIgnoreCase("procesarDatos")) {
            // Verifica si la solicitud contiene datos multipartes (archivo adjunto)
            if (ServletFileUpload.isMultipartContent(request)) {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);

                try {
                    List<FileItem> items = upload.parseRequest(request);
                    for (FileItem item : items) {
                        if (!item.isFormField()) {
                            String rutaBase = getServletContext().getRealPath("/");
                            File baseFile = new File(rutaBase);
                            String rutaProyecto = baseFile.getParentFile().getParent();
                            String nombreArchivo = new File(item.getName()).getName();
                            String rutaArchivo = rutaProyecto + File.separator + "web" + File.separator + "VistaEmpleado" + File.separator + "archivos" + File.separator + nombreArchivo;
                            File archivo = new File(rutaArchivo);

                            try {
                                item.write(archivo);
                                System.out.println("Archivo guardado correctamente en el servidor.");
                            } catch (Exception e) {
                                System.out.println("Error al guardar el archivo en el servidor: " + e.getMessage());
                            }

                            BufferedReader br = new BufferedReader(new InputStreamReader(item.getInputStream()));
                            String linea;
                            while ((linea = br.readLine()) != null) {
                                String[] columnas = linea.split(";");
                                if (columnas.length >= 9) {
                                    empleado.setDniEmpleado(columnas[0]);
                                    empleado.setIdArea(Integer.parseInt(columnas[1]));
                                    empleado.setNombre(columnas[2]);
                                    empleado.setApellido(columnas[3]);
                                    empleado.setPuesto(columnas[4]);
                                    empleado.setTelefono(columnas[5]);
                                    empleado.setGenero(columnas[6]);
                                    empleado.setEstado(columnas[7]);
                                    empleado.setFoto(columnas[8]);
                                    dao.add(empleado);
                                } else {
                                    System.out.println("Formato de fila incorrecto: " + linea);
                                }
                            }
                            br.close();
                        }
                    }
                } catch (FileUploadException ex) {
                    ex.printStackTrace();
                } catch (Exception ex) {
                    Logger.getLogger(ControladorEmpleado.class.getName()).log(Level.SEVERE, null, ex);
                }
                response.sendRedirect(request.getContextPath() + "/ControladorEmpleado?accion=listar");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
