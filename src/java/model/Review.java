package model;

import java.sql.Timestamp;

public class Review {
    private int maReview;
    private int maSach;
    private int userId;
    private String username; // Lấy từ JOIN với bảng User để hiển thị
    private int rating;
    private String comment;
    private Timestamp createdAt;
    private int isApproved;

    public Review() {
    }

    public Review(int maReview, int maSach, int userId, String username, int rating, String comment, Timestamp createdAt, int isApproved) {
        this.maReview = maReview;
        this.maSach = maSach;
        this.userId = userId;
        this.username = username;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
        this.isApproved = isApproved;
    }

    public int getMaReview() {
        return maReview;
    }

    public void setMaReview(int maReview) {
        this.maReview = maReview;
    }

    public int getMaSach() {
        return maSach;
    }

    public void setMaSach(int maSach) {
        this.maSach = maSach;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public int getIsApproved() {
        return isApproved;
    }

    public void setIsApproved(int isApproved) {
        this.isApproved = isApproved;
    }
}
