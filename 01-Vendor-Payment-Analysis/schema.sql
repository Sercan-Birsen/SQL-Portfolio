/*=========================================================
Database Schema
Project: Vendor Payment Analysis
Database: SQLite
=========================================================*/

CREATE TABLE Vendors (
    vendor_id_num INTEGER PRIMARY KEY,
    vendor_name TEXT,
    country TEXT,
    status TEXT,
    currency TEXT,
    created_date TEXT
);

CREATE TABLE Payments (
    payment_id_num INTEGER PRIMARY KEY,
    vendor_id_num INTEGER,
    payment_date TEXT,
    payment_amount_num REAL,
    payment_status TEXT,
    FOREIGN KEY (vendor_id_num)
        REFERENCES Vendors(vendor_id_num)
);

CREATE TABLE Vendor_Contacts (
    contact_id INTEGER PRIMARY KEY,
    vendor_id_num INTEGER,
    contact_name TEXT,
    email TEXT,
    department TEXT,
    FOREIGN KEY (vendor_id_num)
        REFERENCES Vendors(vendor_id_num)
);
