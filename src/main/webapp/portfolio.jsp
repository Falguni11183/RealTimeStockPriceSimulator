<%@ page import="java.util.*, com.stocksimulator.model.Portfolio" %>
<%@ page import="com.stocksimulator.dao.PortfolioDAO" %>

<%
Integer userId = (Integer) session.getAttribute("userId");

if(userId == null){
    response.sendRedirect("login.jsp");
    return;
}

PortfolioDAO dao = new PortfolioDAO();
List<Portfolio> list = dao.getUserPortfolio(userId);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Portfolio</title>

<style>

body{
    margin:0;
    font-family:Arial,sans-serif;
    background:linear-gradient(to right,#081b33,#06111f);
    color:white;
    min-height:100vh;
}

.container{
    width:95%;
    margin:40px auto;
}

h2{
    text-align:center;
    color:#2da8ff;
    font-size:42px;
    margin-bottom:30px;
}

.back-btn{
    display:inline-block;
    margin-bottom:20px;
    padding:10px 20px;
    background:#0d2342;
    color:white;
    text-decoration:none;
    border-radius:8px;
    font-weight:bold;
}

.back-btn:hover{
    background:#17406f;
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
    padding:18px;
    font-size:22px;
}

td{
    padding:18px;
    text-align:center;
    font-size:18px;
    border-top:1px solid rgba(255,255,255,0.08);
}

tr:hover{
    background:rgba(45,168,255,0.08);
}

input[type="number"]{
    width:80px;
    padding:8px;
    border:none;
    border-radius:6px;
    text-align:center;
}

.sell-btn{
    background:#ff4d4d;
    color:white;
    border:none;
    padding:10px 16px;
    border-radius:8px;
    cursor:pointer;
    font-weight:bold;
}

.sell-btn:hover{
    background:#e63939;
}

.no-data{
    text-align:center;
    padding:30px;
    color:#ccc;
    font-size:20px;
}

</style>
</head>

<body>

<div class="container">

<a href="dashboard" class="back-btn"> Dashboard</a>

<h2>My Portfolio</h2>

<table>

<tr>
    <th>Symbol</th>
    <th>Company</th>
    <th>Quantity</th>
    <th>Buy Price</th>
    <th>Total Value</th>
    <th>Action</th>
</tr>

<%
if(list != null && !list.isEmpty()){

    for(Portfolio p : list){

        double total = p.getQuantity() * p.getBuyPrice();
%>

<tr>

    <td><%= p.getStockSymbol() %></td>

    <td><%= p.getCompanyName() %></td>

    <td><%= p.getQuantity() %></td>

    <td>Rs. <%= String.format("%.2f", p.getBuyPrice()) %></td>

    <td>Rs. <%= String.format("%.2f", total) %></td>

    <td>

        <form action="portfolio" method="post">

            <input type="hidden" name="action" value="sell">

            <input type="hidden" name="portfolioId"
                   value="<%= p.getId() %>">

            <input type="number"
                   name="quantity"
                   min="1"
                   max="<%= p.getQuantity() %>"
                   placeholder="Qty"
                   required>

            <button class="sell-btn" type="submit">
                Sell
            </button>

        </form>

    </td>

</tr>

<%
    }

}else{
%>

<tr>
    <td colspan="6" class="no-data">
        No stocks in portfolio
    </td>
</tr>

<%
}
%>

</table>

</div>

</body>
</html>