use [Target_OCT19_KSingh]
 
 drop table Fact_Order_SC_PART

 CREATE TABLE Fact_Order_SC_PART (
	SC_PAR_Gkey int identity(1,1),
	[OrderJobPartId] [int] ,
	[OrderJobServiceCorrectionId] [int] ,
	[Partnumber] float ,
	[Quantity] [decimal](18, 2) ,
	[Unitprice] [decimal](18, 2) ,
	[Enabled]  varchar(20) ,
	[Partcost] [decimal](18, 2) ,
	[IsCustomPart] varchar(20) ,
	[InventoryQuantityConsumed] [decimal](18, 2) ,
	[IsInventoryConsumed]  varchar(20) ,
	DW_CREATED_DATE datetime,
	DW_CREATED_BY varchar(200),
	DW_UPDATED_DATE datetime,
	DW_UPDATED_BY varchar(200)
)


insert into Fact_Order_SC_PART(OrderJobPartId,OrderJobServiceCorrectionId,Partnumber,Quantity,Unitprice,Enabled,Partcost,IsCustomPart,InventoryQuantityConsumed,
IsInventoryConsumed,DW_CREATED_DATE,DW_CREATED_BY,DW_UPDATED_DATE,DW_UPDATED_BY) 
select 
case when OrderJobPartId is null then -1 else OrderJobPartId end as OrderJobPartId,
case when f.OrderJobServiceCorrectionId is null then -1 else f.OrderJobServiceCorrectionId end as OrderJobServiceCorrectionId,
case when Part_key is null then -1 else Part_key end as Partnumber ,
case when Quantity is null then 0.0 else Quantity end as Quantity,
case when f.Unitprice is null then 0.0 else f.Unitprice end as unitprice,
case when f.Enabled  =1 then 'Y' else 'N' end as enanled,
case when Partcost is null then 0.0 else Partcost end as Partcost,
case when IsCustomPart =1 then 'Y' else 'N' end as IsCustomPart,
case when InventoryQuantityConsumed is null then 0.0 else InventoryQuantityConsumed end as InventoryQuantityConsumed,
case when IsInventoryConsumed =1 then 'Y' else 'N' end as IsInventoryConsumed,
GETDATE() AS DW_CREATED_DATE,
SUSER_SNAME() AS DW_CREATED_BY,
GETDATE() AS DW_UPDATED_DATE,
Suser_sname() AS DW_UPDATEDBY
from
ralli. [dbo].[OrderJobServiceCorrectionPart] f
left join Fact_Order_SC ocs on ocs.OrderJobServiceCorrectionId = f.OrderJobServiceCorrectionId
left join dim_part dp on dp.partnumber =f.partnumber




