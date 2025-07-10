package model;

import java.sql.Date;

public class Incident {
    private int report_id;
    private int user_id;
    private String type;
    private String website;
    private Date date;
    private String description;
    private String evidence_path;
    private String contact_email;
    private String status;

    // Getters and Setters
    public int getReport_id() { return report_id; }
    public void setReport_id(int report_id) { this.report_id = report_id; }
    
    public int getUser_id() { return user_id; }
    public void setUser_id(int user_id) { this.user_id = user_id; }
    
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    
    public String getWebsite() { return website; }
    public void setWebsite(String website) { this.website = website; }
    
    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getEvidence_path() { return evidence_path; }
    public void setEvidence_path(String evidence_path) { this.evidence_path = evidence_path; }
    
    public String getContact_email() { return contact_email; }
    public void setContact_email(String contact_email) { this.contact_email = contact_email; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}