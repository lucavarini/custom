<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<body style="font-family:Verdana, Geneva, sans-serif; font-size:12px">
<cfquery datasource="muracms_apps" name="kitchenReservations">
SELECT [menu], [orario], count(nome) as prenotazioni
FROM [muracms_apps].[dbo].[kitchen_choice_menu]
WHERE [data_prenotazione] = <cfqueryparam value="#dateformat(Now(),'yyyy-mm-dd')#" cfsqltype="cf_sql_date">
GROUP BY [menu], [orario]
</cfquery> 
<cfsavecontent variable="report">
<h3>Kitchen Reservations <cfoutput>#dateformat(Now(),'dd/mm/yyyy')#</cfoutput></h3>
<cfoutput query="kitchenReservations" group="orario">
	<h3>Time: #orario#</h3>
	<table cellpadding="2" cellspacing="0" border="1">
	<tr>
		<td>MENU</td>
		<td>RESERV.</td>
	</tr>
	<cfoutput>
	<tr>
		<td>#menu#</td>
		<td align="center">#prenotazioni#</td>
	</tr>
	</cfoutput>
	</table>
</cfoutput>
</cfsavecontent>
<cfoutput>#report#</cfoutput>
</body>
</html>

