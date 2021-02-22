--drop table dri_dim_OJS_OJ


--DDL 
create table dri_dim_OJS_OJ(
geo_key int identity(1,1) primary key,
orderjobstatus nvarchar(225)
)

--DML
insert into dri_dim_OJS_OJ
select distinct case when s.orderjobstatus is null then 'UNK' else s.orderjobstatus
end as orderjobstatus
from [Ralli].[dbo].[OrderJob] s left join dri_dim_OJS_OJ t on s.OrderJobStatus = t.orderjobstatus
where s.orderjobstatus not in (select t.orderjobstatus from dri_dim_OJS_OJ)