USE Salon
-- 2502039415 - PushPull
-- Number 1
Create TABLE MsCustomer(
	CustomerId CHAR(5) NOT NULL,
	CustomerName VARCHAR(50),
	CustomerGender VARCHAR(10),
	CustomerPhone VARCHAR(13),
	CustomerAddress VARCHAR(100),

	Constraint valid_ID_customer
		Check(CustomerId LIKE 'CU[0-9][0-9][0-9]'),
	Constraint valid_gender_customer
		Check(CustomerGender = 'Male' OR CustomerGender = 'Female'),
	Constraint id_pkey_customer
		Primary Key(CustomerId),
)

--Select *
--From MsCustomer

Create TABLE MsStaff(
	StaffId CHAR(5) NOT NULL,
	StaffName VARCHAR(50),
	StaffGender VARCHAR(10),
	StaffPhone VARCHAR(13),
	StaffAddress VARCHAR(100),
	StaffSalary NUMERIC(11,2),
	StaffPosition VARCHAR(20),

	Constraint valid_ID_staff
		Check(StaffId LIKE 'SF[0-9][0-9][0-9]'),
	Constraint valid_gender_staff
		Check(StaffGender = 'Male' OR StaffGender = 'Female'),
	Constraint id_pkey_staff
		Primary Key(StaffId),
)

--Select *
--From MsStaff

Create TABLE MsTreatmentType(
	TreatmentTypeId CHAR(5) NOT NULL,
	TreatmentTypeName VARCHAR(50),

	Constraint valid_ID_TM
		Check(TreatmentTypeId LIKE 'TT[0-9][0-9][0-9]'),
	Constraint id_pkey_trtmnttypeID
		Primary Key(TreatmentTypeId),
)

--Select *
--From MsTreatmentType

Create TABLE MsTreatment(
	TreatmentId CHAR(5) NOT NULL,
	TreatmentTypeId CHAR(5) NOT NULL,
	TreatmentName VARCHAR(50),
	Price NUMERIC (11,2),

	Constraint valid_ID_trmnt
		Check(TreatmentTypeId LIKE 'TM[0-9][0-9][0-9]'),
	Constraint id_fkey_trmnttypeID
		Foreign Key(TreatmentTypeId) References MsTreatmentType(TreatmentTypeId)
		ON Update CASCADE,
	Constraint id_pkey_trtmntypeID
		Primary Key(TreatmentId),
)

--Select *
--From MsTreatment

Create TABLE HeaderSalonServices(
	TransactionId CHAR(5) NOT NULL,
	CustomerId CHAR(5) NOT NULL,
	StaffId CHAR(5) NOT NULL,
	TransactionDate DATE,
	PaymentType VARCHAR(20),

	Constraint valid_ID_transaction
		Check(TransactionId LIKE 'TR[0-9][0-9][0-9]'),
	Constraint id_fkey_Customer
		Foreign Key(CustomerId) References MsCustomer(CustomerId)
		ON Update CASCADE,
	Constraint id_fkey_Staff
		Foreign Key(StaffId) References MsStaff(StaffId)
		ON Update CASCADE,
	Constraint id_pkey_transaction
		Primary Key(TransactionId),
)

--Select *
--From HeaderSalonServices

Create TABLE DetailSalonServices(
	TransactionId CHAR(5) NOT NULL,
	TreatmentId CHAR(5) NOT NULL,

	Constraint id_fkey_transaction
		Foreign Key(TransactionId) References HeaderSalonServices(TransactionId)
		ON Update CASCADE,
	Constraint id_fkey_Staff
		Foreign Key(TreatmentId) References MsTreatment(TreatmentId)
		ON Update CASCADE,
	Constraint id_pkey_transaction_detail
		Primary Key(TransactionId, TreatmentId),
)

--Number 2
DROP Table DetailSalonServices

--Number 3
Create TABLE DetailSalonServices(
	TransactionId CHAR(5) NOT NULL,
	TreatmentId CHAR(5) NOT NULL,

	Constraint id_fkey_transaction
		Foreign Key(TransactionId) References HeaderSalonServices(TransactionId)
		ON Update CASCADE,
	Constraint id_fkey_treatment
		Foreign Key(TreatmentId) References MsTreatment(TreatmentId)
		ON Update CASCADE,
)

Alter TABLE DetailSalonServices
Add CONSTRAINT id_pkey_transtreat
	Primary Key(TransactionId, TreatmentId)

--Number 4
Alter TABLE MsStaff With NOCHECK
ADD Constraint ValidStaffName
	Check(LEN(StaffName) >= 5 AND LEN(StaffName) <=20)

Alter TABLE MsStaff
DROP Constraint ValidStaffName

--Number 5
Alter TABLE MsCustomer
ADD Description VARCHAR(100)

Alter TABLE MsCustomer
DROP Column Description