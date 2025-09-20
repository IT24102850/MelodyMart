<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Seller Dashboard - Add Instrument</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: inline-block; width: 150px; }
        input, select, textarea { width: 200px; padding: 5px; }
        .error { color: red; }
    </style>
</head>
<body>
<h2>Seller Dashboard - Add New Instrument</h2>
<% String addStatus = (String) request.getAttribute("addStatus"); %>
<% if (addStatus != null) { %>
<p class="error"><%= addStatus %></p>
<% } %>
<form action="SaveInstrument" method="post">
    <div class="form-group">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required>
    </div>
    <div class="form-group">
        <label for="description">Description:</label>
        <textarea id="description" name="description" rows="3"></textarea>
    </div>
    <div class="form-group">
        <label for="brandId">Brand ID:</label>
        <input type="number" id="brandId" name="brandId" min="1">
    </div>
    <div class="form-group">
        <label for="model">Model:</label>
        <input type="text" id="model" name="model">
    </div>
    <div class="form-group">
        <label for="color">Color:</label>
        <input type="text" id="color" name="color">
    </div>
    <div class="form-group">
        <label for="price">Price:</label>
        <input type="number" id="price" name="price" step="0.01" min="0.01" required>
    </div>
    <div class="form-group">
        <label for="specifications">Specifications:</label>
        <textarea id="specifications" name="specifications" rows="3"></textarea>
    </div>
    <div class="form-group">
        <label for="warranty">Warranty:</label>
        <input type="text" id="warranty" name="warranty">
    </div>
    <div class="form-group">
        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" min="0" required>
    </div>
    <div class="form-group">
        <label for="stockLevel">Stock Level:</label>
        <select id="stockLevel" name="stockLevel">
            <option value="In Stock">In Stock</option>
            <option value="Low Stock">Low Stock</option>
            <option value="Out of Stock">Out of Stock</option>
        </select>
    </div>
    <div class="form-group">
        <label for="manufacturerId">Manufacturer ID:</label>
        <input type="number" id="manufacturerId" name="manufacturerId" min="1">
    </div>
    <div class="form-group">
        <input type="submit" value="Add Instrument">
    </div>
</form>
</body>
</html>