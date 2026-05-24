package controller.customer;

import dal.OrderDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CustomerConfirmOrderServlet", urlPatterns = {"/CustomerConfirmOrderServlet"})
public class CustomerConfirmOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/auth?action=login");
                return;
            }

            int orderId = Integer.parseInt(request.getParameter("id"));
            int orderOwnerId = OrderDAO.getUserIdByOrderId(orderId);
            
            // Security check: Only the owner can confirm their order
            if (user.getId() == orderOwnerId) {
                OrderDAO.updateOrderStatus(orderId, "COMPLETED");
                request.getSession().setAttribute("message", "Xác nhận thành công! Chúc bạn đọc truyện vui vẻ!");
            } else {
                request.getSession().setAttribute("error", "Bạn không có quyền thực hiện hành động này!");
            }
            
            response.sendRedirect(request.getContextPath() + "/CustomerProfileServlet");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/CustomerProfileServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
