<%--
  Created by IntelliJ IDEA.
  User: ranzr
  Date: 04/04/2023
  Time: 5:59 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*, com.example.assets_hoa.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Asset Information Update Processing</title>
    <style>
        body {
            font-family: Arial;
            background-color: #f2f2f2;
        }

        input[type=text], select {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
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
    <form action="index.jsp">
        <jsp:useBean id="asset" class="com.example.assets_hoa.assets" scope="session"/>
        <%
            asset.clear();
            int v_asset_id = Integer.parseInt(request.getParameter("asset_id"));
            String v_asset_description = request.getParameter("asset_description");
            int v_forrent = Objects.equals(request.getParameter("for_rent"), "1") ? 1 : 0;
            double v_asset_value = Double.parseDouble(request.getParameter("asset_value"));
            char v_asset_status = request.getParameter("asset_status").charAt(0);
            double v_loc_lat = Double.parseDouble(request.getParameter("location_latitude"));
            double v_loc_long = Double.parseDouble(request.getParameter("location_longitude"));
            int v_enclosing_id = Integer.parseInt(request.getParameter("enclosing_asset"));
            char v_asset_type = request.getParameter("asset_type").charAt(0);
            asset = asset.getAssetInfo(v_asset_id);
            asset.setAsset_description(v_asset_description);
            asset.setForrent(v_forrent);
            asset.setAsset_value(v_asset_value);
            asset.setStatus(v_asset_status);
            asset.setLoc_lattitude(v_loc_lat);
            asset.setLoc_longiture(v_loc_long);
            asset.setEnclosing_asset(v_enclosing_id);
            asset.setType_asset(v_asset_type);

            if (asset.update_asset() == 1) {
        %>
        <h1>Asset Updated Successfully!</h1>
        <% } else { %>
        <h1>Asset Update Failed!</h1>
        <h2>Please try again</h2>
        <%}%>

        <input type="submit" value="Return to Main Menu">
    </form>
</div>

</body>
</html>
