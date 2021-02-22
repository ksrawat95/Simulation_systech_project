--drop table  dri_dim_customercomplaintdetail_info
create table dri_dim_customercomplaintdetail_info(
cp_key int identity(1,1) primary key,
complaintstatus nvarchar(225)
)