--//////////////////////////////////////////////////////////////DDL///////////////////////////////////////////////////////////////////////////////
--drop table dim_Location
use [Target_OCT19_KSingh]
CREATE TABLE dim_Location(
	Location_Geo_key	int	IDENTITY(1,1)	Primary Key,
	[LocationID] [float] ,
	[LocationType] [nvarchar](255) ,
	[LocationDescription] [nvarchar](255) ,
	[Region] [nvarchar](255) ,
	[RegionManagerUserID] [float] ,
	[Address] [nvarchar](255) ,
	[City] [nvarchar](255) ,
	[PostalCode] [nvarchar](255) ,
	[PhoneNumber] [nvarchar](255) ,
	[Fax] [nvarchar](255) ,
	[Email] [nvarchar](255) ,
	[StoreManagerUserID] [float] ,
	[IsDelegateServiceCenter] [nvarchar](255) ,
	[Enabled] [nvarchar](255) ,
	[IsPartWareHouse] [nvarchar](255) ,
	[FRTRate] int ,
	[CurrencyCode] [nvarchar](255) ,
	[Market] [nvarchar](255) ,
	[CriticalPartReportLocationTitle] [nvarchar](255) ,
	[IsMRBWareHouse] [nvarchar](255) ,
	[WeekDayWorkHours] [nvarchar](255) ,
	[IsEngineering] [nvarchar](255) ,
	[PreferredLanguage] [nvarchar](255) ,
	DW_CREATED_DATE	date						DEFAULT getdate(),
	DW_CREATED_BY	varchar(200)				Default suser_sname(),
	DW_UPDATED_DATE	date						DEFAULT getdate(),
	DW_UPDATED_BY	varchar(200)				Default suser_sname()
)


--////////////////////////////////////////////////////////////DML/////////////////////////////////////////////////////////////////////////////////

insert into dim_Location(LocationID,LocationType,LocationDescription,Region,RegionManagerUserID,
Address,City,PostalCode,PhoneNumber,Fax,Email,StoreManagerUserID,IsDelegateServiceCenter,Enabled,IsPartWareHouse,
FRTRate,CurrencyCode,Market,CriticalPartReportLocationTitle,IsMRBWareHouse,WeekDayWorkHours,IsEngineering,PreferredLanguage)
select 
case when src.LocationID is null then -1 else src.LocationID end as LocationID,
case when src.LocationType is null then 'UNK' else src.LocationType end as LocationType,
case when src.LocationDescription is null then 'UNK' else 
upper(substring(src.LocationDescription,1,1))+lower(substring(src.LocationDescription,2,len(src.LocationDescription)))+'.' end as LocationDescription,
case when src.Region is null then 'UNK'
when src.Region like 'Mid%' then substring(src.Region,1,3)+' '+ upper(substring(substring(src.Region,4,len(src.region)),1,1))+substring(substring(src.Region,4,len(src.region)),2,len(substring(src.Region,4,len(src.region))))
when src.Region like 'South%' then substring(src.Region,1,5)+' '+upper(substring(substring(src.Region,6,len(src.region)),1,1))+substring(substring(src.Region,6,len(src.region)),2,len(substring(src.Region,6,len(src.region))))
when src.Region like 'North%' then substring(src.Region,1,5)+' '+upper(substring(substring(src.Region,6,len(src.region)),1,1))+substring(substring(src.Region,6,len(src.region)),2,len(substring(src.Region,6,len(src.region))))
else src.Region end as Region,
case when src.RegionManagerUserID is null then -1 else src.RegionManagerUserID end as RegionManagerUserID,
case when src.Address is null then 'UNK' else
'No.'+(substring(src.Address,1,charindex(' ',src.Address)-1)+','+substring(src.Address,charindex(' ',src.Address)+1,LEN(src.Address)))
 end as Address,
case when src.City is null then 'UNK' else src.City end as City,
case when src.PostalCode is null then 'UNK' else src.PostalCode end as PostalCode,
case when src.PhoneNumber is null then 'UNK' else substring(replace(src.PhoneNumber,'-',''),1,3)+' '+
substring(replace(src.PhoneNumber,'-',''),4,3)+' '+substring(replace(src.PhoneNumber,'-',''),7,10)end as PhoneNumber,
case when src.Fax is null then 'UNK' else substring(replace(src.Fax,'-',''),1,3)+' '+
substring(replace(src.Fax,'-',''),4,3)+' '+substring(replace(src.Fax,'-',''),7,10) end as Fax,
case when src.Email is null then 'UNK' else src.Email end as Email,
case when src.StoreManagerUserID is null then -1 else src.StoreManagerUserID end as StoreManagerUserID,
case when src.IsDelegateServiceCenter is null then '-1' 
when src.IsDelegateServiceCenter =-1 then 'Y' 
else 'N' end as IsDelegateServiceCenter,
case when src.Enabled is null then '-1'
when src.Enabled =-1 then 'Y' 
else 'N' 
end as Enabled,
case when src.IsPartWareHouse is null then '-1' 
when src.IsPartWareHouse =-1 then 'Y' 
else 'N' 
end as IsPartWareHouse,
case when src.FRTRate is null then -1 else src.FRTRate end as FRTRate,
case when src.CurrencyCode is null then 'UNK' else src.CurrencyCode end as CurrencyCode,
case when src.Market is null then 'UNK' else src.Market end as Market,
case when src.CriticalPartReportLocationTitle is null then 'UNK' else src.CriticalPartReportLocationTitle end as CriticalPartReportLocationTitle,
case when src.IsMRBWareHouse is null then '-1' 
when src.IsMRBWareHouse =-1 then 'Y' 
else 'N' 
end as IsMRBWareHouse,
case when src.WeekDayWorkHours is null then 'UNK' else src.WeekDayWorkHours end as WeekDayWorkHours,
case when src.IsEngineering is null then '-1'
when src.IsEngineering =-1 then 'Y' 
else  'N' 
 end as IsEngineering,
case when src.PreferredLanguage is null then 'UNK' else upper(src.PreferredLanguage) end as PreferredLanguage
from [RALLI].[dbo].[Location] src left join dim_Location tgt
on tgt.LocationID = src.LocationID  where tgt.LocationID is null


