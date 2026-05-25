package controller.admin;

import dal.ReviewDAO;
import model.Review;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminReviewsServlet", urlPatterns = {"/AdminReviewsServlet"})
public class AdminReviewsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        List<Review> pendingReviews = ReviewDAO.getAllPendingReviews();
        request.setAttribute("pendingReviews", pendingReviews);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/reviews.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        String subAction = request.getParameter("subAction");
        try {
            int reviewId = Integer.parseInt(request.getParameter("reviewId"));
            if ("approve".equals(subAction)) {
                ReviewDAO.approveReview(reviewId);
            } else if ("reject".equals(subAction)) {
                ReviewDAO.rejectReview(reviewId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=reviews");
    }
}
