package com.melodymart.model;

public class User {
    private int id;
    private String fullName;
    private String email;
    private String password;
    private String role;
    private String country;

    public User(String fullName, String email, String password, String role, String country) {
        this.fullName = fullName;
        this.email = email;
        this.password = password; // In production, use a hashed password
        this.role = role;
        this.country = country;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getFullName() { return fullName; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public String getRole() { return role; }
    public String getCountry() { return country; }
}