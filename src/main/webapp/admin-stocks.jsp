<%@ page import="java.util.List" %>
<%@ page import="com.stocksimulator.model.Stock" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Stocks - Admin</title>
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }

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
    margin-bottom: 24px;
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
    font-size: 16px;
    margin-bottom: 12px;
}

.add-form {
    display: flex;
    gap: 12px;
    align-items: flex-end;
    flex-wrap: wrap;
    margin-bottom: 26px;
    padding: 18px;
    background: rgba(255,255,255,0.04);
    border-radius: 12px;
}

.add-form label {
    font-size: 12px;
    color: rgba(255,255,255,0.55);
    display: block;
    margin-bottom: 5px;
}

.add-form input {
    background: rgba(255,255,255,0.08);
    border: 1px solid rgba(255,255,255,0.15);
    border-radius: 7px;
    padding: 9px 12px;
    color: white;
    font-size: 13px;
    outline: none;
}

.add-form input:focus {
    border-color: #e63946;
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
    padding: 11px 16px;
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

.btn-green {
    background: #20d46b;
    color: white;
}

.btn-green:hover {
    background: #18b85d;
}

.btn-blue {
    background: #2da8ff;
    color: white;
}

.btn-blue:hover {
    background: #1a8ee0;
}

.btn-red {
    background: #e63946;
    color: white;
}

.btn-red:hover {
    background: #c0303c;
}

.edit-input {
    background: rgba(255,255,255,0.08);
    border: 1px solid rgba(255,255,255,0.15);
    border-radius: 5px;
    padding: 4px 8px;
    color: white;
    font-size: 12px;
}

.pos {
    color: #20d46b;
}

.neg {
    color: #ff5b5b;
}
</style>
</head>
<body>
<div class="sidebar">
    <div class="logo">⚙️ Admin<br><span style="font-size:12px;color:rgba(255,255,255,0.4)">Stock Simulator</span></div>
    <a href="adminDashboard"    class="nav-item">📊 Dashboard</a>
    <a href="adminUsers"        class="nav-item">👥 Users</a>
    <a href="adminStocks"       class="nav-item active">📈 Stocks</a>
    <a href="adminTransactions" class="nav-item">🔄 Transactions</a>
    <div style="margin-top:auto;padding:20px">
        <a href="adminLogout" class="nav-item" style="color:#ff5b5b">🚪 Logout</a>
    </div>
</div>
<div class="main">
    <div class="topbar">
        <h1>📈 Manage Stocks</h1>
        <span class="admin-badge">👤 <%= session.getAttribute("adminUser") %></span>
    </div>

    <!-- Add Stock Form -->
    <h2>➕ Add New Stock</h2>
    <form action="adminStocks" method="post" class="add-form">
        <input type="hidden" name="action" value="add"/>
        <div>
            <label>Symbol</label>
            <input type="text" name="symbol" placeholder="e.g. INFY" required maxlength="10" style="width:100px"/>
        </div>
        <div>
            <label>Company Name</label>
            <input type="text" name="companyName" placeholder="e.g. Infosys Ltd" required style="width:220px"/>
        </div>
        <div>
            <label>Initial Price (Rs.)</label>
            <input type="number" name="price" placeholder="e.g. 1500.00" step="0.01" min="0.01" required style="width:140px"/>
        </div>
        <button class="btn btn-green" type="submit" style="padding:9px 20px">➕ Add Stock</button>
    </form>

    <!-- Stocks Table -->
    <h2>📋 All Stocks</h2>
    <table>
        <tr>
            <th>#</th>
            <th>Symbol</th>
            <th>Company Name</th>
            <th>Current Price</th>
            <th>Change %</th>
            <th>Edit</th>
            <th>Delete</th>
        </tr>
        <%
        List<Stock> stocks = (List<Stock>) request.getAttribute("stocks");
        int sr = 1;
        for (Stock s : stocks) {
            String cls = s.getChangePercent() >= 0 ? "pos" : "neg";
            String arrow = s.getChangePercent() >= 0 ? "▲" : "▼";
        %>
        <tr>
            <td><%= sr++ %></td>
            <!-- Inline edit form -->
            <form action="adminStocks" method="post">
                <input type="hidden" name="action" value="edit"/>
                <input type="hidden" name="id"     value="<%= s.getId() %>"/>
                <td><input class="edit-input" name="symbol"      value="<%= s.getSymbol() %>"      style="width:70px"/></td>
                <td><input class="edit-input" name="companyName" value="<%= s.getCompanyName() %>" style="width:180px"/></td>
                <td><input class="edit-input" name="price" type="number" step="0.01"
                           value="<%= String.format("%.2f", s.getCurrentPrice()) %>" style="width:100px"/></td>
                <td class="<%= cls %>"><%= arrow %> <%= String.format("%.2f", s.getChangePercent()) %>%</td>
                <td><button class="btn btn-blue" type="submit">💾 Save</button></td>
            </form>
            <td>
                <form action="adminStocks" method="post"
                      onsubmit="return confirm('Delete <%= s.getSymbol() %>?')">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="id"     value="<%= s.getId() %>"/>
                    <button class="btn btn-red" type="submit">🗑 Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
