package model;

public class User {
    private int id;
    private String username;
    private String password;
    private String role;
    private int mangaCoin;
    private String rankTier;
    private String avatar;

    public User() {}

    public User(int id, String username, String password, String role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.role = role;
        this.mangaCoin = 0;
        this.rankTier = "TÂN BINH";
        this.avatar = null;
    }

    public User(int id, String username, String password, String role, int mangaCoin, String rankTier, String avatar) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.role = role;
        this.mangaCoin = mangaCoin;
        this.rankTier = rankTier;
        this.avatar = avatar;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getMangaCoin() {
        return mangaCoin;
    }

    public void setMangaCoin(int mangaCoin) {
        this.mangaCoin = mangaCoin;
    }

    public String getRankTier() {
        return rankTier;
    }

    public void setRankTier(String rankTier) {
        this.rankTier = rankTier;
    }
}
