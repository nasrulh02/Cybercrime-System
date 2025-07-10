<%@ page import="java.sql.*, model.Incident, java.util.*" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Integer userIdObj = (Integer) session.getAttribute("user_id");
    if (userIdObj == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int user_id = userIdObj.intValue();

    List<Incident> list = new ArrayList<Incident>();

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CybercrimeDB", "app", "app");
        
        PreparedStatement ps = conn.prepareStatement(
            "SELECT * FROM Incident WHERE user_id=? ORDER BY report_id DESC");
        ps.setInt(1, user_id);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            Incident i = new Incident();
            i.setReport_id(rs.getInt("report_id"));
            i.setType(rs.getString("type"));
            i.setWebsite(rs.getString("website"));
            i.setDate(rs.getDate("date"));
            i.setDescription(rs.getString("description"));
            i.setEvidence_path(rs.getString("evidence_path"));
            i.setContact_email(rs.getString("contact_email"));
            i.setStatus(rs.getString("status"));
            list.add(i);
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --primary: #2563eb;
            --primary-light: #3b82f6;
            --primary-dark: #1d4ed8;
            --secondary: #1e293b;
            --accent: #7c3aed;
            --light: #f8fafc;
            --dark: #0f172a;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #3b82f6;
            --gray: #64748b;
            --gray-light: #e2e8f0;
            --card-bg: rgba(255, 255, 255, 0.92);
            --header-bg: rgba(37, 99, 235, 0.95);
        }
        
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            margin: 0;
            padding: 0;
            color: var(--secondary);
            line-height: 1.6;
            min-height: 100vh;
            background: linear-gradient(rgba(0, 0, 0, 0.85), rgba(0, 0, 0, 0.85)), 
                        url('https://images.unsplash.com/photo-1563986768609-322da13575f3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            animation: fadeIn 0.8s ease-in-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        .header {
            background: var(--header-bg);
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            position: sticky;
            top: 0;
            z-index: 100;
            backdrop-filter: blur(10px);
            animation: slideDown 0.5s ease-out;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        @keyframes slideDown {
            from { transform: translateY(-100%); }
            to { transform: translateY(0); }
        }
        
        .header h2 {
            margin: 0;
            font-weight: 600;
            font-size: 1.5rem;
            letter-spacing: -0.025em;
        }
        
        .nav-links {
            display: flex;
            gap: 1rem;
        }
        
        .nav-links a {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-weight: 500;
            font-size: 0.875rem;
            display: flex;
            align-items: center;
            gap: 0.25rem;
            background-color: rgba(255, 255, 255, 0.1);
        }
        
        .nav-links a:hover {
            background-color: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }
        
        .container {
            padding: 2rem;
            max-width: 1400px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 1fr 300px;
            gap: 2rem;
            animation: fadeInUp 0.6s ease-out;
        }
        
        @keyframes fadeInUp {
            from { 
                opacity: 0;
                transform: translateY(20px);
            }
            to { 
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .card {
            background: var(--card-bg);
            border-radius: 0.75rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            padding: 1.5rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(5px);
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        
        .card h3 {
            margin-top: 0;
            color: var(--primary);
            font-weight: 600;
            font-size: 1.25rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid var(--gray-light);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1.5rem;
            background-color: white;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            border-radius: 0.75rem;
            overflow: hidden;
        }
        
        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid var(--gray-light);
        }
        
        th {
            background-color: var(--primary);
            color: white;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.05em;
            position: sticky;
            top: 0;
        }
        
        tr {
            transition: all 0.2s ease;
        }
        
        tr:hover {
            background-color: #f8fafc;
        }
        
        .action-links {
            display: flex;
            gap: 0.5rem;
        }
        
        .action-links a {
            color: var(--primary);
            text-decoration: none;
            padding: 0.375rem 0.75rem;
            border-radius: 0.25rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-size: 0.875rem;
            display: flex;
            align-items: center;
            gap: 0.25rem;
            border: 1px solid var(--gray-light);
        }
        
        .action-links a:hover {
            background-color: rgba(37, 99, 235, 0.1);
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
        }
        
        .status {
            font-weight: 600;
            font-size: 0.75rem;
            padding: 0.375rem 0.75rem;
            border-radius: 9999px;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }
        
        .status::before {
            content: "";
            display: inline-block;
            width: 0.5rem;
            height: 0.5rem;
            border-radius: 50%;
            background-color: currentColor;
        }
        
        .status-pending {
            background-color: rgba(251, 191, 36, 0.1);
            color: #d97706;
        }
        
        .status-approved {
            background-color: rgba(16, 185, 129, 0.1);
            color: #047857;
        }
        
        .status-rejected {
            background-color: rgba(239, 68, 68, 0.1);
            color: #b91c1c;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            background-color: var(--primary);
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
            cursor: pointer;
            margin-top: 1rem;
            font-size: 0.875rem;
        }
        
        .btn:hover {
            background-color: var(--primary-light);
            transform: translateY(-3px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }
        
        .info-item {
            margin-bottom: 1.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid var(--gray-light);
            transition: all 0.2s ease;
        }
        
        .info-item:hover {
            transform: translateX(5px);
        }
        
        .info-item:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }
        
        .info-item h4 {
            margin: 0 0 0.5rem 0;
            color: var(--primary);
            font-size: 1rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .info-item p {
            margin: 0;
            font-size: 0.875rem;
            color: var(--gray);
            line-height: 1.5;
        }
        
        .no-reports {
            text-align: center;
            padding: 2rem;
            color: var(--gray);
        }
        
        .no-reports p {
            margin-bottom: 1.5rem;
            font-size: 1rem;
        }
        
        @media (max-width: 1024px) {
            .container {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }
            
            .header {
                flex-direction: column;
                gap: 1rem;
                padding: 1rem;
                text-align: center;
            }
            
            .nav-links {
                width: 100%;
                justify-content: center;
                flex-wrap: wrap;
            }
            
            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }
            
            .card {
                padding: 1rem;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="header">
        <h2><i class="fas fa-user-shield"></i> Welcome <%= email %></h2>
        <div class="nav-links">
            <a href="reportIncident.jsp"><i class="fas fa-plus-circle"></i> Report New Incident</a>
            <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>
    
    <div class="container">
        <main>
            <div class="card">
                <h3><i class="fas fa-clipboard-list"></i> Your Reports</h3>
                <% if (list.isEmpty()) { %>
                    <div class="no-reports">
                        <p>You haven't submitted any reports yet.</p>
                        <a href="reportIncident.jsp" class="btn"><i class="fas fa-plus-circle"></i> Report an Incident</a>
                    </div>
                <% } else { %>
                    <table>
                        <tr>
                            <th>No.</th> 
                            <th>ID</th>
                            <th>Type</th>
                            <th>Website</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                        <% int displayNumber = 1; %>
                        <% for (Incident i : list) { %>
                            <tr>
                                <td><%= displayNumber++ %></td> 
                                <td><%= i.getReport_id() %></td>
                                <td><%= i.getType() %></td>
                                <td><%= i.getWebsite() %></td>
                                <td><%= i.getDate() %></td>
                                <td><span class="status status-<%= i.getStatus().toLowerCase() %>"><%= i.getStatus() %></span></td>
                                <td class="action-links">
                                    <a href="editIncident.jsp?id=<%= i.getReport_id() %>"><i class="fas fa-edit"></i> Edit</a>
                                    <a href="DeleteIncidentServlet?id=<%= i.getReport_id() %>" onclick="return confirm('Are you sure you want to delete this report?')"><i class="fas fa-trash-alt"></i> Delete</a>
                                </td>
                            </tr>
                        <% } %>
                    </table>
                <% } %>
            </div>
        </main>
        
        <aside>
            <div class="card">
                <h3><i class="fas fa-shield-alt"></i> Online Shopping Safety Tips</h3>
                <div class="info-item">
                    <h4><i class="fas fa-lock"></i> 1. Secure Websites Only</h4>
                    <p>Always look for "https://" and a padlock icon in the address bar before entering payment details.</p>
                </div>
                <div class="info-item">
                    <h4><i class="fas fa-fish"></i> 2. Phishing Scams</h4>
                    <p>Be wary of emails offering deals that seem too good to be true. Never click on suspicious links.</p>
                </div>
                <div class="info-item">
                    <h4><i class="fas fa-store-slash"></i> 3. Fake Online Stores</h4>
                    <p>Research new retailers before purchasing. Check for contact information and customer reviews.</p>
                </div>
                <div class="info-item">
                    <h4><i class="fas fa-credit-card"></i> 4. Payment Methods</h4>
                    <p>Use credit cards or secure payment services (like PayPal) that offer buyer protection.</p>
                </div>
                <div class="info-item">
                    <h4><i class="fas fa-key"></i> 5. Strong Passwords</h4>
                    <p>Use unique, complex passwords for each shopping site and enable two-factor authentication.</p>
                </div>
            </div>
            
            <div class="card">
                <h3><i class="fas fa-exclamation-triangle"></i> Report Suspicious Activity</h3>
                <p>If you encounter any of these cybercrimes, report them immediately to protect yourself and others.</p>
                <a href="reportIncident.jsp" class="btn"><i class="fas fa-plus-circle"></i> Report Incident</a>
            </div>
        </aside>
    </div>
</body>
</html>