package dal;

import model.Notification;
import model.ConnectDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {
    
    public void addNotification(int userId, String message) {
        String sql = "INSERT INTO notifications (user_id, message) VALUES (?, ?)";
        try (Connection connection = ConnectDB.getConnecttion();
             PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            st.setString(2, message);
            st.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public List<Notification> getUnreadNotifications(int userId) {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM notifications WHERE user_id = ? AND is_read = FALSE ORDER BY created_at DESC";
        try (Connection connection = ConnectDB.getConnecttion();
             PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Notification(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("message"),
                    rs.getBoolean("is_read"),
                    rs.getTimestamp("created_at")
                ));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public void markAsRead(int notificationId) {
        String sql = "UPDATE notifications SET is_read = TRUE WHERE id = ?";
        try (Connection connection = ConnectDB.getConnecttion();
             PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, notificationId);
            st.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
