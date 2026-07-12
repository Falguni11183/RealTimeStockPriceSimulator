<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<link rel="stylesheet" href="admin-style.css">

<style>
body{
    margin:0;
    font-family:Arial, sans-serif;
    background:#f4f6f9;
}

.sidebar{
    width:220px;
    height:100vh;
    background:#1e293b;
    position:fixed;
    left:0;
    top:0;
    padding-top:20px;
}

.sidebar h2{
    color:white;
    text-align:center;
}

.sidebar a{
    display:block;
    color:white;
    padding:12px 20px;
    text-decoration:none;
}

.sidebar a:hover{
    background:#334155;
}

.main{
    margin-left:220px;
    padding:20px;
}

.topbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.admin-badge{
    background:#2563eb;
    color:white;
    padding:8px 15px;
    border-radius:20px;
}

.stats-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:20px;
    margin-top:25px;
}

.stat-card{
    background:white;
    padding:20px;
    border-radius:12px;
    box-shadow:0 2px 8px rgba(0,0,0,0.1);
    text-align:center;
}

.stat-icon{
    font-size:35px;
}

.stat-val{
    font-size:28px;
    font-weight:bold;
    margin:10px 0;
}

.stat-lbl{
    color:#666;
}

.quick-links{
    margin-top:30px;
    display:flex;
    flex-wrap:wrap;
    gap:15px;
}

.qlink{
    text-decoration:none;
    color:white;
    padding:12px 20px;
    border-radius:8px;
}

.blue{background:#2563eb;}
.green{background:#16a34a;}
.orange{background:#ea580c;}
.red{background:#dc2626;}
</style>
</head>

<body>

<div class="sidebar">
    <h2>Admin Panel</h2>

    <a href="adminDashboard">Dashboard</a>
    <a href="adminUsers">Users</a>
    <a href="adminStocks">Stocks</a>
    <a href="adminTransactions">Transactions</a>
    <a href="adminLogout">Logout</a>
</div>

<div class="main">

    <div class="topbar">
        <h1>Admin Dashboard</h1>
        <span class="admin-badge">
            Admin :
            <%= session.getAttribute("adminUser") %>
        </span>
    </div>

    <div class="stats-grid">

        <div class="stat-card">
            <div class="stat-icon">👥</div>
            <div class="stat-val">
                <%= request.getAttribute("totalUsers") == null ? 0 : request.getAttribute("totalUsers") %>
            </div>
            <div class="stat-lbl">Total Users</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">📈</div>
            <div class="stat-val">
                <%= request.getAttribute("totalStocks") == null ? 0 : request.getAttribute("totalStocks") %>
            </div>
            <div class="stat-lbl">Stocks Listed</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">🔄</div>
            <div class="stat-val">
                <%= request.getAttribute("totalTx") == null ? 0 : request.getAttribute("totalTx") %>
            </div>
            <div class="stat-lbl">Transactions</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">💰</div>
            <div class="stat-val">
                ₹ <%= request.getAttribute("tradingVolume") == null ? 0 : request.getAttribute("tradingVolume") %>
            </div>
            <div class="stat-lbl">Trading Volume</div>
        </div>

    </div>

    <div class="quick-links">

        <a href="adminUsers" class="qlink blue">
            Manage Users
        </a>

        <a href="adminStocks" class="qlink green">
            Manage Stocks
        </a>

        <a href="adminTransactions" class="qlink orange">
            All Transactions
        </a>

        <a href="adminLogout" class="qlink red">
            Logout
        </a>

    </div>

</div>

</body>
</html>