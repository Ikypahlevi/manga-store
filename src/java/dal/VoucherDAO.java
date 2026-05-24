package dal;

import model.ConnectDB;
import model.Voucher;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class VoucherDAO {

    public static Voucher getVoucherByCode(String code) {
        String sql = "SELECT * FROM vouchers WHERE ma_voucher = ? AND is_active = TRUE";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, code.toUpperCase()); // Hỗ trợ nhập mã hoa/thường
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Voucher(
                            rs.getString("ma_voucher"),
                            rs.getInt("discount_percent"),
                            rs.getDouble("min_order_value"),
                            rs.getBoolean("is_active")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
