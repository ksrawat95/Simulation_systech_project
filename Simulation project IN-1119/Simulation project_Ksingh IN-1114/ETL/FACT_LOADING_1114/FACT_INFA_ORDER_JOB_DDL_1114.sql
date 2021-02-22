use [Target_OCT19_KSingh]

--drop table fact_info_order_job
CREATE TABLE fact_info_order_job(
	ORD_key int primary key,
	[OrderJobID] [int] ,
	[OrderID] [int] ,
	[OrderJobStatus] int ,
	[LaborPrice] [decimal](18, 2) default 0,
	[LaborAmount] [decimal](18, 2) default 0,
	[TotalAmount] [decimal](18, 2) default 0,
	[TotalPartPrice] [decimal](18, 2) default 0,
	[PayMethod] int default -1,
	[ComplaintNarrative] [nvarchar](max) default 'UNK',
	[CauseNarrative] [nvarchar](max) default 'UNK',
	[Enabled] [bit] default 0,
	[CustomerConcernDetailID] [int] default -1,
	[VOR] varchar(20) default 'UNK',
	[OrderJobCloseDate] varchar(20) default '01-01-1990',
	[Category] int default -1,
	[IsDuplicatedSymptom] varchar(20) default 'UNK',
	[IsDuplicatedCorrection] varchar(20) default 'UNK',
	[IsTow] varchar(20) default 'UNK',
	DateKey float default 0, 
	DW_CREATED_DATE datetime   default getdate()	,
	DW_CREATED_BY varchar(200) default suser_sname(),
	DW_UPDATED_DATE datetime   default getdate()	,
	DW_UPDATED_BY varchar(200) default suser_sname()
)
