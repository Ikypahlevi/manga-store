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
    private static final int PAGE_SIZE = 8;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int currentPage = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageStr);
                } catch (Exception e) {
                    currentPage = 1;
                }
            }

            int totalRecords = SachDAO.getTotalSach(null, null, null, null);
            int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);
            if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
            }
            int offset = (currentPage - 1) * PAGE_SIZE;
            if (offset < 0) offset = 0;

            ArrayList<Sach> list = SachDAO.getSachByPage(offset, PAGE_SIZE, null, null, null, null);
            
            request.setAttribute("listSach", list);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
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
