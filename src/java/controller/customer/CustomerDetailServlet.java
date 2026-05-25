package controller.customer;

import dal.SachDAO;
import model.Sach;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "CustomerDetailServlet", urlPatterns = {"/CustomerDetailServlet"})
public class CustomerDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int maSach = Integer.parseInt(request.getParameter("id"));
            ArrayList<Sach> list = SachDAO.findByMaSach(maSach);
            if (!list.isEmpty()) {
                request.setAttribute("sach", list.get(0));
                
                jakarta.servlet.http.HttpSession session = request.getSession();
                model.User user = (model.User) session.getAttribute("user");
                if (user != null) {
                    boolean isFav = dal.FavoriteDAO.isFavorite(user.getId(), maSach);
                    request.setAttribute("isFavorite", isFav);
                }

                ArrayList<Sach> relatedComics = SachDAO.getRelatedSach(maSach, 4);
                request.setAttribute("relatedComics", relatedComics);
                java.util.List<model.Review> reviews = dal.ReviewDAO.getReviewsBySachId(maSach);
                request.setAttribute("reviews", reviews);
                request.setAttribute("view", "/WEB-INF/views/customer/detail.jsp");
                request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/customer");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/customer");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
