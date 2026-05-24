package model;

public class OrderDetail {
    private int id;
    private int orderId;
    private int maSach;
    private int quantity;
    private double price;
    private Sach sach; // To hold book info when displaying history

    public OrderDetail() {
    }

    public OrderDetail(int id, int orderId, int maSach, int quantity, double price) {
        this.id = id;
        this.orderId = orderId;
        this.maSach = maSach;
        this.quantity = quantity;
        this.price = price;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public int getMaSach() { return maSach; }
    public void setMaSach(int maSach) { this.maSach = maSach; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public Sach getSach() { return sach; }
    public void setSach(Sach sach) { this.sach = sach; }
}
