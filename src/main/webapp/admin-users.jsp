<%@ page import="java.util.List" %>
<%@ page import="com.stocksimulator.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Users - Admin</title>
<style>
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: Arial, sans-serif;
    background: linear-gradient(to right, #030b14, #081b33);
    color: white;
    display: flex;
    min-height: 100vh;
}

.sidebar {
    width: 220px;
    min-height: 100vh;
    background: #050d18;
    border-right: 1px solid rgba(255,255,255,0.08);
    padding: 16px 0;
    display: flex;
    flex-direction: column;
    flex-shrink: 0;
}

.logo {
    font-size: 20px;
    font-weight: bold;
    color: #e63946;
    padding: 16px 20px 28px;
    line-height: 1.4;
}

.nav-item {
    display: block;
    color: rgba(255,255,255,0.7);
    padding: 13px 20px;
    margin: 3px 10px;
    border-radius: 8px;
    text-decoration: none;
    font-size: 14px;
}

.nav-item:hover,
.nav-item.active {
    background: #1a0a0e;
    color: white;
}

.main {
    flex: 1;
    padding: 30px;
    overflow-y: auto;
}

.topbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 28px;
}

.topbar h1 {
    color: #e63946;
    font-size: 28px;
}

.admin-badge {
    background: rgba(230,57,70,0.15);
    border: 1px solid #e63946;
    border-radius: 20px;
    padding: 6px 16px;
    color: #e63946;
    font-size: 13px;
}

h2 {
    color: #e63946;
    font-size: 18px;
    margin-bottom: 14px;
}

table {
    width: 100%;
    border-collapse: collapse;
    background: rgba(255,255,255,0.04);
    border-radius: 12px;
    overflow: hidden;
    font-size: 13px;
}

th {
    background: #1a0a0e;
    color: #e63946;
    padding: 13px 16px;
    text-align: center;
}

td {
    padding: 12px 16px;
    text-align: center;
    border-top: 1px solid rgba(255,255,255,0.07);
    color: white;
}

tr:hover {
    background: rgba(230,57,70,0.05);
}

.btn {
    padding: 7px 14px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
}

.btn-red {
    background: #e63946;
    color: white;
}

.btn-red:hover {
    background: #c0303c;
}

.btn-green {
    background: #20d46b;
    color: white;
}

.btn-green:hover {
    background: #18b85d;
}

.bal-input {
    background: rgba(255,255,255,0.08);
    border: 1px solid rgba(255,255,255,0.2);
    border-radius: 6px;
    padding: 5px 8px;
    color: white;
    font-size: 12px;
    width: 110px;
}
</style>
</head>
<body>
<div class="sidebar">
    <div class="logo">⚙️ Admin<br><span style="font-size:12px;color:rgba(255,255,255,0.4)">Stock Simulator</span></div>
    <a href="adminDashboard"    class="nav-item">📊 Dashboard</a>
    <a href="adminUsers"        class="nav-item active">👥 Users</a>
    <a href="adminStocks"       class="nav-item">📈 Stocks</a>
    <a href="adminTransactions" class="nav-item">🔄 Transactions</a>
    <div style="margin-top:auto;padding:20px">
        <a href="adminLogout" class="nav-item" style="color:#ff5b5b">🚪 Logout</a>
    </div>
</div>
<div class="main">
    <div class="topbar">
        <h1>👥 Manage Users</h1>
        <span class="admin-badge">👤 <%= session.getAttribute("adminUser") %></span>
    </div>

    <table>
        <tr>
            <th>#</th>
            <th>Username</th>
            <th>Email</th>
            <th>Balance (Rs.)</th>
            <th>Update Balance</th>
            <th>Delete</th>
        </tr>
        <%
        List<User> users = (List<User>) request.getAttribute("users");
        int sr = 1;
        for (User u : users) {
        %>
        <tr>
            <td><%= sr++ %></td>
            <td><strong><%= u.getUsername() %></strong></td>
            <td><%= u.getEmail() %></td>
            <td>Rs. <%= String.format("%,.2f", u.getBalance()) %></td>
            <td>
                <form action="adminUsers" method="post" style="display:inline-flex;gap:6px;align-items:center">
                    <input type="hidden" name="action" value="updateBalance"/>
                    <input type="hidden" name="id"     value="<%= u.getId() %>"/>
                    <input type="number" name="balance" class="bal-input" value="<%= (int)u.getBalance() %>" step="1000" min="0"/>
                    <button class="btn btn-green" type="submit">✔ Set</button>
                </form>
            </td>
            <td>
                <form action="adminUsers" method="post"
                      onsubmit="return confirm('Delete user <%= u.getUsername() %>?')">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="id"     value="<%= u.getId() %>"/>
                    <button class="btn btn-red" type="submit">🗑 Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
