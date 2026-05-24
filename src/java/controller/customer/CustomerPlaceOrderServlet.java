package controller.customer;

import dal.OrderDAO;
import model.Order;
import model.User;
import model.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "CustomerPlaceOrderServlet", urlPatterns = {"/CustomerPlaceOrderServlet"})
public class CustomerPlaceOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/auth?action=login");
                return;
            }

            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/customer?action=cart");
                return;
            }

            String customerName = request.getParameter("customerName");
            String customerPhone = request.getParameter("customerPhone");
            String customerAddress = request.getParameter("customerAddress");

            double totalAmount = 0.0;
            for (CartItem item : cart.values()) {
                totalAmount += item.getTotalPrice();
            }

            double rankDiscountAmount = 0;
            String rank = user.getRankTier();
            if ("HACHIMAN".equals(rank)) rankDiscountAmount = totalAmount * 0.10;
            else if ("WIBU CHÚA".equals(rank)) rankDiscountAmount = totalAmount * 0.08;
            else if ("WIBU CHUẨN".equals(rank)) rankDiscountAmount = totalAmount * 0.02;

            double finalTotal = totalAmount - rankDiscountAmount;

            Order order = new Order();
            order.setUserId(user.getId());
            order.setCustomerName(customerName);
            order.setCustomerPhone(customerPhone);
            order.setCustomerAddress(customerAddress);
            
            // Xử lý voucher
            String voucherCode = request.getParameter("appliedVoucherCode");
            double voucherDiscount = 0;
            if (voucherCode != null && !voucherCode.trim().isEmpty()) {
                model.Voucher voucher = dal.VoucherDAO.getVoucherByCode(voucherCode);
                if (voucher != null && totalAmount >= voucher.getMinOrderValue()) {
                    voucherDiscount = totalAmount * voucher.getDiscountPercent() / 100.0;
                    order.setVoucherCode(voucher.getMaVoucher());
                }
            }
            order.setDiscountAmount(rankDiscountAmount + voucherDiscount);
            order.setTotalAmount(finalTotal - voucherDiscount);

            boolean success = OrderDAO.placeOrder(order, cart);

            if (success) {
                // Earn coins based on final amount paid
                int earnedCoins = (int) Math.round(order.getTotalAmount() / 10000.0);
                int newCoins = user.getMangaCoin() + earnedCoins;
                String newRank = "TÂN BINH";
                if (newCoins >= 5000) newRank = "HACHIMAN";
                else if (newCoins >= 1000) newRank = "WIBU CHÚA";
                else if (newCoins >= 100) newRank = "WIBU CHUẨN";

                dal.UserDAO.updateCoinAndRank(user.getId(), newCoins, newRank);
                user.setMangaCoin(newCoins);
                user.setRankTier(newRank);
                session.setAttribute("user", user);

                // Xóa giỏ hàng
                session.removeAttribute("cart");
                session.setAttribute("cartSize", 0);
                
                // Chuyển hướng về trang profile hoặc thông báo thành công
                request.setAttribute("message", "MÚC THÀNH CÔNG! Đơn hàng siêu phẩm của bạn đã được tiếp nhận và đang được đóng gói cấp tốc!");
                request.getRequestDispatcher("/CustomerProfileServlet").forward(request, response);
            } else {
                request.setAttribute("error", "Lỗi đặt hàng! Có thể số lượng trong kho không đủ, vui lòng kiểm tra lại.");
                request.setAttribute("view", "/WEB-INF/views/customer/checkout.jsp");
                request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/customer");
        }
    }
}
