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
}
