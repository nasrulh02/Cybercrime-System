<%@ page import="java.util.*, model.Incident" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Incident> incidents = (List<Incident>) request.getAttribute("incidents");
    if (incidents == null) {
        incidents = new ArrayList<Incident>();
    }
    
    int pendingCount = 0;
    int resolvedCount = 0;
    int rejectedCount = 0;
    for (Incident incident : incidents) {
        if ("Pending".equals(incident.getStatus())) {
            pendingCount++;
        } else if ("Rejected".equals(incident.getStatus())) {
            rejectedCount++;
        } else {
            resolvedCount++;
        }
    }
    
    // Calculate angles for pie chart
    double total = incidents.size();
    double pendingAngle = total > 0 ? (pendingCount / total) * 360 : 0;
    double resolvedAngle = total > 0 ? (resolvedCount / total) * 360 : 0;
    double rejectedAngle = total > 0 ? (rejectedCount / total) * 360 : 0;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel - Manage Incidents</title>
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
            --warning: #d97706;  /* Pending color */
            --danger: #b91c1c;    /* Rejected color */
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
            background-color: rgba(255, 255, 255, 0.1);
        }
        
        .nav-links a:hover {
            background-color: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }
        
        .container {
            padding: 2rem;
            max-width: 1600px;
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
            animation: fadeIn 0.8s ease-in-out;
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
        
        .status {
            font-weight: 600;
            font-size: 0.75rem;
            padding: 0.375rem 0.75rem;
            border-radius: 9999px;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            transition: all 0.2s ease;
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
        
        .status-form {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }
        
        select {
            padding: 0.5rem;
            border-radius: 0.375rem;
            border: 1px solid var(--gray-light);
            font-family: inherit;
            font-size: 0.875rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background-color: white;
        }
        
        select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2);
        }
        
        .btn {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            cursor: pointer;
            font-size: 0.875rem;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.25rem;
        }
        
        .btn:hover {
            background-color: var(--primary-light);
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }
        
        .stats-container {
            .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: var(--card-bg);
            border-radius: 0.75rem;
            padding: 1.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.05);
            text-align: center;
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(5px);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 150px;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        
        .stat-card h4 {
            margin: 0 0 0.5rem 0;
            color: var(--gray);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            font-weight: 500;
        }
        
        .stat-card p {
            margin: 0;
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary);
        }
        
        /* Pie Chart Styles */
        .pie-stat-card {
            background: var(--card-bg);
            border-radius: 0.75rem;
            padding: 1.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.05);
            text-align: center;
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(5px);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        
        .pie-stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        
        .pie-stat-card h4 {
            margin: 0 0 1rem 0;
            color: var(--gray);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            font-weight: 500;
        }
        
        .pie-chart {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: conic-gradient(
                var(--warning) 0deg <%= pendingAngle %>deg,
                var(--success) <%= pendingAngle %>deg <%= pendingAngle + resolvedAngle %>deg,
                var(--danger) <%= pendingAngle + resolvedAngle %>deg 360deg
            );
            animation: pieGrow 1s ease-out;
            margin-bottom: 1rem;
        }
        
        @keyframes pieGrow {
            from { transform: scale(0.5); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }
        
        .pie-legend {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            justify-content: center;
        }
        
        .legend-item {
            display: flex;
            align-items: center;
            gap: 0.25rem;
            font-size: 0.75rem;
        }
        
        .legend-color {
            width: 10px;
            height: 10px;
            border-radius: 50%;
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="header">
        <h2><i class="fas fa-shield-alt"></i> Admin Dashboard</h2>
        <div class="nav-links">
            <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="stats-container">
            <div class="stat-card">
                <h4>Total Reports</h4>
                <p><%= incidents.size() %></p>
            </div>
            
            <div class="pie-stat-card">
                <h4>Reports Status</h4>
                <div class="pie-chart"></div>
                <div class="pie-legend">
                    <div class="legend-item">
                        <span class="legend-color" style="background-color: var(--warning);"></span>
                        <span>Pending (<%= pendingCount %>)</span>
                    </div>
                    <div class="legend-item">
                        <span class="legend-color" style="background-color: var(--success);"></span>
                        <span>Resolved (<%= resolvedCount %>)</span>
                    </div>
                    <div class="legend-item">
                        <span class="legend-color" style="background-color: var(--danger);"></span>
                        <span>Rejected (<%= rejectedCount %>)</span>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="card">
            <h3><i class="fas fa-clipboard-list"></i> Incident Reports</h3>
            <table>
                <tr>
                    <th>Report ID</th>
                    <th>User ID</th>
                    <th>Type</th>
                    <th>Website</th>
                    <th>Date</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                <% for (Incident i : incidents) { %>
                <tr>
                    <td><%= i.getReport_id() %></td>
                    <td><%= i.getUser_id() %></td>
                    <td><%= i.getType() %></td>
                    <td><%= i.getWebsite() %></td>
                    <td><%= i.getDate() %></td>
                    <td><%= i.getDescription() %></td>
                    <td><span class="status status-<%= i.getStatus().toLowerCase() %>"><%= i.getStatus() %></span></td>
                    <td>
                        <form action="UpdateStatusServlet" method="post" class="status-form">
                            <input type="hidden" name="report_id" value="<%= i.getReport_id() %>">
                            <select name="status">
                                <option value="Pending" <%= "Pending".equals(i.getStatus()) ? "selected" : "" %>>Pending</option>
                                <option value="Approved" <%= "Approved".equals(i.getStatus()) ? "selected" : "" %>>Approved</option>
                                <option value="Rejected" <%= "Rejected".equals(i.getStatus()) ? "selected" : "" %>>Rejected</option>
                            </select>
                            <input type="submit" value="Update" class="btn">
                        </form>
                    </td>
                </tr>
                <% } %>
            </table>
        </div>
    </div>
</body>
</html>