<%--
  Created by IntelliJ IDEA.
  User: CCINFOM_GROUP26
  Date: 04/04/2023
  Time: 5:59 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*, com.example.assets_hoa.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
    <title>Transfer Processing</title>
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
            LocalDate today = LocalDate.now();

            int v_asset_id = asset.generateAssetID();
            String v_asset_name = request.getParameter("asset_name");
            String v_asset_description = request.getParameter("asset_description");
            String v_acquisition_date = request.getParameter("acquisition_date");
            int v_forrent = 1;
            double v_asset_value = Double.parseDouble(request.getParameter("asset_value"));
            char v_asset_type = request.getParameter("asset_type").charAt(0);
            char v_asset_status = request.getParameter("asset_status").charAt(0);
            double v_loc_lat = Double.parseDouble(request.getParameter("location_latitude"));
            double v_loc_long = Double.parseDouble(request.getParameter("location_longitude"));
            String v_hoa_name = request.getParameter("hoa_name");
            int v_enclosing_id = Integer.parseInt(request.getParameter("enclosing_asset"));
            asset.setAsset_id(v_asset_id);
            asset.setAsset_name(v_asset_name);
            asset.setAsset_description(v_asset_description);
            asset.setAcquisition_date(v_acquisition_date);
            asset.setForrent(v_forrent);
            asset.setAsset_value(v_asset_value);
            asset.setType_asset(v_asset_type);
            asset.setStatus(v_asset_status);
            asset.setLoc_lattitude(v_loc_lat);
            asset.setLoc_longiture(v_loc_long);
            asset.setHoa_name(v_hoa_name);
            asset.setEnclosing_asset(v_enclosing_id);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            boolean isValidDate = true;
            Date acquisition_date = null;
            Date today_date = null;
            try {
                acquisition_date = sdf.parse(v_acquisition_date);
                today_date = sdf.parse(today.toString());
            } catch (ParseException e) {
                isValidDate = false;
            }
            assert acquisition_date != null;
            if (acquisition_date.after(today_date)) {
                isValidDate = false;
            }

            if (isValidDate && asset.register_asset() == 1) {
        %>
        <h1>Asset Registered Successfully!</h1>
        <% } else { %>
        <h1>Asset Register Failed!</h1>
        <h2>Wrong value inputted in one of the fields!</h2>
        <h2>Please try again</h2>
        <%}%>

        <input type="submit" value="Return to Main Menu">
    </form>
</div>

</body>
</html>