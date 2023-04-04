package com.example.assets_hoa;
import java.sql.*;
import java.util.*;
public class reference_resident {

    private int resident_id;

    private List<reference_resident> res_list = new ArrayList<>();

    public reference_resident() {
        resident_id = 0;
    }

    public List<reference_resident> getRes_list() {
        res_list.clear();
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM residents");
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

    public int getResident_id() {
        return resident_id;
    }

    public void setResident_id(int resident_id) {
        this.resident_id = resident_id;
    }
}
