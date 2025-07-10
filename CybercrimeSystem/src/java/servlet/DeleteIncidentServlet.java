package servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


public class DeleteIncidentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        
        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int reportId = Integer.parseInt(request.getParameter("id"));
        int userId = (int) session.getAttribute("user_id");
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CybercrimeDB", "app", "app");
            
            PreparedStatement ps = conn.prepareStatement(
                "DELETE FROM Incident WHERE report_id=? AND user_id=?");
            ps.setInt(1, reportId);
            ps.setInt(2, userId);
            
            int result = ps.executeUpdate();
            
            conn.close();
            
            response.sendRedirect("dashboard.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to delete incident report");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }
}