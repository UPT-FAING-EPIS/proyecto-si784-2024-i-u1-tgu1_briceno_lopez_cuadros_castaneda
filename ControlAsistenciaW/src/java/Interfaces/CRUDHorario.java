/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Interfaces;

/**
 *
 * @author Zero
 */

import java.util.List;
import Modelo.Horario;

public interface CRUDHorario {
    public List<Horario> listar();
    public Horario list(int idHorario);
    public boolean add(Horario horario);
    public boolean edit(Horario horario);
    public boolean eliminar(int idHorario);
}



