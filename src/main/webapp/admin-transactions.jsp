<%@ page import="java.util.List" %>
<%@ page import="com.stocksimulator.model.Transaction" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Transactions - Admin</title>
<style>
*{
    box-sizing:border-box;
    margin:0;
    padding:0;
}

body{
    font-family:Arial,sans-serif;
    background:linear-gradient(to right,#030b14,#081b33);
    color:white;
    display:flex;
    min-height:100vh;
}

/* Sidebar */
.sidebar{
    width:220px;
    min-height:100vh;
    background:#050d18;
    border-right:1px solid rgba(255,255,255,0.08);
    padding:16px 0;
    display:flex;
    flex-direction:column;
    flex-shrink:0;
}

.logo{
    font-size:20px;
    font-weight:bold;
    color:#e63946;
    padding:16px 20px 28px;
    line-height:1.4;
}

.nav-item{
    display:block;
    color:rgba(255,255,255,0.7);
    padding:13px 20px;
    margin:3px 10px;
    border-radius:8px;
    text-decoration:none;
    font-size:14px;
    transition:0.3s;
}

.nav-item:hover,
.nav-item.active{
    background:#1a0a0e;
    color:white;
}

/* Main Content */
.main{
    flex:1;
    padding:30px;
    overflow-y:auto;
}

/* Top Bar */
.topbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:24px;
}

.topbar h1{
    color:#e63946;
    font-size:28px;
}

.admin-badge{
    background:rgba(230,57,70,0.15);
    border:1px solid #e63946;
    border-radius:20px;
    padding:6px 16px;
    color:#e63946;
    font-size:13px;
}

/* Table */
table{
    width:100%;
    border-collapse:collapse;
    background:rgba(255,255,255,0.04);
    border-radius:12px;
    overflow:hidden;
    font-size:13px;
}

th{
    background:#1a0a0e;
    color:#e63946;
    padding:13px 16px;
    text-align:center;
}

td{
    padding:12px 16px;
    text-align:center;
    border-top:1px solid rgba(255,255,255,0.07);
    color:white;
}

tr:hover{
    background:rgba(230,57,70,0.05);
}

/* Transaction Badges */
.badge-buy{
    background:rgba(32,212,107,0.15);
    border:1px solid #20d46b;
    border-radius:5px;
    padding:3px 10px;
    color:#20d46b;
    font-weight:bold;
}

.badge-sell{
    background:rgba(255,91,91,0.15);
    border:1px solid #ff5b5b;
    border-radius:5px;
    padding:3px 10px;
    color:#ff5b5b;
    font-weight:bold;
}
</style>
</head>
<body>
<div class="sidebar">
    <div class="logo">⚙️ Admin<br><span style="font-size:12px;color:rgba(255,255,255,0.4)">Stock Simulator</span></div>
    <a href="adminDashboard"    class="nav-item">📊 Dashboard</a>
    <a href="adminUsers"        class="nav-item">👥 Users</a>
    <a href="adminStocks"       class="nav-item">📈 Stocks</a>
    <a href="adminTransactions" class="nav-item active">🔄 Transactions</a>
    <div style="margin-top:auto;padding:20px">
        <a href="adminLogout" class="nav-item" style="color:#ff5b5b">🚪 Logout</a>
    </div>
</div>
<div class="main">
    <div class="topbar">
        <h1>🔄 All Transactions</h1>
        <span class="admin-badge">👤 <%= session.getAttribute("adminUser") %></span>
    </div>

    <table>
        <tr>
            <th>#</th>
            <th>Txn ID</th>
            <th>User</th>
            <th>Stock</th>
            <th>Type</th>
            <th>Qty</th>
            <th>Price (Rs.)</th>
            <th>Total (Rs.)</th>
        </tr>
        <%
        List<Transaction> txns = (List<Transaction>) request.getAttribute("transactions");
        int sr = 1;
        for (Transaction t : txns) {
        %>
        <tr>
            <td><%= sr++ %></td>
            <td>#<%= t.getId() %></td>
            <td><strong><%= t.getUsername() %></strong></td>
            <td><%= t.getSymbol() %></td>
            <td>
                <% if ("BUY".equalsIgnoreCase(t.getType())) { %>
                    <span class="badge-buy">BUY</span>
                <% } else { %>
                    <span class="badge-sell">SELL</span>
                <% } %>
            </td>
            <td><%= t.getQuantity() %></td>
            <td>Rs. <%= String.format("%,.2f", t.getPrice()) %></td>
            <td>Rs. <%= String.format("%,.2f", t.getTotal()) %></td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
