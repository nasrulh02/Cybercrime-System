package servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

public class UpdateIncidentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("email") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int reportId = Integer.parseInt(request.getParameter("report_id"));
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
                "UPDATE Incident SET type=?, website=?, date=?, description=?, evidence_path=?, contact_email=? " +
                "WHERE report_id=? AND user_id=?");
            ps.setString(1, type);
            ps.setString(2, website);
            ps.setDate(3, date);
            ps.setString(4, description);
            ps.setString(5, evidencePath);
            ps.setString(6, contactEmail);
            ps.setInt(7, reportId);
            ps.setInt(8, userId);
            
            int result = ps.executeUpdate();
            conn.close();
            
            if (result > 0) {
                response.sendRedirect("dashboard.jsp");
            } else {
                request.setAttribute("error", "Failed to update report");
                request.getRequestDispatcher("editIncident.jsp?id=" + reportId).forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred");
            request.getRequestDispatcher("editIncident.jsp?id=" + reportId).forward(request, response);
        }
    }
}