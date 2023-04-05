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
    <title>Update Asset Rental Info</title>
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
    <jsp:useBean id="rental" class="com.example.assets_hoa.asset_rentals" scope="session"/>
    <jsp:useBean id="asset" class="com.example.assets_hoa.assets" scope="session"/>
    <%
        rental.clear();
        asset.clear();
        //split value from request parameter delimited by "\\|"
        String[] values = request.getParameter("asset_id").split("\\|");
        int v_asset_id = Integer.parseInt(values[0]);
        String v_rental_date = values[1];

        rental = rental.getARInfo(v_asset_id, v_rental_date);
        asset = asset.getAssetInfo(v_asset_id);
        char assetStatus = rental.getStatus();
    %>
    <h3>Update Asset Rental Information Form</h3>
    <form action="7_update_rentalinfo_processing.jsp">
        Asset Name:
        <label>
            <input type="text" name="asset_name"
                   value="<%=asset.getAsset_name()%>" readonly>
        </label><br>

        Asset ID:
        <label>
            <input type="text" id="asset_id" name="asset_id"
                   value="<%=asset.getAsset_id()%>" readonly>
        </label><br>
        <%if (asset.getEnclosing_asset() != 0 && asset.getEnclosed_assets() != null) {%>
            Enclosed From Asset:
            <label>
                <input type="text" id="enclosed_assets" name="enclosed_assets"
                       value="(ID: <%=asset.getEnclosing_asset()%>) <%=asset.getEnclosing_assetName()%>" readonly>
            </label><br>
        <% } %>
        Rental Date:
        <label for="rental_date"></label>
        <input type="date" id="rental_date"
               name="rental_date" value="<%=rental.getRental_date()%>" readonly>
        <br>

        Reservation Date:
        <label for="reservation_date"></label>
        <input type="date" id="reservation_date"
               name="reservation_date" value="<%=rental.getReservation_date()%>" readonly>
        <br>

        Rental Amount: <label for="rental_amount"></label>
        <% if (assetStatus == 'R' || assetStatus == 'C') { %>
            <input type="number" id="rental_amount" name="rental_amount" value="<%=rental.getRental_amount()%>" readonly>
        <% } else { %>
            <input type="number" id="rental_amount" name="rental_amount" value="<%=rental.getRental_amount()%>" required>
        <% } %>
        <br>

        Discount: <label for="discount_amount"></label>
        <% if (assetStatus == 'O' || assetStatus == 'N') { %>
            <input type="number" id="discount_amount" name="discount_amount" value="<%=rental.getDiscount()%>" required>
        <% } else { %>
            <input type="number" id="discount_amount" name="discount_amount" value="<%=rental.getDiscount()%>" readonly>
        <% } %>
        <br>

        Rental Status:
        <label for="rental_status"></label>
        <% if (assetStatus == 'R' && (asset.getEnclosing_asset() == 0 && asset.getEnclosed_assets() != null)) { %>
            <select id="rental_status" name="rental_status">
                <option value="<%=rental.getStatus()%>"><%=rental.getStatusString()%></option>
                <%
                    for (String status : rental.getStatusListString()) {
                        if (!status.equals(rental.getStatusString()) && !status.equals("Returned")) {
                %>
                <option value="<%=rental.getStatusEnum(status)%>"><%=status%></option>
                <% } } %>
            </select><br>
        <% } else { %>
            <select id="rental_status" name="rental_status">
                <option value="<%=rental.getStatus()%>"><%=rental.getStatusString()%></option>
            </select><br>
        <% } %>

        Inspection Details: <label for="inspection_details"></label>
        <% if (assetStatus == 'R' || assetStatus == 'C' || assetStatus == 'O') { %>
            <input type="text" id="inspection_details" name="inspection_details" value="<%=rental.getInspection_details()%>" readonly>
        <% } else { %>
            <input type="text" id="inspection_details" name="inspection_details" value="<%=rental.getInspection_details()%>" required>
        <br>
        <% } %>

        Assessed Value: <label for="assessed_value"></label>
        <% if (assetStatus == 'R' || assetStatus == 'C') { %>
            <input type="number" id="assessed_value" name="assessed_value" value="<%=rental.getAssessed_value()%>" readonly>
        <% } else { %>
            <input type="number" id="assessed_value" name="assessed_value" value="<%=rental.getAssessed_value()%>" required>
        <% } %>
        <br>

        Accepting Officer: <label for="accepting_officer"></label>
        <input type="text" id="accepting_officer" name="accepting_officer"
               value=" (ID: <%= rental.getAccept_hoid()%>) <%=rental.getAccept_position()%>" readonly>

        Return Date:
        <label for="return_date"></label>
        <input type="date" id="return_date"
               name="return_date" value="<%=rental.getReturn_date()%>" readonly>
        <br>

        <input type="submit" value="Update">
    </form>
</div>

</body>
</html>
