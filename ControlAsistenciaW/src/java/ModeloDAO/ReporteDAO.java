package ModeloDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import Config.Conexion;
import Modelo.Reporte;
import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author JORGE
 */
public class ReporteDAO {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    CallableStatement cs;
    ResultSet rs;
    
    
    // Agrega este método a tu clase ReporteDAO
    public List<Reporte> Listar() {
        List<Reporte> listaReportes = new ArrayList<>();
        String sql = "SELECT r.IdReporte, r.FechaInicio, r.FechaFin, a.NombreArea, r.TotalAsistencias, r.TotalTardanzas, r.TotalFaltas " +
                     "FROM tb_reporte r " +
                     "JOIN tb_area a ON r.IdArea = a.IdArea";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Reporte report = new Reporte();
                report.setIdReporte(rs.getInt("IdReporte"));
                report.setFechaInicio(rs.getDate("FechaInicio"));
                report.setFechaFin(rs.getDate("FechaFin"));
                report.setNombreArea(rs.getString("NombreArea"));
                report.setTotalAsistencias(rs.getInt("TotalAsistencias"));
                report.setTotalTardanzas(rs.getInt("TotalTardanzas"));
                report.setTotalFaltas(rs.getInt("TotalFaltas"));

                listaReportes.add(report);
            }
        } catch (SQLException e) {
            // Handle SQLException if needed
        } finally {
            // Close resources (PreparedStatement, ResultSet) in a finally block
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException ex) {
                // Handle SQLException if needed
            }
        }

        return listaReportes;
    }
    
    
    public boolean generarReporte(Date fechaInicio, Date fechaFin, String nombreArea) throws SQLException {
        con = null;
        cs = null;
        rs = null;

        try {
            con = cn.getConnection();

            // Convertir el nombre del área a entero
            int idArea = Integer.parseInt(nombreArea);

            System.out.println("ID Área obtenido: " + idArea);

            // Llamar al procedimiento almacenado con el ID del área obtenido
            cs = con.prepareCall("{call GenerarReporte(?, ?, ?)}");
            cs.setInt(1, idArea);
            cs.setDate(2, fechaInicio);
            cs.setDate(3, fechaFin);
            

            // Ejecutar el procedimiento almacenado
            int rowsAffected = cs.executeUpdate();

            // Devolver true si se afectaron filas (update/delete), false si no se afectaron filas (insert)
            return rowsAffected > 0;
        } catch (NumberFormatException e) {
            // Manejar la excepción si la conversión a entero falla
            System.err.println("Error al convertir el nombre del área a entero: " + e.getMessage());
            return false;
        } finally {
            // Cerrar recursos aquí si es necesario
            if (rs != null) {
                rs.close();
            }
            if (cs != null) {
                cs.close();
            }
        }
    }
}