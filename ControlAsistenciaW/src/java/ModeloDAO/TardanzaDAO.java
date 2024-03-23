package ModeloDAO;


import Modelo.Tardanza;
import Config.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class TardanzaDAO {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public boolean agregarTardanzaSiLlegoTarde(Tardanza tardanza) {
        if (tardanza.getMinutosTardanza() > 0) {
            String sql = "INSERT INTO tb_tardanza (IdAsistencia, MinutosTardanza) VALUES (?, ?)";

            try {
                con = cn.getConnection();
                ps = con.prepareStatement(sql);
                ps.setInt(1, tardanza.getIdAsistencia());
                ps.setInt(2, tardanza.getMinutosTardanza());

                int rowsAffected = ps.executeUpdate();
                return rowsAffected > 0;
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        } else {
            return false;
        }
    }

    public int contarTardanzas() {
        int cantidadTardanzas = 0;
        String sql = "SELECT COUNT(*) AS TotalTardanzas FROM Tb_Tardanza";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                cantidadTardanzas = rs.getInt("TotalTardanzas");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } 
        
        return cantidadTardanzas;
    }
    
    public Tardanza obtenerTardanzaPorIdAsistencia(int idAsistencia) {
        String sql = "SELECT * FROM tb_tardanza WHERE IdAsistencia = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idAsistencia);
            rs = ps.executeQuery();
            if (rs.next()) {
                Tardanza tardanza = new Tardanza();
                tardanza.setIdTardanza(rs.getInt("IdTardanza"));
                tardanza.setIdAsistencia(rs.getInt("IdAsistencia"));
                tardanza.setMinutosTardanza(rs.getInt("MinutosTardanza"));
                return tardanza;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
