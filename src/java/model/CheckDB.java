package model;
import java.sql.*;

public class CheckDB {
    public static void main(String[] args) {
        try {
            Connection con = ConnectDB.getConnecttion();
            Statement stmt = con.createStatement();
            
            // Check order_details columns
            ResultSet rs = stmt.executeQuery("DESCRIBE order_details");
            System.out.println("--- order_details columns ---");
            while(rs.next()) {
                System.out.println(rs.getString("Field") + " - " + rs.getString("Type"));
            }
            
            // Update prices if needed
            int updated = stmt.executeUpdate("UPDATE order_details od JOIN sach s ON od.ma_sach = s.ma_sach SET od.price = s.gia_tien WHERE od.price IS NULL OR od.price = 0");
            System.out.println("Updated " + updated + " rows in order_details");
            
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
