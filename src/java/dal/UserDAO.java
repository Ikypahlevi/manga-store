package dal;

import model.User;
import model.ConnectDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    
    public static User checkLogin(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getInt("manga_coin"),
                        rs.getString("rank_tier")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return null;
    }

    public static boolean register(String username, String password) {
        String sql = "INSERT INTO Users (username, password, role, manga_coin, rank_tier) VALUES (?, ?, 'CUSTOMER', 0, 'TÂN BINH')";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static boolean isUsernameExists(String username) {
        String sql = "SELECT 1 FROM Users WHERE username = ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static boolean updateCoinAndRank(int userId, int newCoins, String newRank) {
        String sql = "UPDATE Users SET manga_coin = ?, rank_tier = ? WHERE id = ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, newCoins);
            ps.setString(2, newRank);
            ps.setInt(3, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static java.util.List<model.VipCustomer> getTopVipUsers() {
        java.util.List<model.VipCustomer> list = new java.util.ArrayList<>();
        String sql = "SELECT u.id, u.username, u.password, u.role, u.manga_coin, u.rank_tier, SUM(o.total_amount) as total_spent " +
                     "FROM Users u " +
                     "JOIN orders o ON u.id = o.user_id " +
                     "WHERE o.status = 'COMPLETED' " +
                     "GROUP BY u.id " +
                     "ORDER BY total_spent DESC";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                model.User u = new model.User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("role"),
                    rs.getInt("manga_coin"),
                    rs.getString("rank_tier")
                );
                list.add(new model.VipCustomer(u, rs.getDouble("total_spent")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
