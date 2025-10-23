<%@ page import="java.sql.*, java.util.*, main.java.com.melodymart.util.DBConnection" %>
<%
    String customerId = (String) session.getAttribute("customerId");
    String customerName = (String) session.getAttribute("userName");
    if (customerId == null) {
        response.sendRedirect("sign-in.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Cart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        table { width:100%; border-collapse:collapse; background:#fff; }
        th,td { padding:10px; border-bottom:1px solid #ddd; text-align:center; }
        .btn { border:none; cursor:pointer; border-radius:6px; padding:6px 10px; }
        .btn-danger{background:#dc2626;color:#fff}
        .qty-btn{background:#f1f5f9;border:none;width:30px;height:30px;border-radius:50%;}
        .total-box{margin-top:20px;text-align:right;font-weight:bold;font-size:18px;}
    </style>
</head>
<body>
<h2 style="text-align:center;">Welcome, <%= customerName %>!</h2>
<table>
    <tr><th>Image</th><th>Item</th><th>Price</th><th>Qty</th><th>Total</th><th>Action</th></tr>
    <%
        double grandTotal=0;
        try(Connection conn=DBConnection.getConnection()){
            String sql="SELECT C.InstrumentID,I.Name,I.Price,I.ImageURL,C.Quantity FROM Cart C JOIN Instrument I ON C.InstrumentID=I.InstrumentID WHERE C.CustomerID=?";
            PreparedStatement ps=conn.prepareStatement(sql);
            ps.setString(1,customerId);
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                String id=rs.getString("InstrumentID");
                String name=rs.getString("Name");
                double price=rs.getDouble("Price");
                int qty=rs.getInt("Quantity");
                String img=rs.getString("ImageURL");
                double total=price*qty;
                grandTotal+=total;
    %>
    <tr class="cart-item" data-id="<%=id%>">
        <td><img src="<%=img!=null&&!img.isEmpty()?img:"https://via.placeholder.com/60"%>" width="60"></td>
        <td><%=name%></td>
        <td class="item-price" data-value="<%=price%>">$<%=String.format("%.2f",price)%></td>
        <td>
            <button class="qty-btn minus">-</button>
            <input type="number" class="qty" value="<%=qty%>" min="1" style="width:50px;text-align:center;">
            <button class="qty-btn plus">+</button>
        </td>
        <td class="item-total">$<%=String.format("%.2f",total)%></td>
        <td><button class="btn btn-danger remove"><i class="fas fa-trash"></i></button></td>
    </tr>
    <% } }catch(Exception e){ e.printStackTrace(); } %>
</table>
<div class="total-box">Grand Total: <span class="grand-total">$<%=String.format("%.2f",grandTotal)%></span></div>

<script>
    function format(n){return "$"+n.toFixed(2);}
    document.querySelectorAll(".cart-item").forEach(row=>{
        const id=row.dataset.id;
        const price=parseFloat(row.querySelector(".item-price").dataset.value);
        const input=row.querySelector(".qty");
        const totalCell=row.querySelector(".item-total");

        row.querySelector(".plus").addEventListener("click",()=>{input.value++;updateQty(id,input,price,totalCell);});
        row.querySelector(".minus").addEventListener("click",()=>{if(input.value>1){input.value--;updateQty(id,input,price,totalCell);}});
        input.addEventListener("change",()=>{if(input.value<1)input.value=1;updateQty(id,input,price,totalCell);});
        row.querySelector(".remove").addEventListener("click",()=>{
            if(confirm("Remove item?")) updateCart(id,0,"remove",row);
        });
    });

    function updateQty(id,input,price,totalCell){
        const qty=parseInt(input.value);
        totalCell.textContent=format(price*qty);
        updateCart(id,qty,"update");
    }

    function updateCart(id,qty,action,row){
        fetch("UpdateCartServlet",{
            method:"POST",
            headers:{"Content-Type":"application/x-www-form-urlencoded"},
            body:"instrumentId="+id+"&quantity="+qty+"&action="+action
        }).then(r=>r.text()).then(t=>{
            if(t.startsWith("OK:")){
                const newTotal=parseFloat(t.split(":")[1])||0;
                document.querySelector(".grand-total").textContent=format(newTotal);
                if(action==="remove") row.remove();
            }else alert(t);
        }).catch(e=>alert("Error: "+e));
    }
</script>
</body>
</html>
