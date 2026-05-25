package controller.auth;

import dal.UserDAO;
import model.User;
import model.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "AuthServlet", urlPatterns = {"/auth"})
public class AuthServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/customer");
            return;
        } else if ("register".equals(action)) {
            request.setAttribute("view", "/WEB-INF/views/auth/register.jsp");
            request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
            return;
        }
        
        // Mặc định là login
        request.setAttribute("view", "/WEB-INF/views/auth/login.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("login".equals(action)) {
            String u = request.getParameter("username");
            String p = request.getParameter("password");
            
            User user = UserDAO.checkLogin(u, p);
            if (user != null) {
                HttpSession session = request.getSession();
                // Backup guest cart
                Map<Integer, CartItem> guestCart = (Map<Integer, CartItem>) session.getAttribute("cart");
                
                // Recreate session to prevent session fixation
                session.invalidate();
                session = request.getSession(true);
                session.setAttribute("user", user);
                
                // Merge guest cart to the new session
                Map<Integer, CartItem> dbCart = dal.CartDAO.getCartByUserId(user.getId());
                
                if (guestCart != null && !guestCart.isEmpty()) {
                    for (Map.Entry<Integer, CartItem> entry : guestCart.entrySet()) {
                        int maSach = entry.getKey();
                        CartItem guestItem = entry.getValue();
                        CartItem dbItem = dbCart.get(maSach);
                        
                        if (dbItem == null) {
                            dal.CartDAO.addToCart(user.getId(), maSach, guestItem.getQuantity());
                            dbCart.put(maSach, guestItem);
                        } else {
                            dal.CartDAO.updateQuantity(user.getId(), maSach, dbItem.getQuantity() + guestItem.getQuantity());
                            dbItem.setQuantity(dbItem.getQuantity() + guestItem.getQuantity());
                        }
                    }
                }
                
                // Recalculate cart size
                int cartSize = 0;
                for (CartItem ci : dbCart.values()) {
                    cartSize += ci.getQuantity();
                }
                session.setAttribute("cart", dbCart);
                session.setAttribute("cartSize", cartSize);
                
                if ("ADMIN".equals(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/admin");
                } else {
                    response.sendRedirect(request.getContextPath() + "/customer");
                }
            } else {
                request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
                request.setAttribute("view", "/WEB-INF/views/auth/login.jsp");
                request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
            }
        } else if ("register".equals(action)) {
            String u = request.getParameter("username");
            String p = request.getParameter("password");
            String cp = request.getParameter("confirmPassword");
            
            if (u == null || u.trim().isEmpty() || p == null || p.trim().isEmpty() || cp == null || cp.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
                request.setAttribute("username", u);
                request.setAttribute("view", "/WEB-INF/views/auth/register.jsp");
                request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
                return;
            }
            
            if (!p.equals(cp)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                request.setAttribute("username", u);
                request.setAttribute("view", "/WEB-INF/views/auth/register.jsp");
                request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
                return;
            }
            
            if (p.length() < 3) {
                request.setAttribute("error", "Mật khẩu phải chứa ít nhất 3 ký tự!");
                request.setAttribute("username", u);
                request.setAttribute("view", "/WEB-INF/views/auth/register.jsp");
                request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
                return;
            }
            
            if (UserDAO.isUsernameExists(u)) {
                request.setAttribute("error", "Tên đăng nhập đã tồn tại trong hệ thống!");
                request.setAttribute("username", u);
                request.setAttribute("view", "/WEB-INF/views/auth/register.jsp");
                request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
                return;
            }
            
            boolean success = UserDAO.register(u, p);
            if (success) {
                request.setAttribute("message", "Đăng ký tài khoản thành công! Vui lòng đăng nhập.");
                request.setAttribute("view", "/WEB-INF/views/auth/login.jsp");
                request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Có lỗi xảy ra trong quá trình đăng ký, vui lòng thử lại!");
                request.setAttribute("username", u);
                request.setAttribute("view", "/WEB-INF/views/auth/register.jsp");
                request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
            }
        }
    }
}
