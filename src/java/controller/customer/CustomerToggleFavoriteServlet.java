package controller.customer;

import dal.FavoriteDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CustomerToggleFavoriteServlet", urlPatterns = {"/CustomerToggleFavoriteServlet"})
public class CustomerToggleFavoriteServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            out.print("{\"success\": false, \"message\": \"Vui lòng đăng nhập để thả tim.\"}");
            return;
        }

        try {
            int maSach = Integer.parseInt(request.getParameter("id"));
            boolean isFavorite = FavoriteDAO.toggleFavorite(user.getId(), maSach);
            
            out.print("{\"success\": true, \"isFavorite\": " + isFavorite + "}");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Lỗi hệ thống.\"}");
        }
    }
}
