package Modelo;

import java.sql.Date;

/**
 *
 * @author JORGE
 */
public class Reporte {
    private int idReporte;
    private Date FechaInicio;
    private Date FechaFin;
    private String NombreArea;
    private int totalAsistencias;
    private int totalTardanzas;
    private int totalFaltas;

    public Reporte() {
    }

    public Reporte(int idReporte, Date FechaInicio, Date FechaFin, String NombreArea, int totalAsistencias, int totalTardanzas, int totalFaltas) {
        this.idReporte = idReporte;
        this.FechaInicio = FechaInicio;
        this.FechaFin = FechaFin;
        this.NombreArea = NombreArea;
        this.totalAsistencias = totalAsistencias;
        this.totalTardanzas = totalTardanzas;
        this.totalFaltas = totalFaltas;
    }

    public int getIdReporte() {
        return idReporte;
    }

    public void setIdReporte(int idReporte) {
        this.idReporte = idReporte;
    }

    public Date getFechaInicio() {
        return FechaInicio;
    }

    public void setFechaInicio(Date FechaInicio) {
        this.FechaInicio = FechaInicio;
    }

    public Date getFechaFin() {
        return FechaFin;
    }

    public void setFechaFin(Date FechaFin) {
        this.FechaFin = FechaFin;
    }

    public String getNombreArea() {
        return NombreArea;
    }

    public void setNombreArea(String NombreArea) {
        this.NombreArea = NombreArea;
    }

    public int getTotalAsistencias() {
        return totalAsistencias;
    }

    public void setTotalAsistencias(int totalAsistencias) {
        this.totalAsistencias = totalAsistencias;
    }

    public int getTotalTardanzas() {
        return totalTardanzas;
    }

    public void setTotalTardanzas(int totalTardanzas) {
        this.totalTardanzas = totalTardanzas;
    }

    public int getTotalFaltas() {
        return totalFaltas;
    }

    public void setTotalFaltas(int totalFaltas) {
        this.totalFaltas = totalFaltas;
    }
}