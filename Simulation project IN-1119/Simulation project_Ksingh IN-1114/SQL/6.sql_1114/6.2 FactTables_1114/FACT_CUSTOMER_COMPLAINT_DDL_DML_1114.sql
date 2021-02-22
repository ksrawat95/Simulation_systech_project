--use ralli
use [Target_OCT19_KSingh]

--drop table Fact_CUST_CUMP

create table Fact_CUST_CUMP(
CUST_CP_Gkey int identity(1,1),
CustomerComplaintID float,
vehicle_Geo_key int,	
Location_Geo_key int,
Enabled float,
createdate varchar(20),
CUST_Geo_key int,
DateKey float,
DW_CREATED_DATE datetime,
DW_CREATED_BY varchar(200),
DW_UPDATED_DATE datetime,
DW_UPDATED_BY varchar(200)
)


insert into Fact_CUST_CUMP(CustomerComplaintID,vehicle_Geo_key,Location_Geo_key,Enabled,createdate,CUST_Geo_key,DateKey,DW_CREATED_DATE,DW_CREATED_BY,DW_UPDATED_DATE,DW_UPDATED_BY)
select 
case when CustomerComplaintID is null then 0 else CustomerComplaintID end as CustomerComplaintID,
case when vehicle_Geo_key is null then -1 else vehicle_Geo_key end as vehicle_key,
case when l.Location_Geo_key is null then -1 else l.Location_Geo_key end as Location_key,
case when f.Enabled is null then 0 else f.Enabled end as Enabled,
case when f.[CreatedDate] is null then 'unk' ELSE ltrim(rtrim(format( f.[CreatedDate],'dd-MM-yyyy hh:mm:ss'))) END AS  [CreatedDate],
case when c.CUST_Geo_key is null then 0 else c.CUST_Geo_key end as CUST_key,
case when D.DateKey is null then -1 else D.DateKey end as DateKey,
GETDATE() AS DW_CREATED_DATE,
SUSER_SNAME() AS DW_CREATED_BY,
GETDATE() AS DW_UPDATED_DATE,
Suser_sname() AS DW_UPDATEDBY
from ralli.dbo.CustomerComplaint f 
left join [dbo].[dim_VehicleVIN] v 
ON f.[VIN] =  V.VehicleVIN
left join [dbo].[dim_location] L
on f.locationid = l.locationid
left join [dbo].[Dim_Customer] c
ON f.[Customer_id] =  C.[Customer_id]
LEFT JOIN [dbo].[Dim_Date] D
ON CAST (f.[CreatedDate] AS DATE) = D.Date



