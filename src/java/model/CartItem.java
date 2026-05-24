package model;

public class CartItem {
    private Sach sach;
    private int quantity;

    public CartItem() {
    }

    public CartItem(Sach sach, int quantity) {
        this.sach = sach;
        this.quantity = quantity;
    }

    public Sach getSach() {
        return sach;
    }

    public void setSach(Sach sach) {
        this.sach = sach;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return sach.getGiaTien() * quantity;
    }
}
