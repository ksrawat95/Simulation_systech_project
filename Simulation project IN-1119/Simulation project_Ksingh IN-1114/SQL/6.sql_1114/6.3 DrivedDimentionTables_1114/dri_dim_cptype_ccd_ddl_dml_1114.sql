


--DDL

--drop table dri_dim_cptype_CCD
create table dri_dim_cptype_CCD(
cpt_key int identity(1,1) primary key,
complainttype nvarchar(225)
)

--DML

insert into dri_dim_cptype_CCD
select distinct case when s.complainttype is null then 'UNK' else s.complainttype
end as complainttype
from [Ralli].[dbo].[CustomerComplaintDetail] s  left join dri_dim_cptype_CCD t on s.ComplaintType = t.complainttype
where s.ComplaintType not in (select t.complainttype from dri_dim_cptype_CCD)