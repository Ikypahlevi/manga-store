package controller.admin;

import dal.UserDAO;
import model.VipCustomer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminVipServlet", urlPatterns = {"/AdminVipServlet"})
public class AdminVipServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<VipCustomer> list = UserDAO.getTopVipUsers();
            request.setAttribute("listVip", list);
            request.setAttribute("view", "/WEB-INF/views/admin/vip.jsp");
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
