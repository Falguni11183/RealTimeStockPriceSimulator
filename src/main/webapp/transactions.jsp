<%@ page import="java.util.*" %>
<%@ page import="com.stocksimulator.model.Transaction" %>

<%
List<Transaction> list =
(List<Transaction>)request.getAttribute("transactions");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transactions</title>

<style>

body{
    margin:0;
    background:linear-gradient(to right,#081b33,#06111f);
    font-family:Arial;
    color:white;
}

.container{
    width:95%;
    margin:30px auto;
}

h1{
    color:#2da8ff;
    margin-bottom:20px;
}

table{
    width:100%;
    border-collapse:collapse;
    background:rgba(255,255,255,0.05);
}

th{
    background:#0d2342;
    color:#2da8ff;
    padding:15px;
}

td{
    padding:15px;
    text-align:center;
    border-top:1px solid rgba(255,255,255,0.08);
}

.buy{
    color:#1ecb6b;
    font-weight:bold;
}

.sell{
    color:#ff4d4d;
    font-weight:bold;
}

</style>
</head>

<body>

<div class="container">

<h1>Transaction History</h1>
<h2>Total Records: <%= list == null ? "NULL" : list.size() %></h2>

<table>

<tr>
    <th>Stock</th>
    <th>Type</th>
    <th>Quantity</th>
    <th>Price</th>
    <th>Total</th>
</tr>

<%
if(list != null){

for(Transaction t : list){
%>

<tr>

<td><%= t.getSymbol() %></td>

<td class="<%= t.getType().equals("BUY") ? "buy" : "sell" %>">
<%= t.getType() %>
</td>

<td><%= t.getQuantity() %></td>

<td>Rs. <%= String.format("%.2f", t.getPrice()) %></td>

<td>Rs. <%= String.format("%.2f", t.getTotal()) %></td>

</tr>

<%
}
}
%>

</table>

</div>

</body>
</html>