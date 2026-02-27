-- Таблица организаций (Контрагенты и наша компания)
CREATE TABLE Company (
    CompanyID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    INN VARCHAR(12) NOT NULL,
    KPP VARCHAR(9),
    Address TEXT,
    BankAccount VARCHAR(20)
);

-- Таблица справочника товаров
CREATE TABLE Product (
    ProductID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Unit VARCHAR(50),
    OKEI_Code VARCHAR(3)
);

-- Таблица шапки документа ТОРГ-12
CREATE TABLE Torg12_Header (
    DocID SERIAL PRIMARY KEY,
    DocNumber VARCHAR(50) NOT NULL,
    DocDate DATE NOT NULL,
    SupplierID INT NOT NULL,
    BuyerID INT NOT NULL,
    BaseDocument VARCHAR(255), -- Например: "Договор №1 от 01.01.2023"
    TotalAmount DECIMAL(15, 2),
    FOREIGN KEY (SupplierID) REFERENCES Company(CompanyID),
    FOREIGN KEY (BuyerID) REFERENCES Company(CompanyID)
);

-- Таблица спецификации (строк) документа ТОРГ-12
CREATE TABLE Torg12_Line (
    LineID SERIAL PRIMARY KEY,
    DocID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity DECIMAL(10, 3) NOT NULL,
    Price DECIMAL(15, 2) NOT NULL,
    AmountNoVat DECIMAL(15, 2) NOT NULL,
    VatRate INT NOT NULL, -- например 20
    VatAmount DECIMAL(15, 2) NOT NULL,
    TotalAmount DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (DocID) REFERENCES Torg12_Header(DocID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);