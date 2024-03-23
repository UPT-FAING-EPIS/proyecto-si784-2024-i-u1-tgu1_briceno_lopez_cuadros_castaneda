package ModeloDAO;

import Config.Conexion;
import Interfaces.CRUDArea;
import Modelo.Area;
import java.sql.*;
import java.util.*;

/**
 *
 * @author JORGE
 */
public class AreaDAO implements CRUDArea{
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    Area area = new Area();

    @Override
    public List<Area> listar() {
        List<Area> areas = new ArrayList<>();
        String sql = "SELECT a.IdArea, a.NombreArea, a.Descripcion, h.NombreHorario " +
                     "FROM tb_area a " +
                     "JOIN tb_horario h ON a.IdHorario = h.IdHorario";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                int IdArea = rs.getInt("IdArea");
                String NombreArea = rs.getString("NombreArea");
                String Descripcion = rs.getString("Descripcion");
                String NombreHorario = rs.getString("NombreHorario");

                Area a = new Area(IdArea, NombreHorario, NombreArea, Descripcion);
                areas.add(a);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar las áreas: " + e);
        }

        return areas;
    }

    @Override
    public Area list(int IdArea) {
        Area a = null;
        String sql = "SELECT a.IdArea, a.NombreArea, a.Descripcion, h.NombreHorario " +
                     "FROM tb_area a " +
                     "JOIN tb_horario h ON a.IdHorario = h.IdHorario " +
                     "WHERE a.IdArea=?";
        
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, IdArea);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                int IdAreaResult = rs.getInt("IdArea");
                String NombreHorario = rs.getString("NombreHorario");
                String NombreArea = rs.getString("NombreArea");
                String Descripcion = rs.getString("Descripcion");
                
                a = new Area(IdAreaResult, NombreHorario, NombreArea, Descripcion);
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener el área: " + e);
        }
        
        return a;
    }

    @Override
    public boolean add(Area area) { 
        String sqlInsertarArea = "INSERT INTO tb_area (IdArea, IdHorario, NombreArea, Descripcion) "
                    + "VALUES (?, (SELECT IdHorario FROM tb_horario WHERE NombreHorario = ?), ?, ?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sqlInsertarArea);
            ps.setInt(1, area.getIdArea());
            ps.setString(2, area.getNombreHorario());
            ps.setString(3, area.getNombreArea());
            ps.setString(4, area.getDescripcion());

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            System.out.println("Error al insertar el área: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }


    @Override
    public boolean edit(Area area) {
        String sqlObtenerIdHorario = "SELECT IdHorario FROM tb_horario WHERE NombreHorario=?";
        try {
            con = cn.getConnection();

            // Obtener el ID del horario
            ps = con.prepareStatement(sqlObtenerIdHorario);
            ps.setString(1, area.getNombreHorario());
            rs = ps.executeQuery();

            if (rs.next()) {
                int idHorario = rs.getInt("IdHorario");

                // Actualizar el área con el ID de horario obtenido
                String sqlActualizarArea = "UPDATE tb_area SET IdHorario=?, NombreArea=?, Descripcion=? WHERE IdArea=?";
                ps = con.prepareStatement(sqlActualizarArea);
                ps.setInt(1, idHorario);
                ps.setString(2, area.getNombreArea());
                ps.setString(3, area.getDescripcion());
                ps.setInt(4, area.getIdArea());

                int filasAfectadas = ps.executeUpdate();
                return filasAfectadas > 0;
            } else {
                System.out.println("El horario con nombre " + area.getNombreHorario() + " no fue encontrado.");
            }
        } catch (SQLException e) {
            System.out.println("Error al actualizar el área: " + e);
        } 
        return false;
    }


    @Override
    public boolean eliminar(int IdArea) {
        String sql = "DELETE FROM tb_area WHERE IdArea=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, IdArea);

            int filasAfectadas = ps.executeUpdate();

            if (filasAfectadas > 0) {
                System.out.println("Área eliminada correctamente.");
                return true;
            } else {
                System.out.println("No se pudo eliminar el área.");
            }
        } catch (SQLException e) {
            System.out.println("Error al eliminar el área: " + e);
        }
        return false;
    }
    
    public int contarAreas() {
        String sql = "SELECT COUNT(*) AS count FROM tb_area";
        int count = 0;

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException e) {
            System.out.println("Error al contar las áreas: " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e);
            }
        }

        return count;
    }
    
    public String obtenerNombreAreaPorId(int idArea) {
        String nombreArea = null;
        String sql = "SELECT NombreArea FROM tb_area WHERE IdArea = ?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idArea);
            rs = ps.executeQuery();

            if (rs.next()) {
                nombreArea = rs.getString("NombreArea");
            }
        } catch (SQLException e) {
            
        }
        return nombreArea;
    }
    
    public int obtenerIdAreaPorNombre(String nombreArea) {
        int idArea = 0;

        String sql = "SELECT IdArea FROM tb_area WHERE NombreArea = ?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, nombreArea);
            rs = ps.executeQuery();

            if (rs.next()) {
                idArea = rs.getInt("IdArea");
            }
        } catch (SQLException e) {
        }

        return idArea;
    }
}
