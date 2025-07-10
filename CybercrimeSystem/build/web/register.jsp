<html>
<head>
    <title>Register</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: white;
            line-height: 1.6;
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
        
        .register-container {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 1.5rem;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3), 0 10px 10px -5px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            width: 90%;
            max-width: 800px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(10px);
            animation: slideUp 0.6s ease-out;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }
        
        .register-header {
            grid-column: 1 / -1;
        }
        
        .register-form {
            grid-column: 1 / -1;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }
        
        .form-group {
            margin-bottom: 1rem;
            text-align: left;
            animation: fadeIn 0.8s ease-out;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        @keyframes slideUp {
            from { 
                opacity: 0;
                transform: translateY(30px);
            }
            to { 
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .logo {
            color: white;
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }
        
        .logo-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            color: white;
            font-weight: bold;
            font-size: 1.25rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.3);
        }
        
        h2 {
            color: white;
            margin-bottom: 1.5rem;
            font-weight: 600;
            font-size: 1.5rem;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
            font-weight: 500;
            color: rgba(255, 255, 255, 0.9);
        }
        
        input[type="text"], 
        input[type="password"], 
        input[type="email"] {
            width: 100%;
            padding: 0.875rem;
            margin: 0.25rem 0;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 0.75rem;
            box-sizing: border-box;
            font-size: 0.9375rem;
            font-family: inherit;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: rgba(255, 255, 255, 0.1);
            color: white;
        }
        
        input[type="text"]::placeholder,
        input[type="password"]::placeholder,
        input[type="email"]::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }
        
        input[type="text"]:focus, 
        input[type="password"]:focus, 
        input[type="email"]:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.3);
            background: rgba(255, 255, 255, 0.2);
        }
        
        input[type="submit"] {
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            color: white;
            padding: 0.9375rem;
            border: none;
            border-radius: 0.75rem;
            cursor: pointer;
            font-size: 1rem;
            width: 100%;
            margin-top: 0.5rem;
            font-weight: 600;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.3);
            grid-column: 1 / -1;
        }
        
        input[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.3);
        }
        
        .password-container {
            margin-top: 0.5rem;
        }
        
        .password-strength {
            height: 4px;
            background: var(--gray-light);
            border-radius: 2px;
            margin-top: 0.5rem;
            overflow: hidden;
            display: none; /* Initially hidden */
        }
        
        .password-strength-bar {
            height: 100%;
            width: 0%;
            background: var(--danger);
            transition: all 0.3s ease;
        }
        
        .password-strength-weak .password-strength-bar {
            width: 30%;
            background: var(--danger);
        }
        
        .password-strength-medium .password-strength-bar {
            width: 60%;
            background: var(--warning);
        }
        
        .password-strength-strong .password-strength-bar {
            width: 100%;
            background: var(--success);
        }
        
        .password-match {
            font-size: 0.75rem;
            margin-top: 0.25rem;
            color: var(--danger);
            display: none;
        }
        
        .password-match.valid {
            color: var(--success);
        }
        
        .login-link {
            margin-top: 1rem;
            display: block;
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            grid-column: 1 / -1;
        }
        
        .login-link:hover {
            color: var(--primary-light);
            text-decoration: underline;
            transform: translateX(5px);
        }
        
        .error {
            color: var(--danger);
            margin-top: 1rem;
            font-size: 0.875rem;
            background-color: rgba(239, 68, 68, 0.2);
            padding: 1rem;
            border-radius: 0.75rem;
            border: 1px solid rgba(239, 68, 68, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            animation: shake 0.5s cubic-bezier(.36,.07,.19,.97) both;
            grid-column: 1 / -1;
        }
        
        @keyframes shake {
            10%, 90% { transform: translateX(-1px); }
            20%, 80% { transform: translateX(2px); }
            30%, 50%, 70% { transform: translateX(-4px); }
            40%, 60% { transform: translateX(4px); }
        }
        
        @media (max-width: 768px) {
            .register-container {
                grid-template-columns: 1fr;
                padding: 1.5rem;
                margin: 1rem;
                border-radius: 1rem;
                max-width: 400px;
            }
            
            .register-form {
                grid-template-columns: 1fr;
            }
            
            h2 {
                font-size: 1.25rem;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <div class="logo">
                <span class="logo-icon">C</span>
                <span>CyberSecure</span>
            </div>
            <h2>Create Account</h2>
        </div>
        
        <form method="post" action="RegisterServlet" class="register-form">
            <div class="form-group">
                <label for="full_name">Full Name</label>
                <input type="text" id="full_name" name="full_name" placeholder="Full Name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="your@email.com" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Create a password" required onkeyup="checkPasswordStrength()">
                <div class="password-container">
                    <div class="password-strength" id="password-strength">
                        <div class="password-strength-bar" id="password-strength-bar"></div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="confirm_password">Confirm Password</label>
                <input type="password" id="confirm_password" name="confirm_password" placeholder="Confirm password" required onkeyup="checkPasswordMatch()">
                <div class="password-match" id="password-match">Passwords don't match</div>
            </div>
            <div class="form-group">
                <label for="security_question">Security Question</label>
                <input type="text" id="security_question" name="security_question" placeholder="What city were you born in?" required>
            </div>
            <div class="form-group">
                <label for="security_answer">Security Answer</label>
                <input type="text" id="security_answer" name="security_answer" placeholder="Your answer" required>
            </div>
            
            <input type="submit" value="Register">
            
            <a href="login.jsp" class="login-link">
                <i class="fas fa-sign-in-alt"></i> Already have an account? Sign in
            </a>
            
            <div class="error">${error}</div>
        </form>
    </div>

    <script>
        function checkPasswordStrength() {
            const password = document.getElementById('password').value;
            const strengthBar = document.getElementById('password-strength-bar');
            const strengthContainer = document.getElementById('password-strength');
            
            // Show the strength container when typing begins
            strengthContainer.style.display = password.length > 0 ? 'block' : 'none';
            
            // Reset classes
            strengthContainer.className = 'password-strength';
            
            if (password.length === 0) {
                strengthBar.style.width = '0%';
                strengthContainer.style.display = 'none';
                return;
            }
            
            // Calculate strength
            let strength = 0;
            if (password.length > 3) strength += 3;
            if (password.length > 5) strength += 3;
            if (/[A-Z]/.test(password)) strength += 3;
            if (/[0-9]/.test(password)) strength += 3;
            if (/[^A-Za-z0-9]/.test(password)) strength += 3;
            
            // Update UI
            if (strength <= 3) {
                strengthContainer.classList.add('password-strength-weak');
            } else if (strength <= 9) {
                strengthContainer.classList.add('password-strength-medium');
            } else {
                strengthContainer.classList.add('password-strength-strong');
            }
            
            // Also check match when password changes
            checkPasswordMatch();
        }
        
        function checkPasswordMatch() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirm_password').value;
            const matchMessage = document.getElementById('password-match');
            
            if (password.length === 0 || confirmPassword.length === 0) {
                matchMessage.style.display = 'none';
                return;
            }
            
            if (password === confirmPassword) {
                matchMessage.textContent = 'Passwords match';
                matchMessage.classList.add('valid');
                matchMessage.style.display = 'block';
            } else {
                matchMessage.textContent = 'Passwords don\'t match';
                matchMessage.classList.remove('valid');
                matchMessage.style.display = 'block';
            }
        }
    </script>
</body>
</html>