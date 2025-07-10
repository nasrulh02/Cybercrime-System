package model;

public class User {
    private int user_id;
    private String email, password, full_name, security_question, security_answer;

    public int getUser_id() { return user_id; }
    public void setUser_id(int user_id) { this.user_id = user_id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFull_name() { return full_name; }
    public void setFull_name(String full_name) { this.full_name = full_name; }

    public String getSecurity_question() { return security_question; }
    public void setSecurity_question(String security_question) { this.security_question = security_question; }

    public String getSecurity_answer() { return security_answer; }
    public void setSecurity_answer(String security_answer) { this.security_answer = security_answer; }
}