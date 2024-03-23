package Modelo;

/**
 *
 * @author JORGE
 */
public class Area {
    public int IdArea;
    public String NombreHorario;
    public String NombreArea;
    public String Descripcion;

    public Area() {
    }

    public Area(int IdArea, String NombreHorario, String NombreArea, String Descripcion) {
        this.IdArea = IdArea;
        this.NombreHorario = NombreHorario;
        this.NombreArea = NombreArea;
        this.Descripcion = Descripcion;
    }

    public int getIdArea() {
        return IdArea;
    }

    public void setIdArea(int IdArea) {
        this.IdArea = IdArea;
    }

    public String getNombreHorario() {
        return NombreHorario;
    }

    public void setNombreHorario(String NombreHorario) {
        this.NombreHorario = NombreHorario;
    }

    public String getNombreArea() {
        return NombreArea;
    }

    public void setNombreArea(String NombreArea) {
        this.NombreArea = NombreArea;
    }

    public String getDescripcion() {
        return Descripcion;
    }

    public void setDescripcion(String Descripcion) {
        this.Descripcion = Descripcion;
    }
}
