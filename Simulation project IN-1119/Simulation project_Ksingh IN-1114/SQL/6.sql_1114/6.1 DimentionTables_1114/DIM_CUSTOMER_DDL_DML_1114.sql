
drop table Dim_Customer
--/////////////////////////////////////////////////////////////////////////////DDL///////////////////////////////////////////////////////////////////////////
use [Target_OCT19_KSingh]
create table Dim_Customer (
CUST_Geo_key	int		IDENTITY(1,1) Primary Key,
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

insert into Dim_Customer (Customer_id,Firstname,Lastname,contactaddress,contactphone,Contact_email)
select case when src.customer_id is null then '0' else  src.customer_id end as customer_id,
case when src.Firstname is null then 'UNK' else (upper(substring(src.Firstname,1,1))+lower(SUBSTRING(src.firstname,2,len(src.firstname)))) end as Firstname,
case when src.Lastname is null then 'UNK' else (upper(substring(src.Lastname,1,1))+lower(SUBSTRING(src.Lastname,2,len(src.Lastname)))) end as Lastname,
case when src.Contactaddress is null then 'UNK' else 'No.'+(substring(src.Contactaddress,1,charindex(' ',src.Contactaddress)-1)+','+substring(src.Contactaddress,charindex(' ',src.Contactaddress)+1,LEN(src.Contactaddress))) end as Contactaddress ,
case when src.Contactphone is null then 'UNK' else (substring(REVERSE(substring(REVERSE(REPLACE(REPLACE(src.Contactphone,'+',''),' ','')),1,10)),1,3)+' '+
substring(REVERSE(substring(REVERSE(REPLACE(REPLACE(src.Contactphone,'+',''),' ','')),1,10)),4,3)+' '+
substring(REVERSE(substring(REVERSE(REPLACE(REPLACE(src.Contactphone,'+',''),' ','')),1,10)),7,4)) end as contactphone,
case when src.Contact_email is null then 'UNK' else src.Contact_email end as Contact_email
from [RALLI].[dbo].[Customer] src left join Dim_Customer tgt
on tgt.Customer_id = src.Customer_id  where tgt.Customer_id is null


--///////////////////////////////////////////////////////////////DML//////////////////////////////////////////////////////////////////////////////////////////////////

UPDATE Dim_Customer  
SET 
contactphone=substring(REVERSE(substring(REVERSE(REPLACE(REPLACE(src.Contactphone,'+',''),' ','')),1,10)),1,3)+' '+
substring(REVERSE(substring(REVERSE(REPLACE(REPLACE(src.Contactphone,'+',''),' ','')),1,10)),4,3)+' '+
substring(REVERSE((REVERSE(REPLACE(REPLACE(src.Contactphone,'+',''),' ','')),1,10)),7,4)
FROM Dim_Customer tgt  
INNER JOIN [RALLI].[dbo].[Customer] src ON tgt.Customer_id = src.Customer_id 
where tgt.contactphone <>substring(REVERSE(substring(REVERSE(REPLACE(REPLACE(src.Contactphone,'+',''),' ','')),1,10)),1,3)+' '+
substring(REVERSE(substring(REVERSE(REPLACE(REPLACE(src.Contactphone,'+',''),' ','')),1,10)),4,3)+' '+
substring(REVERSE(substring(REVERSE(REPLACE(REPLACE(src.Contactphone,'+',''),' ','')),1,10)),7,4) 








