import model.ConnectDB;
import java.sql.*;

public class ShowDB {
    public static void main(String[] args) {
        try (Connection conn = ConnectDB.getConnecttion()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SHOW COLUMNS FROM sach");
            while (rs.next()) {
                System.out.println(rs.getString("Field") + " - " + rs.getString("Type"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
