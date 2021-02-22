
create table Dim_infa_Customer (
CUST_key	int	 Primary Key,
Customer_id		float	,
Firstname		varchar(30)	,
Lastname		varchar(30)	,
contactaddress	varchar(200),
contactphone	varchar(200),
Contact_email	varchar(100),
DW_CREATED_DATE	date		DEFAULT getdate(),
DW_CREATED_BY	varchar(200)Default suser_sname(),
DW_UPDATED_DATE	date		DEFAULT getdate(),
DW_UPDATED_BY	varchar(200)Default suser_sname(),
)