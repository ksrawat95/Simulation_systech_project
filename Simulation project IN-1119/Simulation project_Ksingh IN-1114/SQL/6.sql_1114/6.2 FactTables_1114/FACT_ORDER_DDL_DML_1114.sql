drop table fact_orders
CREATE TABLE FACT_ORDERS(
	ORDERS_Gkey int identity(1,1),
	[OrderID] [float] ,
	[OrderNumber] [nvarchar](255) ,
	[DateTime] [smalldatetime] ,
	vehicle_Geo_key int,
	[Odometer] [float] ,
	User_Geo_key int ,
	Location_Geo_key int ,
	[PaymentType] int ,
	[PaymentRecievedByUserID] [float] ,
	[OrderStatus] [nvarchar](255) ,
	[TotalPartPrice] [float] ,
	[TotalLaborAmount] [float] ,
	[TotalTaxAmount] [float] ,
	[TotalAmount] [float] ,
	[IsCustomerPickUp] varchar(20) ,
	[IsRangerDrop] varchar(20) ,
	[ShippingAmount] [float] ,
	[OrderCloseDate] varchar(20) ,
	[DiscountAmount] [float] ,
	[ReadyForInvoiceDate] varchar(20) ,
	[IsRepeatedIssueReviewed] varchar(20) ,
	[IsReadyForDelivery] varchar(20) ,
	[LeadTechnicianID] [nvarchar](255) ,
	[IsCPO] varchar(20) ,
	[IsCPOCompliant] varchar(20),
	CUST_Geo_key int ,
	DateKey_daytime float,
	DateKey_OCdate float,
	DateKey_RFIdate float,
	DW_CREATED_DATE datetime,
	DW_CREATED_BY varchar(200),
	DW_UPDATED_DATE datetime,
	DW_UPDATED_BY varchar(200)
) 
insert into FACT_ORDERS (OrderID,OrderNumber,DateTime,vehicle_Geo_key,Odometer,User_Geo_key,Location_Geo_key,PaymentType,PaymentRecievedByUserID,OrderStatus,
TotalPartPrice,TotalLaborAmount,TotalTaxAmount,TotalAmount,IsCustomerPickUp,IsRangerDrop,ShippingAmount,OrderCloseDate,DiscountAmount,ReadyForInvoiceDate,IsRepeatedIssueReviewed,
IsReadyForDelivery,LeadTechnicianID,IsCPO,IsCPOCompliant,CUST_Geo_key,DateKey_daytime,DateKey_OCdate,DateKey_RFIdate,DW_CREATED_DATE,DW_CREATED_BY,
DW_UPDATED_DATE,DW_UPDATED_BY)
select 
case when OrderID is null then 0 else orderid end as orderid ,
case when OrderNumber is null then 'UNK' else ordernumber end as ordernumber,
case when DateTime is null then '01-01-1900' else datetime end as datetime,
case when v.vehicle_Geo_key is null then -1 else v.vehicle_Geo_key end as vehicle_Geo_key,
case when Odometer is null then 0 else odometer end as odometer,
case when U.User_Geo_key is null then -1 else U.User_Geo_key end as User_Geo_key,
case when l.Location_Geo_key is null then -1 else l.Location_Geo_key end as Location_Geo_key,
case when dd.geo_key is null then -1 else dd.geo_key end as payment_geo_key,
case when PaymentRecievedByUserID is null then 0 else PaymentRecievedByUserID end as PaymentRecievedByUserID,
case when OrderStatus is null then 'UNK' else upper(substring(OrderStatus,1,1))+lower(substring(orderstatus,2,len(orderstatus))) end as OrderStatus,
case when cast(TotalPartPrice as decimal(10,2)) is null then 0 else cast(TotalPartPrice as decimal(10,2)) end as TotalPartPrice,
case when cast(TotalLaborAmount as decimal(10,2)) is null then 0 else cast(TotalLaborAmount as decimal(10,2)) end as TotalLaborAmount,
case when cast(TotalTaxAmount as decimal(10,2)) is null then 0 else cast(TotalTaxAmount as decimal(10,2)) end as TotalTaxAmount,
case when cast(TotalAmount as decimal(10,2)) is null then 0 else cast(TotalAmount as decimal(10,2)) end as TotalAmount,
case when IsCustomerPickUp = 1 then 'Y' else 'N' end as IsCustomerPickUp,
case when IsRangerDrop = 1 then 'Y' else 'N' end as IsRangerDrop,
case when cast(ShippingAmount as decimal(10,2)) is null then 0 else cast(ShippingAmount as decimal(10,2)) end as ShippingAmount,
case when f.orderclosedate is null then 'unk' ELSE ltrim(rtrim(format( f.orderclosedate,'yyyy/MM/dd hh:mm:ss'))) END AS  orderclosedate,
case when cast(DiscountAmount as decimal(10,2)) is null then 0 else cast(DiscountAmount as decimal(10,2)) end as DiscountAmount,
case when f.ReadyForInvoiceDate is null then 'unk' ELSE ltrim(rtrim(format( f.ReadyForInvoiceDate,'yyyy/MM/dd hh:mm:ss'))) END AS  ReadyForInvoiceDate,
case when IsRepeatedIssueReviewed = 1 then 'Y' else 'N' end as IsRepeatedIssueReviewed,
case when IsReadyForDelivery = 1 then 'Y' else 'N' end as IsReadyForDelivery,
case when LeadTechnicianID is null then 0 else LeadTechnicianID end as LeadTechnicianID,
case when IsCPO = 1 then 'Y' else 'N' end as IsCPO,
case when IsCPOCompliant = 1 then 'Y' else 'N' end as IsCPOCompliant,
case when c.CUST_Geo_key is null then 0 else c.CUST_Geo_key end as CUST_Geo_key,
case when D.DateKey is null then -1 else D.DateKey end as DateKey,
case when Dt.DateKey is null then -1 else Dt.DateKey end as DateKey,
case when Do.DateKey is null then -1 else Do.DateKey end as DateKey,
GETDATE() AS DW_CREATED_DATE,
SUSER_SNAME() AS DW_CREATED_BY,
GETDATE() AS DW_UPDATED_DATE,
Suser_sname() AS DW_UPDATEDBY
from
[ralli].[dbo].[orders] f
left join [dbo].[dim_VehicleVIN] v 
ON f.[VIN] =  V.VehicleVIN
left join [dbo].[dim_location] L
on f.servicelocationid = l.locationid
left join [dbo].[Dim_Customer] c
ON f.[Customer_id] =  C.[Customer_id]
left join Dim_Users U  on U.UserID = f.serviceadvisoruserid
LEFT JOIN [dbo].[Dim_Date] D ON CAST (f.[DateTime] AS DATE) = D.Date
LEFT JOIN [dbo].[Dim_Date] Dt ON CAST (f.[OrderCloseDate] AS DATE) = Dt.Date
LEFT JOIN [dbo].[Dim_Date] Do ON CAST (f.[ReadyForInvoiceDate] AS DATE) = Do.Date
left join dri_dim_PT_O dd ON f.paymenttype =  dd.paymethod

