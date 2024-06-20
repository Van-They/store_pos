CREATE TABLE
    IF NOT EXISTS group_item (
        code TEXT PRIMARY Key NOT NULL,
        description TEXT,
        description_2 TEXT,
        active INTEGER,
        displayLang TEXT,
        imgPath TEXT
    );

CREATE TABLE
    IF NOT EXISTS item (
        code TEXT PRIMARY Key NOT NULL,
        groupCode TEXT,
        description TEXT,
        description_2 TEXT,
        unitPrice REAL,
        cost REAL,
        active INTEGER,
        displayLang TEXT,
        imgPath TEXT
    );

CREATE TABLE
    IF NOT EXISTS setting (
        uId INTEGER PRIMARY KEY AUTOINCREMENT,
        invoiceNo INTEGER,
        orderNo INTEGER,
        invoiceText TEXT
    );

CREATE TABLE
    IF NOT EXISTS order_head (
        orderId TEXT PRIMARY KEY,
        invoiceNo TEXT,
        discountAmount REAL,
        discountPercentage REAL,
        taxAmount REAL,
        taxPercentage REAL,
        subtotal REAL,
        grandTotal REAL,
        date TEXT
    );

CREATE TABLE
    IF NOT EXISTS order_head_tmp (
        orderId TEXT PRIMARY KEY,
        invoiceNo TEXT,
        discountAmount REAL,
        discountPercentage REAL,
        taxAmount REAL,
        taxPercentage REAL,
        subtotal REAL,
        grandTotal REAL,
        date TEXT
    );

CREATE TABLE
    IF NOT EXISTS order_tran (
        uId INTEGER PRIMARY KEY AUTOINCREMENT,
        orderId TEXT,
        invoiceNo TEXT,
        code TEXT,
        groupCode TEXT,
        description TEXT,
        description_2 TEXT,
        displayLang TEXT,
        unitPrice REAL,
        qty REAL,
        taxAmount REAL,
        taxPercentage REAL,
        discountAmount REAL,
        discountPercentage REAL,
        extendPrice REAL,
        subtotal REAL,
        grandTotal REAL,
        imagePath TEXT,
        date TEXT
    );

CREATE TABLE
    IF NOT EXISTS order_tran_tmp (
        uId INTEGER PRIMARY KEY AUTOINCREMENT,
        orderId TEXT,
        invoiceNo TEXT,
        code TEXT,
        groupCode TEXT,
        description TEXT,
        description_2 TEXT,
        displayLang TEXT,
        unitPrice REAL,
        qty REAL,
        taxAmount REAL,
        taxPercentage REAL,
        discountAmount REAL,
        discountPercentage REAL,
        extendPrice REAL,
        subtotal REAL,
        grandTotal REAL,
        imagePath TEXT,
        date TEXT
    );

CREATE TABLE
    IF NOT EXISTS payment_method (
        code TEXT PRIMARY KEY NOT NULL,
        description TEXT,
        description_2 TEXT,
        displayLang TEXT,
        imagePath TEXT
    );

CREATE TABLE
    IF NOT EXISTS customer (
        code TEXT PRIMARY KEY NOT NULL,
        firstName TEXT,
        lastName TEXT,
        phoneNumber TEXT,
        imagePath TEXT,
        dob TEXT,
        date TEXT
    );

CREATE TABLE
    IF NOT EXISTS posh_cash (
        orderId TEXT PRIMARY KEY NOT NULL,
        invoiceNo TEXT,
        paymentCode TEXT,
        paymentDesc TEXT,
        amount REAL,
        date TEXT
    )