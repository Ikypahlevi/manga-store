package controller.customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CustomerServlet", urlPatterns = {"/customer"})
public class CustomerServlet extends HttpServlet {

    private static final int PAGE_SIZE = 8;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "home";

        switch (action) {
            case "home":
                request.getRequestDispatcher("/CustomerHomeServlet").forward(request, response);
                break;
            case "detail":
                request.getRequestDispatcher("/CustomerDetailServlet").forward(request, response);
                break;
            case "cart":
                request.getRequestDispatcher("/CustomerCartServlet").forward(request, response);
                break;
            case "add-to-cart":
                request.getRequestDispatcher("/CustomerAddToCartServlet").forward(request, response);
                break;
            case "update-cart":
                request.getRequestDispatcher("/CustomerUpdateCartServlet").forward(request, response);
                break;
            case "remove-from-cart":
                request.getRequestDispatcher("/CustomerRemoveFromCartServlet").forward(request, response);
                break;
            case "checkout":
                request.getRequestDispatcher("/CustomerCheckoutServlet").forward(request, response);
                break;
            case "place-order":
                request.getRequestDispatcher("/CustomerPlaceOrderServlet").forward(request, response);
                break;
            case "profile":
                request.getRequestDispatcher("/CustomerProfileServlet").forward(request, response);
                break;
            case "add-review":
                request.getRequestDispatcher("/CustomerAddReviewServlet").forward(request, response);
                break;
            case "apply-voucher":
                request.getRequestDispatcher("/CustomerApplyVoucherServlet").forward(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/customer");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
