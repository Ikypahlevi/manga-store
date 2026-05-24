package model;

public class VipCustomer {
    private User user;
    private double totalSpent;

    public VipCustomer(User user, double totalSpent) {
        this.user = user;
        this.totalSpent = totalSpent;
    }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public double getTotalSpent() { return totalSpent; }
    public void setTotalSpent(double totalSpent) { this.totalSpent = totalSpent; }
}
