use [Target_OCT19_KSingh]
drop table fact_CustomerComplaintDetail


CREATE TABLE fact_CustomerComplaintDetail(
	CCD_Gkey int identity(1,1),
	[CustomerComplaintDetail_ID] [float] ,
	[CustomerComplaintID] [float] ,
	[ComplaintStatus] float ,
	[ComplaintType] float ,
	[ActionType] float ,
	[Description] [varchar](3000) ,
	[ShortDescription] [varchar](255) ,
	[IsVehicleOperable] varchar(20) ,
	[IsTow] varchar(20) ,
	[ServiceLocationID] [float] ,
	[CreateDate] [smalldatetime] ,
	[ComplaintCloseDate] [smalldatetime] ,
	[CreatedByUserID] [float] ,
	ComplaintCloseDateDateKey float, 
	CreateDateDateKey float ,
	DW_CREATED_DATE datetime,
	DW_CREATED_BY varchar(200),
	DW_UPDATED_DATE datetime,
	DW_UPDATED_BY varchar(200)
) 



begin
DECLARE @COUNT1 int;

select @COUNT1 = count(*) from fact_CustomerComplaintDetail

IF @count1= 0
begin


insert into fact_CustomerComplaintDetail (CustomerComplaintDetail_ID,CustomerComplaintID,ComplaintStatus,ComplaintType,ActionType,Description,ShortDescription,IsVehicleOperable,
IsTow,ServiceLocationID,CreateDate,ComplaintCloseDate,CreatedByUserID,ComplaintCloseDateDateKey,CreateDateDateKey,DW_CREATED_DATE,DW_CREATED_BY,DW_UPDATED_DATE,DW_UPDATED_BY)
select 
case when CustomerComplaintDetail_ID is null then -1 else CustomerComplaintDetail_ID end as CustomerComplaintDetail_ID,
case when CP.CUST_CP_Gkey is null then -1 else CP.CUST_CP_Gkey end as CustomerComplaintIDGK,
case when fcc.cs_key is null then -1 else fcc.cs_key end as ComplaintStatuskey,
case when fct.cpt_key is null then -1 else fct.cpt_key end as complainttype_key,
case when fat.at_key is null then -1 else fat.at_key end as ActionType,
case when Description is null then 'UNK' else Description end as Description,
case when ShortDescription is null then 'UNK' else ShortDescription end as ShortDescription,
case when IsVehicleOperable is null then -1 else IsVehicleOperable end as IsVehicleOperable,
case when IsTow is null then -1 else IsTow end as IsTow,
case when l.Location_Geo_key is null then -1 else l.Location_Geo_key end as Location_Geo_key,
case when f.CreateDate is null then '01-01-1900' else f.CreateDate end as CreateDate ,
case when f.ComplaintCloseDate is null then '01-01-2019' else f.ComplaintCloseDate end as ComplaintCloseDate,
case when U.User_Geo_key is null then -1 else U.User_Geo_key end as User_Geo_key,
case when D.DateKey is null then -1 else D.DateKey end as ComplaintCloseDateDateKey,
case when DD.DateKey is null then -1 else DD.DateKey end as CreateDateDateKey,
GETDATE() AS DW_CREATED_DATE,
SUSER_SNAME() AS DW_CREATED_BY,
GETDATE() AS DW_UPDATED_DATE,
Suser_sname() AS DW_CREATEDBY
from ralli.[dbo].[CustomerComplaintDetail] f
left join Fact_CUST_CUMP  CP on f.customerComplaintid = CP.customerComplaintid
left join Dim_Users U  on U.UserID = f.CreatedByUserID
left join  [dbo].[dim_location] L on f.ServiceLocationID = l.locationid
left join dri_dim_CustomerComplaintDetail fcc on fcc.complaintstatus = f.ComplaintStatus
left join dri_dim_cptype_CCD fct on fct.complainttype = f.complainttype
left join dri_dim_AT_CCD fat on fat.ActionType = f.ActionType
LEFT JOIN [dbo].[Dim_Date] D ON CAST (f.ComplaintCloseDate AS DATE) = D.Date
LEFT JOIN [dbo].[Dim_Date] DD ON CAST (f.CreateDate AS DATE) = DD.Date

--12582


end
else
begin

insert into fact_CustomerComplaintDetail (CustomerComplaintDetail_ID,CustomerComplaintID,ComplaintStatus,ComplaintType,ActionType,Description,ShortDescription,IsVehicleOperable,
IsTow,ServiceLocationID,CreateDate,ComplaintCloseDate,CreatedByUserID,ComplaintCloseDateDateKey,CreateDateDateKey,DW_CREATED_DATE,DW_CREATED_BY,DW_UPDATED_DATE,DW_UPDATED_BY)
select 
case when CustomerComplaintDetail_ID is null then -1 else CustomerComplaintDetail_ID end as CustomerComplaintDetail_ID,
case when CP.CUST_CP_Gkey is null then -1 else CP.CUST_CP_Gkey end as CustomerComplaintIDGK,
case when fcc.cs_key is null then -1 else fcc.cs_key end as ComplaintStatuskey,
case when fct.cpt_key is null then -1 else fct.cpt_key end as complainttype_key,
case when fat.at_key is null then -1 else fat.at_key end as ActionType,
case when Description is null then 'UNK' else Description end as Description,
case when ShortDescription is null then 'UNK' else ShortDescription end as ShortDescription,
case when IsVehicleOperable is null then -1 else IsVehicleOperable end as IsVehicleOperable,
case when IsTow is null then -1 else IsTow end as IsTow,
case when l.Location_Geo_key is null then -1 else l.Location_Geo_key end as Location_Geo_key,
case when f.CreateDate is null then '01-01-1900' else f.CreateDate end as CreateDate ,
case when f.ComplaintCloseDate is null then '01-01-2019' else f.ComplaintCloseDate end as ComplaintCloseDate,
case when U.User_Geo_key is null then -1 else U.User_Geo_key end as User_Geo_key,
case when D.DateKey is null then -1 else D.DateKey end as ComplaintCloseDateDateKey,
case when DD.DateKey is null then -1 else DD.DateKey end as CreateDateDateKey,
GETDATE() AS DW_CREATED_DATE,
SUSER_SNAME() AS DW_CREATED_BY,
GETDATE() AS DW_UPDATED_DATE,
Suser_sname() AS DW_CREATEDBY
from ralli.[dbo].[CustomerComplaintDetail] f
left join Fact_CUST_CUMP  CP on f.customerComplaintid = CP.customerComplaintid
left join Dim_Users U  on U.UserID = f.CreatedByUserID
left join  [dbo].[dim_location] L on f.ServiceLocationID = l.locationid
left join dri_dim_CustomerComplaintDetail fcc on fcc.complaintstatus = f.ComplaintStatus
left join dri_dim_cptype_CCD fct on fct.complainttype = f.complainttype
left join dri_dim_AT_CCD fat on fat.ActionType = f.ActionType
LEFT JOIN [dbo].[Dim_Date] D ON CAST (f.ComplaintCloseDate AS DATE) = D.Date
LEFT JOIN [dbo].[Dim_Date] DD ON CAST (f.CreateDate AS DATE) = D.Date
where f.[CreateDate]>(select max([CreateDate]) from [fact_CustomerComplaintDetail])
end
end




