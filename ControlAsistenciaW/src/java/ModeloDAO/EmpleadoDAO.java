package ModeloDAO;

import Interfaces.CRUDEmpleado;
import Modelo.Empleado;
import Config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmpleadoDAO implements CRUDEmpleado {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    Empleado empleado = new Empleado();

    @Override
    public List<Empleado> listar() {
        ArrayList<Empleado> lista = new ArrayList<>();
        String sql = "SELECT * FROM Tb_Empleado";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Empleado emp = new Empleado();
                emp.setDniEmpleado(rs.getString("DniEmpleado"));
                emp.setIdArea(rs.getInt("IdArea"));
                emp.setNombre(rs.getString("Nombre"));
                emp.setApellido(rs.getString("Apellido"));
                emp.setPuesto(rs.getString("Puesto"));
                emp.setTelefono(rs.getString("Telefono"));
                emp.setGenero(rs.getString("Genero"));
                emp.setEstado(rs.getString("Estado"));
                emp.setFoto(rs.getString("Foto"));
                lista.add(emp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public Empleado list(String dniEmpleado) {
        Empleado objEmpleado = null;
        String sql = "SELECT * FROM Tb_Empleado WHERE DniEmpleado = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, dniEmpleado);
            rs = ps.executeQuery();
            if (rs.next()) {
                objEmpleado = new Empleado();
                objEmpleado.setDniEmpleado(rs.getString("DniEmpleado"));
                objEmpleado.setIdArea(rs.getInt("IdArea"));
                objEmpleado.setNombre(rs.getString("Nombre"));
                objEmpleado.setApellido(rs.getString("Apellido"));
                objEmpleado.setPuesto(rs.getString("Puesto"));
                objEmpleado.setTelefono(rs.getString("Telefono"));
                objEmpleado.setGenero(rs.getString("Genero"));
                objEmpleado.setEstado(rs.getString("Estado"));
                objEmpleado.setFoto(rs.getString("Foto"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return objEmpleado;
    }

    @Override
    public boolean add(Empleado emp) {
        String sql = "INSERT INTO Tb_Empleado (DniEmpleado, IdArea, Nombre, Apellido, Puesto, Telefono, Genero, Estado, Foto) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, emp.getDniEmpleado());
            ps.setInt(2, emp.getIdArea());
            ps.setString(3, emp.getNombre());
            ps.setString(4, emp.getApellido());
            ps.setString(5, emp.getPuesto());
            ps.setString(6, emp.getTelefono());
            ps.setString(7, emp.getGenero());
            ps.setString(8, emp.getEstado());
            ps.setString(9, emp.getFoto());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean edit(Empleado emp) {
        String sql = "UPDATE Tb_Empleado SET IdArea = ?, Nombre = ?, Apellido = ?, Puesto = ?, Telefono = ?, Genero = ?, Estado = ?, Foto = ? WHERE DniEmpleado = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, emp.getIdArea());
            ps.setString(2, emp.getNombre());
            ps.setString(3, emp.getApellido());
            ps.setString(4, emp.getPuesto());
            ps.setString(5, emp.getTelefono());
            ps.setString(6, emp.getGenero());
            ps.setString(7, emp.getEstado());
            ps.setString(8, emp.getFoto());
            ps.setString(9, emp.getDniEmpleado());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminar(String dniEmpleado) {
        String sql = "DELETE FROM Tb_Empleado WHERE DniEmpleado = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, dniEmpleado);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int contarEmpleados() {
        String sql = "SELECT COUNT(*) FROM Tb_Empleado";

        try {
             con = cn.getConnection();
             ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            System.out.println("Error al contar empleados: " + ex.toString());
        }

        return 0; // Devuelve 0 si hay un error.
    }
    
   public String listarPorDNI(String dni) {
        String nombreCompleto = null;
        String sql = "SELECT Nombre, Apellido FROM Tb_Empleado WHERE DniEmpleado = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, dni);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Concatena el nombre y apellido y guárdalo en nombreCompleto
                nombreCompleto = rs.getString("Nombre") + " " + rs.getString("Apellido");
            }
        } catch (SQLException e) {
        }
        return (nombreCompleto != null) ? nombreCompleto : "Empleado no Registrado";
    }
   
   public String obtenerNombreApellidoPorIdUsuario(int idUsuario) {
        String nombreCompleto = null;
        String sql = "SELECT e.Nombre, e.Apellido " +
                     "FROM Tb_Empleado e " +
                     "INNER JOIN Tb_Usuario u ON e.DniEmpleado = u.DniEmpleado " +
                     "WHERE u.IdUsuario = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idUsuario);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Concatena el nombre y apellido y guárdalo en nombreCompleto
                nombreCompleto = rs.getString("Nombre") + " " + rs.getString("Apellido");
            }
        } catch (SQLException e) {
            // Manejo de excepciones
        } finally {
            // Asegúrate de cerrar la conexión, el PreparedStatement y el ResultSet
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return (nombreCompleto != null) ? nombreCompleto : "Empleado no Registrado";
   }
   
   
   // Método en EmpleadoDAO para obtener empleados por área
    public List<Empleado> obtenerEmpleadosPorArea(int idArea) {
        List<Empleado> listaEmpleados = new ArrayList<>();
        String sql = "SELECT * FROM tb_empleado WHERE IdArea = ?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idArea);
            rs = ps.executeQuery();

            while (rs.next()) {
                Empleado empleado = new Empleado();
                empleado.setDniEmpleado(rs.getString("DniEmpleado"));
                empleado.setNombre(rs.getString("Nombre"));
                // Agrega más propiedades según la estructura de tu tabla empleado

                listaEmpleados.add(empleado);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Asegúrate de cerrar las conexiones en el bloque finally
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return listaEmpleados;
    }
    
    public Empleado obtenerEmpleadoPorDNI(String dni) {
        String sql = "SELECT * FROM tb_empleado WHERE DniEmpleado = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, dni);
            rs = ps.executeQuery();

            if (rs.next()) {
                empleado = new Empleado();
                empleado.setDniEmpleado(rs.getString("DniEmpleado"));
                
                String nombreCompleto = rs.getString("Nombre") + " " + rs.getString("Apellido");
                empleado.setNombre(nombreCompleto);
                
            }
        } catch (SQLException e) {
        }

        return empleado;
    }
}

