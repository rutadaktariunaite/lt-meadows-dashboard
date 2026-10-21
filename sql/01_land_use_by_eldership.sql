-- This file  creates the dataset final20102025
-- create database projektas;

-- 
-- Pievos ir ganyklos 
--
use projektas;
SET SESSION max_execution_time = 300000;


-- unikalios kulturos
-- select 	KULTUROS_KODAS as tipas, min(KULTUROS_PAVADINIMAS), sum(PLOTAS) as plotas
-- 		from pievosirganyklos2020
-- 		group by KULTUROS_KODAS
--         order by plotas desc
-- 		;

-- duplikatai: ar yra duplikatu per lauko id:
-- SET SESSION max_execution_time = 300000;
-- select 
--     lauko_id,
--     count(*) as kiekis
-- from pievosirganyklos_2010_2019
-- where kulturos_kodas in ('GPŽ', 'DGP', 'EPT', 'SPT', 'MNP') and metai = 2019
-- group by lauko_id
-- having count(*) > 1;

-- 2010-2019
drop table if exists PG20102019;
create table PG20102019 as
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as PG_ha_sen
		from pievosirganyklos_2010_2019
        where metai between 2010 and 2019 and VALDOS_CENTR_SEN is not null
		group by rajonas, seniunija, metai
        order by rajonas, seniunija, metai;
        
-- 2020-2025
drop table if exists PG20202025;

create table PG20202025 as
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as PG_ha_sen
		from pievosirganyklos2020
        where metai = 2020 and VALDOS_CENTR_SEN is not null
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as PG_ha_sen
		from pievosirganyklos2021
        where metai = 2021 and VALDOS_CENTR_SEN is not null
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as PG_ha_sen
		from pievosirganyklos2022
        where metai = 2022 and VALDOS_CENTR_SEN is not null
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as PG_ha_sen
		from pievosirganyklos2023
        where metai = 2023 and VALDOS_CENTR_SEN is not null
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as PG_ha_sen
		from pievosirganyklos2024
        where metai = 2024 and VALDOS_CENTR_SEN is not null
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as PG_ha_sen
		from pievosirganyklos2025
        where metai = 2025 and VALDOS_CENTR_SEN is not null
		group by rajonas, seniunija, metai
        order by rajonas, seniunija, metai asc;

-- 2010-2025 sujungti
drop table if exists PG20102025;
create table PG20102025 as
select * from PG20102019
union all
select * from PG20202025
order by rajonas, seniunija, metai asc;

-- seniūnijų plotas (ha)
select * from PG20102025;
select sum(PG_ha_sen), metai from PG20102025
group by metai;

-- drop tables
-- drop table if exists 
-- 			pievosirganyklos2025,
--             pievosirganyklos2024,
--             pievosirganyklos2023,
--             pievosirganyklos2022,
--             pievosirganyklos2021,
--             pievosirganyklos2020,
--             pievosirganyklos_2010_2019,
--             pg20152019,
--             pg20202025;

-- 
-- Žieminiai ir vasariniai javai
--

-- 2010-2019
drop table if exists ZVJ20102019;
create table ZVJ20102019 as
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as ZVJ_ha_sen
		from `javu_plotai_2010-2019_v2`
		where metai between 2010 and 2019 and VALDOS_CENTR_SEN is not null
		group by rajonas, seniunija, metai
        order by rajonas, seniunija, metai asc;

-- 2020-2025
drop table if exists ZVJ20202025;
create table ZVJ20202025 as
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as ZVJ_ha_sen
		from ziemvasarjavai2020
        where metai = 2020  and VALDOS_CENTR_SEN is not null
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as ZVJ_ha_sen
		from ziemvasarjavai2021
        where metai = 2021  and VALDOS_CENTR_SEN is not null
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as ZVJ_ha_sen
		from ziemvasarjavai2022
        where metai = 2022  and VALDOS_CENTR_SEN is not null
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as ZVJ_ha_sen
		from ziemvasarjavai2023
        where metai = 2023  and VALDOS_CENTR_SEN is not null
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as ZVJ_ha_sen
		from ziemvasarjavai2024
        where metai = 2024  and VALDOS_CENTR_SEN is not null
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as ZVJ_ha_sen
		from ziemvasarjavai2025
        where metai = 2025  and VALDOS_CENTR_SEN is not null
		group by rajonas, seniunija, metai	
        order by rajonas, seniunija, metai asc;

