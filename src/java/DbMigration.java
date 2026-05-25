import java.sql.Connection;
import java.sql.Statement;
import model.ConnectDB;

public class DbMigration {
    public static void main(String[] args) {
        try (Connection con = ConnectDB.getConnecttion();
             Statement stmt = con.createStatement()) {
            
            String sql = "ALTER TABLE Users ADD COLUMN avatar VARCHAR(255)";
            stmt.executeUpdate(sql);
            System.out.println("Success: Added avatar column.");
            
        } catch (Exception e) {
            if (e.getMessage().contains("Duplicate column name")) {
                System.out.println("Column already exists!");
            } else {
                e.printStackTrace();
            }
        }
    }
}
