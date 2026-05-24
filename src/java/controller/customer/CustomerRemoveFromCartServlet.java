package controller.customer;

import model.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "CustomerRemoveFromCartServlet", urlPatterns = {"/CustomerRemoveFromCartServlet"})
public class CustomerRemoveFromCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            HttpSession session = request.getSession();
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            if (cart != null) {
                cart.remove(id);

                int cartSize = 0;
                double totalCartAmount = 0.0;

                for (CartItem ci : cart.values()) {
                    cartSize += ci.getQuantity();
                    totalCartAmount += ci.getTotalPrice();
                }

                session.setAttribute("cart", cart);
                session.setAttribute("cartSize", cartSize);

                if ("true".equals(request.getParameter("ajax"))) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{"
                        + "\"success\":true,"
                        + "\"cartSize\":" + cartSize + ","
                        + "\"totalCartAmount\":" + totalCartAmount
                        + "}");
                    return;
                }
            }

            response.sendRedirect(request.getContextPath() + "/customer?action=cart");
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
