package model;

public class VipCustomer {
    private User user;
    private double totalSpent;
    private int totalBooks;

    public VipCustomer(User user, double totalSpent, int totalBooks) {
        this.user = user;
        this.totalSpent = totalSpent;
        this.totalBooks = totalBooks;
    }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public double getTotalSpent() { return totalSpent; }
    public void setTotalSpent(double totalSpent) { this.totalSpent = totalSpent; }
    public int getTotalBooks() { return totalBooks; }
    public void setTotalBooks(int totalBooks) { this.totalBooks = totalBooks; }
}
