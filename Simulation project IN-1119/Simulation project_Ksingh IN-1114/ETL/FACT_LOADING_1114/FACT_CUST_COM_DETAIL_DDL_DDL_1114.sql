use [Target_OCT19_KSingh]
--drop table fact_infa_customercomplaintdetail


CREATE TABLE fact_infa_customercomplaintdetail(
	CCD_key int primary key,
	[CustomerComplaintDetail_ID] int ,
	[CustomerComplaintID] varchar(20) ,
	[ComplaintStatus] [varchar](3000) ,
	[ComplaintType] [varchar](3000) ,
	[ActionType] [varchar](3000) ,
	[Description] [varchar](3000) ,
	[ShortDescription] [varchar](255) ,
	[IsVehicleOperable] int ,
	[IsTow] int,
	[ServiceLocationID] varchar(20) default -1,
	[CreateDate] [smalldatetime] default '01-01-1900' ,
	[ComplaintCloseDate] [smalldatetime] default '01-01-1900' ,
	[CreatedByUserID] varchar(20) default -1,
	ComplaintCloseDateDateKey float default -1, 
	CreateDateDateKey float default -1,
	DW_CREATED_DATE datetime default getdate(),
	DW_CREATED_BY varchar(200) default suser_sname(),
	DW_UPDATED_DATE datetime default getdate(),
	DW_UPDATED_BY varchar(200) default suser_sname()
)