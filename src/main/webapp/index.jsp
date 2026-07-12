<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Stock Simulator</title>
<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;
}

html{
    scroll-behavior:smooth;
}

body{
    background:#070b12;
    color:#fff;
    overflow-x:hidden;
}

/* Header */

header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:18px 70px;
    background:rgba(15,23,42,.95);
    backdrop-filter:blur(12px);
    border-bottom:1px solid rgba(255,255,255,.08);
    position:sticky;
    top:0;
    z-index:1000;
}

.logo{
    font-size:30px;
    font-weight:bold;
    color:#00ff99;
    letter-spacing:1px;
}

nav a{
    color:#fff;
    text-decoration:none;
    margin-left:30px;
    font-size:16px;
    transition:.3s;
}

nav a:hover{
    color:#00ff99;
}

/* Hero */

.hero{
    display:flex;
    justify-content:space-between;
    align-items:center;
    min-height:90vh;
    padding:80px 70px;
    background:
    linear-gradient(rgba(0,0,0,.75),rgba(0,0,0,.82)),
    url("https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?auto=format&fit=crop&w=1800&q=80");
    background-size:cover;
    background-position:center;
}

.left{
    max-width:600px;
}

.left h1{
    font-size:62px;
    line-height:1.2;
    margin-bottom:25px;
}

.left p{
    font-size:18px;
    color:#d0d0d0;
    line-height:1.9;
}

/* Buttons */

.btn{
    display:inline-block;
    margin-top:35px;
    margin-right:18px;
    padding:15px 34px;
    border-radius:40px;
    background:#00ff99;
    color:#000;
    text-decoration:none;
    font-weight:bold;
    transition:.35s;
}

.btn:hover{
    transform:translateY(-5px);
    box-shadow:0 0 20px rgba(0,255,153,.5);
}

/* Live Market Card */

.card{
    width:430px;
    background:rgba(255,255,255,.07);
    backdrop-filter:blur(18px);
    border:1px solid rgba(255,255,255,.08);
    border-radius:22px;
    padding:30px;
    box-shadow:0 20px 40px rgba(0,0,0,.45);
}

.card h2{
    margin-bottom:20px;
    color:#00ff99;
}

.row{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:15px 0;
    border-bottom:1px solid rgba(255,255,255,.08);
    font-size:17px;
}

.row:last-child{
    border:none;
}

/* Stats */

.stats{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:25px;
    padding:60px 70px;
    background:#0f172a;
}

.stats div{
    background:#111d31;
    padding:30px;
    text-align:center;
    border-radius:18px;
    font-size:22px;
    font-weight:bold;
    transition:.3s;
}

.stats div:hover{
    transform:translateY(-8px);
    box-shadow:0 0 18px rgba(0,255,153,.35);
}

/* Responsive */

@media(max-width:900px){

.hero{
    flex-direction:column;
    text-align:center;
}

.card{
    width:100%;
    margin-top:40px;
}

header{
    flex-direction:column;
    gap:20px;
}

.stats{
    grid-template-columns:1fr;
}

.left h1{
    font-size:45px;
}

}
.features{
padding:80px 60px;
background:#08111f;
}

.features h2{
text-align:center;
font-size:42px;
margin-bottom:50px;
color:#00ff99;
}

.feature-container{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
gap:30px;
}

.feature-box{
background:rgba(255,255,255,.06);
backdrop-filter:blur(12px);
border:1px solid rgba(255,255,255,.08);
border-radius:20px;
padding:30px;
transition:.4s;
}

.feature-box:hover{
transform:translateY(-10px);
box-shadow:0 0 20px rgba(0,255,153,.35);
border-color:#00ff99;
}

.icon{
font-size:42px;
margin-bottom:20px;
}

.feature-box h3{
margin-bottom:15px;
color:#00ff99;
}

.feature-box p{
line-height:1.8;
color:#d0d0d0;
font-size:15px;
}

