
--DDL
create table dri_dim_PT_O(
geo_key int identity(1,1) primary key,
paymethod nvarchar(225)
)

--DML

insert into dri_dim_PT_O
select distinct case when s.PaymentType is null then 'UNK' else s.PaymentType
end as PaymentType
from [Ralli].[dbo].[orders] s left join dri_dim_PT_O t
on s.paymenttype =t.paymethod
where s.paymenttype not in (select t.paymethod from dri_dim_PT_O)