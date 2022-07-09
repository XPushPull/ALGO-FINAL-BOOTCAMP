Use OOVEO_Salon
-- 2502039415 - PushPull

--Select *
--From MsTreatment, MsTreatmentType

--Select *
--From HeaderSalonServices

-- Number 1
Select *
From MsStaff
Where StaffGender = 'Female'

-- Number 2
Select StaffName, CAST('Rp. 'As VARCHAR) + CAST (StaffSalary As VARCHAR) AS StaffSalary
From MsStaff
Where StaffName LIKE '%M%' AND StaffSalary >= 10000000

--Number 3
Select TreatmentName, Price
From MsTreatment
Where TreatmentTypeId IN ('TT002','TT003')

--Number 4
Select StaffName, StaffPosition, Convert(VARCHAR, TransactionDate, 107) AS TransactionDate
From HeaderSalonServices A
Join MsStaff B
	ON A.StaffId = B.StaffId
Where StaffSalary Between 700000 AND 10000000

--Number 5
Select SUBSTRING(CustomerName, 1, CHARINDEX(' ', CustomerName)) AS Name, LEFT(CustomerGender, 1) AS Gender, PaymentType AS 'Payment Type'
From HeaderSalonServices A
JOIN MsCustomer B
	ON A.CustomerId = B.CustomerId
Where PaymentType = 'Debit' 

--Number 6
Select LEFT(CustomerName, 1) + SUBSTRING(CustomerName, CHARINDEX(' ', CustomerName) + 1, 1) AS Initial, DATENAME(WEEKDAY, TransactionDate) AS Day
From HeaderSalonServices A
JOIN MsCustomer B
	ON A.CustomerId = B.CustomerId
Where DATEDIFF(DAY, '2012/12/24', TransactionDate) BETWEEN -2 AND 2

--Number 7
Select TransactionDate, REVERSE(SUBSTRING(REVERSE(CustomerName), 1, CHARINDEX(' ', REVERSE(CustomerName)) - 1)) AS CustomerName
From HeaderSalonServices A
JOIN MsCustomer B
	ON A.CustomerId = B.CustomerId
Where CustomerName LIKE '% %' AND DATENAME(WEEKDAY, TransactionDate) = 'Saturday'

--Number 8
Select StaffName, CustomerName, REPLACE(CustomerPhone, '0', '+62') AS CustomerPhone, CustomerAddress
From HeaderSalonServices A
JOIN MsCustomer B
	ON A.CustomerId = B.CustomerId
JOIN MsStaff C
	ON A.StaffId = C.StaffId
Where StaffName LIKE '% % %' AND CustomerName LIKE '[aiueo]%'

--Number 9
Select StaffName, TreatmentName, DATEDIFF(DAY, TransactionDate, '2012/12/24') AS 'Term of Transaction'
From DetailSalonServices A
JOIN HeaderSalonServices B
	ON A.TransactionId = B.TransactionId
JOIN MsStaff C
	ON B.StaffId = C.StaffId
JOIN MsTreatment D
	ON A.TreatmentId = D.TreatmentId
Where LEN(TreatmentName) > 20 OR TreatmentName LIKE '% %'

--Number 10
Select TransactionDate, CustomerName, TreatmentName, CAST(Price AS INT)*20/100 AS Discount, PaymentType AS 'Payment Type'
From DetailSalonServices A
JOIN HeaderSalonServices B
	ON A.TransactionId = B.TransactionId
JOIN MsStaff C
	ON B.StaffId = C.StaffId
JOIN MsTreatment D
	ON A.TreatmentId = D.TreatmentId
JOIN MsCustomer E
	ON B.CustomerId = E.CustomerId
Where TransactionDate = '2012/12/22'
