package model;

import java.util.Date;
import java.util.List;

public class Order {
    private int id;
    private int userId;
    private String customerName;
    private String customerPhone;
    private String customerAddress;
    private double totalAmount;
    private Date orderDate;
    private String status;
    private String voucherCode;
    private double discountAmount;
    private List<OrderDetail> details;

    public Order() {
    }

    public Order(int id, int userId, String customerName, String customerPhone, String customerAddress, double totalAmount, Date orderDate, String status) {
        this.id = id;
        this.userId = userId;
        this.customerName = customerName;
        this.customerPhone = customerPhone;
        this.customerAddress = customerAddress;
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
        this.status = status;
    }

    public Order(int id, int userId, String customerName, String customerPhone, String customerAddress, double totalAmount, Date orderDate, String status, String voucherCode, double discountAmount) {
        this.id = id;
        this.userId = userId;
        this.customerName = customerName;
        this.customerPhone = customerPhone;
        this.customerAddress = customerAddress;
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
        this.status = status;
        this.voucherCode = voucherCode;
        this.discountAmount = discountAmount;
    }

    // Getters and Setters
    public String getVoucherCode() { return voucherCode; }
    public void setVoucherCode(String voucherCode) { this.voucherCode = voucherCode; }
    public double getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(double discountAmount) { this.discountAmount = discountAmount; }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public String getCustomerPhone() { return customerPhone; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }
    public String getCustomerAddress() { return customerAddress; }
    public void setCustomerAddress(String customerAddress) { this.customerAddress = customerAddress; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public List<OrderDetail> getDetails() { return details; }
    public void setDetails(List<OrderDetail> details) { this.details = details; }
}
