use [Target_OCT19_KSingh]
 
 --drop table fact_infa_order_sc_part

 CREATE TABLE fact_infa_order_sc_part (
	SC_PAR int primary key,
	[OrderJobPartId] [int] default -1 ,
	[OrderJobServiceCorrectionId] [int]  default -1,
	[Partnumber] int  default -1,
	[Quantity] [decimal](18, 2)  default 0,
	[Unitprice] [decimal](18, 2)  default 0,
	[Enabled]  varchar(20)   default 'UNK',
	[Partcost] [decimal](18, 2)  default 0,
	[IsCustomPart] varchar(20)  default 'UNK',
	[InventoryQuantityConsumed] [decimal](18, 2)  default 0,
	[IsInventoryConsumed]  varchar(20)  default 'UNK',
	DW_CREATED_DATE	date		DEFAULT getdate(),
	DW_CREATED_BY	varchar(200)Default suser_sname(),
	DW_UPDATED_DATE	date		DEFAULT getdate(),
	DW_UPDATED_BY	varchar(200)Default suser_sname(),
)








