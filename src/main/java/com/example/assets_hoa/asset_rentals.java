package com.example.assets_hoa;

import java.sql.*;
import java.util.*;
public class asset_rentals {

    private int asset_id;
    private String rental_date;
    private String reservation_date;
    private int resident_id;
    private double rental_amount;
    private double discount;
    private char status;
    private String inspection_details;
    private double assessed_value;
    private int accept_hoid;
    private String accept_position;
    private String accept_electiondate;
    private String return_date;
    private List<asset_rentals> ar_list = new ArrayList<>();

    public asset_rentals(){
        asset_id = 0;
        rental_date = "";
        reservation_date = "";
        resident_id = 0;
        rental_amount = 0;
        discount = 0;
        status = ' ';
        inspection_details = "";
        assessed_value = 0;
        accept_hoid = 0;
        accept_position = "";
        accept_electiondate = "";
        return_date = "";
    }

    public int record_rental() {
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("INSERT INTO asset_rentals " +
                    "(asset_id, rental_date, reservation_date, resident_id, rental_amount, discount, status, " +
                    "inspection_details, assessed_value, accept_hoid, accept_position, accept_electiondate, return_date) " +
                    "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)");
            System.out.println("ID is " + getAsset_id());
            System.out.println("Rental date is " + getRental_date());
            ps.setInt(1, getAsset_id());
            ps.setString(2, getRental_date());
            ps.setString(3, getReservation_date());
            ps.setInt(4, getResident_id());
            if (getRental_amount() == 0)
                ps.setNull(5, Types.DOUBLE);
            else
                ps.setDouble(5, getRental_amount());
            if (getDiscount() == 0)
                ps.setNull(6, Types.DOUBLE);
            else
                ps.setDouble(6, getDiscount());
            ps.setString(7, String.valueOf(getStatus()));
            if (Objects.equals(getInspection_details(), ""))
                ps.setNull(8, Types.VARCHAR);
            else
                ps.setString(8, getInspection_details());
            if (getAssessed_value() == 0)
                ps.setNull(9, Types.DOUBLE);
            else
                ps.setDouble(9, getAssessed_value());
            if (getAccept_hoid() == 0)
                ps.setNull(10, Types.INTEGER);
            else
                ps.setInt(10, getAccept_hoid());
            if (Objects.equals(getAccept_position(), ""))
                ps.setNull(11, Types.VARCHAR);
            else
                ps.setString(11, getAccept_position());
            if (Objects.equals(getAccept_electiondate(), ""))
                ps.setNull(12, Types.VARCHAR);
            else
                ps.setString(12, getAccept_electiondate());
            if (Objects.equals(getReturn_date(), ""))
                ps.setNull(13, Types.VARCHAR);
            else
                ps.setString(13, getReturn_date());
            ps.executeUpdate();

            assets check_asset = new assets();
            check_asset = check_asset.getAssetInfo(getAsset_id());
            List<assets> enclosed_assets = check_asset.getEnclosed_assets();
            if (check_asset.getType_asset() == 'P' && !enclosed_assets.isEmpty())
                for (assets ea : enclosed_assets) {
                    ps.setInt(1, ea.getAsset_id());
                    ps.setString(2, getRental_date());
                    ps.setString(3, getReservation_date());
                    ps.setInt(4, getResident_id());
                    if (getRental_amount() == 0)
                        ps.setNull(5, Types.DOUBLE);
                    else
                        ps.setDouble(5, getRental_amount());
                    if (getDiscount() == 0)
                        ps.setNull(6, Types.DOUBLE);
                    else
                        ps.setDouble(6, getDiscount());
                    ps.setString(7, String.valueOf(getStatus()));
                    if (Objects.equals(getInspection_details(), ""))
                        ps.setNull(8, Types.VARCHAR);
                    else
                        ps.setString(8, getInspection_details());
                    if (getAssessed_value() == 0)
                        ps.setNull(9, Types.DOUBLE);
                    else
                        ps.setDouble(9, getAssessed_value());
                    if (getAccept_hoid() == 0)
                        ps.setNull(10, Types.INTEGER);
                    else
                        ps.setInt(10, getAccept_hoid());
                    if (Objects.equals(getAccept_position(), ""))
                        ps.setNull(11, Types.VARCHAR);
                    else
                        ps.setString(11, getAccept_position());
                    if (Objects.equals(getAccept_electiondate(), ""))
                        ps.setNull(12, Types.VARCHAR);
                    else
                        ps.setString(12, getAccept_electiondate());
                    if (Objects.equals(getReturn_date(), ""))
                        ps.setNull(13, Types.VARCHAR);
                    else
                        ps.setString(13, getReturn_date());
                    ps.executeUpdate();
                    ea.assetRented(ea.getAsset_id());
                }

            check_asset.assetRented(getAsset_id());

            ps.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e);
            return 0;
        }
        return 1;
    }

    public int update_rental() {
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("UPDATE asset_rentals SET " +
                    "reservation_date = ?, resident_id = ?, rental_amount = ?, discount = ?, status = ?, " +
                    "inspection_details = ?, assessed_value = ?, accept_hoid = ?, accept_position = ?, " +
                    "accept_electiondate = ?, return_date = ? WHERE asset_id = ? AND rental_date = ?");
            ps.setString(1, getReservation_date());

            ps.setInt(2, getResident_id());
            if (getRental_amount() == 0)
                ps.setNull(3, Types.DOUBLE);
            else
                ps.setDouble(3, getRental_amount());
            if (getDiscount() == 0)
                ps.setNull(4, Types.DOUBLE);
            else
                ps.setDouble(4, getDiscount());

            ps.setString(5, String.valueOf(getStatus()));

            if (Objects.equals(getInspection_details(), ""))
                ps.setNull(6, Types.VARCHAR);
            else
                ps.setString(6, getInspection_details());
            if (getAssessed_value() == 0)
                ps.setNull(7, Types.DOUBLE);
            else
                ps.setDouble(7, getAssessed_value());
            if (getAccept_hoid() == 0)
                ps.setNull(8, Types.INTEGER);
            else
                ps.setInt(8, getAccept_hoid());
            if (Objects.equals(getAccept_position(), ""))
                ps.setNull(9, Types.VARCHAR);
            else
                ps.setString(9, getAccept_position());
            if (Objects.equals(getAccept_electiondate(), ""))
                ps.setNull(10, Types.VARCHAR);
            else
                ps.setString(10, getAccept_electiondate());
            if (Objects.equals(getReturn_date(), ""))
                ps.setNull(11, Types.VARCHAR);
            else
                ps.setString(11, getReturn_date());
            ps.setInt(12, getAsset_id());
            ps.setString(13, getRental_date());

            System.out.println(ps.executeUpdate());
            ps.close();
            //For cases if asset is a property, has enclosed assets and is being cancelled
            assets check_asset = new assets();
            //To add OR number after rental is returned
            asset_transaction check_transaction = new asset_transaction();
            check_asset = check_asset.getAssetInfo(getAsset_id());
            check_transaction = check_transaction.getATInfo(getAsset_id(), getRental_date());

            List<assets> enclosed_assets = check_asset.freeEnclosed_asset(getRental_date());
            if (getStatus() == 'C' && check_asset.getType_asset() == 'P' && !enclosed_assets.isEmpty()) {
                PreparedStatement stmt = conn.prepareStatement("UPDATE asset_rentals SET " +
                        "status = ? WHERE asset_id = ? AND rental_date = ?");

                for (assets ea : enclosed_assets) {
                    stmt.setString(1, String.valueOf('C'));
                    stmt.setInt(2, ea.getAsset_id());
                    stmt.setString(3, getRental_date());
                    stmt.executeUpdate();
                    ea.assetFree(ea.getAsset_id());
                }
                stmt.close();
                check_asset.assetFree(getAsset_id());
            }
            // For cases if asset is a property, has enclosed assets and is on-rent
            else if (getStatus() == 'O' && check_asset.getType_asset() == 'P' && !enclosed_assets.isEmpty()) {
                PreparedStatement stmt = conn.prepareStatement("UPDATE asset_rentals SET " +
                        "status = ? WHERE asset_id = ? AND rental_date = ?");

                for (assets ea : enclosed_assets) {
                    stmt.setString(1, String.valueOf('O'));
                    stmt.setInt(2, ea.getAsset_id());
                    stmt.setString(3, getRental_date());
                    stmt.executeUpdate();
                }

                stmt.close();
            }
            //For cases if asset is a property, has enclosed assets and is being returned
            else if (getStatus() == 'N' && check_asset.getType_asset() == 'P' && !enclosed_assets.isEmpty()) {
                PreparedStatement stmt = conn.prepareStatement("UPDATE asset_rentals SET " +
                        "status = ?, accept_hoid = ?, accept_position = ?, accept_electiondate = ?," +
                        " return_date = ? WHERE asset_id = ? AND rental_date = ?");

                for (assets ea : enclosed_assets) {
                    stmt.setString(1, String.valueOf('N'));
                    stmt.setInt(2, getAccept_hoid());
                    stmt.setString(3, getAccept_position());
                    stmt.setString(4, getAccept_electiondate());
                    stmt.setString(5, getReturn_date());
                    stmt.setInt(6, ea.getAsset_id());
                    stmt.setString(7, getRental_date());
                    stmt.executeUpdate();
                    ea.assetFree(ea.getAsset_id());
                }
                stmt.close();
                check_asset.assetFree(getAsset_id());
                if (check_transaction.getOrnum() == 0) {
                    check_transaction.generateNewOR();
                    check_transaction.setNewOR(getAsset_id(), getRental_date(), check_transaction.getOrnum());
                }
            }
            //if its just any other asset
            else {
                if (getStatus() == 'C' || getStatus() == 'N')
                    check_asset.assetFree(getAsset_id());

                if (getStatus() == 'N' && check_transaction.getOrnum() == 0) {
                    check_transaction.generateNewOR();
                    check_transaction.setNewOR(getAsset_id(), getRental_date(), check_transaction.getOrnum());
                }

            }
            conn.close();

        } catch (SQLException e) {
            System.out.println("Error: " + e);
            return 0;
        }
        return 1;
    }

        public asset_rentals getARInfo(int asset_id, String rental_date) {
        asset_rentals ar = new asset_rentals();
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM asset_rentals WHERE asset_id = ? AND " +
                    "rental_date = ?");
            ps.setInt(1, asset_id);
            ps.setString(2, rental_date);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ar.setAsset_id(rs.getInt("asset_id"));
                ar.setRental_date(rs.getString("rental_date"));
                ar.setReservation_date(rs.getString("reservation_date"));
                ar.setResident_id(rs.getInt("resident_id"));
                ar.setRental_amount(rs.getDouble("rental_amount"));
                ar.setDiscount(rs.getDouble("discount"));
                ar.setStatus(rs.getString("status").charAt(0));
                ar.setInspection_details(rs.getString("inspection_details"));
                ar.setAssessed_value(rs.getDouble("assessed_value"));
                ar.setAccept_hoid(rs.getInt("accept_hoid"));
                ar.setAccept_position(rs.getString("accept_position"));
                ar.setAccept_electiondate(rs.getString("accept_electiondate"));
                ar.setReturn_date(rs.getString("return_date"));
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return ar;

    }

    public int getAsset_id() {
        return asset_id;
    }

    public void setAsset_id(int asset_id) {
        this.asset_id = asset_id;
    }

    public String getRental_date() {
        return rental_date;
    }

    public void setRental_date(String rental_date) {
        this.rental_date = rental_date;
    }

    public String getReservation_date() {
        return reservation_date;
    }

    public void setReservation_date(String reservation_date) {
        this.reservation_date = reservation_date;
    }

    public int getResident_id() {
        return resident_id;
    }

    public void setResident_id(int resident_id) {
        this.resident_id = resident_id;
    }

    public double getRental_amount() {
        return rental_amount;
    }

    public void setRental_amount(double rental_amount) {
        this.rental_amount = rental_amount;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public char getStatus() {
        return status;
    }
    public List<Character> getStatusList() {
        List<Character> statusList = new ArrayList<>();
        statusList.add('R');
        statusList.add('C');
        statusList.add('O');
        statusList.add('N');
        return statusList;
    }

    public List<String> getStatusListString() {
        List<String> statusList = new ArrayList<>();
        statusList.add("Reserved");
        statusList.add("Cancelled");
        statusList.add("On-Rent");
        statusList.add("Returned");
        return statusList;
    }
    public String getStatusString() {
        switch (status) {
            case 'R':
                return "Reserved";
            case 'C':
                return "Cancelled";
            case 'O':
                return "On-Rent";
            case 'N':
                return "Returned";
        }
        return null;
    }

    public char getStatusEnum(String status) {
        switch (status) {
            case "Reserved":
                return 'R';
            case "Cancelled":
                return 'C';
            case "On-Rent":
                return 'O';
            case "Returned":
                return 'N';
        }
        return 0;
    }

    public void setStatus(char status) {
        this.status = status;
    }

    public String getInspection_details() {
        return inspection_details;
    }

    public void setInspection_details(String inspection_details) {
        this.inspection_details = inspection_details;
    }

    public double getAssessed_value() {
        return assessed_value;
    }

    public void setAssessed_value(double assessed_value) {
        this.assessed_value = assessed_value;
    }

    public int getAccept_hoid() {
        return accept_hoid;
    }

    public void setAccept_hoid(int accept_hoid) {
        this.accept_hoid = accept_hoid;
    }

    public String getAccept_position() {
        return accept_position;
    }

    public void setAccept_position(String accept_position) {
        this.accept_position = accept_position;
    }

    public String getAccept_electiondate() {
        return accept_electiondate;
    }

    public void setAccept_electiondate(String accept_electiondate) {
        this.accept_electiondate = accept_electiondate;
    }

    public String getReturn_date() {
        return return_date;
    }

    public void setReturn_date(String return_date) {
        this.return_date = return_date;
    }

    public List<asset_rentals> getAr_list() {
        return ar_list;
    }

    public void setAr_list(List<asset_rentals> ar_list) {
        this.ar_list = ar_list;
    }

    public List<asset_rentals> getArListtoUpdate() {
        ar_list.clear();
        try {
            Connection conn = DB.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT asset_id, rental_date, status FROM asset_rentals " +
                    "WHERE status IN ('R', 'N') AND asset_id IN (SELECT asset_id FROM assets WHERE enclosing_asset " +
                    "IS NULL)");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                asset_rentals ar = new asset_rentals();
                ar.setAsset_id(rs.getInt("asset_id"));
                ar.setRental_date(rs.getString("rental_date"));
                ar.setStatus(rs.getString("status").charAt(0));
                ar_list.add(ar);
            }
            ps.close();
            ps = conn.prepareStatement("SELECT asset_id, rental_date, status FROM asset_rentals " +
                    "WHERE status IN ('N') AND asset_id IN (SELECT asset_id FROM assets WHERE enclosing_asset " +
                    "IS NOT NULL)");
            rs = ps.executeQuery();
            while (rs.next()) {
                asset_rentals ar = new asset_rentals();
                ar.setAsset_id(rs.getInt("asset_id"));
                ar.setRental_date(rs.getString("rental_date"));
                ar.setStatus(rs.getString("status").charAt(0));
                ar_list.add(ar);
            }
            ps.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return ar_list;
    }
    public List<asset_rentals> assetsOnRentList() {
        ar_list.clear();
        try {
            Connection conn = DB.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT asset_id, rental_date FROM asset_rentals WHERE status = 'O'" +
                    " AND asset_id IN (SELECT asset_id FROM assets WHERE enclosing_asset IS NULL)");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                asset_rentals ar = new asset_rentals();
                ar.setAsset_id(rs.getInt("asset_id"));
                ar.setRental_date(rs.getString("rental_date"));
                ar_list.add(ar);
            }
            ps.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return ar_list;
    }
    public void clear() {
        asset_id = 0;
        rental_date = "";
        reservation_date = "";
        resident_id = 0;
        rental_amount = 0;
        discount = 0;
        status = ' ';
        inspection_details = "";
        assessed_value = 0;
        accept_hoid = 0;
        accept_position = "";
        accept_electiondate = "";
        return_date = "";
    }
}
