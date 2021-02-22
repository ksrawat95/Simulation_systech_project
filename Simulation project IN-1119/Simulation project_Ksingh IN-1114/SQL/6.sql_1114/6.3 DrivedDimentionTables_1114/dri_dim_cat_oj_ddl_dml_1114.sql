--drop table dri_dim_CAT_OJ


--DDL
create table dri_dim_CAT_OJ(
geo_key int identity(1,1) primary key,
category nvarchar(225)
)



--DML
insert into dri_dim_CAT_OJ
select distinct case when s.category is null then 'UNK' else s.category
end as category
from [Ralli].[dbo].[OrderJob] s left join dri_dim_CAT_OJ on s.Category = t.category
where s.category not in(select t.category from category)