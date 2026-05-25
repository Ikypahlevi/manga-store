package controller.customer;

import dal.OrderDAO;
import model.Order;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CustomerProfileServlet", urlPatterns = {"/CustomerProfileServlet"})
public class CustomerProfileServlet extends HttpServlet {
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

            java.util.List<Order> listOrders = OrderDAO.getOrdersByUserId(user.getId());
            // Lấy chi tiết cho từng đơn hàng (để hiển thị thu gọn/mở rộng)
            for (Order order : listOrders) {
                order.setDetails(OrderDAO.getOrderDetails(order.getId()));
            }

            request.setAttribute("listOrders", listOrders);

            java.util.List<model.Sach> favList = dal.FavoriteDAO.getUserFavorites(user.getId());
            request.setAttribute("favList", favList);

            request.setAttribute("view", "/WEB-INF/views/customer/profile.jsp");
            request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/customer");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
