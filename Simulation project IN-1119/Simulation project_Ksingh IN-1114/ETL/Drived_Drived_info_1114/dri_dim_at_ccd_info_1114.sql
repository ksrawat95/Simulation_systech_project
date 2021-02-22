--drop table dri_dim_AT_CCD_info
create table dri_dim_at_ccd_info(
AT_key int identity(1,1) primary key,
ActionType nvarchar(225)
)