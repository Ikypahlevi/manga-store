import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class DbSetup {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/quan_ly_thu_vien";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(url, "root", "")) {
                Statement stmt = con.createStatement();
                try {
                    stmt.executeUpdate("ALTER TABLE reviews ADD COLUMN is_approved INT DEFAULT 0");
                    System.out.println("Added column is_approved");
                } catch (Exception e) {
                    System.out.println("Column might already exist: " + e.getMessage());
                }
                stmt.executeUpdate("UPDATE reviews SET is_approved = 1");
                System.out.println("Updated existing reviews to approved");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
