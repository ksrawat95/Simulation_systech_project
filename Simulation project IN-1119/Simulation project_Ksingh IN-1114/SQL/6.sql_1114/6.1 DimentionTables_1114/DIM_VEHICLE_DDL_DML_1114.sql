--//////////////////////////////////////////////////////////////////////DDL/////////////////////////////////////////////////////////////////////////////////////////////

--use [Target_OCT19_KSingh]
drop table dim_VehicleVIN
CREATE TABLE dim_VehicleVIN(
	vehicle_Geo_key	int	IDENTITY(1,1)	Primary Key,
	[VehicleVINID] [float] ,
	[VehicleVIN] [nvarchar](255) ,
	[VehicleModelCode] [nvarchar](255) ,
	[VehicleModel] [nvarchar](255) ,
	[ModelCategory] [nvarchar](255) ,
	[ModelYear] [float] ,
	[DriveOrientation] [nvarchar](255) ,
	[Actualdeliveryeddate] [smalldatetime] ,
	[Enabled] [float] ,
	[NearestServiceLocationID] [float] ,
	[FactoryGateDate] [smalldatetime] ,
	[VehicleColor] [nvarchar](255) ,
	[VehicleTitle] [nvarchar](255) ,
	[LastOdometer] [float] ,
	[InventoryVehicle] [float] ,
	[NewUsed] [nvarchar](255) ,
	[Market] [nvarchar](255) ,
	[DeliveryRegion] [nvarchar](255) ,
	[OdometerType] [nvarchar](255) ,
	Start_date date,
	End_date date,
	DW_CREATED_DATE	date						DEFAULT getdate(),
	DW_CREATED_BY	varchar(200)				Default suser_sname(),
	DW_UPDATED_DATE	date						DEFAULT getdate(),
	DW_UPDATED_BY	varchar(200)				Default suser_sname()
)


--//////////////////////////////////////////////////////////////////////DML////////////////////////////////////////////////////////////////////////////////////////////////
insert into dim_VehicleVIN(VehicleVINID,VehicleVIN,VehicleModelCode,VehicleModel,ModelCategory,ModelYear,DriveOrientation,Actualdeliveryeddate,
Enabled,NearestServiceLocationID,FactoryGateDate,VehicleColor,VehicleTitle,LastOdometer,InventoryVehicle,NewUsed,Market,DeliveryRegion,OdometerType,Start_date,end_date)
select 
case when src.VehicleVINID is null then -1 else src.VehicleVINID end as VehicleVINID,
case when src.vehiclevin is null then 'UNK' else src.vehiclevin end as vehiclevin,
case when src.vehiclemodelcode is null then 'UNK' else src.vehiclemodelcode end as vehiclemodelcode,
case when src.vehiclemodel is null then 'UNK' else src.vehiclemodel end as vehiclemodel,
case when src.ModelCategory is null then 'UNK' else src.ModelCategory end as ModelCategory,
case when src.ModelYear is null then -1 else src.ModelYear end as ModelYear,
case when src.DriveOrientation is null then 'UNK' else src.DriveOrientation end as DriveOrientation,
case when src.Actualdeliveryeddate is null then '01-01-1900' else
cast( src.Actualdeliveryeddate as varchar(30)) end as Actualdeliveryeddate,
case when src.Enabled is null then -1 else src.Enabled end as Enabled,
case when src.NearestServiceLocationID is null then -1 else src.NearestServiceLocationID end as NearestServiceLocationID,
case when src.FactoryGateDate is null then '01-01-1900' else
 FORMAT(src.FactoryGateDate, 'yyyyMMdd') end as FactoryGateDate,
case when src.VehicleColor is null then 'UNK' else src.VehicleColor end as VehicleColor,
case when src.VehicleTitle is null then 'UNK' else src.VehicleTitle end as VehicleTitle,
case when src.LastOdometer is null then -1 else src.LastOdometer end as LastOdometer,
case when src.InventoryVehicle is null then -1 else src.InventoryVehicle end as InventoryVehicle,
case when src.NewUsed is null then 'UNK' else src.NewUsed end as NewUsed,
case when src.Market is null then 'UNK'
when src.Market ='EU' then 'EUROPE'
when src.Market ='NA' then 'NORTH AMERICA'
when src.Market ='APAC' then 'ASIA PACIFCE'
else src.Market end as Market,

case when src.DeliveryRegion is null then 'UNK' else 
replace(src.DeliveryRegion,' ','') end as DeliveryRegion,


