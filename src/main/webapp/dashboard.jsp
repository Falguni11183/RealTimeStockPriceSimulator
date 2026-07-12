<%@ page import="java.util.List" %>
<%@ page import="com.stocksimulator.model.Stock" %>

<!DOCTYPE html>
<html>
<head>

<script>
setInterval(function() {
    location.reload();
}, 5000);
</script>

<meta charset="UTF-8">
<title>Stock Dashboard</title>

<style>

body{
    margin:0;
    font-family:Arial, sans-serif;
    background:linear-gradient(to right,#081b33,#06111f);
    color:white;
    display:flex;
}

.sidebar{
    width:250px;
    min-height:100vh;
    background:#050d18;
    border-right:1px solid rgba(255,255,255,0.1);
    padding-top:20px;
}

.logo{
    font-size:28px;
    font-weight:bold;
    color:white;
    padding:20px;
    margin-bottom:20px;
}

.sidebar a{
    display:block;
    color:white;
    text-decoration:none;
    padding:18px 25px;
    margin:10px;
    border-radius:10px;
    font-size:20px;
    transition:0.3s;
}

.sidebar a:hover{
    background:#0d2342;
}

.sidebar .active{
    background:#0d2342;
}

.container{
    flex:1;
    margin:40px;
}

h1{
    color:#2da8ff;
    font-size:48px;
    margin-bottom:30px;
}

table{
    width:100%;
    border-collapse:collapse;
    background:rgba(255,255,255,0.05);
    border-radius:15px;
    overflow:hidden;
}

th{
    background:#0d2342;
    color:#2da8ff;
    padding:20px;
    font-size:24px;
}

td{
    padding:22px;
    text-align:center;
    font-size:20px;
    border-top:1px solid rgba(255,255,255,0.08);
}

tr:hover{
    background:rgba(45,168,255,0.08);
}

.buy-btn{
    background:#1ecb6b;
    color:white;
    border:none;
    padding:10px 20px;
    border-radius:8px;
    cursor:pointer;
    font-weight:bold;
    margin-right:5px;
}

.buy-btn:hover{
    background:#16b65c;
}

.sell-btn{
    background:#ff4d4d;
    color:white;
    border:none;
    padding:10px 20px;
    border-radius:8px;
    cursor:pointer;
    font-weight:bold;
}

.sell-btn:hover{
    background:#e63939;
}

.positive{
    color:#20d46b;
    font-weight:bold;
}

.negative{
    color:#ff5b5b;
    font-weight:bold;
}

</style>

</head>

<body>

<div class="sidebar">

    <div class="logo">Live Trading Dashboard</div>

    <a href="dashboard" class="active">Dashboard</a>

    <a href="market.jsp">Market</a>

    <a href="portfolio.jsp">My Portfolio</a>

   

    <a href="transactions">Transactions</a>

    <a href="profile">Profile</a>

    <a href="LogoutServlet">Logout</a>

</div>

<div class="container">

<h1>Stock Dashboard</h1>

<table>

<tr>
    <th>Symbol</th>
    <th>Company</th>
    <th>Price</th>
    <th>Change %</th>
    <th>Action</th>
</tr>

<%
List<Stock> stocks =
(List<Stock>)request.getAttribute("stocks");

if(stocks != null){

for(Stock s : stocks){
%>

<tr>

<td><%= s.getSymbol() %></td>

<td><%= s.getCompanyName() %></td>

<td class="<%= s.getChangePercent() >= 0 ? "positive" : "negative" %>">

Rs. <%= String.format("%.2f",s.getCurrentPrice()) %>

</td>

<td class="<%= s.getChangePercent() >= 0 ? "positive" : "negative" %>">

<%= String.format("%.2f",s.getChangePercent()) %>%

</td>

<td>

<a href="buy.jsp?stockId=<%=s.getId()%>&symbol=<%=s.getSymbol()%>&price=<%=s.getCurrentPrice()%>">
<button class="buy-btn">Buy</button>
</a>

<a href="sell.jsp?stockId=<%=s.getId()%>&symbol=<%=s.getSymbol()%>&price=<%=s.getCurrentPrice()%>">
<button class="sell-btn">Sell</button>
</a>

</td>

</tr>

<%
}
}
%>

</table>

</div>

</body>
</html>