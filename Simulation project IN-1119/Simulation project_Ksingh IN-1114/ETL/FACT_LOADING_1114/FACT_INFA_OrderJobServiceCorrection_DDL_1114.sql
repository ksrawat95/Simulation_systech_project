use [Target_OCT19_KSingh]
--drop table Fact_infa_order_sc
CREATE TABLE fact_infa_order_sc(
	ORDERS_Gkey						int primary key,
	[OrderJobServiceCorrectionId]	[int] default -1,
	[OrderJobId]					[int] default -1,
	[ServiceCatalogCode]			[nvarchar](50) default 'UNK',
	[ServiceCatalog]				[nvarchar](200) default 'UNK',
	[CorrectionNarrative]			[varchar](4000) default 'UNK',
	[CorrectionLaborHours]			[decimal](18, 2) default 0,
	[CorrectionActualLaborHours]	[decimal](18, 2) default 0,
	[CorrectionLaborPrice]			[decimal](18, 2) default 0,
	[IsWorkCompleted]				varchar(20) ,
	[Enabled]						varchar(20) ,
	DW_CREATED_DATE	date		DEFAULT getdate(),
	DW_CREATED_BY	varchar(200)Default suser_sname(),
	DW_UPDATED_DATE	date		DEFAULT getdate(),
	DW_UPDATED_BY	varchar(200)Default suser_sname(),
) 





