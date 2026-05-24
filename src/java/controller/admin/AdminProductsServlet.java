package controller.admin;

import dal.SachDAO;
import model.Sach;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "AdminProductsServlet", urlPatterns = {"/AdminProductsServlet"})
public class AdminProductsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ArrayList<Sach> list = SachDAO.getAll();
            request.setAttribute("listSach", list);
            request.setAttribute("view", "/WEB-INF/views/admin/products.jsp");
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