case when src.OdometerType is null then 'UNK'
when src.OdometerType ='Miles' then 'mi'
when src.OdometerType ='Kilometers' then 'km'
else src.OdometerType end as OdometerType,
getdate(),
getdate()
from [ralli].[dbo].[VehicleVIN] src left join dim_VehicleVIN tgt
on tgt.VehicleVIN = src.VehicleVIN  where tgt.VehicleVIN is null and src.Enabled=-1


UPDATE dim_VehicleVIN  
SET 
End_date=dateadd(DAY,-1,start_date),
Enabled = 0
FROM dim_VehicleVIN tgt  
INNER JOIN [ralli].[dbo].[VehicleVIN] src on tgt.VehicleVIN = src.VehicleVIN
where tgt.end_date = (select max(end_date) from dim_VehicleVIN where VehicleVIN=tgt.VehicleVIN) and 
tgt.NearestServiceLocationID <> src.NearestServiceLocationID and src.Enabled =-1



insert into dim_VehicleVIN(VehicleVINID,VehicleVIN,VehicleModelCode,VehicleModel,ModelCategory,ModelYear,DriveOrientation,Actualdeliveryeddate,Enabled,
NearestServiceLocationID,FactoryGateDate,VehicleColor,VehicleTitle,LastOdometer,InventoryVehicle,NewUsed,Market,DeliveryRegion,OdometerType,Start_date,End_date)
select 
case when src.VehicleVINID is null then -1 else src.VehicleVINID end as VehicleVINID,
case when src.vehiclevin is null then 'UNK' else src.vehiclevin end as vehiclevin,
case when src.vehiclemodelcode is null then 'UNK' else src.vehiclemodelcode end as vehiclemodelcode,
case when src.vehiclemodel is null then 'UNK' else src.vehiclemodel end as vehiclemodel,
case when src.ModelCategory is null then 'UNK' else src.ModelCategory end as ModelCategory,
case when src.ModelYear is null then -1 else src.ModelYear end as ModelYear,
case when src.DriveOrientation is null then 'UNK' else src.DriveOrientation end as DriveOrientation,
case when src.Actualdeliveryeddate is null then '01-01-1900' else
cast( src.Actualdeliveryeddate as varchar(30)) end as Actualdeliveryeddate,
case when src.Enabled is null then -1 else src.Enabled end as Enabled,
case when src.NearestServiceLocationID is null then -1 else src.NearestServiceLocationID end as NearestServiceLocationID,
case when src.FactoryGateDate is null then '01-01-1900' else
 FORMAT(src.FactoryGateDate, 'yyyyMMdd') end as FactoryGateDate,
case when src.VehicleColor is null then 'UNK' else src.VehicleColor end as VehicleColor,
case when src.VehicleTitle is null then 'UNK' else src.VehicleTitle end as VehicleTitle,
case when src.LastOdometer is null then -1 else src.LastOdometer end as LastOdometer,
case when src.InventoryVehicle is null then -1 else src.InventoryVehicle end as InventoryVehicle,
case when src.NewUsed is null then 'UNK' else src.NewUsed end as NewUsed,
case when src.Market is null then 'UNK'
when src.Market ='EU' then 'EUROPE'
when src.Market ='NA' then 'NORTH AMERICA'
when src.Market ='APAC' then 'ASIA PACIFCE'
else src.Market end as Market,
case when src.DeliveryRegion is null then 'UNK' else 
replace(src.DeliveryRegion,' ','') end as DeliveryRegion,
case when src.OdometerType is null then 'UNK'
when src.OdometerType ='Miles' then 'mi'
when src.OdometerType ='Kilometers' then 'km'
else src.OdometerType end as OdometerType,
getdate(),
getdate()
from [ralli].[dbo].[VehicleVIN] src left join dim_VehicleVIN tgt
on tgt.VehicleVINID = src.VehicleVINID  
where End_date =(select max(end_date) from dim_vehiclevin t1 where t1.[VehicleVIN]=tgt.[VehicleVIN]) and
tgt.nearestservicelocationid <>src.nearestservicelocationid and src.Enabled=-1 

and tgt.[VehicleVIN] is not null

--where tgt.end_date = (select max(end_date) from dim_VehicleVIN where VehicleVIN=tgt.VehicleVIN) and 
--tgt.NearestServiceLocationID <> src.NearestServiceLocationID and src.Enabled =-1
