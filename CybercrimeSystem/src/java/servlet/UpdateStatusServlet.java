package servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


public class UpdateStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Boolean isAdmin = (Boolean) session.getAttribute("is_admin");
        
        if (isAdmin == null || !isAdmin) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int reportId = Integer.parseInt(request.getParameter("report_id"));
        String status = request.getParameter("status");
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CybercrimeDB", "app", "app");
            
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE Incident SET status=? WHERE report_id=?");
            ps.setString(1, status);
            ps.setInt(2, reportId);
            
            ps.executeUpdate();
            conn.close();
            
            response.sendRedirect("AdminServlet");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to update status");
            request.getRequestDispatcher("Admin.jsp").forward(request, response);
        }
    }
}