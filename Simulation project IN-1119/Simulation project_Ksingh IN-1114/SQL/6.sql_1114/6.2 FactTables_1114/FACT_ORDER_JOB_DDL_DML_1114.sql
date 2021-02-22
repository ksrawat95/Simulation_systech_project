drop table fact_order_job
CREATE TABLE fact_order_job(
	ORD_Gkey int identity(1,1),
	[OrderJobID] [int] ,
	[OrderID] [int] ,
	[OrderJobStatus] int ,
	[LaborPrice] [decimal](18, 2) ,
	[LaborAmount] [decimal](18, 2) ,
	[TotalAmount] [decimal](18, 2) ,
	[TotalPartPrice] [decimal](18, 2) ,
	[PayMethod] int ,
	[ComplaintNarrative] [nvarchar](max) ,
	[CauseNarrative] [nvarchar](max) ,
	[Enabled] [bit] ,
	[CustomerConcernDetailID] [int] ,
	[VOR] [bit] ,
	[OrderJobCloseDate] varchar(20) ,
	[Category] int ,
	[IsDuplicatedSymptom] varchar(20) ,
	[IsDuplicatedCorrection] varchar(20) ,
	[IsTow] varchar(20),
	DateKey float, 
	DW_CREATED_DATE datetime,
	DW_CREATED_BY varchar(200),
	DW_UPDATED_DATE datetime,
	DW_UPDATED_BY varchar(200)
) 
insert into fact_order_job (OrderJobID,OrderID,OrderJobStatus,LaborPrice,LaborAmount,TotalAmount,TotalPartPrice,PayMethod,ComplaintNarrative,CauseNarrative,Enabled,CustomerConcernDetailID,VOR,OrderJobCloseDate,Category,IsDuplicatedSymptom,IsDuplicatedCorrection,IsTow,DateKey,
	DW_CREATED_DATE,
	DW_CREATED_BY,
	DW_UPDATED_DATE,
	DW_UPDATED_BY )


select
case when f.OrderJobID is null then -1 else f.OrderJobID end as OrderJobID,
case when o.ORDERS_Gkey is null then -1 else o.ORDERS_Gkey end as ORDERS_Gkey,
case when ojs.geo_key is null then 'UNK'  else  ojs.geo_key	 end as OrderJobStatus_Gkey	,
case when cast(f.LaborPrice as decimal(10,2)) is null then  0.0 else  cast(f.LaborPrice as decimal(10,2)) end as LaborPrice		,
case when cast(f.LaborAmount as decimal(10,2)) is null then  0.0 else  cast(f.LaborAmount as decimal(10,2))		 end as LaborAmount		,
case when cast(f.TotalAmount as decimal(10,2)) is null then  0.0 else cast(f.TotalAmount as decimal(10,2))			 end as TotalAmount		,
case when cast(f.TotalPartPrice as decimal(10,2)) is null then  0.0 else  cast(f.TotalPartPrice as decimal(10,2))		 end as TotalPartPrice	,
case when oj.geo_key is null then  -1 else  oj.geo_key	end as PayMethod			,
case when ComplaintNarrative is null then  'UNK' else  ComplaintNarrative end as ComplaintNarrative,
case when CauseNarrative is null then  'UNK' else  CauseNarrative	 end as CauseNarrative	,
case when Enabled is null then  0 else  Enabled  end as Enabled ,
case when CustomerConcernDetailID is null then  0  else  CustomerConcernDetailID  end as CustomerConcernDetailID ,
case when VOR is null then  0 else  VOR	  end as VOR,
case when OrderJobCloseDate	is null then '01-01-1900'  else  OrderJobCloseDate  end as OrderJobCloseDate ,
case when cat.geo_key is null then -1  else  Cat.geo_key  end as Category_Gkey,
case when IsDuplicatedSymptom = 1 then 'Y' else 'N' end as IsDuplicatedSymptom,
case when IsDuplicatedCorrection = 1 then 'Y' else 'N' end as IsDuplicatedCorrection,
case when IsTow	=1 then 'Y' else 'N' end as	IsTow			,
case when D.DateKey is null then -1 else D.DateKey end as DateKey,
GETDATE() AS DW_CREATED_DATE,
SUSER_SNAME() AS DW_CREATED_BY,
GETDATE() AS DW_UPDATED_DATE,
Suser_sname() AS DW_UPDATEDBY
from [ralli].[dbo].[orderjob] f
left join fact_orders O on o.orderid= f.orderid
left join [dbo].[Dim_Date] D ON CAST (f.OrderJobCloseDate AS DATE) = D.Date
left join dri_dim_PM_OJ oj on oj.paymethod = f.paymethod
left join dri_dim_OJS_OJ ojs on ojs.orderjobstatus = f.orderjobstatus
left join dri_dim_CAT_OJ cat on cat.category = f.category
