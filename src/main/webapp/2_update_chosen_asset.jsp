<%--
  Created by IntelliJ IDEA.
  User: ranzr
  Date: 04/04/2023
  Time: 12:59 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*, com.example.assets_hoa.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Asset Information</title>
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

        input[type=checkbox][readonly] {
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            height: 20px;
            width: 20px;
            vertical-align: middle;
            pointer-events: none;
            opacity: 0.5;
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
    <h3>Update Asset Form</h3>
    <form action="2_update_asset_processing.jsp">
        <jsp:useBean id="asset" class="com.example.assets_hoa.assets" scope="session"/>
        <%
            int v_asset_id = Integer.parseInt(request.getParameter("asset_id"));
            asset = asset.getAssetInfo(v_asset_id);
        %>
        Asset Name:
        <label>
        <input type="text" name="asset_name" value="<%=asset.getAsset_name()%>" readonly>
        </label><br>
        Asset ID:
        <label>
            <input type="text" name="asset_id" id="asset_id" value="<%=asset.getAsset_id()%>" readonly>
        </label><br>
        Asset Description: <label for="asset_description"></label>
        <input type="text" id="asset_description" name="asset_description"
               value="<%=asset.getAsset_description()%>"required>
        <br>
        Acquisition Date:
        <label for="acquisition_date"></label>
        <input type="date" id="acquisition_date"
               name="acquisition_date" value="<%=asset.getAcquisition_date()%>" readonly>
        <br>
        <%
            boolean isChecked = asset.getForrent() == 1;
        %>
        For Rent: <label for="for_rent"></label>
        <input type="checkbox" id="for_rent" name="for_rent" value="1" <%= isChecked ? "checked" : "" %> readonly>
        <br>
        Asset Value: <label for="asset_value"></label>
        <input type="number" id="asset_value" name="asset_value" value="<%=asset.getAsset_value()%>" required><br>
        Asset Type:
        <label for="asset_type"></label>
        <select id="asset_type" name="asset_type">
            <option value="<%=asset.getType_asset()%>"><%=asset.getType_assetString()%></option>
        </select><br>
        Asset Status:
        <label for="asset_status"></label>
        <select id="asset_status" name="asset_status">
            <option value="<%=asset.getStatus()%>"><%=asset.getStatusString()%></option>
            <%
                for (String status : asset.getStatusList()) {
                    if (!status.equals(asset.getStatusString()) && !status.equals("Disposed")) {
            %>
            <option value="<%=asset.getStatusChar(status)%>"><%=status%></option>
            <% } } %>
        </select><br>
        Location Latitude: <label for="location_latitude"></label>
        <input type="number" id="location_latitude" name="location_latitude"
               step = "0.0001" pattern="\d{1,7}\.\d{1,4}" value="<%=asset.getLoc_lattitude()%>" required><br>
        Location Longitude: <label for="location_longitude"></label>
        <input type="number" id="location_longitude" name="location_longitude"
               step = "0.0001" pattern="\d{1,7}\.\d{1,4}" value="<%=asset.getLoc_longiture()%>" required><br>
        Enclosing Asset:
        <label for="enclosing_asset"></label><select id="enclosing_asset" name="enclosing_asset">
        <% if (asset.getEnclosing_asset() != -1 && asset.getEnclosing_asset() != 0) {%>
            <option value="<%=asset.getEnclosing_asset()%>">
                <%=asset.getEnclosing_assetName()%> (ID:<%=asset.getEnclosing_asset()%>)</option>
        <% } %>
        <option value="-1">None</option>
            <%
                    for (assets a : asset.getPropertyAssetsList()) {
                        if (a.getAsset_id() != asset.getAsset_id() && a.getAsset_id() != asset.getEnclosing_asset()) {
            %>
        <option value="<%=a.getAsset_id()%>"><%=a.getAsset_name()%> (ID:<%=a.getAsset_id()%>)</option>
            <% } } %>
        </select><br>
        <input type="submit" value="Update">
    </form>
</div>

</body>
</html>
