package dal;

import model.ConnectDB;
import model.Review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    public static List<Review> getReviewsBySachId(int maSach) {
        List<Review> list = new ArrayList<>();
        // JOIN với bảng Users để lấy username
        String sql = "SELECT r.*, u.username FROM reviews r " +
                     "JOIN Users u ON r.user_id = u.id " +
                     "WHERE r.ma_sach = ? AND r.is_approved = 1 ORDER BY r.created_at DESC";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, maSach);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review rv = new Review(
                            rs.getInt("ma_review"),
                            rs.getInt("ma_sach"),
                            rs.getInt("user_id"),
                            rs.getString("username"),
                            rs.getInt("rating"),
                            rs.getString("comment"),
                            rs.getTimestamp("created_at"),
                            rs.getInt("is_approved")
                    );
                    list.add(rv);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static boolean addReview(int maSach, int userId, int rating, String comment) {
        String sql = "INSERT INTO reviews (ma_sach, user_id, rating, comment) VALUES (?, ?, ?, ?)";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, maSach);
            ps.setInt(2, userId);
            ps.setInt(3, rating);
            ps.setString(4, comment);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static List<Review> getAllPendingReviews() {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.*, u.username FROM reviews r " +
                     "JOIN Users u ON r.user_id = u.id " +
                     "WHERE r.is_approved = 0 ORDER BY r.created_at DESC";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Review rv = new Review(
                        rs.getInt("ma_review"),
                        rs.getInt("ma_sach"),
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getInt("rating"),
                        rs.getString("comment"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("is_approved")
                );
                list.add(rv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static boolean approveReview(int reviewId) {
        String sql = "UPDATE reviews SET is_approved = 1 WHERE ma_review = ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, reviewId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean rejectReview(int reviewId) {
        String sql = "DELETE FROM reviews WHERE ma_review = ?";
        try (Connection con = ConnectDB.getConnecttion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, reviewId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
