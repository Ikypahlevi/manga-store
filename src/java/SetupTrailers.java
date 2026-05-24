import model.ConnectDB;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class SetupTrailers {
    public static void main(String[] args) {
        try (Connection conn = ConnectDB.getConnecttion()) {
            
            try {
                Statement stmt = conn.createStatement();
                stmt.execute("ALTER TABLE sach ADD COLUMN trailer_url VARCHAR(255) DEFAULT NULL");
                System.out.println("Column trailer_url added!");
            } catch (Exception e) {
                System.out.println("Column might already exist: " + e.getMessage());
            }

            Map<Integer, String> trailers = new HashMap<>();
            trailers.put(1, "https://www.youtube.com/embed/S8_YwFLCh4U");
            trailers.put(2, "https://www.youtube.com/embed/VQGCKyvzIM4");
            trailers.put(3, "https://www.youtube.com/embed/9Bv_3yG7Npk");
            trailers.put(4, "https://www.youtube.com/embed/qgqxVKZPjEI");
            trailers.put(5, "https://www.youtube.com/embed/kRkL1aA8tIE");
            trailers.put(6, "https://www.youtube.com/embed/uG6SGBh_91w");
            trailers.put(7, "https://www.youtube.com/embed/k-xItbTttFw");
            trailers.put(8, "https://www.youtube.com/embed/MGRm4IzK1SQ");
            // 9 Vô hạn Gacha - leave null
            trailers.put(10, "https://www.youtube.com/embed/pkOesXJrdnQ");
            trailers.put(11, "https://www.youtube.com/embed/aE1n_K6-X90");
            trailers.put(12, "https://www.youtube.com/embed/1v0pP4z4VvM");
            trailers.put(13, "https://www.youtube.com/embed/C8JlXCEJOtk");
            trailers.put(14, "https://www.youtube.com/embed/cMof_vS6F_8");
            trailers.put(15, "https://www.youtube.com/embed/Mf_x7ZkHl2M");
            trailers.put(16, "https://www.youtube.com/embed/P9HCHX-7r4Q");
            trailers.put(17, "https://www.youtube.com/embed/hD9lFzN8rB8");
            trailers.put(18, "https://www.youtube.com/embed/jG-yO1HkR2A");

            String sql = "UPDATE sach SET trailer_url = ? WHERE ma_sach = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            for (Map.Entry<Integer, String> entry : trailers.entrySet()) {
                ps.setString(1, entry.getValue());
                ps.setInt(2, entry.getKey());
                ps.addBatch();
            }
            
            ps.executeBatch();
            System.out.println("Trailers updated successfully!");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
