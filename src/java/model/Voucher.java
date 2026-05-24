package model;

public class Voucher {
    private String maVoucher;
    private int discountPercent;
    private double minOrderValue;
    private boolean isActive;

    public Voucher() {
    }

    public Voucher(String maVoucher, int discountPercent, double minOrderValue, boolean isActive) {
        this.maVoucher = maVoucher;
        this.discountPercent = discountPercent;
        this.minOrderValue = minOrderValue;
        this.isActive = isActive;
    }

    public String getMaVoucher() {
        return maVoucher;
    }

    public void setMaVoucher(String maVoucher) {
        this.maVoucher = maVoucher;
    }

    public int getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(int discountPercent) {
        this.discountPercent = discountPercent;
    }

    public double getMinOrderValue() {
        return minOrderValue;
    }

    public void setMinOrderValue(double minOrderValue) {
        this.minOrderValue = minOrderValue;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}
