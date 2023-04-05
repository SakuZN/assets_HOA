<%--
  Created by IntelliJ IDEA.
  User: ranzr
  Date: 04/04/2023
  Time: 5:59 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*, com.example.assets_hoa.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<!DOCTYPE html>
<html>
<head>
    <title>Record Rental Processing</title>
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
    <h3>Record Asset Rental Form</h3>
    <form action="index.jsp">
        <jsp:useBean id="asset" class="com.example.assets_hoa.assets" scope="session"/>
        <jsp:useBean id="resident" class="com.example.assets_hoa.reference_resident" scope="session"/>
        <jsp:useBean id="rental" class="com.example.assets_hoa.asset_rentals" scope="session"/>
        <jsp:useBean id="transaction" class="com.example.assets_hoa.asset_transaction" scope="session"/>
        <jsp:useBean id="trans_officer" class="com.example.assets_hoa.reference_officer" scope="session"/>
        <%
            int v_asset_id = Integer.parseInt(request.getParameter("asset_id"));
            int v_resident_id = Integer.parseInt(request.getParameter("resident_id"));
            String v_reservation_date = request.getParameter("reservation_date");
            String v_rental_date = request.getParameter("rental_date");
            char v_rental_status = request.getParameter("rental_status").charAt(0);
            String [] ofcInfo = request.getParameter("trans_ofc").split("\\|");
            int v_trans_hoid = Integer.parseInt(ofcInfo[0]);
            String v_trans_position = ofcInfo[1];
            String v_trans_electiondate = ofcInfo[2];

            trans_officer = trans_officer.getOfcInfo(v_trans_hoid, v_trans_position, v_trans_electiondate);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            boolean isValidDate = true;
            Date rental_date = null;
            Date reservation_date = null;
            try {
                reservation_date = sdf.parse(v_reservation_date);
                rental_date = sdf.parse(v_rental_date);
            } catch (ParseException e) {
                isValidDate = false;
            }
            assert reservation_date != null;
            if (reservation_date.after(rental_date)) {
                isValidDate = false;
            }

            rental.setAsset_id(v_asset_id);
            rental.setResident_id(v_resident_id);
            rental.setReservation_date(v_reservation_date);
            rental.setRental_date(v_rental_date);
            rental.setStatus(v_rental_status);

            transaction.setAsset_id(v_asset_id);
            transaction.setTransaction_date(v_rental_date);
            transaction.setTrans_hoid(trans_officer.getHoa_id());
            transaction.setTrans_position(trans_officer.getPosition());
            transaction.setTrans_electiondate(trans_officer.getElection_date());
            transaction.setIsdeleted(0);
            transaction.setTransaction_type('R');

            if (isValidDate && transaction.register_transaction() == 1 && rental.record_rental() == 1) {
        %>
        <h1>Asset Registered Successfully!</h1>
        <% } else { %>
        <h1>Asset Register Failed!</h1>
        <h2>Please try again</h2>
        <%}%>

        <input type="submit" value="Return to Main Menu">
    </form>
</div>

</body>
</html>