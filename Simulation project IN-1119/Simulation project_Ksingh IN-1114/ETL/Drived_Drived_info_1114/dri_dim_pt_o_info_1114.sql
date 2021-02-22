
--drop table dri_dim_pt_o_info
create table dri_dim_pt_o_info(
PT_key int identity(1,1) primary key,
paymethod nvarchar(225)
)
