--drop table dri_dim_AT_CCD





--DDL

create table dri_dim_AT_CCD(
at_key int identity(1,1) primary key,
ActionType nvarchar(225)
)

--DML
insert into dri_dim_AT_CCD
select distinct case when s.ActionType is null then 'UNK' else s.ActionType
end as ActionType
from [Ralli].[dbo].[CustomerComplaintDetail] s left join dri_dim_AT_CCD t on s.actiontype = t.actiontype
where s.actiontype not in (select t.actiontype from dri_dim_AT_CCD)