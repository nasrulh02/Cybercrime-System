package servlet;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.Incident;


public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Boolean isAdmin = (Boolean) session.getAttribute("is_admin");
        
        if (isAdmin == null || !isAdmin) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CybercrimeDB", "app", "app");
            
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(
                "SELECT i.*, u.email as user_email FROM Incident i JOIN \"User\" u ON i.user_id = u.user_id");
            
            List<Incident> incidents = new ArrayList<>();
            while (rs.next()) {
                Incident i = new Incident();
                i.setReport_id(rs.getInt("report_id"));
                i.setUser_id(rs.getInt("user_id"));
                i.setType(rs.getString("type"));
                i.setWebsite(rs.getString("website"));
                i.setDate(rs.getDate("date"));  // Changed from getString to getDate
                i.setDescription(rs.getString("description"));
                i.setEvidence_path(rs.getString("evidence_path"));
                i.setContact_email(rs.getString("contact_email"));
                i.setStatus(rs.getString("status"));
                incidents.add(i);
            }
            
            request.setAttribute("incidents", incidents);
            request.getRequestDispatcher("Admin.jsp").forward(request, response);
            
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred");
            request.getRequestDispatcher("Admin.jsp").forward(request, response);
        }
    }
}