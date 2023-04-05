<%--
  Created by IntelliJ IDEA.
  User: ranzr
  Date: 04/04/2023
  Time: 5:59 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*, com.example.assets_hoa.*, java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register an Asset</title>
    <style>
        body {
            font-family: Arial, serif;
            background-color: #f2f2f2;
        }

        input[type=text], input[type=number], input[type=date], select {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type=number]::-webkit-outer-spin-button,
        input[type=number]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        input[type=checkbox] {
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            height: 20px;
            width: 20px;
            vertical-align: middle;
        }

        input[type=submit] {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type=submit]:hover {
            background-color: #45a049;
        }

        div {
            border-radius: 5px;
            background-color: #ffffff;
            padding: 20px;
        }
    </style>
</head>
<body>

<div>
    <h3>Register Asset Form</h3>
    <jsp:useBean id="asset" class="com.example.assets_hoa.assets" scope="session"/>
    <%
        asset.clear();
        LocalDate today = LocalDate.now();
    %>
        <form action="1_register_asset_processing.jsp">
            Asset Name: <label for="asset_name"></label><input type="text" id="asset_name" name="asset_name" required><br>
            Asset Description: <label for="asset_description"></label><input type="text" id="asset_description"
                                                                             name="asset_description" required><br>
            Acquisition Date: <label for="acquisition_date"></label>
            <input type="date" id="acquisition_date" name="acquisition_date"
                   value="<%=today%>" readonly><br>
            <%--For Rent: <label for="for_rent"></label><input type="checkbox" id="for_rent" name="for_rent" value=
                1><br>--%>
            Asset Value: <label for="asset_value"></label><input type="number" id="asset_value" name="asset_value" required><br>
            Asset Type:
            <label for="asset_type"></label>
            <select id="asset_type" name="asset_type">
                <option value="P">Property</option>
                <option value="E">Equipment</option>
                <option value="F">F&F</option>
                <option value="O">Other</option>
            </select><br>
            Asset Status:
            <label for="asset_status"></label>
            <select id="asset_status" name="asset_status">
                <option value="W">Working</option>
            </select><br>
            Location Latitude: <label for="location_latitude"></label>
            <input type="number" id="location_latitude" name="location_latitude"
                   step = "0.0001" pattern="\d{1,7}\.\d{1,4}" required><br>
            Location Longitude: <label for="location_longitude"></label>
            <input type="number" id="location_longitude" name="location_longitude"
                   step = "0.0001" pattern="\d{1,7}\.\d{1,4}" required><br>
            HOA Name:
            <label for="hoa_name"></label><select id="hoa_name" name="hoa_name">
                <%
                    for (reference_hoa a : asset.getHoaList()) { %>
                <option value="<%=a.getHoa_name()%>"><%=a.getHoa_name()%></option>
                <% } %>
            </select><br>
            Enclosing Asset:
            <label for="enclosing_asset"></label><select id="enclosing_asset" name="enclosing_asset">
                <option value="-1">None</option>
                <%
                    for (assets a : asset.getPropertyAssetsList()) { %>
                <option value="<%=a.getAsset_id()%>"><%=a.getAsset_name()%> (ID:<%=a.getAsset_id()%>)</option>
                <% } %>
            </select><br>
            <input type="submit" value="Register">
    </form>
</div>

</body>
</html>

