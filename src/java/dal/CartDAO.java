package dal;

import model.CartItem;
import model.ConnectDB;
import model.Sach;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedHashMap;
import java.util.Map;

public class CartDAO {

    public static Map<Integer, CartItem> getCartByUserId(int userId) {
        Map<Integer, CartItem> cart = new LinkedHashMap<>();
        String sql = "SELECT c.ma_sach, c.quantity, s.ten_sach, s.gia_tien, s.so_luong as stock, s.hinh_anh " +
                     "FROM cart_items c " +
                     "JOIN sach s ON c.ma_sach = s.ma_sach " +
                     "WHERE c.user_id = ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Sach sach = new Sach();
                    sach.setMaSach(rs.getInt("ma_sach"));
                    sach.setTenSach(rs.getString("ten_sach"));
                    sach.setGiaTien(rs.getDouble("gia_tien"));
                    sach.setSoLuong(rs.getInt("stock"));
                    sach.setHinhAnh(rs.getString("hinh_anh"));

                    CartItem item = new CartItem(sach, rs.getInt("quantity"));
                    cart.put(sach.getMaSach(), item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cart;
    }

    public static boolean addToCart(int userId, int maSach, int quantity) {
        String sql = "INSERT INTO cart_items (user_id, ma_sach, quantity) VALUES (?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE quantity = quantity + ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, maSach);
            ps.setInt(3, quantity);
            ps.setInt(4, quantity);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean updateQuantity(int userId, int maSach, int quantity) {
        String sql = "UPDATE cart_items SET quantity = ? WHERE user_id = ? AND ma_sach = ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, userId);
            ps.setInt(3, maSach);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean removeFromCart(int userId, int maSach) {
        String sql = "DELETE FROM cart_items WHERE user_id = ? AND ma_sach = ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, maSach);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean clearCart(int userId) {
        String sql = "DELETE FROM cart_items WHERE user_id = ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