-- 2010-2025 sujungti
drop table if exists ZVJ20102025;
create table ZVJ20102025 as
select * from ZVJ20102019
union all
select * from ZVJ20202025
order by rajonas, seniunija, metai asc;

-- drop tables
-- drop table if exists 
-- 				ziemvasarjavai2025,
--            	ziemvasarjavai2024,
--            	ziemvasarjavai2023,
--             	ziemvasarjavai2022,
--             	ziemvasarjavai2021,
--             	ziemvasarjavai2020,
--             	javu_plotai_2010_2019_v2,
--             	zvj20152019,
--             	zvj20202025;

--
-- Ankstiniai javai
--
-- 2010-2019
drop table if exists AJ20102019;
create table AJ20102019 as
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as AJ_ha_sen
		from `ankstiniu_javu_plotai_2010-2019`
		where metai between 2010 and 2019 and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
        order by rajonas, seniunija, metai asc;

-- 2020-2025
drop table if exists AJ20202025;
create table AJ20202025 as
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as AJ_ha_sen
		from ankstiniaijavai2020
        where metai = 2020  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as AJ_ha_sen
		from ankstiniaijavai2021
        where metai = 2021 and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as AJ_ha_sen
		from ankstiniaijavai2022
        where metai = 2022 and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as AJ_ha_sen
		from ankstiniaijavai2023
        where metai = 2023 and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as AJ_ha_sen
		from ankstiniaijavai2024
        where metai = 2024 and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as AJ_ha_sen
		from ankstiniaijavai2025
        where metai = 2025 and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
		order by rajonas, seniunija, metai asc;

-- 2010-2025 sujungti
drop table if exists AJ20102025;
create table AJ20102025 as
select * from AJ20102019
union all
select * from AJ20202025
order by rajonas, seniunija, metai asc;

select * from AJ20102025;


--
-- Bulvės ir daržovės
--

-- 2010-2019
drop table if exists BD20102019;
create table BD20102019 as
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as BD_ha_sen
		from `darzoves_ir_bulves_2010-2019`
		where metai between 2010 and 2019 and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
        order by rajonas, seniunija, metai asc;

-- 2020-2025
drop table if exists BD20202025;
create table BD20202025 as
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as BD_ha_sen
		from bulvesirdarzoves_2020
        where metai = 2020  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as BD_ha_sen
		from bulvesirdarzoves_2021
        where metai = 2021  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as BD_ha_sen
		from bulvesirdarzoves_2022
        where metai = 2022  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as BD_ha_sen
		from bulvesirdarzoves_2023
        where metai = 2023  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as BD_ha_sen
		from bulvesirdarzoves_2024
        where metai = 2024  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as BD_ha_sen
		from bulvesirdarzoves_2025
        where metai = 2025  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
        order by rajonas, seniunija, metai asc;
        
-- 2010-2025 sujungti
drop table if exists BD20102025;
create table BD20102025 as
select * from BD20102019
union all
select * from BD20202025
order by rajonas, seniunija, metai asc;

select * from BD20102025;


--
-- Sodai
--
-- 2010-2019
drop table if exists S20102019;
create table S20102019 as
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as S_ha_sen
		from `sodai_2010-2019`
		where metai between 2010 and 2019 and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
        order by rajonas, seniunija, metai asc;
        
-- 2020-2025
drop table if exists S20202025;
create table S20202025 as
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as S_ha_sen
		from sodai_2020
        where metai = 2020  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as S_ha_sen
		from sodai_2021
        where metai = 2021  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as S_ha_sen
		from sodai_2022
        where metai = 2022  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as S_ha_sen
		from sodai_2023
        where metai = 2023  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as S_ha_sen
		from sodai_2024
        where metai = 2024  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as S_ha_sen
		from sodai_2025
        where metai = 2025  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
        order by rajonas, seniunija, metai asc;
        
