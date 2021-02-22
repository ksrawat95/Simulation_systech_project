use  [Target_OCT19_KSingh]
--drop table dri_dim_pm_oj_info
create table dri_dim_pm_oj_info(
OJ_key int identity(1,1) primary key,
paymethod nvarchar(225)
)