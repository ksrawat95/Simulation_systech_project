--drop table dri_dim_OJS_OJ_info
create table dri_dim_ojs_oj_info(
oj_key int identity(1,1) primary key,
orderjobstatus nvarchar(225)
)