-- 2015-2025 sujungti
drop table if exists S20102025;
create table S20102025 as
select * from S20102019
union all
select * from S20202025
order by rajonas, seniunija, metai asc;

select * from S20102025;

--
-- Techniniai augalai
--

-- 2010-2019
drop table if exists TA20102019;
create table TA20102019 as
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as TA_ha_sen
		from `techniniaiaugalai_2010-2019`
		where metai between 2010 and 2019 and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
        order by rajonas, seniunija, metai asc;
        
-- 2020-2025
drop table if exists TA20202025;
create table TA20202025 as
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as TA_ha_sen
		from techniniaiaugalai2020
        where metai = 2020  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as TA_ha_sen
		from techniniaiaugalai2021
        where metai = 2021  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as TA_ha_sen
		from techniniaiaugalai2022
        where metai = 2022  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as TA_ha_sen
		from techniniaiaugalai2023
        where metai = 2023  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as TA_ha_sen
		from techniniaiaugalai2024
        where metai = 2024  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as TA_ha_sen
		from techniniaiaugalai2025
        where metai = 2025  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
        order by rajonas, seniunija, metai asc;
        
-- 2010-2025 sujungti
drop table if exists TA20102025;
create table TA20102025 as
select * from TA20102019
union all
select * from TA20202025
order by rajonas, seniunija, metai asc;
select * from TA20102025;


--
-- Uogynai
--

-- 2010-2019
drop table if exists UO20102019;
create table UO20102019 as
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as UO_ha_sen
		from `uogos_2010-2019`
		where metai between 2010 and 2019 and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
        order by rajonas, seniunija, metai asc;
        
-- 2020-2025
drop table if exists UO20202025;
create table UO20202025 as
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as UO_ha_sen
		from uogynai2020
        where metai = 2020  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as UO_ha_sen
		from uogynai2021
        where metai = 2021  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as UO_ha_sen
		from uogynai2022
        where metai = 2022  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as UO_ha_sen
		from uogynai2023
        where metai = 2023  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as UO_ha_sen
		from uogynai2024
        where metai = 2024  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
union all
select VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija, metai, round(sum(plotas), 2) as UO_ha_sen
		from uogynai2025
        where metai = 2025  and VALDOS_CENTR_SEN != ''
		group by rajonas, seniunija, metai
        order by rajonas, seniunija, metai asc;
        
-- 2010-2025 sujungti
drop table if exists UO20102025;
create table UO20102025 as
select * from UO20102019
union all
select * from UO20202025
order by rajonas, seniunija, metai asc;
select * from UO20102025;



--
-- drop not needed tables
-- 
select concat('drop table `', group_concat(table_name separator '`,`'), '`;') as komanda -- group_concat: aaa`,`bbb`,`ccc; concat `aaa`,`bbb`,`ccc`
		from information_schema.tables
        where table_schema = 'projektas' 
				and table_name not in (	'pg20102025','zvj20102025','aj20102025',
										'bd20102025','s20102025','ta20102025', 'uo20102025');

--
-- merge
--

-- check if seniūnija spelled the same across datasets

select rajonas, seniunija,
	max(case when k = 'PG' then 1 else 0 end) as PG,
    max(case when k = 'ZVJ' then 1 else 0 end) as ZVJ,
    max(case when k = 'AJ' then 1 else 0 end) as AJ,
    max(case when k = 'BD' then 1 else 0 end) as BD,
    max(case when k = 'S' then 1 else 0 end) as S,
    max(case when k = 'TA' then 1 else 0 end) as TA,
    max(case when k = 'UO' then 1 else 0 end) as UO
from (
	select distinct rajonas, seniunija, 'PG' as k from PG20102025
    union all
    select distinct rajonas, seniunija, 'ZVJ' from ZVJ20102025
	union all 
    select distinct rajonas, seniunija, 'AJ' from AJ20102025
    union all 
    select distinct rajonas, seniunija, 'BD' from BD20102025
    union all 
    select distinct rajonas, seniunija, 'S' from S20102025
    union all 
    select distinct rajonas, seniunija, 'TA' from TA20102025
    union all 
    select distinct rajonas, seniunija, 'UO' from UO20102025
) t
group by rajonas, seniunija
order by rajonas, seniunija;
-- --> išvada: Šeduvos mst ir Šeduva kartojasi du kartus ir tik pievose; keitėsi administracinio vieneto pavadinimas, 

