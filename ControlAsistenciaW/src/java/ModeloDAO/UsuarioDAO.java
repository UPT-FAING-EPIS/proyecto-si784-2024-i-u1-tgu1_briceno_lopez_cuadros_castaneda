package ModeloDAO;

import Modelo.Usuario;
import Config.Conexion;
import Modelo.Empleado;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public UsuarioDAO() {
        Conexion conexion = new Conexion();
        con = conexion.getConnection();
    }

    public List<Usuario> obtenerTodosLosUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        String query = "SELECT * FROM tb_usuario";

        try {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                int idUsuario = rs.getInt("IdUsuario");
                String nombre = rs.getString("Nombre");
                String clave = rs.getString("Clave");
                String nivel = rs.getString("Nivel");

                Usuario usuario = new Usuario(idUsuario, nombre, clave, nivel);
                usuarios.add(usuario);
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuarios;
    }

    public Usuario obtenerUsuarioPorId(int id) {
        String query = "SELECT * FROM tb_usuario WHERE IdUsuario = ?";
        Usuario usuario = null;

        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int idUsuario = rs.getInt("IdUsuario");
                String nombre = rs.getString("Nombre");
                String clave = rs.getString("Clave");
                String nivel = rs.getString("Nivel");

                usuario = new Usuario(idUsuario, nombre, clave, nivel);
            }

            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuario;
    }

    public void agregarUsuario(Usuario usuario) {
        String query = "INSERT INTO tb_usuario (IdUsuario, Nombre, Clave, Nivel) VALUES (?, ?, ?, ?)";

        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, usuario.getIdUsuario());
            pstmt.setString(2, usuario.getNombre());
            pstmt.setString(3, usuario.getClave());
            pstmt.setString(4, usuario.getNivel());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void actualizarUsuario(Usuario usuario) {
        String query = "UPDATE tb_usuario SET Nombre = ?, Clave = ?, Nivel = ? WHERE IdUsuario = ?";

        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, usuario.getNombre());
            pstmt.setString(2, usuario.getClave());
            pstmt.setString(3, usuario.getNivel());
            pstmt.setInt(4, usuario.getIdUsuario());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean eliminarUsuario(int id) {
        String query = "DELETE FROM tb_usuario WHERE IdUsuario = ?";

        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean iniciarSesion(String nombre, String clave, String nivelRequerido) {
        String query = "SELECT * FROM tb_usuario WHERE Nombre = ? AND Clave = ? AND Nivel = ?";
        boolean loginSuccessful = false;
        System.out.println("Nombre de usuario: " + nombre);
        System.out.println("Contraseña: " + clave);

        try {
            ps = con.prepareStatement(query);
            ps.setString(1, nombre);
            ps.setString(2, clave);
            ps.setString(3, nivelRequerido);

            rs = ps.executeQuery();

            if (rs.next()) {
                // Compare retrieved values with input parameters
                String dbNombre = rs.getString("Nombre");
                String dbClave = rs.getString("Clave");
                String dbNivel = rs.getString("Nivel");

                if (nombre.equals(dbNombre) && clave.equals(dbClave) && nivelRequerido.equals(dbNivel)) {
                    loginSuccessful = true;
                }
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.out.println("Error al establecer la conexión a la base de datos");
        }

        return loginSuccessful;
    }
    
    public Empleado obtenerDatosEmpleadoPorNombreUsuario(String nombreUsuario) {
        Empleado empleado = null;

        try {
            con = cn.getConnection();

            // Obtener IdUsuario por nombre de usuario
            String sqlIdUsuario = "SELECT IdUsuario FROM Tb_Usuario WHERE Nombre = ?";
            ps = con.prepareStatement(sqlIdUsuario);
            ps.setString(1, nombreUsuario);
            rs = ps.executeQuery();

            if (rs.next()) {
                int idUsuario = rs.getInt("IdUsuario");

                // Obtener datos del empleado por IdUsuario
                String sqlEmpleado = "SELECT DniEmpleado, Nombre, Apellido FROM Tb_Empleado WHERE IdUsuario = ?";
                ps = con.prepareStatement(sqlEmpleado);
                ps.setInt(1, idUsuario);
                rs = ps.executeQuery();

                if (rs.next()) {
                    empleado = new Empleado();
                    empleado.setDniEmpleado(rs.getString("DniEmpleado"));
                    empleado.setNombre(rs.getString("Nombre"));
                    empleado.setApellido(rs.getString("Apellido"));
                    // Puedes agregar más atributos según necesites
                }
            }
        } catch (SQLException e) {
        }

        return empleado;
    }
}
    


