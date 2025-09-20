<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Instrument</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        label { display: inline-block; width: 120px; }
        input, textarea { margin-bottom: 10px; }
        .error { color: red; }
    </style>
    <script>
        function validateForm() {
            var name = document.forms["addForm"]["name"].value;
            var price = document.forms["addForm"]["price"].value;
            var photo = document.forms["addForm"]["photo"].value;
            var brandID = document.forms["addForm"]["brandID"].value;
            var manufacturerID = document.forms["addForm"]["manufacturerID"].value;

            if (name === "" || price === "" || photo === "" || brandID === "" || manufacturerID === "") {
                alert("All required fields (Name, Price, Photo, Brand ID, Manufacturer ID) must be filled.");
                return false;
            }
            if (isNaN(price) || price <= 0) {
                alert("Price must be a positive number.");
                return false;
            }
            if (isNaN(brandID) || isNaN(manufacturerID) || brandID <= 0 || manufacturerID <= 0) {
                alert("Brand ID and Manufacturer ID must be positive numbers.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<h2>Add New Instrument to Inventory</h2>
<form name="addForm" action="/saveInstrument" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
    <label for="name">Name:*</label>
    <input type="text" id="name" name="name" required><br><br>

    <label for="description">Description:</label>
    <textarea id="description" name="description" rows="4" cols="50"></textarea><br><br>

    <label for="brandID">Brand ID:*</label>
    <input type="number" id="brandID" name="brandID" required><br><br>

    <label for="model">Model:</label>
    <input type="text" id="model" name="model"><br><br>

    <label for="color">Color:</label>
    <input type="text" id="color" name="color"><br><br>

    <label for="price">Price:*</label>
    <input type="number" id="price" name="price" step="0.01" required><br><br>

    <label for="specifications">Specifications:</label>
    <textarea id="specifications" name="specifications" rows="4" cols="50"></textarea><br><br>

    <label for="warranty">Warranty:</label>
    <input type="text" id="warranty" name="warranty"><br><br>

    <label for="photo">Photo:*</label>
    <input type="file" id="photo" name="photo" accept="image/*" required><br><br>

    <label for="quantity">Quantity:</label>
    <input type="number" id="quantity" name="quantity" min="0" value="0"><br><br>

    <label for="manufacturerID">Manufacturer ID:*</label>
    <input type="number" id="manufacturerID" name="manufacturerID" required><br><br>

    <input type="submit" value="Add Instrument">
</form>

<!-- Display error/success messages from servlet if passed -->
<% if (request.getAttribute("error") != null) { %>
<p class="error"><%= request.getAttribute("error") %></p>
<% } %>
<% if (request.getAttribute("success") != null) { %>
<p style="color:green;"><%= request.getAttribute("success") %></p>
<% } %>
</body>
</html>