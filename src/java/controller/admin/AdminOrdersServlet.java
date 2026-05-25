package controller.admin;

import dal.OrderDAO;
import model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AdminOrdersServlet", urlPatterns = {"/AdminOrdersServlet"})
public class AdminOrdersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String search = request.getParameter("search");
            String status = request.getParameter("status");
            
            java.util.List<Order> list;
            if ((search != null && !search.trim().isEmpty()) || (status != null && !status.trim().isEmpty())) {
                list = OrderDAO.searchOrders(search, status);
            } else {
                list = OrderDAO.getAllOrders();
            }
            
            request.setAttribute("listOrders", list);
            request.setAttribute("search", search);
            request.setAttribute("status", status);
            request.setAttribute("view", "/WEB-INF/views/admin/orders.jsp");
            request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
