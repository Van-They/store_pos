CREATE TABLE
    IF NOT EXISTS groupItem (
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
        orderNo INTEGER
    );

CREATE TABLE
    IF NOT EXISTS orderHead (
        orderId TEXT PRIMARY KEY,
        invoiceNo TEXT,
        subtotal REAL,
        discountAmount REAL,
        discountPercentage REAL,
        taxAmount REAL,
        taxPercentage REAL,
        grandTotal REAL,
        date TEXT
    );
CREATE TABLE
    IF NOT EXISTS orderHeadTmp (
        orderId TEXT PRIMARY KEY,
        invoiceNo TEXT,
        subtotal REAL,
        discountAmount REAL,
        discountPercentage REAL,
        taxAmount REAL,
        taxPercentage REAL,
        grandTotal REAL,
        date TEXT
    );

CREATE TABLE
    IF NOT EXISTS orderTran (
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
    IF NOT EXISTS orderTranTmp (
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