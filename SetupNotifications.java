import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class SetupNotifications {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/quan_ly_thu_vien";
        String user = "root";
        String password = ""; 

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, user, password);
            Statement stmt = con.createStatement();
            
            String sql = "CREATE TABLE IF NOT EXISTS notifications ("
                       + "id INT AUTO_INCREMENT PRIMARY KEY, "
                       + "user_id INT, "
                       + "message VARCHAR(255) NOT NULL, "
                       + "is_read BOOLEAN DEFAULT FALSE, "
                       + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                       + "FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE"
                       + ")";
            stmt.executeUpdate(sql);
            System.out.println("Created table 'notifications' successfully.");
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
