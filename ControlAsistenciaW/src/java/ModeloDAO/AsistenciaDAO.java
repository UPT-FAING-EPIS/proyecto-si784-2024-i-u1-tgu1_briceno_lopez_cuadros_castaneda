package ModeloDAO;

import Config.Conexion;
import Interfaces.CRUDAsistencia;
import Modelo.Asistencia;
import Modelo.Horario;
import Modelo.Tardanza;
import java.sql.*;
import java.sql.Date;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author JORGE
 */
public class AsistenciaDAO implements CRUDAsistencia {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    Asistencia area = new Asistencia();

    @Override
    public List<Asistencia> listar() {
        List<Asistencia> asistencias = new ArrayList<>();

        try {
            con = cn.getConnection();
            String sql = "SELECT * FROM tb_asistencia";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Asistencia asistencia = new Asistencia();
                asistencia.setIdAsistencia(rs.getInt("IdAsistencia"));
                asistencia.setDniEmpleado(rs.getString("DniEmpleado"));
                asistencia.setFechaAsistencia(rs.getDate("FechaAsistencia"));
                asistencia.setHoraEntrada(rs.getTime("HoraEntrada").toLocalTime());
                asistencia.setHoraSalida(rs.getTime("HoraSalida").toLocalTime());
                asistencia.setEstadoAsistencia(rs.getString("EstadoAsistencia"));

                asistencias.add(asistencia);
            }
        } catch (SQLException e) {
        }
        return asistencias;
    }
    
    public List<Asistencia> listarDNI(String dniEmpleado) {
        List<Asistencia> asistencias = new ArrayList<>();

        try {
            con = cn.getConnection();
            String sql = "SELECT * FROM tb_asistencia WHERE DniEmpleado = ?";
            ps = con.prepareStatement(sql);

            // Set the parameter for the user's DNI
            ps.setString(1, dniEmpleado);
            System.out.println("Nombre de usuario: " + dniEmpleado);

            rs = ps.executeQuery();

            while (rs.next()) {
                Asistencia asistencia = new Asistencia();
                asistencia.setIdAsistencia(rs.getInt("IdAsistencia"));
                asistencia.setDniEmpleado(rs.getString("DniEmpleado"));
                asistencia.setFechaAsistencia(rs.getDate("FechaAsistencia"));
                asistencia.setHoraEntrada(rs.getTime("HoraEntrada").toLocalTime());
                asistencia.setHoraSalida(rs.getTime("HoraSalida").toLocalTime());
                asistencia.setEstadoAsistencia(rs.getString("EstadoAsistencia"));

                asistencias.add(asistencia);
            }
        } catch (SQLException e) {
        }
        return asistencias;
    }

    @Override
    public Asistencia list(int IdAsistencia) {
        String sql = "SELECT * FROM tb_asistencia WHERE IdAsistencia=?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, IdAsistencia);
            rs = ps.executeQuery();

            if (rs.next()) {
                Asistencia asistencia = new Asistencia();
                asistencia.setIdAsistencia(rs.getInt("IdAsistencia"));
                asistencia.setDniEmpleado(rs.getString("DniEmpleado"));
                asistencia.setFechaAsistencia(rs.getDate("FechaAsistencia"));
                asistencia.setHoraEntrada(rs.getTime("HoraEntrada").toLocalTime());
                asistencia.setHoraSalida(rs.getTime("HoraSalida").toLocalTime());
                asistencia.setEstadoAsistencia(rs.getString("EstadoAsistencia"));

                return asistencia;
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener la asistencia: " + e);
        }
        return null;
    }

    @Override
    public boolean eliminar(int IdAsistencia) {
         String sql = "UPDATE tb_asistencia SET EstadoAsistencia='Cancelada' WHERE IdAsistencia=?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, IdAsistencia);

            int filasAfectadas = ps.executeUpdate();

            if (filasAfectadas > 0) {
                System.out.println("Asistencia cancelada correctamente.");
                return true;
            } else {
                System.out.println("No se pudo cancelar la asistencia.");
            }
        } catch (SQLException e) {
            System.out.println("Error al cancelar la asistencia: " + e);
        }
        return false;
    }
    
    
    public String obtenerNombrePorDNI(String dni) {
        String sql = "SELECT Nombre, Apellido FROM tb_empleado WHERE DniEmpleado = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, dni);
            rs = ps.executeQuery();
            if (rs.next()) {
                String nombre = rs.getString("Nombre");
                String apellido = rs.getString("Apellido");
                return nombre + " " + apellido;
            }
        } catch (SQLException e) {
        }
        return null;
    }
    
    public int obtenerIdAreaPorEmpleado(String dniEmpleado) {
        String sql = "SELECT IdArea FROM tb_empleado WHERE DniEmpleado = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, dniEmpleado);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("IdArea");
            }
        } catch (SQLException e) {
        }
        return -1;
    }
    
    
    
    public int contarAsistencias() {
        int cantidad = 0;
        String query = "SELECT COUNT(*) AS total FROM Tb_Asistencia";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            if (rs.next()) {
                cantidad = rs.getInt("total");
            }

        } catch (SQLException e) {
        }

        return cantidad;
    }

    
    public LocalTime obtenerHoraEntradaPorArea(String dniEmpleado) {
        String sql = "SELECT h.HoraEntrada FROM tb_empleado e " +
                     "JOIN tb_area a ON e.IdArea = a.IdArea " +
                     "JOIN tb_horario h ON a.IdHorario = h.IdHorario " +
                     "WHERE e.DniEmpleado = ?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, dniEmpleado);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Obtener la hora de entrada del horario
                return rs.getTime("HoraEntrada").toLocalTime();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;  // Retorna null si no se encuentra la hora de entrada
    }
    
    public boolean marcarEntrada(Asistencia asistencia, LocalTime horario) {
        String sqlSelect = "SELECT COUNT(*) FROM tb_asistencia WHERE DniEmpleado = ? AND FechaAsistencia = ?";
        String sqlInsert = "INSERT INTO tb_asistencia (DniEmpleado, FechaAsistencia, HoraEntrada, EstadoAsistencia) VALUES (?, ?, ?, ?)";
        String sqlTardanza = "INSERT INTO tb_tardanza (IdAsistencia, MinutosTardanza) VALUES (?, ?)";

        try {
            con = cn.getConnection();

            // Verificar si ya hay una entrada registrada para el empleado en la fecha dada
            ps = con.prepareStatement(sqlSelect);
            ps.setString(1, asistencia.getDniEmpleado());
            ps.setDate(2, (java.sql.Date) asistencia.getFechaAsistencia());
            rs = ps.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                // Ya hay una entrada registrada, no se puede marcar entrada nuevamente
                return false;
            }

            int idAsistenciaGenerado = insertarNuevaAsistencia(asistencia, sqlInsert);

            if (idAsistenciaGenerado != -1) {
                // Calcular la tardanza y agregar registro en tb_tardanza si llega tarde
                long minutosTardanza = calcularTardanza(asistencia, horario, idAsistenciaGenerado, sqlTardanza);

                if (minutosTardanza > 0) {
                    // Si hay tardanza, agregar registro en tb_tardanza
                    System.out.println("Entrada marcada correctamente. Tardanza: " + minutosTardanza + " minutos");
                } else {
                    System.out.println("Entrada marcada correctamente. Sin tardanza.");
                }

                return true;
            } else {
                System.out.println("No se pudo insertar la asistencia.");
            }
        } catch (SQLException e) {
            // Maneja la excepción aquí, puedes imprimir el mensaje o mostrar un JOptionPane
            System.out.println("Error al ejecutar consulta SQL: " + e.getMessage());
        } 
        return false;
    }

    private int insertarNuevaAsistencia(Asistencia asistencia, String sqlInsert) throws SQLException {
        // No hay entrada registrada, proceder con la inserción
        ps = con.prepareStatement(sqlInsert, Statement.RETURN_GENERATED_KEYS);
        ps.setString(1, asistencia.getDniEmpleado());
        ps.setDate(2, (java.sql.Date) asistencia.getFechaAsistencia());
        ps.setTime(3, Time.valueOf(asistencia.getHoraEntrada()));
        ps.setString(4, "Marco Entrada");

        int filasAfectadas = ps.executeUpdate();

        if (filasAfectadas > 0) {
            // Obtener el ID generado para la nueva asistencia
            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            }
        }

        return -1; // Retorna -1 si no se pudo insertar la asistencia
    }

    private long calcularTardanza(Asistencia asistencia, LocalTime horario, int idAsistenciaGenerado, String sqlTardanza) throws SQLException {
        if (horario != null) {
            LocalTime horaEntradaHorario = horario;
            LocalTime horaEntradaEmpleado = asistencia.getHoraEntrada();

            // Calcular la diferencia en minutos
            long minutosTardanza = ChronoUnit.MINUTES.between(horaEntradaHorario, horaEntradaEmpleado);

            if (minutosTardanza > 0) {
                // Si hay tardanza, agregar registro en tb_tardanza
                ps = con.prepareStatement(sqlTardanza);
                ps.setInt(1, idAsistenciaGenerado);
                ps.setInt(2, (int) minutosTardanza);
                int filasAfectadasTardanza = ps.executeUpdate();

                if (filasAfectadasTardanza > 0) {
                    System.out.println("Tardanza insertada correctamente.");
                } else {
                    System.out.println("No se pudo insertar la tardanza.");
                }

                return minutosTardanza;
            }
        }

        return 0; // Retorna 0 si no hay tardanza
    }
    
    public boolean marcarSalida(Asistencia asistencia) {
        String sqlSelect = "SELECT COUNT(*) FROM tb_asistencia WHERE DniEmpleado = ? AND FechaAsistencia = ?";
        String sqlUpdate = "UPDATE tb_asistencia SET HoraSalida = ?, EstadoAsistencia = ? WHERE DniEmpleado = ? AND FechaAsistencia = ?";

        try {
            con = cn.getConnection();

            // Verificar si ya hay una entrada registrada para el empleado en la fecha dada
            ps = con.prepareStatement(sqlSelect);
            ps.setString(1, asistencia.getDniEmpleado());
            ps.setDate(2, (java.sql.Date) asistencia.getFechaAsistencia());
            ResultSet rs = ps.executeQuery();

            if (!rs.next() || rs.getInt(1) == 0) {
                // No hay entrada registrada, no se puede marcar salida
                return false;
            }

            // Si hay entrada registrada, proceder con la actualización de salida
            ps = con.prepareStatement(sqlUpdate);
            ps.setTime(1, Time.valueOf(LocalTime.now()));
            ps.setString(2, "Asistencia Completa");
            ps.setString(3, asistencia.getDniEmpleado());
            ps.setDate(4, (java.sql.Date) asistencia.getFechaAsistencia());

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();  // Manejo básico de la excepción (imprimir el stack trace)
        } finally {
            // Cierra los recursos (ResultSet, PreparedStatement y Connection) en el bloque finally
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return false;
    }
    
}
