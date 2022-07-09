Use OOVEO_Salon
-- 2502039415 - PushPull

--Select *
--From MsTreatment, MsTreatmentType

--Select *
--From HeaderSalonServices

-- Number 1
Select 
	Max(Price) As [Maximum Price],
	MIN(Price) As [Minimum Price], 
	CAST(Round(AVG(Price),0) as decimal(18,2))[Average Price]
From MsTreatment

-- Number 2
Select 
	StaffPosition, 
	Left(StaffGender, 1) As [Gender], 
	Cast('Rp.' As varchar) + Cast(Cast(Avg(StaffSalary) As decimal(18,2)) As Varchar) as [Average Salary]
From MsStaff
Group by StaffPosition, StaffGender
	
--Number 3
Select 
	Convert(varchar, TransactionDate, 107) as TransactionDate, 
	Count(TransactionId) as [Total Transaction per Day]
From HeaderSalonServices
Group by TransactionDate

--Number 4
Select 
	Upper(CustomerGender) as CustomerGender, 
	Count(TransactionId) as [Total Transaction]
From HeaderSalonServices A
Join MsCustomer B
		On A.CustomerId = B.CustomerId
Group by CustomerGender

--Number 5
Select
	A.TreatmentTypeName,
	Count(C.TransactionId) [Total Transaction]
From MsTreatmentType A
Join MsTreatment B
	on B.TreatmentTypeId = A.TreatmentTypeId
Join DetailSalonServices C
	on B.TreatmentId = C.TreatmentId
Group by A.TreatmentTypeName
Order by [Total Transaction] desc

--Number 6
Select 
	Convert(varchar,A.TransactionDate,106)[Date],
	Cast('Rp.' as varchar) + Cast(Sum(Price) as varchar)[Revenue per Day]
From HeaderSalonServices A
Join DetailSalonServices B
	on B.TransactionId = A.TransactionId
Join MsTreatment C
	on C.TreatmentId = B.TreatmentId
Group by A.TransactionDate
Having sum(Price) between 1000000 and 5000000

--Number 7
Select
	Replace(A.TreatmentTypeId,'TT0','Treatment Type ')[ID],
	A.TreatmentTypeName,
	Cast(Count(B.TreatmentId) as varchar) + ' Treatment'[Total Treatment per Type]
From MsTreatmentType A
Join MsTreatment B
	on A.TreatmentTypeId = B.TreatmentTypeId
Group by A.TreatmentTypeId, A.TreatmentTypeName
Having Count(B.TreatmentId) > 5
Order by Count(B.TreatmentId) desc

--Number 8
Select
	Left(A.StaffName, CHARINDEX(' ',A.StaffName) - 1)[StaffName],
	B.TransactionId [TransactionID],
	count(C.TreatmentId) [Total Treatment per Transaction]
From MsStaff A
Join HeaderSalonServices B
	on B.StaffId = A.StaffId
Join DetailSalonServices C
	on C.TransactionId = B.TransactionId
Group by A.StaffName, B.TransactionId

--Number 9
Select
	A.TransactionDate,
	B.CustomerName,
	E.TreatmentName,
	E.Price
From HeaderSalonServices A
Join MsCustomer B
	on B.CustomerId = A.CustomerId
Join MsStaff C
	on C.StaffId = A.StaffId
Join DetailSalonServices D
	on D.TransactionId = A.TransactionId
Join MsTreatment E
	on E.TreatmentId = D.TreatmentId
Where DATENAME(weekday,TransactionDate) = 'Thursday'
	and C.StaffName like '%Ryan%'
Order by TransactionDate, B.CustomerName asc

--Number 10
Select
	A.TransactionDate,
	B.CustomerName,
	Sum(D.Price)[TotalPrice]
From HeaderSalonServices A
Join MsCustomer B
	on A.CustomerId = B.CustomerId
Join DetailSalonServices C
	on A.TransactionId = C.TransactionId
Join MsTreatment D
	on D.TreatmentId = C.TreatmentId
Where Day(A.TransactionDate) > 20
Group by A.TransactionDate, B.CustomerName
Order by TransactionDate
