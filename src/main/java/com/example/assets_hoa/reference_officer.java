package com.example.assets_hoa;

import java.sql.*;
import java.util.*;
import java.time.LocalDate;
import java.time.DayOfWeek;

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

    /**
     * Gets the list of transaction officers available for the day
     * @return List of transaction officers
     */
    public List<reference_officer> getTransOfc_list() {
        ofc_list.clear();
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM officer WHERE position " +
                    "NOT IN ('Secretary', 'Treasurer') AND " + dayToday() + " = 1");
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

    /**
     * Gets the list of accepting (Financial) officers available for the day
     * @return List of accepting officers
     */
    public List<reference_officer> getAcceptOfc_list() {
        ofc_list.clear();
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM officer WHERE position " +
                    "IN ('Secretary', 'Treasurer') AND " + dayToday() + " = 1");
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

    /**
     * Gets the list of approving officers (President) available for the day
     * @return List of approving officers
     */
    public List<reference_officer> getApprovingOfc_list() {
        ofc_list.clear();
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM officer WHERE position " +
                    "IN ('President', 'Vice-President') AND " + dayToday() + " = 1");
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

    /**
     * Get the info of the given officer
     * @param ho_id        HOA ID
     * @param position    Position of the officer
     * @param election_date   Election date of the officer
     * @return
     */
    public reference_officer getOfcInfo(int ho_id, String position, String election_date) {
        reference_officer ofc = new reference_officer();
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM officer WHERE ho_id = ? " +
                    "AND position = ? AND election_date = ?");
            ps.setInt(1, ho_id);
            ps.setString(2, position);
            ps.setString(3, election_date);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ofc.setHoa_id(rs.getInt("ho_id"));
                ofc.setPosition(rs.getString("position"));
                ofc.setElection_date(rs.getString("election_date"));
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return ofc;
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

    public void clear() {
        hoa_id = 0;
        position = "";
        election_date = "";
    }

    /**
     * Gets the day of the week
     * @return Day of the week in appropriate format
     */
    private String dayToday() {
        LocalDate today = LocalDate.now();
        DayOfWeek day = today.getDayOfWeek();
        switch (day) {
            case MONDAY:
                return "M";
            case TUESDAY:
                return "T";
            case WEDNESDAY:
                return "W";
            case THURSDAY:
                return "H";
            case FRIDAY:
                return "F";
            case SATURDAY:
                return "S";
            case SUNDAY:
                return "N";
        }
        return "";
    }
}
