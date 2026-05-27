package model;

public class Sach {
    private int maSach;
    private String tenSach;
    private double giaTien;
    private int soLuong;
    private String hinhAnh;
    private String moTa;
    private String trailerUrl;
    private String theLoai;

    public Sach() {
    }

    public Sach(int maSach, String tenSach, double giaTien, int soLuong, String hinhAnh) {
        this.maSach = maSach;
        this.tenSach = tenSach;
        this.giaTien = giaTien;
        this.soLuong = soLuong;
        this.hinhAnh = hinhAnh;
    }

    public Sach(int maSach, String tenSach, double giaTien, int soLuong, String hinhAnh, String moTa) {
        this.maSach = maSach;
        this.tenSach = tenSach;
        this.giaTien = giaTien;
        this.soLuong = soLuong;
        this.hinhAnh = hinhAnh;
        this.moTa = moTa;
    }

    public Sach(int maSach, String tenSach, double giaTien, int soLuong, String hinhAnh, String moTa, String trailerUrl) {
        this.maSach = maSach;
        this.tenSach = tenSach;
        this.giaTien = giaTien;
        this.soLuong = soLuong;
        this.hinhAnh = hinhAnh;
        this.moTa = moTa;
        this.trailerUrl = trailerUrl;
    }

    public Sach(int maSach, String tenSach, double giaTien, int soLuong, String hinhAnh, String moTa, String trailerUrl, String theLoai) {
        this.maSach = maSach;
        this.tenSach = tenSach;
        this.giaTien = giaTien;
        this.soLuong = soLuong;
        this.hinhAnh = hinhAnh;
        this.moTa = moTa;
        this.trailerUrl = trailerUrl;
        this.theLoai = theLoai;
    }

    public int getMaSach() {
        return maSach;
    }

    public void setMaSach(int maSach) {
        this.maSach = maSach;
    }

    public String getTenSach() {
        return tenSach;
    }

    public void setTenSach(String tenSach) {
        this.tenSach = tenSach;
    }

    public double getGiaTien() {
        return giaTien;
    }

    public void setGiaTien(double giaTien) {
        this.giaTien = giaTien;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    public String getTrailerUrl() {
        return trailerUrl;
    }

    public void setTrailerUrl(String trailerUrl) {
        this.trailerUrl = trailerUrl;
    }

    public String getTheLoai() {
        return theLoai;
    }

    public void setTheLoai(String theLoai) {
        this.theLoai = theLoai;
    }
}