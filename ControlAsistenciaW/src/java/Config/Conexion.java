package Config;
import java.sql.*;


public class Conexion {
    Connection con=null;
    public Conexion(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://161.132.55.120:3306/db_controlasistencia","Jorge","020815");
        } catch(ClassNotFoundException | SQLException e) {
            //System.out.println("error conexion"+e.getMessage());
        }   
    }
    public Connection getConnection(){
        return con;
    }
}
