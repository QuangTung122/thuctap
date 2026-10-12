java
package model;

public class Customer {
    private String id;
    private String name;
    private String email;
    private String phone;

    // Constructor không tham số
    public Customer() {}

    // Constructor đầy đủ tham số
    public Customer(String id, String name, String email, String phone) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
    }

    // Các hàm Getter và Setter (Bắt buộc phải có để JSTL EL hiển thị được)
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}