package model;
import java.sql.*;

public class ConnectDB {
    private static final String URL = "jdbc:mysql://localhost:3306/quan_ly_thu_vien";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static Connection getConnecttion() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Retrieve connection info from Environment Variables (for Render/Aiven deployment)
        String url = System.getenv("DB_URL");
        String user = System.getenv("DB_USER");
        String pass = System.getenv("DB_PASS");
        
        // Fallback to local config if environment variables are not set
        if (url == null || url.isEmpty()) {
            url = URL;
            user = USER;
            pass = PASSWORD;
        }
        
        return DriverManager.getConnection(url, user, pass);
    }
}
