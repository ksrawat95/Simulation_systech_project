use [Target_OCT19_KSingh]
drop table Fact_Order_SC
CREATE TABLE Fact_Order_SC(
	ORDERS_Gkey						int identity(1,1),
	[OrderJobServiceCorrectionId]	[int] ,
	[OrderJobId]					[int] ,
	[ServiceCatalogCode]			[nvarchar](50) ,
	[ServiceCatalog]				[nvarchar](200) ,
	[CorrectionNarrative]			[varchar](4000) ,
	[CorrectionLaborHours]			[decimal](18, 2) ,
	[CorrectionActualLaborHours]	[decimal](18, 2) ,
	[CorrectionLaborPrice]			[decimal](18, 2) ,
	[IsWorkCompleted]				varchar(20) ,
	[Enabled]						varchar(20) ,
	DW_CREATED_DATE					datetime,
	DW_CREATED_BY					varchar(200),
	DW_UPDATED_DATE					datetime,
	DW_UPDATED_BY					varchar(200)
) 

insert into Fact_Order_SC (OrderJobServiceCorrectionId,OrderJobId,ServiceCatalogCode,ServiceCatalog,CorrectionNarrative,
CorrectionLaborHours,
CorrectionActualLaborHours,
CorrectionLaborPrice,IsWorkCompleted,Enabled,DW_CREATED_DATE,DW_CREATED_BY,DW_UPDATED_DATE,DW_UPDATED_BY)

select 
case when OrderJobServiceCorrectionId is null then -1 else OrderJobServiceCorrectionId end as OrderJobServiceCorrectionId,
case when foj.ORD_Gkey is null then -1 else foj.ORD_Gkey end as ORD_Gkey ,
case when ServiceCatalogCode is null  then 'UNK' else ServiceCatalogCode end as ServiceCatalogCode,
case when ServiceCatalog is null then 'UNK' else servicecatalog end as servicecatalog,
case when CorrectionNarrative is null then 'UNK' else CorrectionNarrative end as CorrectionNarrative,
case when cast(CorrectionLaborHours as decimal(10,2)) is null then 0.0 else cast(CorrectionLaborHours as decimal(10,2)) end as CorrectionLaborHours,
case when cast(CorrectionActualLaborHours as decimal(10,2)) is null then 0.0 else cast(CorrectionActualLaborHours as decimal(10,2)) end as CorrectionActualLaborHours,
case when cast(CorrectionLaborPrice as decimal(10,2)) is null then 0.0 else cast(CorrectionLaborPrice as decimal(10,2)) end as CorrectionLaborPrice,
case when IsWorkCompleted =1 then 'Y' else 'N' end as IsWorkCompleted,
case when f.Enabled =1 then 'Y' else 'N' end as Enabled,
GETDATE() AS DW_CREATED_DATE,
SUSER_SNAME() AS DW_CREATED_BY,
GETDATE() AS DW_UPDATED_DATE,
Suser_sname() AS DW_UPDATEDBY
from ralli.[dbo].[OrderJobServiceCorrection] f
left join fact_order_job foj on foj.orderjobid = f.orderjobid






