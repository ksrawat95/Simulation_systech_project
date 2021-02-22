CREATE TABLE dim_infa_user(
	User_key int Primary Key,
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
	version int	,
	DW_CREATED_DATE	date						DEFAULT getdate(),
	DW_CREATED_BY	varchar(200)				Default suser_sname(),
	DW_UPDATED_DATE	date						DEFAULT getdate(),
	DW_UPDATED_BY	varchar(200)				Default suser_sname()
) 