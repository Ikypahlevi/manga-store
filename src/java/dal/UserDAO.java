package dal;

import model.User;
import model.ConnectDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    
    public static String hashPassword(String password) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes(java.nio.charset.StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder(2 * hash.length);
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static User checkLogin(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username = ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, username);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("password");
                    boolean isMatch = false;
                    boolean needsUpgrade = false;

                    String hashedPassword = hashPassword(password);

                    if (storedPassword.equals(hashedPassword)) {
                        isMatch = true;
                    } else if (storedPassword.equals(password)) { // Backward compatibility
                        isMatch = true;
                        needsUpgrade = true;
                    }

                    if (isMatch) {
                        User user = new User(
                            rs.getInt("id"),
                            rs.getString("username"),
                            storedPassword,
                            rs.getString("role"),
                            rs.getInt("manga_coin"),
                            rs.getString("rank_tier"),
                            rs.getString("avatar")
                        );

                        if (needsUpgrade) {
                            updatePassword(user.getId(), hashedPassword);
                            user.setPassword(hashedPassword);
                        }
                        
                        return user;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return null;
    }

    public static boolean updatePassword(int userId, String newHashedPassword) {
        String sql = "UPDATE Users SET password = ? WHERE id = ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newHashedPassword);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean register(String username, String password) {
        String sql = "INSERT INTO Users (username, password, role, manga_coin, rank_tier) VALUES (?, ?, 'CUSTOMER', 0, 'TÂN BINH')";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, hashPassword(password));
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
    
    public static boolean updateAvatar(int userId, String avatar) {
        String sql = "UPDATE Users SET avatar = ? WHERE id = ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, avatar);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static java.util.List<model.VipCustomer> getTopVipUsers() {
        java.util.List<model.VipCustomer> list = new java.util.ArrayList<>();
        String sql = "SELECT u.id, u.username, u.password, u.role, u.manga_coin, u.rank_tier, u.avatar, " +
                     "COALESCE(o_agg.total_spent, 0) as total_spent, " +
                     "COALESCE(od_agg.total_books, 0) as total_books " +
                     "FROM Users u " +
                     "JOIN (" +
                     "    SELECT user_id, SUM(total_amount) as total_spent " +
                     "    FROM orders WHERE status = 'COMPLETED' GROUP BY user_id" +
                     ") o_agg ON u.id = o_agg.user_id " +
                     "JOIN (" +
                     "    SELECT o.user_id, SUM(od.quantity) as total_books " +
                     "    FROM orders o JOIN order_details od ON o.id = od.order_id " +
                     "    WHERE o.status = 'COMPLETED' GROUP BY o.user_id" +
                     ") od_agg ON u.id = od_agg.user_id " +
                     "WHERE u.role != 'ADMIN' AND (o_agg.total_spent >= 1500000 OR od_agg.total_books >= 50) " +
                     "ORDER BY o_agg.total_spent DESC";
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
                    rs.getString("rank_tier"),
                    rs.getString("avatar")
                );
                list.add(new model.VipCustomer(u, rs.getDouble("total_spent"), rs.getInt("total_books")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
