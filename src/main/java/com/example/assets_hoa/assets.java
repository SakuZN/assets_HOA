package com.example.assets_hoa;

import java.sql.*;
import java.util.*;
public class assets {

    private int         asset_id;
    private String      asset_name;
    private String      asset_description;

    private String      acquisition_date;
    private int         forrent;
    private double      asset_value;
    private char        type_asset;
    private final char[] ENUM_TYPES = {'P', 'E', 'F', 'O'};
    private char        status;
    private final char[] ENUM_STATUS = {'W', 'D', 'P', 'S', 'X'};
    private double      loc_lattitude;
    private double      loc_longiture;
    private String      hoa_name;
    private int         enclosing_asset;

    private ArrayList<assets> assetsList = new ArrayList<assets>();
    private ArrayList<reference_hoa> hoaList = new ArrayList<reference_hoa>();

    public assets () {
        asset_id = 0;
        asset_name = "";
        asset_description = "";
        acquisition_date = "";
        forrent = 0;
        asset_value = 0.0;
        type_asset = ' ';
        status = ' ';
        loc_lattitude = 0.0;
        loc_longiture = 0.0;
        hoa_name = "";
        enclosing_asset = -1;
    }

    public int register_asset() {
        try {
            Connection conn = DB.getConnection();
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO assets (asset_id, asset_name, " +
                    "asset_description, acquisition_date, forrent, asset_value, type_asset, status, loc_lattitude, " +
                    "loc_longiture, hoa_name, enclosing_asset) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            stmt.setInt(1,      getAsset_id());
            stmt.setString(2,   getAsset_name());
            stmt.setString(3,   getAsset_description());
            stmt.setString(4,   getAcquisition_date());
            stmt.setInt(5,      getForrent());
            stmt.setDouble(6,   getAsset_value());
            stmt.setString(7,   String.valueOf(getType_asset()));
            stmt.setString(8,   String.valueOf(getStatus()));
            stmt.setDouble(9,   getLoc_lattitude());
            stmt.setDouble(10,  getLoc_longiture());
            stmt.setString(11,  getHoa_name());
            if (getEnclosing_asset() != -1) {
                stmt.setInt(12, getEnclosing_asset());
            } else {
                stmt.setNull(12, java.sql.Types.INTEGER);
            }
            stmt.executeUpdate();

            conn.close();
            stmt.close();
        }
        catch (Exception e) {
            System.out.println("Error: " + e);
            return 0;
        }
        return 1;
    }

    public int update_asset() {
        try {
            Connection conn = DB.getConnection();
            PreparedStatement stmt = conn.prepareStatement("UPDATE assets SET " +
                    "asset_description = ?, forrent = ?, asset_value = ?, " +
                    "status = ?, loc_lattitude = ?, loc_longiture = ?, enclosing_asset = ? WHERE asset_id = ?");
            stmt.setString(1,   getAsset_description());
            stmt.setInt(2,      getForrent());
            stmt.setDouble(3,   getAsset_value());
            stmt.setString(4,   String.valueOf(getStatus()));
            stmt.setDouble(5,   getLoc_lattitude());
            stmt.setDouble(6,   getLoc_longiture());
            if (getEnclosing_asset() != -1) {
                stmt.setInt(7, getEnclosing_asset());
            } else {
                stmt.setNull(7, java.sql.Types.INTEGER);
            }
            stmt.setInt(8,     getAsset_id());
            stmt.executeUpdate();
            conn.close();
            stmt.close();
        }
        catch (Exception e) {
            System.out.println("Error: " + e);
            return 0;
        }
        return 1;
    }
    public int delete_asset() {
        try {
            Connection conn = DB.getConnection();
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM assets WHERE asset_id = ?");
            stmt.setInt(1,     getAsset_id());
            stmt.executeUpdate();
            conn.close();
            stmt.close();
        }
        catch (Exception e) {
            System.out.println("Error: " + e);
            return 0;
        }
        return 1;
    }
    public int dispose_asset() {
        try {
            Connection conn = DB.getConnection();
            PreparedStatement stmt = conn.prepareStatement("UPDATE assets SET status = 'X' WHERE asset_id = ?");
            stmt.setInt(1,     getAsset_id());
            stmt.executeUpdate();
            conn.close();
            stmt.close();
        }
        catch (Exception e) {
            System.out.println("Error: " + e);
            return 0;
        }
        return 1;
    }

    public int generateAssetID() {
        int newID = 0;
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement stmt = conn.prepareStatement("SELECT MAX(asset_id) + 1 FROM assets");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                newID = rs.getInt(1);
            }
            conn.close();
            rs.close();
            stmt.close();
        }
        catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return newID;
    }

    public int getAsset_id() {
        return asset_id;
    }

    public void setAsset_id(int asset_id) {
        this.asset_id = asset_id;
    }

    public String getAsset_name() {
        return asset_name;
    }

    public void setAsset_name(String asset_name) {
        this.asset_name = asset_name;
    }

    public String getAsset_description() {
        return asset_description;
    }

    public void setAsset_description(String asset_description) {
        this.asset_description = asset_description;
    }

    public String getAcquisition_date() {
        return acquisition_date;
    }

    public void setAcquisition_date(String acquisition_date) {
        this.acquisition_date = acquisition_date;
    }

    public int getForrent() {
        return forrent;
    }

    public void setForrent(int forrent) {
        this.forrent = forrent;
    }

    public double getAsset_value() {
        return asset_value;
    }

    public void setAsset_value(double asset_value) {
        this.asset_value = asset_value;
    }

    public char getType_asset() {
        return type_asset;
    }
    public String getType_assetString() {
        switch (type_asset) {
            case 'P':
                return "Property";
            case 'E':
                return "Equipment";
            case 'F':
                return "F&F";
            case 'O':
                return "Other";
            default:
                return "Unknown";
        }
    }

    public void setType_asset(char type_asset) {
        this.type_asset = type_asset;
    }

    public char getStatus() {
        return status;
    }
    public String getStatusString() {
        switch (status) {
            case 'W':
                return "Working";
            case 'D':
                return "Deteriorated";
            case 'P':
                return "For Repair";
            case 'S':
                return "For Disposal";
            case 'X':
                return "Disposed";
            default:
                return "Unknown";
        }
    }
    public List<String> getStatusList() {
        List<String> statusList = new ArrayList<>();
        statusList.add("Working");
        statusList.add("Deteriorated");
        statusList.add("For Repair");
        statusList.add("For Disposal");
        statusList.add("Disposed");
        return statusList;
    }
    public char getStatusChar(String status) {
        switch (status) {
            case "Working":
                return 'W';
            case "Deteriorated":
                return 'D';
            case "For Repair":
                return 'P';
            case "For Disposal":
                return 'S';
            case "Disposed":
                return 'X';
            default:
                return 'U';
        }
    }

    public void setStatus(char status) {
        this.status = status;
    }

    public double getLoc_lattitude() {
        return loc_lattitude;
    }

    public void setLoc_lattitude(double loc_lattitude) {
        this.loc_lattitude = loc_lattitude;
    }

    public double getLoc_longiture() {
        return loc_longiture;
    }

    public void setLoc_longiture(double loc_longiture) {
        this.loc_longiture = loc_longiture;
    }

    public String getHoa_name() {
        return hoa_name;
    }

    public void setHoa_name(String hoa_name) {
        this.hoa_name = hoa_name;
    }

    public ArrayList<assets> getPropertyAssetsList() {
        this.assetsList.clear();
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement stmt = conn.prepareStatement("SELECT asset_id, asset_name FROM assets WHERE type_asset " +
                    "= 'P'");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                assets asset = new assets();
                asset.setAsset_id(rs.getInt("asset_id"));
                asset.setAsset_name(rs.getString("asset_name"));
                assetsList.add(asset);
            }
            conn.close();
            rs.close();
            stmt.close();
        }
        catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return assetsList;
    }

    public ArrayList<assets> getAssetsList() {
        assetsList.clear();
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement stmt = conn.prepareStatement("SELECT asset_id, asset_name FROM assets WHERE status " +
                    "!= 'X'");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                assets asset = new assets();
                asset.setAsset_id(rs.getInt("asset_id"));
                asset.setAsset_name(rs.getString("asset_name"));
                assetsList.add(asset);
            }
            conn.close();
            rs.close();
            stmt.close();
        }
        catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return assetsList;
    }
    public ArrayList<assets> getBadEncode_assets() {
        assetsList.clear();
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM assets a\n" +
                    "WHERE a.asset_id NOT IN (\n" +
                    "    SELECT at.asset_id FROM asset_transactions at\n" +
                    "    )\n" +
                    "AND a.asset_id NOT IN (\n" +
                    "    SELECT da.asset_id FROM donated_assets da\n" +
                    "    );");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                assets asset = new assets();
                asset.setAsset_id(rs.getInt("asset_id"));
                asset.setAsset_name(rs.getString("asset_name"));
                assetsList.add(asset);
            }
            conn.close();
            rs.close();
            stmt.close();
        }
        catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return assetsList;
    }

    public ArrayList<reference_hoa> getHoaList() {
        this.hoaList.clear();
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement stmt = conn.prepareStatement("SELECT hoa_name FROM hoa");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                hoaList.add(new reference_hoa(rs.getString("hoa_name")));
            }
            conn.close();
            rs.close();
            stmt.close();
        }
        catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return hoaList;
    }

    public ArrayList<assets> getForDisposal(){
        assetsList.clear();
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement stmt = conn.prepareStatement("SELECT asset_id, asset_name FROM assets WHERE status " +
                    "= 'S'");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                assets asset = new assets();
                asset.setAsset_id(rs.getInt("asset_id"));
                asset.setAsset_name(rs.getString("asset_name"));
                assetsList.add(asset);
            }
            conn.close();
            rs.close();
            stmt.close();
        }
        catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return assetsList;
    }

    public assets getAssetInfo(int asset_id) {
        assets asset = new assets();
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM assets WHERE asset_id = ?");
            stmt.setInt(1, asset_id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                asset.setAsset_id(rs.getInt("asset_id"));
                asset.setAsset_name(rs.getString("asset_name"));
                asset.setAsset_description(rs.getString("asset_description"));
                asset.setAcquisition_date(rs.getString("acquisition_date"));
                asset.setStatus(rs.getString("status").charAt(0));
                asset.setLoc_lattitude(rs.getDouble("loc_lattitude"));
                asset.setLoc_longiture(rs.getDouble("loc_longiture"));
                asset.setEnclosing_asset(rs.getInt("enclosing_asset"));
                asset.setForrent(rs.getInt("forrent"));
                asset.setAsset_value(rs.getDouble("asset_value"));
                asset.setType_asset(rs.getString("type_asset").charAt(0));
                asset.setHoa_name(rs.getString("hoa_name"));
            }
            conn.close();
            rs.close();
            stmt.close();
        }
        catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return asset;
    }

    public int getEnclosing_asset() {
        return enclosing_asset;
    }
    public String getEnclosing_assetName() {
        String asset_name = "";
        if (enclosing_asset == -1 || enclosing_asset == 0)
            return "None";
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement stmt = conn.prepareStatement("SELECT asset_name FROM assets WHERE asset_id = ?");
            stmt.setInt(1, enclosing_asset);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                asset_name = rs.getString("asset_name");
            }
            conn.close();
            rs.close();
            stmt.close();
        }
        catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return asset_name;
    }

    public void setEnclosing_asset(int enclosing_asset) {
        if (enclosing_asset != -1)
            this.enclosing_asset = enclosing_asset;
    }
}
