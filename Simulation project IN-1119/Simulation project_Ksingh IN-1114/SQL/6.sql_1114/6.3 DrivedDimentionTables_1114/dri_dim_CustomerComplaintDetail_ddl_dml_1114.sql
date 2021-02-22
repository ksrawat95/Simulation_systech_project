
--DDL

--drop table dri_dim_CustomerComplaintDetail
create table dri_dim_CustomerComplaintDetail(
cs_key int identity(1,1) primary key,
complaintstatus nvarchar(225)
)


--DML

insert into dri_dim_CustomerComplaintDetail
select distinct case when ccd.complaintstatus is null then 'UNK' else ccd.complaintstatus
end as complaintstatus
from [Ralli].[dbo].[CustomerComplaintDetail] ccd left join dri_dim_CustomerComplaintDetail ddc on ccd.ComplaintStatus = ddc.complaintstatus
where ccd.ComplaintStatus not in (select ccd.ComplaintStatus from dri_dim_CustomerComplaintDetail)