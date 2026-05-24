package controller.customer;

import dal.ReviewDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CustomerAddReviewServlet", urlPatterns = {"/CustomerAddReviewServlet"})
public class CustomerAddReviewServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            out.print("{\"success\": false, \"message\": \"Vui lòng đăng nhập để đánh giá.\"}");
            return;
        }

        try {
            int maSach = Integer.parseInt(request.getParameter("id"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");

            if (rating < 1 || rating > 5) {
                out.print("{\"success\": false, \"message\": \"Đánh giá sao không hợp lệ.\"}");
                return;
            }

            boolean isAdded = ReviewDAO.addReview(maSach, user.getId(), rating, comment);

            if (isAdded) {
                out.print("{\"success\": true}");
            } else {
                out.print("{\"success\": false, \"message\": \"Có lỗi xảy ra khi lưu đánh giá.\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Lỗi hệ thống.\"}");
        }
    }
}