-- check šeduva
select rajonas, seniunija, metai, PG_ha_sen from PG20102025
where rajonas like "Radviliškio%" and seniunija like "Šeduvos%"
order by rajonas, seniunija, metai;
-- --> išvada 2010 metai pievos ir ganyklos atsiranda 1 ha iš niekur


-- merge all datasets and keep all possible seniunija x metai combinations
drop table if exists merge20102025;
create table merge20102025 as
	with visi as (
		select rajonas, seniunija, metai from pg20102025
        union
		select rajonas, seniunija, metai from aj20102025
        union
        select rajonas, seniunija, metai from bd20102025
        union
        select rajonas, seniunija, metai from s20102025
        union
        select rajonas, seniunija, metai from ta20102025
        union
        select rajonas, seniunija, metai from uo20102025
		union
        select rajonas, seniunija, metai from zvj20102025
        )
select 	rajonas, seniunija, metai, PG_ha_sen, AJ_ha_sen, BD_ha_sen, S_ha_sen, TA_ha_sen, UO_ha_sen,ZVJ_ha_sen 
		from visi
left join pg20102025  using (rajonas, seniunija, metai)
left join aj20102025 using(rajonas, seniunija, metai)
left join bd20102025 using(rajonas, seniunija, metai)
left join s20102025 using(rajonas, seniunija, metai)
left join ta20102025 using(rajonas, seniunija, metai)
left join uo20102025 using(rajonas, seniunija, metai)
left join zvj20102025 using(rajonas, seniunija, metai);

-- apskritis į lentelę
alter table merge20102025 add column apskritis varchar(100);
update merge20102025 set apskritis = case 
	when rajonas in ('Alytaus m. sav.','Alytaus r. sav.','Druskininkų sav.','Lazdijų r. sav.','Varėnos r. sav.') then 'Alytaus apskr.'
    when rajonas in ('Birštono sav.','Jonavos r. sav.','Kaišiadorių r. sav.','Kauno m. sav.','Kauno r. sav.','Kėdainių r. sav.','Prienų r. sav.','Raseinių r. sav.') then 'Kauno apskr.'
    when rajonas in ('Klaipėdos m. sav.','Klaipėdos r. sav.','Kretingos r. sav.','Neringos sav.','Palangos m. sav.','Skuodo r. sav.','Šilutės r. sav.') then 'Klaipėdos apskr.'
    when rajonas in ('Kalvarijos sav.','Kazlų Rūdos sav.','Marijampolės sav.','Šakių r. sav.','Vilkaviškio r. sav.') then 'Marijampolės apskr.'
    when rajonas in ('Biržų r. sav.','Kupiškio r. sav.','Panevėžio m. sav.','Panevėžio r. sav.','Pasvalio r. sav.','Rokiškio r. sav.') then 'Panevėžio apskr.'
    when rajonas in ('Akmenės r. sav.','Joniškio r. sav.','Kelmės r. sav.','Pakruojo r. sav.','Radviliškio r. sav.','Šiaulių m. sav.','Šiaulių r. sav.') then 'Šiaulių apskr.'
    when rajonas in ('Jurbarko r. sav.','Pagėgių sav.','Šilalės r. sav.','Tauragės r. sav.') then 'Tauragės apskr.'
    when rajonas in ('Mažeikių r. sav.','Plungės r. sav.','Rietavo sav.','Telšių r. sav.') then 'Telšių apskr.'
    when rajonas in ('Anykščių r. sav.','Ignalinos r. sav.','Molėtų r. sav.','Utenos r. sav.','Visagino sav.','Zarasų r. sav.') then 'Utenos apskr.'
    else 'Vilniaus apskr.'
    end;

