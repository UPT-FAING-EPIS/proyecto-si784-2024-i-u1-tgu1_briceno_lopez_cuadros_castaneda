package Interfaces;

import java.util.List;
import Modelo.Empleado;

public interface CRUDEmpleado {
    public List<Empleado> listar();
    public Empleado list(String dniEmpleado);
    public boolean add(Empleado empleado);
    public boolean edit(Empleado empleado);
    public boolean eliminar(String dniEmpleado);
}
