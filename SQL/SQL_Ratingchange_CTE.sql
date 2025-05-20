/* Use Notepad++ for better visibility. Use Word Wrap option from View tab.
This SQL query uses Common Table Expression (CTE) to regenerate and validate the report data. 
Please go through Rating change report file to get an understanding on report structure.*/
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*Securities as of March 2024*/
with mar as 
(select asset_id, sec_desc, eff_dt, maturity_date, cpn,
moody_rtng, sp_rtng, fitch_rtng, pf prcnt 
from 
(select a.sid, nvl(b.primary_asset_id, b.sid) asset_id, b.description sec_desc , a.new_eff_dt as eff_dt,
b.maturity_date, b. cpn, a.new_moody_rtng as moody_rtng, a.new_sp_rtng as sp_rtng,
a.new_fitch_rtng as fitch_rtng, v.pf_prcnt*100 pf_prcnt, v.portfolio_number
from security_table b, position_table v, rating_table a
where a.sid = b.sid and v.security_gdr_id = a.sid
and v.DATE_AS_OF = last_day(a.new_eff_dt) and
to_char (a.new_eff_dt, 'MM-YYYY' ) = '03-2024') -- change the date range here
where portfolio_number = 1234 -- update portfolio number here
order by sec_desc) ,

/*Securities as of March 2024*/
older as 
(select asset_id, sec_desc, eff_dt, maturity_date, cpn,
moody_rtng, sp_rtng, fitch_rtng, pf_prcnt 
from
(select asset_id, sec_desc, eff_dt,
rank () over (partition by asset_id order by eff_dt desc) as date_rank,
maturity_date, cpn, moody_rtng, sp_rtng, fitch_rtng, pf_prcnt
from 
(select a.sid, nvl (b.primary_asset_id, b.sid) asset_id, b.description sec_desc , a.old_eff_dt as eff_dt,
b.maturity_date, b. cpn, a. old_moody_rtng as moody_rtng, a. old_sp_rtng as sp_rtng,
a.old_fitch_rtng as fitch_rtng, v.pf_prcnt*100 pf_prcnt, v.portfolio_number
from security_table b, position_table v, rating_table a
where a.sid = b.sid and v.security_gdr_id = a.sid
and v. DATE_AS_OF = last_day(a.new_eff_dt)
and to_char (a.old_eff_dt, 'MM-YYYY' ) != '03-2024'
order by a. old_eff_dt desc)
where portfolio_number = 1234 -- update portfolio number here
and eff_dt is not null
order by sec_desc) where date_rank = 1 ),

/*Only prior records for asset_ids present in March 2024*/
old_fnl as (select distinct* from older where asset_id in (select asset_id from mar)),

/*Final March 2024 set*/
mar_fnl as (select distinct* from mar)

/*Final Select statement*/
select * from (select distinct * from mar_fnl
union all select distinct * from old fnl) a
order by a. asset_id, a. sec_desc, a.eff_dt desc


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
This query is designed to compare the most recent and prior ratings and attributes of securities held in a specific portfolio  as of given date. It retrieves, for each security in that portfolio:

Current Data (March 2024):
	All relevant details for each security held in the portfolio as of March 2024, including asset ID, description, effective date, maturity date, coupon rate, and credit ratings from Moody’s, S&P, and Fitch, as well as the portfolio percentage.
Most Recent Prior Data (Before March 2024):
	For each of those same securities, the query also retrieves the most recent available record before March 2024, including the same set of details and ratings.
Combines and Orders Results:
	The results are combined so that, for each security, you see both the March 2024 data and the most recent prior data (if available), ordered by asset ID, security description, and effective date (most recent first).

Purpose
Change Analysis: This allows you to easily compare how the attributes or ratings of each security have changed from the previous reporting period to March 2024.
Audit/Reporting: Useful for portfolio managers, auditors, or analysts who need to track changes in holdings or credit quality over time.
*/
