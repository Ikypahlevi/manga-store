import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class DbFavoriteSetup {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/quan_ly_thu_vien";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(url, "root", "")) {
                Statement stmt = con.createStatement();
                String createTable = "CREATE TABLE IF NOT EXISTS favorites ("
                    + "id INT AUTO_INCREMENT PRIMARY KEY, "
                    + "user_id INT NOT NULL, "
                    + "ma_sach INT NOT NULL, "
                    + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                    + "UNIQUE KEY(user_id, ma_sach)"
                    + ")";
                stmt.executeUpdate(createTable);
                System.out.println("Tạo bảng favorites thành công!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
