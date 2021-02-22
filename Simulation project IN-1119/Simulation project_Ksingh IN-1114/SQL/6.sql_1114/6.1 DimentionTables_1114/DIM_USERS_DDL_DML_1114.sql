--////////////////////////////////////////////////DDL//////////////////////////////////////////////////////////////////////////////////////////////////////

drop table dim_users
CREATE TABLE dim_users(
	User_Geo_key	int	IDENTITY(1,1)	Primary Key,
	[UserID] [float] ,
	[FirstName] [nvarchar](255) ,
	[LastName] [nvarchar](255) ,
	[DisplayName] [nvarchar](255) ,
	[Department] [nvarchar](255) ,
	[Title] [nvarchar](255),
	[Manager] [nvarchar](255) ,
	[Email] [nvarchar](255) ,
	[Enabled] [float] ,
	[Division] [nvarchar](255) ,
	[ManagerUserID] [float] ,
	version int									,
	DW_CREATED_DATE	date						DEFAULT getdate(),
	DW_CREATED_BY	varchar(200)				Default suser_sname(),
	DW_UPDATED_DATE	date						DEFAULT getdate(),
	DW_UPDATED_BY	varchar(200)				Default suser_sname()
) 
--////////////////////////////////////////////////DML//////////////////////////////////////////////////////////////////////////////////////////////////////
insert into dim_users (UserID,FirstName,LastName,DisplayName,Department,Title,Manager,Email,Enabled,Division
,ManagerUserID,version)
select 
case when src.userid is null then 0 else src.userid end as userid,
case when src.Firstname is null then 'UNK' else
(upper(substring(src.Firstname,1,1))+lower(SUBSTRING(src.firstname,2,len(src.firstname)))) end as Firstname,
case when src.Lastname is null then 'UNK' else
(upper(substring(src.Lastname,1,1))+lower(SUBSTRING(src.Lastname,2,len(src.Lastname)))) end as Lastname,
case when src.displayname is null then 'UNK' else
(upper(substring(src.Lastname,1,1))+lower(SUBSTRING(src.Lastname,2,len(src.Lastname))))
+' '+
(upper(substring(src.Firstname,1,1))+lower(SUBSTRING(src.firstname,2,len(src.firstname)))) end as displayname,
case when src.department is null then 'UNK' else src.department end as department,
case when src.title is null then 'UNK' else src.title end as title,
case when src.Manager is null then 'UNK' else src.Manager end as Manager,
case when src.Email is null then 'UNK' else src.Email end as Email,
case when src.Enabled is null then 0 else src.Enabled end as Enabled,
case when src.division is null then 'UNK' else src.Division end as Division,
case when src.Manageruserid is null then 0 else src.Manageruserid end as Manageruserid,
0 as version 
from [RALLI].[dbo].[users] src left join dim_users tgt
on tgt.UserID = src.UserID  where tgt.UserID is null



insert into dim_users (UserID,FirstName,LastName,DisplayName,Department,Title,Manager,Email,Enabled,Division
,ManagerUserID,version)
select 
case when src.userid is null then 0 else src.userid end as userid,
case when src.Firstname is null then 'UNK' else
(upper(substring(src.Firstname,1,1))+lower(SUBSTRING(src.firstname,2,len(src.firstname)))) end as Firstname,
case when src.Lastname is null then 'UNK' else
(upper(substring(src.Lastname,1,1))+lower(SUBSTRING(src.Lastname,2,len(src.Lastname)))) end as Lastname,
case when src.displayname is null then 'UNK' else
(upper(substring(src.Lastname,1,1))+lower(SUBSTRING(src.Lastname,2,len(src.Lastname))))
+' '+
(upper(substring(src.Firstname,1,1))+lower(SUBSTRING(src.firstname,2,len(src.firstname)))) end as displayname,
case when src.department is null then 'UNK' else src.department end as department,
case when src.title is null then 'UNK' else src.title end as title,
case when src.Manager is null then 'UNK' else src.Manager end as Manager,
case when src.Email is null then 'UNK' else src.Email end as Email,
case when src.Enabled is null then 0 else src.Enabled end as Enabled,
case when src.division is null then 'UNK' else src.Division end as Division,
case when src.Manageruserid is null then 0 else src.Manageruserid end as Manageruserid,
case when version is null then 0 else version+1 end as version
from [RALLI].[dbo].[users] src left join dim_users tgt
on tgt.UserID = src.UserID  where 
tgt.Title<>src.Title and version = (select max(version) from dim_users where tgt.UserID = UserID )



select top 5 UserID,FirstName,LastName,DisplayName,Department,Title,Manager,Email from [RALLI].[dbo].[users]


select top 5 UserID,FirstName,LastName,DisplayName,Department,Title,Manager,Email from dim_users