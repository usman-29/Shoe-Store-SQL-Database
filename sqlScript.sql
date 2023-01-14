SUPPLIER TABLE
CREATE TABLE Supplier
(
  Supplier_Name VARCHAR(255) NOT NULL,
  Supplier_ID INT NOT NULL,
  Total_Amount INT NOT NULL,
  Buying_Date Date NOT NULL,
  PRIMARY KEY (Supplier_ID)
);

-- SITE ADMIN TABLE 
CREATE TABLE Site_Admin
(
  Admin_Name VARCHAR(255) NOT NULL,
  Admin_ID INT NOT NULL,
  PRIMARY KEY (Admin_ID)
);

-- SERVICE PROVIDER TABLE 
CREATE TABLE Service_Provider
(
  Provider_Name VARCHAR(255) NOT NULL,
  Service_Provided VARCHAR(255) NOT NULL,
  Provider_Id INT NOT NULL,
  PRIMARY KEY (Provider_Id)
);

-- MARKETING CAMPAIGN TABLE
CREATE TABLE Marketing_Campaign
(
  Start_Date Date NOT NULL,
  End_Date Date NOT NULL,
  Campaign_Name VARCHAR(255) NOT NULL,
  Campaign_Description VARCHAR(255) NOT NULL,
  Campaign_ID INT NOT NULL,
  Admin_ID INT NOT NULL,
  PRIMARY KEY (Campaign_Id)
);

-- MARKETING COSTS TABLE 
CREATE TABLE Marketing_Costs
(
  Exp_amount INT NOT NULL,
  Cost_ID INT NOT NULL,
  Campaign_ID INT NOT NULL,
  PRIMARY KEY (Cost_ID)
);

-- SHOE TABLE
CREATE TABLE Shoe
(
  SKU INT NOT NULL,
  Shoe_Name VARCHAR(255) NOT NULL,
  Cost_Price INT NOT NULL,
  Shoe_Size INT NOT NULL,
  Selling_Price INT NOT NULL,
  Shoe_Brand VARCHAR(255) NOT NULL,
  is_sold NUMBER(1) NOT NULL,
  Post_Date Date NOT NULL,
  Quantity INT NOT NULL,
ADMIN_ID INT NOT NULL,
  PRIMARY KEY (SKU)
);

-- normalized SHOE ORDER table
CREATE TABLE Shoe_Order
(
  SKU INT NOT NULL,
  OrderID INT NOT NULL,
  PRIMARY KEY (SKU, OrderID)
);

-- normalized SHOE SUPPLIER table
CREATE TABLE Shoe_Supplier
(
  SKU INT NOT NULL,
  Supplier_ID INT NOT NULL,
  PRIMARY KEY (SKU, Supplier_ID)
);

-- CUSTOMER TABLE
CREATE TABLE Customer
(
  Customer_Name VARCHAR(255) NOT NULL,
  CustomerID INT NOT NULL,
  Customer_Number INT NOT NULL,
  Street_Address VARCHAR(255) NOT NULL,
  City VARCHAR(255) NOT NULL,
  Customer_Equity INT NOT NULL,
  Code_Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (CustomerID)
);

-- SHOE ORDER TABLE 
CREATE TABLE S_Order
(
  Order_Amount INT NOT NULL,
  OrderID INT NOT NULL,
  Quantity INT NOT NULL,
  Order_Date Date NOT NULL,
  CustomerID INT NOT NULL,
  Code_Name VARCHAR(255),
  Admin_ID INT NOT NULL,
  PRIMARY KEY (OrderID)
);

-- CODE TABLE
CREATE TABLE Code
(
  Code_Name VARCHAR(255) NOT NULL,
  Code_Uses INT NOT NULL,
  Total_Amount INT NOT NULL,
Admin_ID INT NOT NULL,
CustomerID INT NOT NULL,
  PRIMARY KEY (Code_Name)
);

--SERVICES TABLE
CREATE TABLE Shoe_Service
(
  Service_Cost INT NOT NULL,
  Service_ID INT NOT NULL,
  Service_Name VARCHAR(255) NOT NULL,
  Service_Date Date NOT NULL,
  SKU INT,
  PRIMARY KEY (Service_ID)
);

-- SHIPPING COST
CREATE TABLE Shipping_Cost
(
  ID INT NOT NULL,
  is_free NUMBER(1) NOT NULL,
  Shipping_Cost INT NOT NULL,
  OrderID INT NOT NULL,
  PRIMARY KEY (ID)
);

-- PROVIDES
CREATE TABLE Provides
(
  Provider_Id INT NOT NULL,
  Service_ID INT NOT NULL,
  PRIMARY KEY (Provider_Id, Service_ID)
);
-- QUERIES
-- Provides table foreign keys
ALTER TABLE Provides
  ADD FOREIGN KEY (Provider_Id) REFERENCES Service_Provider(Provider_Id);
ALTER TABLE Provides
  ADD FOREIGN KEY (Service_ID) REFERENCES Shoe_Service(Service_ID);

-- Shipping cost table foreign key
ALTER TABLE Shipping_Cost
  ADD FOREIGN KEY (OrderID) REFERENCES S_Order(OrderID);

-- Shoe_Service table foreign key
ALTER TABLE Shoe_Service
 ADD FOREIGN KEY (SKU) REFERENCES Shoe(SKU);

-- Marketing campaign foreign key
ALTER TABLE Marketing_Campaign
ADD FOREIGN KEY (Admin_ID) REFERENCES Site_Admin(Admin_ID);

-- Marketing Costs table foreign key
ALTER TABLE Marketing_CostS
ADD FOREIGN KEY (Campaign_ID) REFERENCES Marketing_Campaign(Campaign_ID);

-- Shoe table foreign key
ALTER TABLE Shoe
ADD FOREIGN KEY (Admin_ID) REFERENCES Site_Admin(Admin_ID);

-- Code table foreign keys
ALTER TABLE Code
ADD FOREIGN KEY (Admin_ID) REFERENCES Site_Admin(Admin_ID);
ALTER TABLE Code
ADD FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

-- Shoe order table foreign keys
ALTER TABLE S_Order
ADD FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);
ALTER TABLE S_Order
  ADD FOREIGN KEY (Code_Name) REFERENCES Code(Code_Name);
ALTER TABLE S_Order
  ADD FOREIGN KEY (Admin_ID) REFERENCES Site_Admin(Admin_ID);

-- Customer table foreign keys
ALTER TABLE Customer
  ADD FOREIGN KEY (Code_Name) REFERENCES Code(Code_Name);

-- Shoe Order table foreign keys
ALTER TABLE Shoe_Order  
ADD FOREIGN KEY (SKU) REFERENCES Shoe(SKU);
ALTER TABLE Shoe_Order  
ADD  FOREIGN KEY (OrderID) REFERENCES S_Order(OrderID);

-- Shoe Supplier table foreign keys
ALTER TABLE Shoe_Supplier
ADD  FOREIGN KEY (SKU) REFERENCES Shoe(SKU);
ALTER TABLE Shoe_Supplier
ADD  FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID);
