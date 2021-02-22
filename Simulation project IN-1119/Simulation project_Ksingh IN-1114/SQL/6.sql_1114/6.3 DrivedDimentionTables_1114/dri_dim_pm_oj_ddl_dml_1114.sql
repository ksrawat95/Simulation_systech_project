--drop table dri_dim_PM_OJ

--DDL

create table dri_dim_PM_OJ(
geo_key int identity(1,1) primary key,
paymethod nvarchar(225)
)


--DML



insert into dri_dim_PM_OJ
select distinct case when s.paymethod is null then 'UNK' else s.paymethod
end as paymethod
from [Ralli].[dbo].[OrderJob] s left join dri_dim_PM_OJ t on s.PayMethod = t.paymethod
where s.PayMethod not in (select t.paymethod from dri_dim_PM_OJ)