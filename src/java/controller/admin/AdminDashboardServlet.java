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

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/AdminDashboardServlet"})
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ArrayList<Sach> list = SachDAO.getAll();
            request.setAttribute("listSach", list);
            
            // Get monthly revenue
            java.util.Map<String, Double> revenueMap = dal.OrderDAO.getMonthlyRevenue();
            
            // Convert to JSON strings for Chart.js
            StringBuilder labels = new StringBuilder("[");
            StringBuilder data = new StringBuilder("[");
            boolean first = true;
            for (java.util.Map.Entry<String, Double> entry : revenueMap.entrySet()) {
                if (!first) {
                    labels.append(",");
                    data.append(",");
                }
                labels.append("'").append(entry.getKey()).append("'");
                data.append(entry.getValue());
                first = false;
            }
            labels.append("]");
            data.append("]");
            
            request.setAttribute("chartLabels", labels.toString());
            request.setAttribute("chartData", data.toString());
            
            // Get top selling books
            java.util.Map<String, Integer> topBooksMap = dal.OrderDAO.getTopSellingBooks();
            StringBuilder topLabels = new StringBuilder("[");
            StringBuilder topData = new StringBuilder("[");
            boolean firstTop = true;
            for (java.util.Map.Entry<String, Integer> entry : topBooksMap.entrySet()) {
                if (!firstTop) {
                    topLabels.append(",");
                    topData.append(",");
                }
                topLabels.append("'").append(entry.getKey().replace("'", "\\'")).append("'");
                topData.append(entry.getValue());
                firstTop = false;
            }
            topLabels.append("]");
            topData.append("]");
            
            request.setAttribute("topBooksLabels", topLabels.toString());
            request.setAttribute("topBooksData", topData.toString());
            
            request.setAttribute("view", "/WEB-INF/views/admin/dashboard.jsp");
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
