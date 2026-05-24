package controller.customer;

import dal.SachDAO;
import model.Sach;
import model.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "CustomerAddToCartServlet", urlPatterns = {"/CustomerAddToCartServlet"})
public class CustomerAddToCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = 1;
            String qStr = request.getParameter("quantity");
            if (qStr != null && !qStr.isEmpty()) {
                quantity = Integer.parseInt(qStr);
            }

            HttpSession session = request.getSession();
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new HashMap<>();
            }

            ArrayList<Sach> sList = SachDAO.findByMaSach(id);
            if (!sList.isEmpty()) {
                Sach s = sList.get(0);
                CartItem item = cart.get(id);
                if (item == null) {
                    item = new CartItem(s, quantity);
                    cart.put(id, item);
                } else {
                    item.setQuantity(item.getQuantity() + quantity);
                }

                int cartSize = 0;
                for (CartItem ci : cart.values()) {
                    cartSize += ci.getQuantity();
                }
                session.setAttribute("cart", cart);
                session.setAttribute("cartSize", cartSize);

                if ("true".equals(request.getParameter("ajax"))) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\":true,\"cartSize\":" + cartSize + "}");
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
