Use OOVEO_Salon

--Number 1
Select 
	TreatmentId,
	TreatmentName
From MsTreatment
Where TreatmentId in ('TM001','TM002')

--Number 2
Select 
	TreatmentName,
	Price
From MsTreatment A
Join MsTreatmentType B
	on B.TreatmentTypeId = A.TreatmentTypeId
Where B.TreatmentTypeName not in ('Hair Treatment', 'Message / Spa')

--subqversion
Select 
	TreatmentName,
	Price
From MsTreatment A
Where A.TreatmentTypeId in (
	Select B.TreatmentTypeId
	From MsTreatmentType B
	Where B.TreatmentTypeName not in ('Hair Treatment', 'Message / Spa')
)

--Number 3
Select 
	CustomerName,
	CustomerPhone,
	CustomerAddress
From MsCustomer A
Where len(A.CustomerName) > 8 and A.CustomerId in (
	Select B.CustomerId
	From HeaderSalonServices B
	Where DATENAME(Weekday, B.TransactionDate) = 'Friday'
)

--Number 4
Select
	
