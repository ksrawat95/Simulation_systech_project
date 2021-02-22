--//////////////////////////////////////////////////////////DDL///////////////////////////////////////////////////////////////////////////////////////
drop table dim_Part
CREATE TABLE dim_Part(
	Part_key	int	IDENTITY(1,1)					Primary Key,
	[PartId] [float]							,
	[PartNumber] [nvarchar](255)				,
	[PartSystem] [nvarchar](255)				,
	[PartSubSystem] [nvarchar](255)				,
	[SupplierCode] [float]						,
	[Name] [nvarchar](255)						,
	[Description] [nvarchar](255)				,
	[PlanningLeadtime] [float]					,
	[UnitPrice] [float]							,
	[Orderpoint] [float]						,
	[SafetyStockQuantity] [float]				,
	[FabricatedFlag] [nvarchar](255)			,
	[PurchasedFlag] [nvarchar](255)				,
	[StockedFlag] [nvarchar](255)				,
	[InspectionRequiredFlag] [nvarchar](255)	,
	[HazardousMaterialFlag] [nvarchar](255)		,
	[Version] [nvarchar](255)					,
	[ENABLED] [nvarchar](255)					,
	History1 [nvarchar](255)					,
	History2 [nvarchar](255)					,
	DW_CREATED_DATE	date						DEFAULT getdate(),
	DW_CREATED_BY	varchar(200)				Default suser_sname(),
	DW_UPDATED_DATE	date						DEFAULT getdate(),
	DW_UPDATED_BY	varchar(200)				Default suser_sname(),
)



--///////////////////////////////////////////////////////////DML///////////////////////////////////////////////////////////////////////////////////////
delete from dim_Part
insert into dim_Part ([PartId],[PartNumber],[PartSystem],[PartSubSystem],[SupplierCode],[Name],[Description],[PlanningLeadtime]
,[UnitPrice],[Orderpoint],[SafetyStockQuantity],[FabricatedFlag],[PurchasedFlag],[StockedFlag],[InspectionRequiredFlag],
[HazardousMaterialFlag],[Version],[ENABLED]
)
select case when src.PartID is null then 0 else src.PartID end as PartID,
case when src.PartNumber is null then 'UNK' else src.PartNumber end as  PartNumber,
case when src.PartSystem is null then 'UNK' else(upper(substring(src.PartSystem,1,1))+lower(SUBSTRING(src.PartSystem,2,len(src.PartSystem))))end as PartSystem,
case when src.PartSubSystem is null then 'UNK' else(upper(substring(src.PartSubSystem,1,1))+lower(SUBSTRING(src.PartSubSystem,2,len(src.PartSubSystem))))end as PartSubSystem ,
case when src.suppliercode is null then 0 else src.suppliercode end as suppliercode,
case when src.name is null then 'UNK' else REPLACE(REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE
( REPLACE( REPLACE( REPLACE(REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE
(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(src.name,char(32),''), char(33),''), char(34),''),char(35),'')
,char(36),''),char(37),''),char(38),''),char(39),''),char(40),''),char(41),''),char(42),''),char(43),''),char(44),''),char(45)
,''),char(46),''),char(47),''),char(58),''),char(59),''),char(60),''),char(61),''),char(62),''),char(63),''),char(64),'')
,char(91),''),char(92),''),char(93),''),char(94),''),char(95),''),char(96),''),char(123),''),char(124),''),char(125),''),
char(126),''),char(127),'') end as name,
case when src.description is null then 'UNK' else 
(upper(substring(src.description,1,1))+lower(SUBSTRING(src.description,2,len(src.description)))) end as description,
case when src.planningleadtime is null then 'UNK' else src.planningleadtime end as planningleadtime,
case when src.unitprice is null then 0 else src.unitprice end as unitprice,
case when src.orderpoint is null then 0 else src.orderpoint end as orderpoint,
case when src.safetystockquantity is null then 0 else src.safetystockquantity end as safetystockquantity,
case when src.fabricatedflag = 0 then 'N' else 'Y'end as fabricatedflag,
case when src.purchasedflag = 0 then 'N' else'Y'end as purchasedflag,
case when src.stockedflag = 0 then 'N' else 'Y' end as stockedflag,
case when src.InspectionRequiredFlag = 0 then 'N' else 'Y' end as InspectionRequiredFlag,
case when src.HazardousMaterialFlag = 0 then 'N' else 'Y'end as HazardousMaterialFlag,
case when src.version is null then 'UNK' else src.version end as version,
case when src.ENABLED = 0 then 'N'else 'Y'end as ENABLED
from  [RALLI].[dbo].[Part] src left join dim_Part tgt
on tgt.PartID = src.PartID  where tgt.PartID is null


UPDATE dim_Part  
SET 
history2 = history1,
history1=tgt.name,
name = REPLACE(REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE
( REPLACE( REPLACE( REPLACE(REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE
(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(src.name,char(32),''), char(33),''), char(34),''),char(35),'')
,char(36),''),char(37),''),char(38),''),char(39),''),char(40),''),char(41),''),char(42),''),char(43),''),char(44),''),char(45)
,''),char(46),''),char(47),''),char(58),''),char(59),''),char(60),''),char(61),''),char(62),''),char(63),''),char(64),'')
,char(91),''),char(92),''),char(93),''),char(94),''),char(95),''),char(96),''),char(123),''),char(124),''),char(125),''),
char(126),''),char(127),'')
FROM dim_Part tgt  
INNER JOIN [RALLI].[dbo].[Part] src ON tgt.PartID = src.PartID  
where tgt.name <> REPLACE(REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE
( REPLACE( REPLACE( REPLACE(REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE
(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(src.name,char(32),''), char(33),''), char(34),''),char(35),'')
,char(36),''),char(37),''),char(38),''),char(39),''),char(40),''),char(41),''),char(42),''),char(43),''),char(44),''),char(45)
,''),char(46),''),char(47),''),char(58),''),char(59),''),char(60),''),char(61),''),char(62),''),char(63),''),char(64),'')
,char(91),''),char(92),''),char(93),''),char(94),''),char(95),''),char(96),''),char(123),''),char(124),''),char(125),''),
char(126),''),char(127),'')


