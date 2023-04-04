<!DOCTYPE html>
<html>
<head>
    <title>Assets - MAIN MENU</title>
    <style>
        .menu {
            list-style-type: none;
            margin: 0;
            padding: 0;
            width: 200px;
            background-color: #f1f1f1;
        }

        .menu li a {
            display: block;
            color: #000;
            padding: 8px 16px;
            text-decoration: none;
        }

        .menu li a:hover:not(.active) {
            background-color: #555;
            color: white;
        }

        .active {
            background-color: #4CAF50;
            color: white;
        }
    </style>
</head>
<body>
<h1><%= "HOA Assets - MAIN MENU" %></h1>
<h1><%= "Welcome, Officer!" %></h1>
<br/>
<ul class="menu">
    <li><a href="register_asset.jsp">Register an Asset</a></li>
    <li><a href="update_asset.jsp">Update Asset Information</a></li>
    <li><a href="delete_wrongasset.jsp">Delete wrongly encoded Asset</a></li>
    <li><a href="dispose_asset.jsp">Dispose an Asset</a></li>
    <li><a href="record_rental.jsp">Record Asset Rental</a></li>
    <li><a href="return_rental.jsp">Return Asset Rental</a></li>
    <li><a href="update_rentalinfo.jsp">Update Asset Rental Information</a></li>
    <li><a href="delete_rentalinfo.jsp">Delete Asset Rental Information</a></li>
</ul>

</body>
</html>