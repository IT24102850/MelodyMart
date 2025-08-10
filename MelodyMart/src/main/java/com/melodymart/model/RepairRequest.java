package com.melodymart.model;

public class RepairRequest {
    private int id;
    private int customerId;
    private int instrumentId;
    private String issueDescription;
    private String status;
    private Double estimatedCost;

    // Constructor
    public RepairRequest() {}

    public RepairRequest(int id, int customerId, int instrumentId, String issueDescription, String status, Double estimatedCost) {
        this.id = id;
        this.customerId = customerId;
        this.instrumentId = instrumentId;
        this.issueDescription = issueDescription;
        this.status = status;
        this.estimatedCost = estimatedCost;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }
    public int getInstrumentId() { return instrumentId; }
    public void setInstrumentId(int instrumentId) { this.instrumentId = instrumentId; }
    public String getIssueDescription() { return issueDescription; }
    public void setIssueDescription(String issueDescription) { this.issueDescription = issueDescription; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Double getEstimatedCost() { return estimatedCost; }
    public void setEstimatedCost(Double estimatedCost) { this.estimatedCost = estimatedCost; }
}