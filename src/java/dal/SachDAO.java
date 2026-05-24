package dal;

import java.util.ArrayList;
import model.*;
import java.sql.*;

public class SachDAO {

    // Helper: tạo đối tượng Sach từ ResultSet (tránh lặp code)
    private static Sach mapRow(ResultSet rs) throws SQLException {
        return new Sach(
                rs.getInt("ma_sach"),
                rs.getString("ten_sach"),
                rs.getDouble("gia_tien"),
                rs.getInt("so_luong"),
                rs.getString("hinh_anh"),
                rs.getString("mo_ta"),
                rs.getString("trailer_url")
        );
    }

    public static ArrayList<Sach> getAll() throws ClassNotFoundException, SQLException {
        ArrayList<Sach> list = new ArrayList<>();
        String sql = "SELECT * FROM sach";
        try (Connection conn = ConnectDB.getConnecttion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public static ArrayList<Sach> findByMaSach(int masach) throws ClassNotFoundException, SQLException {
        ArrayList<Sach> list = new ArrayList<>();
        String sql = "SELECT * FROM sach WHERE ma_sach = ?";
        try (Connection conn = ConnectDB.getConnecttion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, masach);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }

    public static void Update(Sach s) throws ClassNotFoundException, SQLException {
        String sql = "UPDATE sach SET ten_sach = ?, gia_tien = ?, so_luong = ?, hinh_anh = ?, mo_ta = ?, trailer_url = ? WHERE ma_sach = ?";
        try (Connection conn = ConnectDB.getConnecttion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getTenSach());
            ps.setDouble(2, s.getGiaTien());
            ps.setInt(3, s.getSoLuong());
            ps.setString(4, s.getHinhAnh());
            ps.setString(5, s.getMoTa());
            ps.setString(6, s.getTrailerUrl());
            ps.setInt(7, s.getMaSach());
            ps.executeUpdate();
        }
    }

    public static void Insert(Sach s) throws ClassNotFoundException, SQLException {
        String sql = "INSERT INTO sach (ten_sach, gia_tien, so_luong, hinh_anh, mo_ta, trailer_url) VALUES (?,?,?,?,?,?)";
        try (Connection conn = ConnectDB.getConnecttion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getTenSach());
            ps.setDouble(2, s.getGiaTien());
            ps.setInt(3, s.getSoLuong());
            ps.setString(4, s.getHinhAnh());
            ps.setString(5, s.getMoTa());
            ps.setString(6, s.getTrailerUrl());
            ps.executeUpdate();
        }
    }

    public static void Delete(int masach) throws ClassNotFoundException, SQLException {
        String sql = "DELETE FROM sach WHERE ma_sach = ?";
        try (Connection conn = ConnectDB.getConnecttion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, masach);
            ps.executeUpdate();
        }
    }

    public static int getTotalSach(Double minPrice, Double maxPrice, String keyword) throws ClassNotFoundException, SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM sach WHERE 1=1");
        if (minPrice != null) sql.append(" AND gia_tien >= ?");
        if (maxPrice != null) sql.append(" AND gia_tien <= ?");
        if (keyword != null && !keyword.trim().isEmpty()) sql.append(" AND ten_sach LIKE ?");
        
        try (Connection conn = ConnectDB.getConnecttion();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            int index = 1;
            if (minPrice != null) ps.setDouble(index++, minPrice);
            if (maxPrice != null) ps.setDouble(index++, maxPrice);
            if (keyword != null && !keyword.trim().isEmpty()) ps.setString(index++, "%" + keyword + "%");
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public static ArrayList<Sach> getSachByPage(int offset, int limit, Double minPrice, Double maxPrice, String keyword) throws ClassNotFoundException, SQLException {
        ArrayList<Sach> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM sach WHERE 1=1");
        if (minPrice != null) sql.append(" AND gia_tien >= ?");
        if (maxPrice != null) sql.append(" AND gia_tien <= ?");
        if (keyword != null && !keyword.trim().isEmpty()) sql.append(" AND ten_sach LIKE ?");
        sql.append(" LIMIT ?, ?");
        
        try (Connection conn = ConnectDB.getConnecttion();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            int index = 1;
            if (minPrice != null) ps.setDouble(index++, minPrice);
            if (maxPrice != null) ps.setDouble(index++, maxPrice);
            if (keyword != null && !keyword.trim().isEmpty()) ps.setString(index++, "%" + keyword + "%");
            ps.setInt(index++, offset);
            ps.setInt(index++, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }
    public static ArrayList<Sach> getRelatedSach(int excludeMaSach, int limit) throws ClassNotFoundException, SQLException {
        ArrayList<Sach> list = new ArrayList<>();
        String sql = "SELECT * FROM sach WHERE ma_sach != ? ORDER BY RAND() LIMIT ?";
        try (Connection conn = ConnectDB.getConnecttion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, excludeMaSach);
            ps.setInt(2, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }
}