.cta{
background:#0f172a;
padding:80px 20px;
text-align:center;
}

.cta h2{
font-size:42px;
color:#00ff99;
margin-bottom:20px;
}

.cta p{
font-size:18px;
color:#d0d0d0;
margin-bottom:35px;
}
.footer{
    background:#0f172a;
    padding:25px 20px;
    text-align:center;
    border-top:1px solid rgba(255,255,255,.08);
}

.footer p{
    margin:0;
    color:#bdbdbd;
    font-size:15px;
    letter-spacing:.5px;
}
</style>
</head>
<body>
<header>
<div class="logo">📈 Stock Simulator</div>
<nav>
<a href="index.jsp">Home</a>
<a href="admin-login.html">Admin</a>
<a href="login.html">Login</a>
<a href="register.html">Register</a>
</nav>
</header>
<section class="hero">
<div class="left">
<h1>Stock Market Experience Platform</h1>
<p>Practice buying and selling stocks with virtual money. Track your portfolio and understand the market through a real-time stock price simulator.</p>
<a class="btn" href="login.html">Start Trading</a>
<a class="btn" href="register.html">Register</a>
</div>
<div class="card">

<h2>📈 Live Market Trend</h2>

<div class="row">
<span>RELIANCE</span>
<span id="relPrice" style="color:#00ff99;">₹2845.20</span>
</div>

<div class="row">
<span>TCS</span>
<span id="tcsPrice" style="color:#00ff99;">₹3921.40</span>
</div>

<div class="row">
<span>INFY</span>
<span id="infyPrice" style="color:#00ff99;">₹1678.60</span>
</div>

<div class="row">
<span>HDFC</span>
<span id="hdfcPrice" style="color:#00ff99;">₹1745.10</span>
</div>

<div class="row">
<span>ICICI</span>
<span id="iciciPrice" style="color:#00ff99;">₹1218.30</span>
</div>

</div>
</section>
<section class="features">

<h2>Why Choose Stock Simulator?</h2>

<div class="feature-container">

<div class="feature-box">
<div class="icon">📈</div>
<h3>Live Market</h3>
<p>
View live stock prices with automatic updates.
</p>
</div>

<div class="feature-box">
<div class="icon">💼</div>
<h3>Portfolio</h3>
<p>
Monitor your portfolio and investment performance.
</p>
</div>

<div class="feature-box">
<div class="icon">💹</div>
<h3>Buy & Sell Stocks</h3>
<p>
Buy and sell stocks in a risk-free environment.
</p>
</div>

<div class="feature-box">
<div class="icon">📊</div>
<h3>Profit & Loss</h3>
<p>
Analyze every trade with detailed profit and loss calculations and monitor your performance.
</p>
</div>



</div>

</section>

<section class="cta">

<h2>Ready to Start Trading?</h2>

<p>
Build your virtual portfolio, analyze the market and become a smarter investor.
</p>

<a href="login.html" class="btn">
🚀 Launch Dashboard
</a>

</section>
<footer class="footer">
    <p>© 2026 Stock Simulator | All Rights Reserved</p>
</footer>
<script>

let stocks = {
    relPrice: 2845.20,
    tcsPrice: 3921.40,
    infyPrice: 1678.60,
    hdfcPrice: 1745.10,
    iciciPrice: 1218.30
};

function updateStock(id){

    let change = (Math.random()*20)-10;

    stocks[id] += change;

    let element = document.getElementById(id);

    element.innerHTML = "₹" + stocks[id].toFixed(2);

    if(change >= 0){

        element.style.color="#00ff99";

    }else{

        element.style.color="#ff4d4d";

    }

}

setInterval(function(){

    updateStock("relPrice");
    updateStock("tcsPrice");
    updateStock("infyPrice");
    updateStock("hdfcPrice");
    updateStock("iciciPrice");

},3000);

</script>
</body>
</html>
