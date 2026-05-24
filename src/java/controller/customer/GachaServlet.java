package controller.customer;

import dal.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

@WebServlet(name = "GachaServlet", urlPatterns = {"/gacha"})
public class GachaServlet extends HttpServlet {
    private static final int GACHA_PRICE = 100;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("view", "/WEB-INF/views/customer/gacha.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            out.print("{\"success\": false, \"message\": \"Bạn cần đăng nhập để quay Gacha!\"}");
            return;
        }
        
        if (user.getMangaCoin() < GACHA_PRICE) {
            out.print("{\"success\": false, \"message\": \"Không đủ xu! Cần " + GACHA_PRICE + " xu để quay.\"}");
            return;
        }
        
        Random rand = new Random();
        int roll = rand.nextInt(100);
        String rewardType;
        String rewardName;
        int coinReward = 0;
        
        if (roll < 10) {
            rewardType = "JACKPOT";
            rewardName = "🎉 Nổ Hũ! Trúng 1000 Xu!";
            coinReward = 1000;
        } else if (roll < 30) {
            rewardType = "VOUCHER";
            rewardName = "🎁 Mã Giảm Giá: GACHAVIP (Giảm 50%)";
        } else if (roll < 60) {
            rewardType = "REFUND";
            rewardName = "💰 An ủi! Nhận lại 50 Xu";
            coinReward = 50;
        } else {
            rewardType = "MISS";
            rewardName = "💀 Tạch rồi! Cố lên nhé!";
            coinReward = 0;
        }
        
        int newCoin = user.getMangaCoin() - GACHA_PRICE + coinReward;
        user.setMangaCoin(newCoin);
        UserDAO.updateCoinAndRank(user.getId(), newCoin, user.getRankTier());
        session.setAttribute("user", user);
        
        out.print("{\"success\": true, \"rewardType\": \"" + rewardType + "\", \"rewardName\": \"" + rewardName + "\", \"newCoin\": " + newCoin + "}");
    }
}
