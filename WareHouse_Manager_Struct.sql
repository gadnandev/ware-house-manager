CREATE DATABASE WAREHOUSE_MANAGER

GO

USE WAREHOUSE_MANAGER

GO
-------------------------------------------------------------
-------------------------------------------------------------
-----------------------FUNCTION------------------------------


--------------Tự tăng ID sản phẩm giới hạn 99 triệu sản phẩm--------
CREATE FUNCTION AUTO_IDSP() 
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @ID VARCHAR(10)
	IF (SELECT COUNT(ID) FROM OBJECT) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(ID, 8)) FROM OBJECT
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'SP0000000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 and @ID < 99 THEN 'SP000000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99 and @ID < 999 THEN 'SP00000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 999 and @ID < 9999 THEN 'SP0000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9999 and @ID < 99999 THEN 'SP000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99999 and @ID < 999999 THEN 'SP00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 999999 and @ID < 9999999 THEN 'SP0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9999999 and @ID < 99999999 THEN 'SP' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END

GO

--------------Tự tăng ID phiếu nhập giới hạn 99 triệu phiếu--------
CREATE FUNCTION AUTO_IDIN()
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @ID VARCHAR(10)
	IF (SELECT COUNT(ID) FROM INPUT) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(ID, 8)) FROM INPUT
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'IN0000000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 and @ID < 99 THEN 'IN000000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99 and @ID < 999 THEN 'IN00000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 999 and @ID < 9999 THEN 'IN0000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9999 and @ID < 99999 THEN 'IN000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99999 and @ID < 999999 THEN 'IN00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 999999 and @ID < 9999999 THEN 'IN0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9999999 and @ID < 99999999 THEN 'IN' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END

GO

--------------Tự tăng ID phiếu xuất giới hạn 99 triệu phiếu--------
CREATE FUNCTION AUTO_IDOUT()
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @ID VARCHAR(10)
	IF (SELECT COUNT(ID) FROM OUTPUT) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(ID, 8)) FROM OUTPUT
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'HD0000000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 and @ID < 99 THEN 'HD000000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99 and @ID < 999 THEN 'HD00000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 999 and @ID < 9999 THEN 'HD0000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9999 and @ID < 99999 THEN 'HD000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99999 and @ID < 999999 THEN 'HD00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 999999 and @ID < 9999999 THEN 'HD0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9999999 and @ID < 99999999 THEN 'HD' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END

GO	


-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

-------Tạo bảng nhà cung cấp-------
CREATE TABLE SUPLIER(
ID INT IDENTITY PRIMARY KEY,
NAME NVARCHAR(100),
ADDRESS NVARCHAR(100),
PHONE NVARCHAR(10),
EMAIL NVARCHAR(100),
MORE_INFO NVARCHAR(1000),
CONSTRACT_DATE DATE)

GO
-------Tạo bảng đơn vị tính-------
CREATE TABLE UNIT(
ID INT IDENTITY PRIMARY KEY,
NAME NVARCHAR(100))

GO
-------Tạo bảng khách hàng-------
CREATE TABLE CUSTOMER(
ID INT IDENTITY PRIMARY KEY,
NAME NVARCHAR(100),
ADDRESS NVARCHAR(100),
PHONE NVARCHAR(10),
EMAIL NVARCHAR(100),
MORE_INFO NVARCHAR(1000),
REGULAR INT DEFAULT 0)

GO	
------Tạo bảng phiếu nhập------
CREATE	TABLE INPUT(
ID NVARCHAR(10) PRIMARY KEY CONSTRAINT IDIN DEFAULT dbo.AUTO_IDIN(),
DATE_INPUT DATE,
STATUS INT DEFAULT 0)


GO	
------Tạo bảng loại sản phẩm--------
CREATE TABLE OBJECT_TYPE(
ID INT IDENTITY PRIMARY KEY,
NAME NVARCHAR(100))

GO	
------Tạo bảng chi tiết phiếu nhập-------
CREATE TABLE INPUT_DETAIL(
ID INT IDENTITY PRIMARY KEY,
INPUT_ID NVARCHAR(10),
OBJECT_TYPE_ID INT,
NAME NVARCHAR(100),
SUPLIER_ID INT,
UNIT_ID INT,
AMOUNT INT,
IN_PRICE BIGINT,
OUT_PRICE BIGINT,
CONSTRAINT FK_INPUT FOREIGN KEY (INPUT_ID) REFERENCES dbo.INPUT(ID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FK_OBJECT_TYPE FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES dbo.OBJECT_TYPE(ID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FK_SUPLIER FOREIGN KEY (SUPLIER_ID) REFERENCES dbo.SUPLIER(ID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FK_UNIT FOREIGN KEY (UNIT_ID) REFERENCES dbo.UNIT(ID) ON DELETE CASCADE ON UPDATE CASCADE)

GO	
-------Tạo bảng phiếu xuất--------
CREATE TABLE OUTPUT(
ID NVARCHAR(10) PRIMARY KEY CONSTRAINT IDOUT DEFAULT dbo.AUTO_IDOUT(),
DATE_OUTPUT DATE,
CUSTOMER_ID INT,
STATUS INT DEFAULT 0
CONSTRAINT FK_CUSTOMER FOREIGN KEY(CUSTOMER_ID) REFERENCES dbo.CUSTOMER(ID) ON DELETE CASCADE ON UPDATE CASCADE)

GO	
-------Tạo bảng chi tiết phiếu xuất---------
CREATE TABLE OUTPUT_DETAIL(
ID INT IDENTITY PRIMARY KEY,
OUTPUT_ID NVARCHAR(10),
INPUT_DETAIL_ID INT,
AMOUNT INT,
CONSTRAINT FK_OUTPUT FOREIGN KEY(OUTPUT_ID) REFERENCES dbo.OUTPUT(ID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FK_INPUT_DETAIL FOREIGN KEY(INPUT_DETAIL_ID) REFERENCES dbo.INPUT_DETAIL(ID) ON DELETE CASCADE ON UPDATE CASCADE)
-------Tạo bảng user----------
CREATE TABLE USERS(
ID NVARCHAR(20) PRIMARY KEY,
PASSWORD NVARCHAR(50))

