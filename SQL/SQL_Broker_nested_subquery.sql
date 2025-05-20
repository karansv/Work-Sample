/* Use Notepad++ for better visibility. Use Word Wrap option from View tab.
This SQL query uses deeply nested subqueries to regenerate and validate the report data. 
Please go through Broker report file to get an understanding on report structure.*/

Select c.broker,c.trans,round((c.trans/mnt.total)*100,2) mnt_prcnt, c.ytd_trans,round((c.ytd_trans/ytd.total)*100,2) ytd_prcnt
from 
(Select ytd.*,mnt.trans from (SELECT broker, sum(abs(proceeds)) as YTD_TRANS FROM broker_table
WHERE TRD_DT >= '01-JAN-YYYY' AND TRD_DT <= '31-MAR-YYYY' AND PF_NO = 1234
AND ASSET_GRP NOT IN ('SS') AND NOT (ASSET_GRP IN ('BB') AND (ASSET_ID LIKE 'PW%'OR ASSET_ID LIKE 'APC%' 
OR ASSET_ID LIKE 'RFRS%')) AND NOT (EXTRNL_MEMO_NO LIKE 'AT%' AND ATP_TRD_ID IS NULL
AND ASSET_GRP IN ('FG', 'FC', 'G5', 'G6'))Group by broker ) ytd
left join 
	(SELECT broker as broker_a, sum(abs(proceeds)) TRANS FROM broker_table WHERE TRD_DT >= '01-MAR-YYYY'
AND TRD_DT <= '31-MAR-YYYY'AND PF_NO = 1234 AND ASSET_GRP NOT IN ('SS')
AND NOT ( ASSET_GRP IN ('BB') AND ( ASSET_ID LIKE 'PW%' OR ASSET_ID LIKE 'APC%' OR ASSET_ID LIKE 'RFRS%' )  )
AND NOT ( EXTRNL_MEMO_NO LIKE 'AT%' AND ATP_TRD_ID IS NULL AND ASSET_GRP IN ('FG', 'FC', 'G5', 'G6')  )
Group by broker) mnt on mnt.broker_a = ytd.broker)c,
 
(SELECT sum(abs(proceeds)) as total FROM broker_table
WHERE TRD_DT >= '01-JAN-YYYY' AND TRD_DT <= '31-MAR-YYYY' AND PF_NO = 1234
AND ASSET_GRP NOT IN ('SS') AND NOT (ASSET_GRP IN ('BB') AND (ASSET_ID LIKE 'PW%'OR ASSET_ID LIKE 'APC%' 
OR ASSET_ID LIKE 'RFRS%')) AND NOT (EXTRNL_MEMO_NO LIKE 'AT%' AND ATP_TRD_ID IS NULL
AND ASSET_GRP IN ('FG', 'FC', 'G5', 'G6'))) ytd,

(SELECT sum(abs(proceeds)) as total FROM broker_table
WHERE TRD_DT >= '01-MAR-YYYY' AND TRD_DT <= '31-MAR-YYYY' AND PF_NO = 1234
AND ASSET_GRP NOT IN ('SS') AND NOT (ASSET_GRP IN ('BB') AND (ASSET_ID LIKE 'PW%'OR ASSET_ID LIKE 'APC%' 
OR ASSET_ID LIKE 'RFRS%')) AND NOT (EXTRNL_MEMO_NO LIKE 'AT%' AND ATP_TRD_ID IS NULL
AND ASSET_GRP IN ('FG', 'FC', 'G5', 'G6'))) mnt 
order by c.broker

/*
Query Purpose and Structure
Purpose:
	The query generates a brokerage report for a specified month and year-to-date (YTD) period.
	It calculates both the transaction amounts and their percentage contributions (for the month and YTD) per broker.
	The logic is based on business rules for filtering and aggregating data from broker_table.
	The usage of this query is to identify and validate only required fields from existing Source system and perform the calculation based on existing business logic for future transition to proposed system.

Main Output Columns:
	broker: Broker name/ID.
	trans: Total proceeds for the month.
	mnt_prcnt: Monthly proceeds as a percentage of the total for the month.
	ytd_trans: Total proceeds YTD.
	ytd_prcnt: YTD proceeds as a percentage of the total YTD.


Query Review and Explanation
1. Subqueries for Aggregation
	YTD Subquery: Aggregates total proceeds per broker from the start of the year to the end of the selected month.
	Monthly Subquery: Aggregates total proceeds per broker for the selected month.
	Total YTD and Monthly: Calculates the total proceeds for all brokers for YTD and the month, used for percentage calculations.

2. Filters Applied
Date Ranges:
	YTD: '01-JAN-YYYY' to '31-MAR-YYYY'
	Month: '01-MAR-YYYY' to '31-MAR-YYYY'
Portfolio Filter:
	PF_NO = 1234
Asset Group Exclusions:
	Exclude ASSET_GRP = 'SS'
	Exclude certain ASSET_GRP = 'BB' with specific ASSET_ID patterns
	Exclude certain records based on EXTRNL_MEMO_NO, ATP_TRD_ID, and ASSET_GRP

3. Joins and Final Selection
	The monthly and YTD subqueries are joined on broker name.
	The totals are cross-joined (comma join) to allow for percentage calculations.
	The final output is ordered by broker name.

*/
