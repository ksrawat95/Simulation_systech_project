use ralli
use [Target_OCT19_KSingh]

--truncate table Fact_INFA_CUST_CUMP

create table fact_infa_cust_cump(
Cump_key int primary key,
CustomerComplaintID float,
vehicleID int,	
Location_key int,
Enabled float,
createdate varchar(20),
CUST_key int,
DateKey float,
DW_CREATED_DATE	date		DEFAULT getdate(),
DW_CREATED_BY	varchar(200)Default suser_sname(),
DW_UPDATED_DATE	date		DEFAULT getdate(),
DW_UPDATED_BY	varchar(200)Default suser_sname(),
)





