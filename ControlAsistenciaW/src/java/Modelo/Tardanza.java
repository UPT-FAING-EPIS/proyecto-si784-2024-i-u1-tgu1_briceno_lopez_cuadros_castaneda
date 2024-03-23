package Modelo;

/**
 *
 * @author JORGE
 */
public class Tardanza {
    
    private int IdTardanza;
    private int IdAsistencia;
    private int MinutosTardanza;

    public Tardanza() {
    }

    public Tardanza(int IdTardanza, int IdAsistencia, int MinutosTardanza) {
        this.IdTardanza = IdTardanza;
        this.IdAsistencia = IdAsistencia;
        this.MinutosTardanza = MinutosTardanza;
    }

    public int getIdTardanza() {
        return IdTardanza;
    }

    public void setIdTardanza(int IdTardanza) {
        this.IdTardanza = IdTardanza;
    }

    public int getIdAsistencia() {
        return IdAsistencia;
    }

    public void setIdAsistencia(int IdAsistencia) {
        this.IdAsistencia = IdAsistencia;
    }

    public int getMinutosTardanza() {
        return MinutosTardanza;
    }

    public void setMinutosTardanza(int MinutosTardanza) {
        this.MinutosTardanza = MinutosTardanza;
    }
}
