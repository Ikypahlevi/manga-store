import model.ConnectDB;
import java.sql.*;

public class ShowDB {
    public static void main(String[] args) {
        try (Connection conn = ConnectDB.getConnecttion()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SHOW TABLES");
            while (rs.next()) {
                System.out.println(rs.getString(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
