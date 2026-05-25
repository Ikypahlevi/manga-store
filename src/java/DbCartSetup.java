import model.ConnectDB;
import java.sql.Connection;
import java.sql.Statement;

public class DbCartSetup {
    public static void main(String[] args) {
        String sql = "CREATE TABLE IF NOT EXISTS cart_items ("
                   + "id INT AUTO_INCREMENT PRIMARY KEY, "
                   + "user_id INT NOT NULL, "
                   + "ma_sach INT NOT NULL, "
                   + "quantity INT NOT NULL, "
                   + "FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE, "
                   + "FOREIGN KEY (ma_sach) REFERENCES sach(ma_sach) ON DELETE CASCADE, "
                   + "UNIQUE KEY (user_id, ma_sach)"
                   + ");";
                   
        try (Connection conn = ConnectDB.getConnecttion()) {
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            System.out.println("Bảng cart_items đã được tạo thành công!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
