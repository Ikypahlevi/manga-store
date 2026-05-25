package dal;

import model.ConnectDB;
import model.Sach;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FavoriteDAO {

    public static boolean isFavorite(int userId, int maSach) {
        String sql = "SELECT id FROM favorites WHERE user_id = ? AND ma_sach = ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, maSach);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean toggleFavorite(int userId, int maSach) {
        if (isFavorite(userId, maSach)) {
            // Xóa đi nếu đã thả tim
            String sql = "DELETE FROM favorites WHERE user_id = ? AND ma_sach = ?";
            try (Connection con = ConnectDB.getConnecttion();
                 PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, userId);
                ps.setInt(2, maSach);
                ps.executeUpdate();
                return false; // Trả về false nghĩa là đã un-favorite
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // Thêm vào nếu chưa thả tim
            String sql = "INSERT INTO favorites (user_id, ma_sach) VALUES (?, ?)";
            try (Connection con = ConnectDB.getConnecttion();
                 PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, userId);
                ps.setInt(2, maSach);
                ps.executeUpdate();
                return true; // Trả về true nghĩa là đã favorite
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public static List<Sach> getUserFavorites(int userId) {
        List<Sach> list = new ArrayList<>();
        String sql = "SELECT s.* FROM favorites f JOIN Sach s ON f.ma_sach = s.ma_sach WHERE f.user_id = ? ORDER BY f.created_at DESC";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Sach s = new Sach(
                            rs.getInt("ma_sach"),
                            rs.getString("ten_sach"),
                            rs.getDouble("gia_tien"),
                            rs.getInt("so_luong"),
                            rs.getString("hinh_anh"),
                            rs.getString("mo_ta")
                    );
                    list.add(s);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static Map<String, Integer> getTopFavorites() {
        Map<String, Integer> map = new HashMap<>();
        String sql = "SELECT s.ten_sach, COUNT(f.id) as total_fav " +
                     "FROM favorites f JOIN Sach s ON f.ma_sach = s.ma_sach " +
                     "GROUP BY f.ma_sach, s.ten_sach " +
                     "ORDER BY total_fav DESC LIMIT 5";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("ten_sach"), rs.getInt("total_fav"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
}
