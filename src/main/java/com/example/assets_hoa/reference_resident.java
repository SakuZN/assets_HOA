package com.example.assets_hoa;
import java.sql.*;
import java.util.*;
public class reference_resident {

    private int resident_id;
    private int renter;

    private List<reference_resident> res_list = new ArrayList<>();

    public reference_resident() {
        resident_id = 0;
        renter = 0;
    }

    /**
     * Get all residents who are currently not renters
     *
     * @return
     */
    public List<reference_resident> getRes_list_not_renters() {
        res_list.clear();
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM residents WHERE renter = 0");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                reference_resident res = new reference_resident();
                res.setResident_id(rs.getInt("resident_id"));
                res_list.add(res);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return res_list;
    }

    /**
     * Optional function to fix the renter status of residents who are not renters
     * @return 1 if successful, 0 if not
     */
    public int fix_not_Actualrenters() {
        res_list.clear();
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM residents WHERE resident_id NOT IN " +
                    "(SELECT resident_id FROM asset_rentals WHERE status IN ('R', 'O'))");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                reference_resident res = new reference_resident();
                res.setResident_id(rs.getInt("resident_id"));
                res_list.add(res);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return 0;
        }
        for (reference_resident res : res_list) {
            res.setResident_not_renting();
        }
        return 1;
    }

    /**
     * Set the resident as a renter
     * @return 1 if successful, 0 if not
     */

    public int setResident_renting() {
        int result = 0;
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("UPDATE residents SET renter = 1 WHERE resident_id = ?");
            ps.setInt(1, resident_id);
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return result;
    }

    /**
     * Set the resident as not a renter
     * @return 1 if successful, 0 if not
     */
    public int setResident_not_renting() {
        int result = 0;
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("UPDATE residents SET renter = 0 WHERE resident_id = ?");
            ps.setInt(1, resident_id);
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return result;
    }
    public int getRenter() {
        return renter;
    }
    public void setRenter(int renter) {
        this.renter = renter;
    }

    public int getResident_id() {
        return resident_id;
    }

    public void setResident_id(int resident_id) {
        this.resident_id = resident_id;
    }

    public void clear() {
        resident_id = 0;
        renter = 0;
    }
}
