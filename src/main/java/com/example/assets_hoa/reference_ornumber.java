package com.example.assets_hoa;

import java.sql.*;
import java.util.*;
public class reference_ornumber {

    private int ornum;

    public reference_ornumber() {
        ornum = 0;
    }

    public int generateNewORNumber() {
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("SELECT MAX(ornum) + 1 FROM ref_ornumbers");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ornum = rs.getInt("MAX(ornum)");
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return ornum;
    }
}
