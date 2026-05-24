package model;
import java.sql.Connection;
import java.sql.Statement;

public class UpdateDB {
    public static void main(String[] args) {
        try {
            Connection con = ConnectDB.getConnecttion();
            Statement stmt = con.createStatement();
            
            try {
                stmt.executeUpdate("ALTER TABLE users ADD COLUMN manga_coin INT DEFAULT 0");
                System.out.println("Added manga_coin");
            } catch (Exception e) {
                System.out.println("manga_coin exists");
            }
            try {
                stmt.executeUpdate("ALTER TABLE users ADD COLUMN rank_tier VARCHAR(50) DEFAULT 'TÂN BINH'");
                System.out.println("Added rank_tier");
            } catch (Exception e) {
                System.out.println("rank_tier exists");
            }
            
            stmt.close();
            con.close();
            System.out.println("DB Updated successfully.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
