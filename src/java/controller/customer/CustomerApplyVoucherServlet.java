package controller.customer;

import dal.VoucherDAO;
import model.CartItem;
import model.Voucher;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

@WebServlet(name = "CustomerApplyVoucherServlet", urlPatterns = {"/CustomerApplyVoucherServlet"})
public class CustomerApplyVoucherServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String code = request.getParameter("code");
        if (code == null || code.trim().isEmpty()) {
            out.print("{\"success\": false, \"message\": \"Vui lòng nhập mã giảm giá.\"}");
            return;
        }

        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        
        if (cart == null || cart.isEmpty()) {
            out.print("{\"success\": false, \"message\": \"Giỏ hàng đang trống.\"}");
            return;
        }

        double totalAmount = 0;
        for (CartItem item : cart.values()) {
            totalAmount += item.getTotalPrice();
        }

        User user = (User) session.getAttribute("user");
        double rankDiscountAmount = 0;
        if (user != null) {
            String rank = user.getRankTier();
            if ("HACHIMAN".equals(rank)) rankDiscountAmount = totalAmount * 0.10;
            else if ("WIBU CHÚA".equals(rank)) rankDiscountAmount = totalAmount * 0.08;
            else if ("WIBU CHUẨN".equals(rank)) rankDiscountAmount = totalAmount * 0.02;
        }

        Voucher voucher = VoucherDAO.getVoucherByCode(code);
        if (voucher == null) {
            out.print("{\"success\": false, \"message\": \"Mã giảm giá không tồn tại hoặc đã hết hạn.\"}");
            return;
        }

        if (totalAmount < voucher.getMinOrderValue()) {
            out.print("{\"success\": false, \"message\": \"Đơn hàng chưa đạt giá trị tối thiểu " + String.format("%,.0f", voucher.getMinOrderValue()) + "đ để áp dụng mã này.\"}");
            return;
        }

        double discountAmount = totalAmount * voucher.getDiscountPercent() / 100.0;
        // Giới hạn giảm giá tối đa (nếu cần), hiện tại chưa cần
        double newTotal = totalAmount - rankDiscountAmount - discountAmount;

        out.print("{\"success\": true, \"message\": \"Áp dụng mã thành công! Giảm " + voucher.getDiscountPercent() + "%\", " +
                  "\"code\": \"" + voucher.getMaVoucher() + "\", " +
                  "\"discountAmount\": " + discountAmount + ", " +
                  "\"newTotal\": " + newTotal + "}");
    }
}
