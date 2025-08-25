
package main.java.com.melodymart.model;

public class User {
    private int id;
    private String name;
    private String email;
    private String password;
    private String role; // "customer", "seller", or "admin"

    private String country;

    // Constructor
    public User() {}

    public User(int id, String name, String email, String password, String role, String address, String phone, String country) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.role = role;

        this.country = country;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }
}
