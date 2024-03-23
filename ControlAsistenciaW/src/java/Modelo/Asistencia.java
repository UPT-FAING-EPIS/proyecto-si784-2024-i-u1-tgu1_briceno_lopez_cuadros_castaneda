package Modelo;

import java.time.*;
import java.util.*;

/**
 *
 * @author JORGE
 */
public class Asistencia {
    private int idAsistencia;
    private String dniEmpleado;
    private Date fechaAsistencia;
    private LocalTime horaEntrada;
    private LocalTime horaSalida;
    private String estadoAsistencia;

    public Asistencia() {
    }

    public Asistencia(int idAsistencia, String dniEmpleado, Date fechaAsistencia, LocalTime horaEntrada, LocalTime horaSalida, String estadoAsistencia) {
        this.idAsistencia = idAsistencia;
        this.dniEmpleado = dniEmpleado;
        this.fechaAsistencia = fechaAsistencia;
        this.horaEntrada = horaEntrada;
        this.horaSalida = horaSalida;
        this.estadoAsistencia = estadoAsistencia;
    }

    public int getIdAsistencia() {
        return idAsistencia;
    }

    public void setIdAsistencia(int idAsistencia) {
        this.idAsistencia = idAsistencia;
    }

    public String getDniEmpleado() {
        return dniEmpleado;
    }

    public void setDniEmpleado(String dniEmpleado) {
        this.dniEmpleado = dniEmpleado;
    }

    public Date getFechaAsistencia() {
        return fechaAsistencia;
    }

    public void setFechaAsistencia(Date fechaAsistencia) {
        this.fechaAsistencia = fechaAsistencia;
    }

    public LocalTime getHoraEntrada() {
        return horaEntrada;
    }

    public void setHoraEntrada(LocalTime horaEntrada) {
        this.horaEntrada = horaEntrada;
    }

    public LocalTime getHoraSalida() {
        return horaSalida;
    }

    public void setHoraSalida(LocalTime horaSalida) {
        this.horaSalida = horaSalida;
    }

    public String getEstadoAsistencia() {
        return estadoAsistencia;
    }

    public void setEstadoAsistencia(String estadoAsistencia) {
        this.estadoAsistencia = estadoAsistencia;
    }
}
