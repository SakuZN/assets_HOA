package com.example.assets_hoa;

import java.sql.*;
import java.util.*;

public class asset_transaction {

    private int asset_id;
    private String transaction_date;
    private int trans_hoid;
    private String trans_position;
    private String trans_electiondate;
    private int isdeleted;
    private int approval_hoid;
    private String approval_position;
    private String approval_electiondate;
    private int ornum;
    private char transaction_type;
    private List<asset_transaction> at_list = new ArrayList<>();
    public asset_transaction() {
        this.asset_id = 0;
        this.transaction_date = "";
        this.trans_hoid = 0;
        this.trans_position = "";
        this.trans_electiondate = "";
        this.isdeleted = 0;
        this.approval_hoid = 0;
        this.approval_position = "";
        this.approval_electiondate = "";
        this.ornum = 0;
        this.transaction_type = ' ';
    }

    public List<asset_transaction> getATList() {
        try {
            at_list.clear();
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM asset_transactions WHERE transaction_type = " +
                    "'R' AND isdeleted = 0");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                asset_transaction at = new asset_transaction();
                at.setAsset_id(rs.getInt("asset_id"));
                at.setTransaction_date(rs.getString("transaction_date"));
                at.setTrans_hoid(rs.getInt("trans_hoid"));
                at.setTrans_position(rs.getString("trans_position"));
                at.setTrans_electiondate(rs.getString("trans_electiondate"));
                at.setIsdeleted(rs.getInt("isdeleted"));
                at.setApproval_hoid(rs.getInt("approval_hoid"));
                at.setApproval_position(rs.getString("approval_position"));
                at.setApproval_electiondate(rs.getString("approval_electiondate"));
                at.setOrnum(rs.getInt("ornum"));
                at.setTransaction_type(rs.getString("transaction_type").charAt(0));
                at_list.add(at);
            }
            conn.close();
            ps.close();
        }
        catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return at_list;
    }

    public int register_transaction() {
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("INSERT INTO asset_transactions " +
                    "(asset_id, transaction_date, trans_hoid, trans_position, trans_electiondate, isdeleted, " +
                    "approval_hoid, approval_position, approval_electiondate, ornum, transaction_type) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setInt(1, getAsset_id());
            ps.setString(2, getTransaction_date());
            ps.setInt(3, getTrans_hoid());
            ps.setString(4, getTrans_position());
            ps.setString(5, getTrans_electiondate());
            ps.setInt(6, getIsdeleted());
            if (getApproval_hoid() == 0)
                ps.setNull(7, Types.INTEGER);
            else
                ps.setInt(7, getApproval_hoid());
            if (Objects.equals(getApproval_position(), ""))
                ps.setNull(8, Types.VARCHAR);
            else
                ps.setString(8, getApproval_position());
            if (Objects.equals(getApproval_electiondate(), ""))
                ps.setNull(9, Types.VARCHAR);
            else
                ps.setString(9, getApproval_electiondate());
            if (getOrnum() == 0)
                ps.setNull(10, Types.INTEGER);
            else
                ps.setInt(10, getOrnum());
            ps.setString(11, String.valueOf(getTransaction_type()));
            ps.executeUpdate();

            assets check_asset = new assets();
            check_asset = check_asset.getAssetInfo(getAsset_id());
            List<assets> enclosed_assets = check_asset.getEnclosed_assets();
            if (check_asset.getType_asset() == 'P' && !enclosed_assets.isEmpty())
                for (assets ea : enclosed_assets) {
                    ps.setInt(1, ea.getAsset_id());
                    ps.setString(2, getTransaction_date());
                    ps.setInt(3, getTrans_hoid());
                    ps.setString(4, getTrans_position());
                    ps.setString(5, getTrans_electiondate());
                    ps.setInt(6, getIsdeleted());
                    if (getApproval_hoid() == 0)
                        ps.setNull(7, Types.INTEGER);
                    else
                        ps.setInt(7, getApproval_hoid());
                    if (Objects.equals(getApproval_position(), ""))
                        ps.setNull(8, Types.VARCHAR);
                    else
                        ps.setString(8, getApproval_position());
                    if (Objects.equals(getApproval_electiondate(), ""))
                        ps.setNull(9, Types.VARCHAR);
                    else
                        ps.setString(9, getApproval_electiondate());
                    if (getOrnum() == 0)
                        ps.setNull(10, Types.INTEGER);
                    else
                        ps.setInt(10, getOrnum());
                    ps.setString(11, String.valueOf(getTransaction_type()));
                    ps.executeUpdate();
                }

            conn.close();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return 0;
        }
        return 1;
    }

    public asset_transaction getATInfo(int asset_id, String transaction_date) {
        asset_transaction at = new asset_transaction();
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM asset_transactions WHERE asset_id = ? AND " +
                    "transaction_date = ? AND transaction_type = 'R' AND isdeleted = 0");
            ps.setInt(1, asset_id);
            ps.setString(2, transaction_date);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                at.setAsset_id(rs.getInt("asset_id"));
                at.setTransaction_date(rs.getString("transaction_date"));
                at.setTrans_hoid(rs.getInt("trans_hoid"));
                at.setTrans_position(rs.getString("trans_position"));
                at.setTrans_electiondate(rs.getString("trans_electiondate"));
                at.setIsdeleted(rs.getInt("isdeleted"));
                at.setApproval_hoid(rs.getInt("approval_hoid"));
                at.setApproval_position(rs.getString("approval_position"));
                at.setApproval_electiondate(rs.getString("approval_electiondate"));
                at.setOrnum(rs.getInt("ornum"));
                at.setTransaction_type(rs.getString("transaction_type").charAt(0));
            }
            conn.close();
            ps.close();
        }
        catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return at;
    }

    public int markDeleteTransaction() {
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("UPDATE asset_transactions SET isdeleted = 1 WHERE asset_id = ? AND " +
                    "transaction_date = ? AND transaction_type = 'R' AND isdeleted = 0");
            ps.setInt(1, getAsset_id());
            ps.setString(2, getTransaction_date());
            ps.executeUpdate();

            conn.close();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return 0;
        }
        return 1;
    }

    public void generateNewOR() {
        reference_ornumber ro = new reference_ornumber();
        setOrnum(ro.generateNewORNumber());
    }

    public int setNewOR(int asset_id, String transaction_date, int new_ornum) {
        try {
            Connection conn = DB.getConnection();
            assert conn != null;
            PreparedStatement ps = conn.prepareStatement("UPDATE asset_transactions SET ornum = ? WHERE asset_id = ? AND " +
                    "transaction_date = ? AND transaction_type = 'R' AND isdeleted = 0");
            ps.setInt(1, new_ornum);
            ps.setInt(2, asset_id);
            ps.setString(3, transaction_date);
            ps.executeUpdate();

            conn.close();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return 0;
        }
        return 1;
    }

    public int getAsset_id() {
        return asset_id;
    }

    public void setAsset_id(int asset_id) {
        this.asset_id = asset_id;
    }

    public String getTransaction_date() {
        return transaction_date;
    }

    public void setTransaction_date(String transaction_date) {
        this.transaction_date = transaction_date;
    }

    public int getTrans_hoid() {
        return trans_hoid;
    }

    public void setTrans_hoid(int trans_hoid) {
        this.trans_hoid = trans_hoid;
    }

    public String getTrans_position() {
        return trans_position;
    }

    public void setTrans_position(String trans_position) {
        this.trans_position = trans_position;
    }

    public String getTrans_electiondate() {
        return trans_electiondate;
    }

    public void setTrans_electiondate(String trans_electiondate) {
        this.trans_electiondate = trans_electiondate;
    }

    public int getIsdeleted() {
        return isdeleted;
    }

    public void setIsdeleted(int isdeleted) {
        this.isdeleted = isdeleted;
    }

    public int getApproval_hoid() {
        return approval_hoid;
    }

    public void setApproval_hoid(int approval_hoid) {
        this.approval_hoid = approval_hoid;
    }

    public String getApproval_position() {
        return approval_position;
    }

    public void setApproval_position(String approval_position) {
        this.approval_position = approval_position;
    }

    public String getApproval_electiondate() {
        return approval_electiondate;
    }

    public void setApproval_electiondate(String approval_electiondate) {
        this.approval_electiondate = approval_electiondate;
    }

    public int getOrnum() {
        return ornum;
    }

    public void setOrnum(int ornum) {
        this.ornum = ornum;
    }

    public char getTransaction_type() {
        return transaction_type;
    }
    public String getTransactionType_String() {
        String type_desc = "";
        switch (transaction_type) {
            case 'R':
                type_desc = "Rental";
                break;
            case 'T':
                type_desc = "Transfer";
                break;
            case 'A':
                type_desc = "Activity";
                break;
        }
        return type_desc;
    }

    public List<Character> getTypeList() {
        List<Character> typeList = new ArrayList<>();
        typeList.add('R');
        typeList.add('T');
        typeList.add('A');
        return typeList;
    }
    public List<String> getTypeDescList() {
        List<String> typeDescList = new ArrayList<>();
        typeDescList.add("Rental");
        typeDescList.add("Transfer");
        typeDescList.add("Assessment");
        return typeDescList;
    }

    public void setTransaction_type(char transaction_type) {
        this.transaction_type = transaction_type;
    }

    public void setAt_list(List<asset_transaction> at_list) {
        this.at_list = at_list;
    }
    public void clear() {
        this.asset_id = 0;
        this.transaction_date = "";
        this.trans_hoid = 0;
        this.trans_position = "";
        this.trans_electiondate = "";
        this.isdeleted = 0;
        this.approval_hoid = 0;
        this.approval_position = "";
        this.approval_electiondate = "";
        this.ornum = 0;
        this.transaction_type = ' ';
    }
}
