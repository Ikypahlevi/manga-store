package controller.admin;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AdminUpdateOrderStatusServlet", urlPatterns = {"/AdminUpdateOrderStatusServlet"})
public class AdminUpdateOrderStatusServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            boolean updated = OrderDAO.updateOrderStatus(orderId, status);
            
            if (updated) {
                int userId = OrderDAO.getUserIdByOrderId(orderId);
                if (userId > 0) {
                    dal.NotificationDAO nDao = new dal.NotificationDAO();
                    String msg = "";
                    if ("APPROVED".equals(status)) msg = "🎉 Đơn hàng #" + orderId + " của bạn đã được Admin phê duyệt!";
                    else if ("COMPLETED".equals(status)) msg = "📦 Đơn hàng #" + orderId + " đã giao thành công!";
                    else if ("CANCELLED".equals(status)) msg = "❌ Đơn hàng #" + orderId + " đã bị hủy.";
                    
                    if (!msg.isEmpty()) {
                        nDao.addNotification(userId, msg);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=orders");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
