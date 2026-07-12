<%@ page import="java.util.List" %>
<%@ page import="com.stocksimulator.model.Stock" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>

<script>
/* Auto-refresh every 10 seconds (keeps search query in URL) */
setTimeout(function() {
    var q = document.getElementById("searchInput").value;
    window.location.href = "market?query=" + encodeURIComponent(q);
}, 10000);
</script>

<meta charset="UTF-8">
<title>Market - Stock Simulator</title>

<style>

/* ── Base ────────────────────────────────────────────────── */
* { box-sizing: border-box; margin: 0; padding: 0; }

body {
    font-family: Arial, sans-serif;
    background: linear-gradient(to right, #081b33, #06111f);
    color: white;
    display: flex;
    min-height: 100vh;
}

/* ── Sidebar ─────────────────────────────────────────────── */
.sidebar {
    width: 250px;
    min-height: 100vh;
    background: #050d18;
    border-right: 1px solid rgba(255,255,255,0.1);
    padding-top: 20px;
    flex-shrink: 0;
}

.logo {
    font-size: 22px;
    font-weight: bold;
    color: white;
    padding: 20px;
    margin-bottom: 20px;
}

.sidebar a {
    display: block;
    color: white;
    text-decoration: none;
    padding: 18px 25px;
    margin: 10px;
    border-radius: 10px;
    font-size: 18px;
    transition: 0.3s;
}

.sidebar a:hover { background: #0d2342; }
.sidebar .active  { background: #0d2342; }

/* ── Main content ────────────────────────────────────────── */
.container { flex: 1; padding: 40px; }

h1 { color: #2da8ff; font-size: 40px; margin-bottom: 30px; }
h2 { color: #2da8ff; font-size: 22px; margin-bottom: 14px; }

/* ── Search bar ──────────────────────────────────────────── */
.search-bar {
    display: flex;
    gap: 12px;
    margin-bottom: 36px;
}

.search-bar input {
    flex: 1;
    padding: 14px 20px;
    border-radius: 10px;
    border: 1px solid rgba(255,255,255,0.2);
    background: rgba(255,255,255,0.07);
    color: white;
    font-size: 16px;
    outline: none;
    transition: border 0.3s;
}

.search-bar input:focus {
    border-color: #2da8ff;
}

.search-bar button {
    padding: 14px 28px;
    background: #2da8ff;
    color: white;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: background 0.3s;
}

.search-bar button:hover { background: #1a8ee0; }

/* ── Tables ──────────────────────────────────────────────── */
.table-section { margin-bottom: 50px; }

table {
    width: 100%;
    border-collapse: collapse;
    background: rgba(255,255,255,0.05);
    border-radius: 15px;
    overflow: hidden;
}

th {
    background: #0d2342;
    color: #2da8ff;
    padding: 16px 20px;
    font-size: 15px;
    text-align: center;
}

td {
    padding: 16px 20px;
    text-align: center;
    font-size: 15px;
    border-top: 1px solid rgba(255,255,255,0.08);
}

tr:hover { background: rgba(45,168,255,0.07); }

.positive { color: #20d46b; font-weight: bold; }
.negative { color: #ff5b5b; font-weight: bold; }

.badge-gain {
    background: rgba(32,212,107,0.15);
    border: 1px solid #20d46b;
    border-radius: 6px;
    padding: 3px 10px;
    color: #20d46b;
    font-weight: bold;
}

.badge-loss {
    background: rgba(255,91,91,0.15);
    border: 1px solid #ff5b5b;
    border-radius: 6px;
    padding: 3px 10px;
    color: #ff5b5b;
    font-weight: bold;
}

/* ── Action buttons ──────────────────────────────────────── */
.buy-btn {
    background: #1ecb6b;
    color: white;
    border: none;
    padding: 8px 18px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: bold;
    margin-right: 5px;
    font-size: 13px;
}
.buy-btn:hover  { background: #16b65c; }

.sell-btn {
    background: #ff4d4d;
    color: white;
    border: none;
    padding: 8px 18px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: bold;
    font-size: 13px;
}
.sell-btn:hover { background: #e63939; }

/* ── Two-column layout for gainers / losers ──────────────── */
.two-col {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 30px;
}

/* ── No-result notice ────────────────────────────────────── */
.no-result {
    text-align: center;
    padding: 30px;
    color: rgba(255,255,255,0.5);
    font-size: 15px;
}

/* ── Auto-refresh indicator ──────────────────────────────── */
.refresh-note {
    font-size: 12px;
    color: rgba(255,255,255,0.35);
    margin-bottom: 20px;
}

</style>
</head>

<body>

<!-- ══ Sidebar ══════════════════════════════════════════════════════════════ -->
<div class="sidebar">
    <div class="logo">Live Trading<br>Dashboard</div>
    <a href="dashboard">Dashboard</a>
    <a href="market"   class="active">Market</a>
    <a href="portfolio">My Portfolio</a>
    <a href="transactions">Transactions</a>
    <a href="profile">Profile</a>
    <a href="logout">Logout</a>
</div>

<!-- ══ Main ═════════════════════════════════════════════════════════════════ -->
<div class="container">

    <h1>📈 Market</h1>
    <p class="refresh-note">⟳ Page auto-refreshes every 10 seconds</p>

    <!-- ── Search Bar ──────────────────────────────────────────────────── -->
    <form action="market" method="get" class="search-bar">
        <input  type="text"
                id="searchInput"
                name="query"
                placeholder="Search by company name or symbol  (e.g. TCS, Infosys)"
                value="<%= request.getAttribute("query") != null ? request.getAttribute("query") : "" %>" />
        <button type="submit">🔍 Search</button>
    </form>

    <!-- ── Search Results ─────────────────────────────────────────────── -->
    <%
    String query = (String) request.getAttribute("query");
    List<Stock> searchResults = (List<Stock>) request.getAttribute("searchResults");
    boolean isSearching = (query != null && !query.isEmpty());
    %>

    <div class="table-section">
        <h2><%= isSearching ? "Search Results for \"" + query + "\"" : "All Stocks" %></h2>

        <table>
            <tr>
                <th>Symbol</th>
                <th>Company</th>
                <th>Price (Rs.)</th>
                <th>Change %</th>
                <th>Action</th>
            </tr>
            <%
            if (searchResults != null && !searchResults.isEmpty()) {
                for (Stock s : searchResults) {
                    String cls = s.getChangePercent() >= 0 ? "positive" : "negative";
                    String arrow = s.getChangePercent() >= 0 ? "▲" : "▼";
            %>
            <tr>
                <td><strong><%= s.getSymbol() %></strong></td>
                <td><%= s.getCompanyName() %></td>
                <td class="<%= cls %>">Rs. <%= String.format("%.2f", s.getCurrentPrice()) %></td>
                <td class="<%= cls %>"><%= arrow %> <%= String.format("%.2f", s.getChangePercent()) %>%</td>
                <td>
                    <a href="buy.jsp?stockId=<%= s.getId() %>&symbol=<%= s.getSymbol() %>&price=<%= s.getCurrentPrice() %>">
                        <button class="buy-btn">Buy</button>
                    </a>
                    <a href="sell.jsp?stockId=<%= s.getId() %>&symbol=<%= s.getSymbol() %>&price=<%= s.getCurrentPrice() %>">
                        <button class="sell-btn">Sell</button>
                    </a>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="5" class="no-result">
                <%= isSearching ? "No stocks found for \"" + query + "\"" : "No stocks available." %>
            </td></tr>
            <% } %>
        </table>
    </div>

    <!-- ── Top Gainers & Top Losers ──────────────────────────────────── -->
    <%
    List<Stock> topGainers = (List<Stock>) request.getAttribute("topGainers");
    List<Stock> topLosers  = (List<Stock>) request.getAttribute("topLosers");
    %>

    <div class="two-col">

        <!-- Top Gainers -->
        <div class="table-section">
            <h2>🚀 Top Gainers</h2>
            <table>
                <tr>
                    <th>Symbol</th>
                    <th>Price</th>
                    <th>Change %</th>
                </tr>
                <%
                if (topGainers != null && !topGainers.isEmpty()) {
                    for (Stock s : topGainers) {
                %>
                <tr>
                    <td><strong><%= s.getSymbol() %></strong><br>
                        <small style="color:rgba(255,255,255,0.5)"><%= s.getCompanyName() %></small></td>
                    <td>Rs. <%= String.format("%.2f", s.getCurrentPrice()) %></td>
                    <td><span class="badge-gain">▲ <%= String.format("%.2f", s.getChangePercent()) %>%</span></td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr><td colspan="3" class="no-result">No gainers right now.</td></tr>
                <% } %>
            </table>
        </div>

        <!-- Top Losers -->
        <div class="table-section">
            <h2>📉 Top Losers</h2>
            <table>
                <tr>
                    <th>Symbol</th>
                    <th>Price</th>
                    <th>Change %</th>
                </tr>
                <%
                if (topLosers != null && !topLosers.isEmpty()) {
                    for (Stock s : topLosers) {
                %>
                <tr>
                    <td><strong><%= s.getSymbol() %></strong><br>
                        <small style="color:rgba(255,255,255,0.5)"><%= s.getCompanyName() %></small></td>
                    <td>Rs. <%= String.format("%.2f", s.getCurrentPrice()) %></td>
                    <td><span class="badge-loss">▼ <%= String.format("%.2f", Math.abs(s.getChangePercent())) %>%</span></td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr><td colspan="3" class="no-result">No losers right now.</td></tr>
                <% } %>
            </table>
        </div>

    </div><!-- /.two-col -->

</div><!-- /.container -->
</body>
</html>
