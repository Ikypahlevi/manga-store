<%@page import="java.sql.*"%>
<%@page import="model.ConnectDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Database Setup - Manga Store</title>
    <style>
        body { font-family: monospace; background: #222; color: #0f0; padding: 20px; }
        .success { color: #0f0; }
        .error { color: #f00; }
        .warning { color: #ff0; }
    </style>
</head>
<body>
    <h1>Manga Store - System Setup Tool</h1>
    <hr>
    <%
        Connection conn = null;
        Statement stmt = null;
        try {
            conn = ConnectDB.getConnecttion();
            stmt = conn.createStatement();
            
            out.println("<h3>[1] Đang khởi tạo bảng 'reviews'...</h3>");
            String sqlReviews = "CREATE TABLE IF NOT EXISTS reviews ("
                              + "ma_review INT AUTO_INCREMENT PRIMARY KEY, "
                              + "ma_sach INT NOT NULL, "
                              + "user_id INT NOT NULL, "
                              + "rating INT NOT NULL CHECK(rating >= 1 AND rating <= 5), "
                              + "comment TEXT, "
                              + "created_at DATETIME DEFAULT CURRENT_TIMESTAMP)";
            stmt.executeUpdate(sqlReviews);
            out.println("<p class='success'>=> OK! Bảng 'reviews' đã sẵn sàng.</p>");
            
            out.println("<h3>[2] Đang khởi tạo bảng 'vouchers'...</h3>");
            String sqlVouchers = "CREATE TABLE IF NOT EXISTS vouchers ("
                               + "ma_voucher VARCHAR(50) PRIMARY KEY, "
                               + "discount_percent INT NOT NULL, "
                               + "min_order_value DOUBLE NOT NULL, "
                               + "is_active BOOLEAN DEFAULT TRUE)";
            stmt.executeUpdate(sqlVouchers);
            
            // Insert sample voucher
            try {
                stmt.executeUpdate("INSERT INTO vouchers (ma_voucher, discount_percent, min_order_value, is_active) VALUES ('MANGA20', 20, 100000, 1)");
                out.println("<p class='success'>=> Đã thêm voucher mẫu: MANGA20 (Giảm 20%).</p>");
            } catch (SQLException e) {
                out.println("<p class='warning'>=> Voucher mẫu MANGA20 đã tồn tại.</p>");
            }
            
            out.println("<p class='success'>=> OK! Bảng 'vouchers' đã sẵn sàng.</p>");
            
            out.println("<h3>[3] Đang thêm cột cho bảng 'orders'...</h3>");
            try {
                stmt.executeUpdate("ALTER TABLE orders ADD COLUMN voucher_code VARCHAR(50) DEFAULT NULL");
                out.println("<p class='success'>=> Đã thêm cột 'voucher_code' vào bảng 'orders'.</p>");
            } catch (SQLException e) {
                out.println("<p class='warning'>=> Cột 'voucher_code' đã tồn tại (hoặc có lỗi: " + e.getMessage() + "). Bỏ qua.</p>");
            }
            
            try {
                stmt.executeUpdate("ALTER TABLE orders ADD COLUMN discount_amount DOUBLE DEFAULT 0");
                out.println("<p class='success'>=> Đã thêm cột 'discount_amount' vào bảng 'orders'.</p>");
            } catch (SQLException e) {
                out.println("<p class='warning'>=> Cột 'discount_amount' đã tồn tại (hoặc có lỗi: " + e.getMessage() + "). Bỏ qua.</p>");
            }
            
            out.println("<h3>[4] Đang thêm hạng thành viên & Manga Coin (Phase 2)...</h3>");
            try {
                stmt.executeUpdate("ALTER TABLE users ADD COLUMN manga_coin INT DEFAULT 0");
                out.println("<p class='success'>=> Đã thêm cột 'manga_coin' vào bảng 'users'.</p>");
            } catch (SQLException e) {
                out.println("<p class='warning'>=> Cột 'manga_coin' đã tồn tại (hoặc có lỗi). Bỏ qua.</p>");
            }
            try {
                stmt.executeUpdate("ALTER TABLE users ADD COLUMN rank_tier VARCHAR(50) DEFAULT 'TÂN BINH'");
                out.println("<p class='success'>=> Đã thêm cột 'rank_tier' vào bảng 'users'.</p>");
            } catch (SQLException e) {
                out.println("<p class='warning'>=> Cột 'rank_tier' đã tồn tại (hoặc có lỗi). Bỏ qua.</p>");
            }
            
            out.println("<h2>🎉 TẤT CẢ SETUP THÀNH CÔNG! BẠN CÓ THỂ QUAY LẠI ỨNG DỤNG.</h2>");
            
        } catch(Exception e) {
            out.println("<h2 class='error'>LỖI: " + e.getMessage() + "</h2>");
            e.printStackTrace();
        } finally {
            if(stmt != null) try { stmt.close(); } catch(Exception e){}
            if(conn != null) try { conn.close(); } catch(Exception e){}
        }
    %>
</body>
</html>
