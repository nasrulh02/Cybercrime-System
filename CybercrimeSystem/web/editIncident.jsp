<%@ page import="java.sql.*, model.Incident" %>
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

    String reportIdParam = request.getParameter("id");
    if (reportIdParam == null || reportIdParam.isEmpty()) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    
    int report_id = Integer.parseInt(reportIdParam);
    Incident i = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CybercrimeDB", "app", "app");
        
        PreparedStatement ps = conn.prepareStatement(
            "SELECT * FROM Incident WHERE report_id=? AND user_id=?");
        ps.setInt(1, report_id);
        ps.setInt(2, user_id);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            i = new Incident();
            i.setReport_id(rs.getInt("report_id"));
            i.setUser_id(rs.getInt("user_id"));
            i.setType(rs.getString("type"));
            i.setWebsite(rs.getString("website"));
            i.setDate(rs.getDate("date"));
            i.setDescription(rs.getString("description"));
            i.setEvidence_path(rs.getString("evidence_path"));
            i.setContact_email(rs.getString("contact_email"));
            i.setStatus(rs.getString("status"));
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Incident</title>
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
                        url('https://images.unsplash.com/photo-1550751827-4bd374c3f58b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80');
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
            max-width: 800px;
            margin: 0 auto;
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
        
        .form-group {
            margin-bottom: 1.5rem;
            animation: fadeIn 0.6s ease-out;
        }
        
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--secondary);
            font-size: 0.875rem;
        }
        
        input[type="text"],
        input[type="date"],
        input[type="email"],
        textarea,
        select {
            width: 100%;
            padding: 0.875rem;
            border: 1px solid var(--gray-light);
            border-radius: 0.5rem;
            font-size: 1rem;
            font-family: inherit;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background-color: white;
        }
        
        input[type="text"]:focus,
        input[type="date"]:focus,
        input[type="email"]:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2);
        }
        
        textarea {
            min-height: 150px;
            resize: vertical;
        }
        
        .btn {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 0.875rem 1.75rem;
            border-radius: 0.5rem;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .btn:hover {
            background-color: var(--primary-light);
            transform: translateY(-3px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--primary);
            text-decoration: none;
            margin-top: 1.5rem;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .back-link:hover {
            color: var(--accent);
            text-decoration: underline;
            transform: translateX(-5px);
        }
        
        .error-message {
            color: var(--danger);
            background-color: rgba(239, 68, 68, 0.1);
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
            text-align: center;
            border: 1px solid rgba(239, 68, 68, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            animation: shake 0.5s cubic-bezier(.36,.07,.19,.97) both;
        }
        
        @keyframes shake {
            10%, 90% { transform: translateX(-1px); }
            20%, 80% { transform: translateX(2px); }
            30%, 50%, 70% { transform: translateX(-4px); }
            40%, 60% { transform: translateX(4px); }
        }
        
        .required-field::after {
            content: " *";
            color: var(--danger);
        }
        
        .evidence-preview {
            margin-top: 1rem;
            padding: 1rem;
            border: 1px dashed var(--gray-light);
            border-radius: 0.5rem;
            background-color: #f8fafc;
            transition: all 0.3s ease;
        }
        
        .evidence-preview:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }
        
        .evidence-preview a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.2s ease;
        }
        
        .evidence-preview a:hover {
            text-decoration: underline;
            color: var(--accent);
            transform: translateX(3px);
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
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="header">
        <h2><i class="fas fa-edit"></i> Edit Incident Report</h2>
        <div class="nav-links">
            <a href="dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>
    
    <div class="container">
        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> <%= error %>
            </div>
        <% } %>
        
        <% if (i != null) { %>
        <div class="card">
            <h3><i class="fas fa-edit"></i> Edit Report #<%= i.getReport_id() %></h3>
            <form action="UpdateIncidentServlet" method="post">
                <input type="hidden" name="report_id" value="<%= i.getReport_id() %>">
                <input type="hidden" name="user_id" value="<%= i.getUser_id() %>">
                
                <div class="form-group">
                    <label for="type" class="required-field">Type:</label>
                    <select id="type" name="type" required>
                        <option value="Phishing" <%= "Phishing".equals(i.getType()) ? "selected" : "" %>>Phishing</option>
                        <option value="Fraud" <%= "Fraud".equals(i.getType()) ? "selected" : "" %>>Fraud</option>
                        <option value="Hacking" <%= "Hacking".equals(i.getType()) ? "selected" : "" %>>Hacking</option>
                        <option value="Malware" <%= "Malware".equals(i.getType()) ? "selected" : "" %>>Malware</option>
                        <option value="Identity Theft" <%= "Identity Theft".equals(i.getType()) ? "selected" : "" %>>Identity Theft</option>
                        <option value="Other" <%= "Other".equals(i.getType()) ? "selected" : "" %>>Other</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="website" class="required-field">Website:</label>
                    <input type="text" id="website" name="website" value="<%= i.getWebsite() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="date" class="required-field">Date:</label>
                    <input type="date" id="date" name="date" value="<%= i.getDate() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="description" class="required-field">Description:</label>
                    <textarea id="description" name="description" required><%= i.getDescription() %></textarea>
                </div>
                
                <div class="form-group">
                    <label for="evidence_path">Evidence Path:</label>
                    <input type="text" id="evidence_path" name="evidence_path" value="<%= i.getEvidence_path() != null ? i.getEvidence_path() : "" %>">
                    <% if (i.getEvidence_path() != null && !i.getEvidence_path().isEmpty()) { %>
                        <div class="evidence-preview">
                            <p>Current evidence: <a href="<%= i.getEvidence_path() %>" target="_blank"><i class="fas fa-external-link-alt"></i> View File</a></p>
                        </div>
                    <% } %>
                </div>
                
                <div class="form-group">
                    <label for="contact_email" class="required-field">Contact Email:</label>
                    <input type="email" id="contact_email" name="contact_email" value="<%= i.getContact_email() %>" required>
                </div>
                
                <button type="submit" class="btn"><i class="fas fa-save"></i> Update Report</button>
            </form>
            
            <a href="dashboard.jsp" class="back-link">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M19 12H5M12 19l-7-7 7-7"/>
                </svg>
                Back to Dashboard
            </a>
        </div>
        <% } else { %>
            <div class="error-message">
                <i class="fas fa-exclamation-triangle"></i> Incident not found or you don't have permission to edit it.
                <a href="dashboard.jsp" style="display: block; margin-top: 0.5rem; color: var(--primary);">Return to Dashboard</a>
            </div>
        <% } %>
    </div>
</body>
</html>