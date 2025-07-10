package servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get parameters from request
        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String securityQuestion = request.getParameter("security_question");
        String securityAnswer = request.getParameter("security_answer");
        
        Connection conn = null;
        PreparedStatement check = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            // Load driver and establish connection
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CybercrimeDB", "app", "app");
            
            // Check if email exists
            check = conn.prepareStatement("SELECT email FROM \"User\" WHERE email=?");
            check.setString(1, email);
            rs = check.executeQuery();
            
            if (rs.next()) {
                request.setAttribute("error", "Email already registered");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            
            // Insert new user
            ps = conn.prepareStatement(
                "INSERT INTO \"User\" (full_name, email, password, security_question, security_answer) " +
                "VALUES (?, ?, ?, ?, ?)");
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, securityQuestion);
            ps.setString(5, securityAnswer);
            
            int result = ps.executeUpdate();
            
            if (result > 0) {
                response.sendRedirect("login.jsp?registration=success");
            } else {
                request.setAttribute("error", "Registration failed");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
            
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database driver not found");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } finally {
            // Close resources in finally block
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (check != null) check.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}