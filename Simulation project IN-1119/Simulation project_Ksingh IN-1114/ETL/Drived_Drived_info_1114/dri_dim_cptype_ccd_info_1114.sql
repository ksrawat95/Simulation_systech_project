drop table  dri_dim_cptype_ccd_info
create table dri_dim_cptype_ccd_info (
ct_key int identity(1,1) primary key,
complainttype nvarchar(225)
)