-- rajono ha
drop table if exists final20102025;
create table final20102025 as
select 	*,
	-- ha iš viso per seniūnija ir metus visoms kultūroms
	round(coalesce(PG_ha_sen, 0) + coalesce(AJ_ha_sen, 0) + coalesce(BD_ha_sen, 0) +
    coalesce(S_ha_sen, 0) + coalesce(TA_ha_sen, 0) + coalesce(UO_ha_sen, 0) + coalesce(ZVJ_ha_sen, 0), 2)
    as VISO_ha_sen,
    -- ha iš viso per rajoną ir metus visoms kultūroms
    round(coalesce(PG_ha_raj, 0) + coalesce(AJ_ha_raj, 0) + coalesce(BD_ha_raj, 0) +
    coalesce(S_ha_raj, 0) + coalesce(TA_ha_raj, 0) + coalesce(UO_ha_raj, 0) + coalesce(ZVJ_ha_raj, 0), 2)
    as VISO_ha_raj
-- ha per rajoną ir metus kiekvienai auginamai kultūrai atskirai
from (
	select *, 
		round(sum(PG_ha_sen) over (partition by rajonas, metai), 2) as PG_ha_raj,
		round(sum(AJ_ha_sen) over (partition by rajonas, metai), 2) as AJ_ha_raj,
		round(sum(BD_ha_sen) over (partition by rajonas, metai), 2) as BD_ha_raj,
		round(sum(S_ha_sen) over (partition by rajonas, metai), 2) as S_ha_raj,
		round(sum(TA_ha_sen) over (partition by rajonas, metai), 2) as TA_ha_raj,
		round(sum(UO_ha_sen) over (partition by rajonas, metai), 2) as UO_ha_raj,
		round(sum(ZVJ_ha_sen) over (partition by rajonas, metai), 2) as ZVJ_ha_raj
from merge20102025) t1
;

select * from final20102025;

-- drop temp tables
drop table if exists
`aj20102019`,`aj20152019`,`aj20152025`,`aj20202025`,
`ankstiniaijavai2020`,`ankstiniaijavai2021`,`ankstiniaijavai2022`,
`ankstiniaijavai2023`,`ankstiniaijavai2024`,`ankstiniaijavai2025`,
`ankstiniu_javu_plotai_2010-2019`,
`bd20102019`,`bd20152019`,`bd20152025`,`bd20202025`,
`bulvesirdarzoves_2020`,`bulvesirdarzoves_2021`,`bulvesirdarzoves_2022`,
`bulvesirdarzoves_2023`,`bulvesirdarzoves_2024`,`bulvesirdarzoves_2025`,
`darzoves_ir_bulves_2010-2019`,
`javu_plotai_2010-2019_v2`,
`pg20102019`,`pg20152019`,`pg20152025`,`pg20202025`,
-- `pievosirganyklos2020`,`pievosirganyklos2021`,`pievosirganyklos2022`, -- reikalinga kitame faile
-- `pievosirganyklos2023`,`pievosirganyklos2024`,`pievosirganyklos2025`,
-- `pievosirganyklos_2010_2019`,
`s20102019`,`s20152019`,`s20202025`,
`sodai_2010-2019`,`sodai_2020`,`sodai_2021`,`sodai_2022`,
`sodai_2023`,`sodai_2024`,`sodai_2025`,
`ta20102019`,`ta20202025`,
`techniniaiaugalai2020`,`techniniaiaugalai2021`,`techniniaiaugalai2022`,
`techniniaiaugalai2023`,`techniniaiaugalai2024`,`techniniaiaugalai2025`,
`techniniaiaugalai_2010-2019`,
`ziemvasarjavai2020`,`ziemvasarjavai2021`,`ziemvasarjavai2022`,
`ziemvasarjavai2023`,`ziemvasarjavai2024`,`ziemvasarjavai2025`,
`zvj20102019`,`zvj20152019`,`zvj20202025`, `zvj20152025`,
`uo20102019`,
`uogos_2010-2019`, 
`uogynai2020`,`uogynai2021`,`uogynai2022`,
`uogynai2023`,`uogynai2024`,`uogynai2025`;


