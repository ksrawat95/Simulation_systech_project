use  [Target_OCT19_KSingh]

drop table dri_dim_cat_oj_info
create table dri_dim_cat_oj_info(
oj_key int identity(1,1) primary key,
category nvarchar(225)
)