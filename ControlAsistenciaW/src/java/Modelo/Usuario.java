package Modelo;


public class Usuario {
    private int IdUsuario;
    private String Nombre;
    private String Clave;
    private String Nivel;

    public Usuario() {
    }
    

    public Usuario(int IdUsuario, String Nombre, String Clave, String Nivel) {
        this.IdUsuario = IdUsuario;
        this.Nombre = Nombre;
        this.Clave = Clave;
        this.Nivel = Nivel;
    }

    public int getIdUsuario() {
        return IdUsuario;
    }

    public void setIdUsuario(int IdUsuario) {
        this.IdUsuario = IdUsuario;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public String getClave() {
        return Clave;
    }

    public void setClave(String Clave) {
        this.Clave = Clave;
    }

    public String getNivel() {
        return Nivel;
    }

    public void setNivel(String Nivel) {
        this.Nivel = Nivel;
    }
    
    
}
