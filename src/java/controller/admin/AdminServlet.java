package controller.admin;

import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AdminServlet", urlPatterns = {"/admin"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // 1. Kiểm tra phân quyền truy cập Admin
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "dashboard";

        try {
            // Fetch Top 5 Books for the Admin Sidebar globally
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

            switch (action) {
                case "dashboard":
                    request.getRequestDispatcher("/AdminDashboardServlet").forward(request, response);
                    break;
                case "products":
                    request.getRequestDispatcher("/AdminProductsServlet").forward(request, response);
                    break;
                case "vip":
                    request.getRequestDispatcher("/AdminVipServlet").forward(request, response);
                    break;
                case "add":
                    request.getRequestDispatcher("/AdminAddServlet").forward(request, response);
                    break;
                case "edit":
                    request.getRequestDispatcher("/AdminEditServlet").forward(request, response);
                    break;
                case "delete":
                    request.getRequestDispatcher("/AdminDeleteServlet").forward(request, response);
                    break;
                case "orders":
                    request.getRequestDispatcher("/AdminOrdersServlet").forward(request, response);
                    break;
                case "update-order-status":
                    request.getRequestDispatcher("/AdminUpdateOrderStatusServlet").forward(request, response);
                    break;
                case "reviews":
                    request.getRequestDispatcher("/AdminReviewsServlet").forward(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // 1. Kiểm tra phân quyền truy cập Admin
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                request.getRequestDispatcher("/AdminAddServlet").forward(request, response);
            } else if ("update".equals(action)) {
                request.getRequestDispatcher("/AdminEditServlet").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin");
        }
    }
}
