<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.stocksimulator.model.User" %>

<%
User user = (User)request.getAttribute("user");

double portfolioValue =
request.getAttribute("portfolioValue") == null
? 0
: (Double)request.getAttribute("portfolioValue");

double profit =
request.getAttribute("profit") == null
? 0
: (Double)request.getAttribute("profit");

double loss =
request.getAttribute("loss") == null
? 0
: (Double)request.getAttribute("loss");

int totalTransactions =
request.getAttribute("totalTransactions") == null
? 0
: (Integer)request.getAttribute("totalTransactions");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>

<style>

body{
    margin:0;
    background:linear-gradient(to right,#081b33,#06111f);
    font-family:Arial;
    color:white;
}

.card{
    width:500px;
    margin:60px auto;
    background:#102544;
    padding:30px;
    border-radius:15px;
    box-shadow:0 0 20px rgba(0,0,0,0.4);
}

h1{
    color:#2da8ff;
    text-align:center;
    margin-bottom:25px;
}

.info{
    margin:15px 0;
    font-size:18px;
}

.stat{
    background:#0d2342;
    margin-top:15px;
    padding:15px;
    border-radius:10px;
    font-size:18px;
}

.label{
    color:#2da8ff;
    font-weight:bold;
}

</style>
</head>

<body>

<div class="card">

<h1>👤 Profile</h1>

<div class="info">
<span class="label">Username :</span>
<%= user != null ? user.getUsername() : "N/A" %>
</div>

<div class="info">
<span class="label">Email :</span>
<%= user != null ? user.getEmail() : "N/A" %>
</div>

<div class="stat">
💰 Portfolio Value :
Rs. <%= String.format("%.2f", portfolioValue) %>
</div>

<div class="stat">
📄 Total Transactions :
<%= totalTransactions %>
</div>

<div class="stat">
📈 Total Profit :
Rs. <%= String.format("%.2f", profit) %>
</div>

<div class="stat">
📉 Total Loss :
Rs. <%= String.format("%.2f", loss) %>
</div>

</div>

</body>
</html>