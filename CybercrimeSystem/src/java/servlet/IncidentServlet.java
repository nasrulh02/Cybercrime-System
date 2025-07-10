package servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.Incident;


public class IncidentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("email") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("user_id");
        String type = request.getParameter("type");
        String website = request.getParameter("website");
        String dateStr = request.getParameter("date");
        String description = request.getParameter("description");
        String evidencePath = request.getParameter("evidence_path");
        String contactEmail = request.getParameter("contact_email");
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CybercrimeDB", "app", "app");
            
            Date date = Date.valueOf(dateStr);
            
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO Incident (user_id, type, website, date, description, evidence_path, contact_email) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)");
            ps.setInt(1, userId);
            ps.setString(2, type);
            ps.setString(3, website);
            ps.setDate(4, date);
            ps.setString(5, description);
            ps.setString(6, evidencePath);
            ps.setString(7, contactEmail);
            
            int result = ps.executeUpdate();
            conn.close();
            
            response.sendRedirect("dashboard.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to submit report");
            request.getRequestDispatcher("reportIncident.jsp").forward(request, response);
        }
    }
}