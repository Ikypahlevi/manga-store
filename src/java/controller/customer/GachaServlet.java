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
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import dal.SachDAO;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Sach;
import model.GachaReward;

@WebServlet(name = "GachaServlet", urlPatterns = {"/gacha"})
public class GachaServlet extends HttpServlet {
    private static final int GACHA_PRICE = 100;
    
    private List<GachaReward> getRewards() throws ClassNotFoundException, SQLException {
        List<GachaReward> rewards = new ArrayList<>();
        List<Sach> books = SachDAO.getAll();
        // Add all books
        for(Sach s : books) {
            rewards.add(new GachaReward("BOOK", s.getTenSach(), "img/" + s.getHinhAnh(), (int)s.getGiaTien()));
        }
        // Add special items
        rewards.add(new GachaReward("COIN_1000", "1000 Xu", "https://api.dicebear.com/7.x/bottts/svg?seed=jackpot&backgroundColor=FFD166", 1000));
        rewards.add(new GachaReward("COIN_500", "500 Xu", "https://api.dicebear.com/7.x/bottts/svg?seed=coin&backgroundColor=06D6A0", 500));
        rewards.add(new GachaReward("VOUCHER", "Voucher 50%", "https://api.dicebear.com/7.x/bottts/svg?seed=voucher&backgroundColor=ef476f", 0));
        rewards.add(new GachaReward("MISS", "Chúc may mắn lần sau", "https://api.dicebear.com/7.x/bottts/svg?seed=miss&backgroundColor=118ab2", 0));
        return rewards;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("rewards", getRewards());
            request.setAttribute("view", "/WEB-INF/views/customer/gacha.jsp");
            request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(GachaServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(GachaServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
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
            
            List<GachaReward> rewards = getRewards();
            Random rand = new Random();
            int roll = rand.nextInt(100);
            int targetIndex = -1;
            
            // Tỉ lệ: 40% Tạch, 40% Sách, 10% Voucher, 8% 500 Xu, 2% 1000 Xu
            if (roll < 40) {
                targetIndex = findIndex(rewards, "MISS");
            } else if (roll < 80) {
                List<Integer> bookIndices = new ArrayList<>();
                for(int i = 0; i < rewards.size(); i++) {
                    if (rewards.get(i).getType().equals("BOOK")) bookIndices.add(i);
                }
                if (!bookIndices.isEmpty()) {
                    targetIndex = bookIndices.get(rand.nextInt(bookIndices.size()));
                } else {
                    targetIndex = findIndex(rewards, "MISS");
                }
            } else if (roll < 90) {
                targetIndex = findIndex(rewards, "VOUCHER");
            } else if (roll < 98) {
                targetIndex = findIndex(rewards, "COIN_500");
            } else {
                targetIndex = findIndex(rewards, "COIN_1000");
            }
            
            if(targetIndex == -1) targetIndex = 0;
            GachaReward won = rewards.get(targetIndex);
            
            int coinReward = won.getCoinValue();
            String rewardName = won.getName();
            if(won.getType().equals("BOOK")) {
                rewardName = "Truyện: " + won.getName() + " (Đã quy đổi " + coinReward + " Xu vào ví)";
            }
            
            
            int newCoin = user.getMangaCoin() - GACHA_PRICE + coinReward;
            user.setMangaCoin(newCoin);
            UserDAO.updateCoinAndRank(user.getId(), newCoin, user.getRankTier());
            session.setAttribute("user", user);
            
            out.print("{\"success\": true, \"targetIndex\": " + targetIndex + ", \"rewardType\": \"" + won.getType() + "\", \"rewardName\": \"" + rewardName.replace("\"", "\\\"") + "\", \"newCoin\": " + newCoin + "}");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(GachaServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(GachaServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private int findIndex(List<GachaReward> rewards, String type) {
        for(int i = 0; i < rewards.size(); i++) {
            if (rewards.get(i).getType().equals(type)) return i;
        }
        return -1;
    }
}
