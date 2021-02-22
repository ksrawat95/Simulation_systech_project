--drop table fact_infa_orders

use [Target_OCT19_KSingh]

drop table fact_infa_orders
CREATE TABLE fact_infa_orders(
	ORDERS_key int primary key,
	[OrderID] int default -1 ,
	[OrderNumber] [nvarchar](255) default 'UNK' ,
	[DateTime] DateTime default '01-01-1990',
	vehicle_key int default -1,
	[Odometer] [nvarchar](255) default 'UNK',
	User_key int default -1,
	Location_key int default -1 ,
	[PaymentType]  [nvarchar](255) default 'UNK',
	[PaymentRecievedByUserID] int default -1,
	[OrderStatus] [nvarchar](255) default 'UNK',
	[TotalPartPrice] int default -1,
	[TotalLaborAmount] int default -1,
	[TotalTaxAmount] int default -1,
	[TotalAmount] int default -1,
	[IsCustomerPickUp] int default -1,
	[IsRangerDrop] int default -1,
	[ShippingAmount] int default -1,
	[OrderCloseDate] varchar(20) default 'UNK',
	[DiscountAmount] int default -1,
	[ReadyForInvoiceDate] varchar(20) default 'UNK',
	[IsRepeatedIssueReviewed] int default -1,
	[IsReadyForDelivery] int default -1,
	[LeadTechnicianID] [nvarchar](255) default 'UNK',
	[IsCPO] int default -1,
	[IsCPOCompliant] int default -1,
	CUST_key int default -1,
	DateKey_daytime [nvarchar](255) default 'UNK',
	DateKey_OCdate [nvarchar](255) default 'UNK',
	DateKey_RFIdate [nvarchar](255) default 'UNK',
	DW_CREATED_DATE	date		DEFAULT getdate(),
	DW_CREATED_BY	varchar(200)Default suser_sname(),
	DW_UPDATED_DATE	date		DEFAULT getdate(),
	DW_UPDATED_BY	varchar(200)Default suser_sname(),
) 