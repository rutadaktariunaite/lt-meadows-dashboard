-- -- This file creates the datasets pg20102025laukai and pg20102025sample

--
-- PIEVOS IR GANYKLOS: lauko plotas ir skaičius
-- 

use projektas;

-- union all pievas ir ganyklas, kad suskaičiuotum laukus
drop table if exists PG20102025FULL;
create table PG20102025FULL as
select * from pievosirganyklos_2010_2019
union all
select * from pievosirganyklos2020
union all
select * from pievosirganyklos2021
union all
select * from pievosirganyklos2022
union all 
select * from pievosirganyklos2023
union all
select * from pievosirganyklos2024
union all
select * from pievosirganyklos2025
;

select * from PG20102025FULL;

-- ištrink seniūnijos missingus
delete from PG20102025FULL
where VALDOS_CENTR_SEN is null or VALDOS_CENTR_SEN = "";
-- -- This file creates the datasets pg20102025laukai and pg20102025sample

select * from PG20102025FULL;

drop table if exists PG20102025SAMPLE;
create table PG20102025SAMPLE as
select LAUKO_ID, METAI, PLOTAS, VALDOS_CENTR_SAV, VALDOS_CENTR_SEN
from PG20102025FULL
where rand() < 0.01907;

select count(*) from PG20102025FULL;

-- LAUKŲ DEKLARAVIMAS SENIŪNIJOS LYGMENIU
drop table if exists PG20102025LAUKAI;
create table PG20102025LAUKAI as
select 	METAI as metai, VALDOS_CENTR_SAV as rajonas, VALDOS_CENTR_SEN as seniunija,
		count(lauko_id) as laukai_n,
        round(sum(plotas), 1) as plotas_all,
        round(avg(plotas), 1) as plotas_avg,
        round(min(plotas), 2) as laukas_min,
        round(max(plotas), 1) as laukas_max
        from  PG20102025FULL
group by metai, rajonas, seniunija
order by metai, rajonas, seniunija asc
;
