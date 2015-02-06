<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<body style="font-family:Verdana, Geneva, sans-serif; font-size:12px">
<cfquery datasource="muracms_apps" name="eventReservations">
SELECT *
FROM event_subscription
ORDER BY nome ASC
</cfquery> 
<cfsavecontent variable="report">
<h3>Event Reservations <cfoutput>#dateformat(Now(),'dd/mm/yyyy')#</cfoutput></h3>
<table cellpadding="2" cellspacing="0" border="1">
	<tr>
		<td>Nome</td>
		<td>Noleggio slitta</td>
		<td>Data iscrizione</td>
	</tr>
	<cfoutput query="eventReservations">
	<tr>
		<td>#nome#</td>
		<td align="center"><cfif opzione EQ 0>No<cfelse>Si</cfif></td>
		<td>#DateFormat(sys_date, "dd/mm/yy")#</td>
	</tr>
	</cfoutput>
</table>
</cfsavecontent>
<cfoutput>#report#</cfoutput>
</body>
</html>

