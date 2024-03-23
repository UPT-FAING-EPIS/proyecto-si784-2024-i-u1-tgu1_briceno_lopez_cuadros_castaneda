package Interfaces;

import Modelo.Asistencia;
import java.util.List;

/**
 *
 * @author JORGE
 */
public interface CRUDAsistencia {
    public List<Asistencia> listar();
    public Asistencia list(int IdAsistencia);
    public boolean eliminar(int IdAsistencia);
}
