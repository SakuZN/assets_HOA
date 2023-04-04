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

    public asset_transaction(){

    }
}
