/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Interfaces;

import Modelo.Area;
import java.util.List;

/**
 *
 * @author JORGE
 */
public interface CRUDArea {
    public List<Area> listar();
    public Area list(int IdArea);
    public boolean add(Area area);
    public boolean edit(Area area);
    public boolean eliminar(int IdArea);
}
