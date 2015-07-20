<cfparam name="URL.datepicker" default="">
<cfparam name="URL.orario" default="">
<!--- mensa_limit for total amount of reservation --->
<cfset total_seats = 45>
<cfquery datasource="muracms_apps" name="seats">
SELECT count(*) as booked_seats
FROM kitchen
WHERE data_prenotazione = <cfqueryparam value="#dateformat(URL.datepicker,'dd/mm/yyyy')#" cfsqltype="cf_sql_date"> AND orario = <cfqueryparam value="#URL.orario#" cfsqltype="cf_sql_varchar">
</cfquery>
<cfif seats.booked_seats GTE total_seats>
<cfoutput>Full!</cfoutput>
</cfif>