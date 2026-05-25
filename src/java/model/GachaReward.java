package model;

public class GachaReward {
    private String type; // BOOK, COIN, VOUCHER, MISS
    private String name;
    private String image;
    private int coinValue;

    public GachaReward(String type, String name, String image, int coinValue) {
        this.type = type;
        this.name = name;
        this.image = image;
        this.coinValue = coinValue;
    }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public int getCoinValue() { return coinValue; }
    public void setCoinValue(int coinValue) { this.coinValue = coinValue; }
}
