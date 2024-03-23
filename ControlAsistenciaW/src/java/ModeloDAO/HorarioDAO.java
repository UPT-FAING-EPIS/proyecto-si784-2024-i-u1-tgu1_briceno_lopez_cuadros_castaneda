package ModeloDAO;

/**
 *
 * @author Zero
 */

import Interfaces.CRUDHorario;
import Modelo.Horario;
import Config.Conexion;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Time;


public class HorarioDAO implements CRUDHorario {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    Horario horario = new Horario();
    

    @Override
    public List<Horario> listar() {
        ArrayList<Horario> lista = new ArrayList<>();
        String sql = "SELECT * FROM Tb_Horario";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Horario hor = new Horario();
                hor.setIdHorario(rs.getInt("IdHorario"));
                hor.setNombreHorario(rs.getString("NombreHorario"));
                hor.setFechaInicio(rs.getDate("FechaInicio"));
                hor.setFechaFin(rs.getDate("FechaFin"));
                hor.setHoraEntrada(rs.getTime("HoraEntrada").toLocalTime());
                hor.setHoraSalida(rs.getTime("HoraSalida").toLocalTime());
                lista.add(hor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    
    @Override
    public Horario list(int idHorario) {
        Horario objHorario = null;
        String sql = "SELECT * FROM Tb_Horario WHERE IdHorario = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idHorario);
            rs = ps.executeQuery();
            if (rs.next()) {
                objHorario = new Horario();
                objHorario.setIdHorario(rs.getInt("IdHorario"));
                objHorario.setNombreHorario(rs.getString("NombreHorario"));
                objHorario.setFechaInicio(rs.getDate("FechaInicio"));
                objHorario.setFechaFin(rs.getDate("FechaFin"));
                objHorario.setHoraEntrada(rs.getTime("HoraEntrada").toLocalTime());
                objHorario.setHoraSalida(rs.getTime("HoraSalida").toLocalTime());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return objHorario;
    }

    @Override
    public boolean add(Horario h) {
        String sql = "INSERT INTO Tb_Horario (NombreHorario, FechaInicio, FechaFin, HoraEntrada, HoraSalida) VALUES (?, ?, ?, ?, ?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, h.getNombreHorario());
            ps.setDate(2, (Date) h.getFechaInicio());
            ps.setDate(3, (Date) h.getFechaFin());
            ps.setTime(4, Time.valueOf(h.getHoraEntrada()));
            ps.setTime(5, Time.valueOf(h.getHoraSalida()));
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean edit(Horario h) {
        String sql = "UPDATE Tb_Horario SET NombreHorario = ?, FechaInicio = ?, FechaFin = ?, HoraEntrada = ?, HoraSalida = ? WHERE IdHorario = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, h.getNombreHorario());
            ps.setDate(2, (Date) h.getFechaInicio());
            ps.setDate(3, (Date) h.getFechaFin());
            ps.setTime(4, Time.valueOf(h.getHoraEntrada()));
            ps.setTime(5, Time.valueOf(h.getHoraSalida()));
            ps.setInt(6, h.getIdHorario());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminar(int idHorario) {
        String sql = "DELETE FROM Tb_Horario WHERE IdHorario = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idHorario);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int contarHorarios() {
        String sql = "SELECT COUNT(*) AS count FROM Tb_Horario";
        int count = 0;

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException e) {
            System.out.println("Error al contar los horarios: " + e); 
        }

        return count;
    }
}


