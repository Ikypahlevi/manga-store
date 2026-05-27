package controller.customer;

import dal.SachDAO;
import model.Sach;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "CustomerHomeServlet", urlPatterns = {"/CustomerHomeServlet"})
public class CustomerHomeServlet extends HttpServlet {
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
            
            Double minPrice = null;
            String minPriceStr = request.getParameter("minPrice");
            if (minPriceStr != null && !minPriceStr.isEmpty()) {
                try {
                    minPrice = Double.parseDouble(minPriceStr);
                } catch (Exception e) {}
            }
            
            Double maxPrice = null;
            String maxPriceStr = request.getParameter("maxPrice");
            if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                try {
                    maxPrice = Double.parseDouble(maxPriceStr);
                } catch (Exception e) {}
            }
            
            String keyword = request.getParameter("keyword");
            String category = request.getParameter("category");
            if (category == null) category = "Tất cả";
            
            int totalRecords = SachDAO.getTotalSach(minPrice, maxPrice, keyword, category);
            int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);
            if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
            }
            int offset = (currentPage - 1) * PAGE_SIZE;
            if (offset < 0) offset = 0;
            
            ArrayList<Sach> list = SachDAO.getSachByPage(offset, PAGE_SIZE, minPrice, maxPrice, keyword, category);
            
            request.setAttribute("listSach", list);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("minPrice", minPrice);
            request.setAttribute("maxPrice", maxPrice);
            request.setAttribute("keyword", keyword);
            request.setAttribute("category", category);
            request.setAttribute("view", "/WEB-INF/views/customer/home.jsp");
            request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CustomerHomeServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CustomerHomeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
