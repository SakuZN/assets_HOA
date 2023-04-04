package com.example.assets_hoa;

import java.sql.*;
import java.util.*;

public class reference_officer {

    private int hoa_id;
    private String position;
    private String election_date;

    private List<reference_officer> ofc_list = new ArrayList<>();

    public reference_officer() {
        hoa_id = 0;
        position = "";
        election_date = "";
    }

    public List<reference_officer> getOfc_list() {
        ofc_list.clear();
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM officer");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                reference_officer ofc = new reference_officer();
                ofc.setHoa_id(rs.getInt("ho_id"));
                ofc.setPosition(rs.getString("position"));
                ofc.setElection_date(rs.getString("election_date"));
                ofc_list.add(ofc);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return ofc_list;
    }
    public int getHoa_id() {
        return hoa_id;
    }

    public void setHoa_id(int hoa_id) {
        this.hoa_id = hoa_id;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getElection_date() {
        return election_date;
    }

    public void setElection_date(String election_date) {
        this.election_date = election_date;
    }
}
