<%@ page contentType="text/html;charset=UTF-8" %>
<%
String symbol = request.getParameter("symbol");
String priceStr = request.getParameter("price");

double price = 0;
try {
    price = Double.parseDouble(priceStr);
} catch(Exception e) {
    price = 100;
}
%>

<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<title>Sell Stock</title>

<style>

body{
    background:#081b33;
    font-family:Arial;
    color:white;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.card{
    background:#102544;
    padding:30px;
    border-radius:15px;
    width:400px;
    text-align:center;
}

input{
    width:90%;
    padding:12px;
    margin-top:10px;
    border:none;
    border-radius:8px;
}

button{
    background:#ff4d4d;
    color:white;
    border:none;
    padding:12px 25px;
    border-radius:8px;
    margin-top:15px;
    cursor:pointer;
    font-weight:bold;
}

.popup{
    position:fixed;
    top:0;
    left:0;
    width:100%;
    height:100%;
    background:rgba(0,0,0,0.8);
    display:none;
    justify-content:center;
    align-items:center;
}

.popup-box{
    background:#0f1f3a;
    padding:25px;
    border-radius:12px;
    text-align:center;
    width:300px;
}

.popup-box button{
    background:#ff4d4d;
}

#chartBox{
    display:none;
    margin-top:25px;
    width:100%;
}

#stockChart{
    background:#0f1f3a;
    border-radius:12px;
    padding:10px;
}

</style>

<script>

function calculateTotal(){

    let price =
    parseFloat(document.getElementById("price").value);

    let qty =
    parseInt(document.getElementById("qty").value)||0;

    document.getElementById("total").innerHTML =
    "₹ " + (price*qty).toFixed(2);
}

function openPopup(){
    document.getElementById("popup").style.display="flex";
}

function closePopup(){

    document.getElementById("popup").style.display="none";

    document.getElementById("chartBox").style.display="block";

    loadChart();
}

function loadChart(){

    const ctx =
    document.getElementById("stockChart");

    if(window.stockGraph){
        window.stockGraph.destroy();
    }

    window.stockGraph = new Chart(ctx,{

        type:'line',

        data:{

            labels:[
                '9:30',
                '10:00',
                '10:30',
                '11:00',
                '11:30',
                '12:00',
                '12:30',
                '1:00'
            ],

            datasets:[{

                label:'<%=symbol%>',

                data:[
                    <%=price+12%>,
                    <%=price+8%>,
                    <%=price+5%>,
                    <%=price%>,
                    <%=price-4%>,
                    <%=price-7%>,
                    <%=price-3%>,
                    <%=price-10%>
                ],

                borderColor:'#ff4d4d',
                backgroundColor:'rgba(255,77,77,0.15)',
                fill:true,
                tension:0.4,
                borderWidth:3
            }]
        },

        options:{
            responsive:true,

            plugins:{
                legend:{
                    labels:{
                        color:'white'
                    }
                }
            },

            scales:{
                x:{
                    ticks:{ color:'white' }
                },
                y:{
                    ticks:{ color:'white' }
                }
            }
        }
    });
}

</script>

</head>

<body>

<div class="card">

<h2>Sell Stock</h2>

<p>Stock : <%=symbol%></p>

<p>Current Price : ₹ <%= String.format("%.2f", price) %></p>

<form action="sell" method="post">

<input type="hidden"
name="stockId"
value="<%=request.getParameter("stockId")%>">

<input type="hidden"
id="price"
value="<%=price%>">

<input type="number"
id="qty"
name="quantity"
placeholder="Enter Quantity To Sell"
onkeyup="calculateTotal()"
required>

<h3 id="total">₹ 0</h3>

<button type="button"
onclick="openPopup()">
Confirm Sell
</button>

</form>

<div class="popup" id="popup">

    <div class="popup-box">

        <h3>✅ Sell Successful</h3>

        <p><b><%=symbol%></b> sold at ₹<%= String.format("%.2f", price) %></p>

        <button onclick="closePopup()">
            OK
        </button>

    </div>

</div>

<div id="chartBox">

    <h3>📉 <%=symbol%> Stock Trend</h3>

    <canvas id="stockChart"
            width="700"
            height="350">
    </canvas>

</div>

</div>

</body>
</html>