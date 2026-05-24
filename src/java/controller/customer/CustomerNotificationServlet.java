package controller.customer;

import dal.NotificationDAO;
import model.Notification;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "CustomerNotificationServlet", urlPatterns = {"/customer/notifications"})
public class CustomerNotificationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            out.print("{\"success\": false, \"message\": \"Chưa đăng nhập\"}");
            return;
        }
        
        String action = request.getParameter("action");
        NotificationDAO nDao = new NotificationDAO();
        
        if ("mark-read".equals(action)) {
            int notifId = Integer.parseInt(request.getParameter("id"));
            nDao.markAsRead(notifId);
            out.print("{\"success\": true}");
            return;
        }
        
        // Default: Get unread notifications
        List<Notification> unreadList = nDao.getUnreadNotifications(user.getId());
        StringBuilder json = new StringBuilder();
        json.append("{\"success\": true, \"notifications\": [");
        for (int i = 0; i < unreadList.size(); i++) {
            Notification n = unreadList.get(i);
            json.append("{")
                .append("\"id\":").append(n.getId()).append(",")
                .append("\"message\":\"").append(n.getMessage().replace("\"", "\\\"")).append("\"")
                .append("}");
            if (i < unreadList.size() - 1) {
                json.append(",");
            }
        }
        json.append("]}");
        out.print(json.toString());
    }
}
