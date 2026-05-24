import model.ConnectDB;
import java.sql.*;

public class ShowDB {
    public static void main(String[] args) {
        try (Connection conn = ConnectDB.getConnecttion()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT ma_sach, ten_sach FROM sach");
            while (rs.next()) {
                System.out.println(rs.getInt("ma_sach") + " - " + rs.getString("ten_sach"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
