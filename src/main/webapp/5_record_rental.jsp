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
    <title>Record Asset Rental</title>
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
    <h3>Record Asset Rental Form</h3>
    <jsp:useBean id="asset" class="com.example.assets_hoa.assets" scope="session"/>
    <jsp:useBean id="resident" class="com.example.assets_hoa.reference_resident" scope="session"/>
    <jsp:useBean id="rental" class="com.example.assets_hoa.asset_rentals" scope="session"/>
    <jsp:useBean id="transaction" class="com.example.assets_hoa.asset_transaction" scope="session"/>
    <jsp:useBean id="trans_officer" class="com.example.assets_hoa.reference_officer" scope="session"/>
    <%
        asset.clear();
        rental.clear();
        transaction.clear();
        // Get the list of assets rental info to update
        List<assets> assetsForRent = asset.getForRent();
        List<reference_officer> transOfcList = trans_officer.getTransOfc_list();
        LocalDate today = LocalDate.now();
        // Check if assets list is empty
        if (assetsForRent.isEmpty()) {
            // If the list is empty, show a message and disable the submit button
    %>
        <p>No Available Items To Rent!.</p>
        <form action ="index.jsp">
        <input type="submit" value="Go Back To Main Menu">
        </form>
    <%
    } else if (transOfcList.isEmpty()) {
            // Check if no transaction officer is available
    %>
        <p>No Available Transaction Officer Today!</p>
        <form action ="index.jsp">
            <input type="submit" value="Go Back To Main Menu">
        </form>
    <%
        }  else {
        // If the list is not empty, show the dropbox and enable the submit button
    %>
    <form action="5_record_rental_processing.jsp">
        Asset To Rent:
        <label for="asset_id"></label>
        <select id="asset_id" name="asset_id">
            <%
                for (assets a : asset.getForRent()) { %>
            <option value="<%=a.getAsset_id()%>"><%=a.getAsset_name()%> (ID:<%=a.getAsset_id()%>)</option>
            <% } %>
        </select><br>
        Renter ID:
        <label for="resident_id"></label>
        <select id="resident_id" name="resident_id">
            <%
                for (reference_resident r : resident.getRes_list()) { %>
            <option value="<%=r.getResident_id()%>">ID:<%=r.getResident_id()%></option>
            <% } %>
        </select><br>
        Reservation Date: <label for="reservation_date"></label>
        <input type="date" id="reservation_date" name="reservation_date" value="<%=today%>" readonly>
        <br>
        Rental Date: <label for="rental_date"></label>
        <input type="date" id="rental_date" name="rental_date" required>
        <br>
        Rental Status:
        <label for="rental_status"></label>
        <select id="rental_status" name="rental_status">
            <option value="R">Reserved</option>
        </select><br>
        Transaction Officer ID:
        <label for="trans_ofc"></label>
        <select id="trans_ofc" name="trans_ofc">
            <%
                for (reference_officer rofc : trans_officer.getTransOfc_list()) { %>
            <option value="<%=rofc.getHoa_id()%>|<%=rofc.getPosition()%>|<%=rofc.getElection_date()%>">
                <%=rofc.getPosition()%> (ID:<%=rofc.getHoa_id()%>)
            </option>
            <% } %>
        </select><br>
        <input type="submit" value="Register">
    </form>
    <% } %>
</div>

</body>
</html>

