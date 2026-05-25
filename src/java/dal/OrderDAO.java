package dal;

import model.CartItem;
import model.ConnectDB;
import model.Order;
import model.OrderDetail;
import model.Sach;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class OrderDAO {

    public static boolean placeOrder(Order order, Map<Integer, CartItem> cart) {
        String insertOrderSql = "INSERT INTO orders (user_id, customer_name, customer_phone, customer_address, total_amount, status, voucher_code, discount_amount) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        String insertDetailSql = "INSERT INTO order_details (order_id, ma_sach, quantity, price) VALUES (?, ?, ?, ?)";
        String updateStockSql = "UPDATE sach SET so_luong = so_luong - ? WHERE ma_sach = ?";

        Connection con = null;
        try {
            con = ConnectDB.getConnecttion();
            con.setAutoCommit(false); // Bắt đầu Transaction

            // 1. Insert Order
            PreparedStatement psOrder = con.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, order.getUserId());
            psOrder.setString(2, order.getCustomerName());
            psOrder.setString(3, order.getCustomerPhone());
            psOrder.setString(4, order.getCustomerAddress());
            psOrder.setDouble(5, order.getTotalAmount());
            psOrder.setString(6, "PENDING");
            psOrder.setString(7, order.getVoucherCode());
            psOrder.setDouble(8, order.getDiscountAmount());
            psOrder.executeUpdate();

            // Lấy ID đơn hàng vừa tạo
            ResultSet rsKeys = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rsKeys.next()) {
                orderId = rsKeys.getInt(1);
            }

            // 2. Insert Order Details & Cập nhật số lượng kho
            PreparedStatement psDetail = con.prepareStatement(insertDetailSql);
            PreparedStatement psStock = con.prepareStatement(updateStockSql);

            for (CartItem item : cart.values()) {
                int maSach = item.getSach().getMaSach();
                int qty = item.getQuantity();

                psDetail.setInt(1, orderId);
                psDetail.setInt(2, maSach);
                psDetail.setInt(3, qty);
                psDetail.setDouble(4, item.getSach().getGiaTien());
                psDetail.addBatch();

                psStock.setInt(1, qty);
                psStock.setInt(2, maSach);
                psStock.addBatch();
            }

            psDetail.executeBatch();
            psStock.executeBatch();

            con.commit(); // Hoàn tất Transaction
            return true;

        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback(); // Nếu có lỗi thì hoàn tác toàn bộ!
                } catch (Exception ex) {}
            }
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (Exception e) {}
            }
        }
        return false;
    }

    public static List<Order> getOrdersByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Order(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("customer_name"),
                        rs.getString("customer_phone"),
                        rs.getString("customer_address"),
                        rs.getDouble("total_amount"),
                        rs.getTimestamp("order_date"),
                        rs.getString("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Order(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("customer_name"),
                        rs.getString("customer_phone"),
                        rs.getString("customer_address"),
                        rs.getDouble("total_amount"),
                        rs.getTimestamp("order_date"),
                        rs.getString("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<OrderDetail> getOrderDetails(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT od.*, s.ten_sach, s.hinh_anh FROM order_details od JOIN sach s ON od.ma_sach = s.ma_sach WHERE od.order_id = ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail detail = new OrderDetail(
                        rs.getInt("id"),
                        rs.getInt("order_id"),
                        rs.getInt("ma_sach"),
                        rs.getInt("quantity"),
                        rs.getDouble("price")
                );
                Sach s = new Sach();
                s.setTenSach(rs.getString("ten_sach"));
                s.setHinhAnh(rs.getString("hinh_anh"));
                detail.setSach(s);
                list.add(detail);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static int getUserIdByOrderId(int orderId) {
        String sql = "SELECT user_id FROM orders WHERE id = ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("user_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static java.util.Map<String, Double> getMonthlyRevenue() {
        java.util.Map<String, Double> map = new java.util.LinkedHashMap<>();
        // Khởi tạo 12 tháng với giá trị 0
        for (int i = 1; i <= 12; i++) {
            map.put("Tháng " + i, 0.0);
        }
        
        String sql = "SELECT MONTH(o.order_date) as m, SUM(o.total_amount) as total FROM orders o JOIN Users u ON o.user_id = u.id WHERE o.status = 'COMPLETED' AND YEAR(o.order_date) = YEAR(CURRENT_DATE) AND u.role != 'ADMIN' GROUP BY MONTH(o.order_date)";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int month = rs.getInt("m");
                double total = rs.getDouble("total");
                map.put("Tháng " + month, total);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    public static java.util.Map<String, Integer> getTopSellingBooks() {
        java.util.Map<String, Integer> map = new java.util.LinkedHashMap<>();
        String sql = "SELECT s.ten_sach, SUM(od.quantity) as total_qty " +
                     "FROM order_details od " +
                     "JOIN sach s ON od.ma_sach = s.ma_sach " +
                     "JOIN orders o ON od.order_id = o.id " +
                     "JOIN Users u ON o.user_id = u.id " +
                     "WHERE o.status = 'COMPLETED' AND u.role != 'ADMIN' " +
                     "GROUP BY s.ten_sach " +
                     "ORDER BY total_qty DESC " +
                     "LIMIT 5";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("ten_sach"), rs.getInt("total_qty"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
}
