<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<body style="font-family:Verdana, Geneva, sans-serif; font-size:12px">
<cfquery datasource="muracms_apps" name="kitchenReservationsSum">
SELECT [menu], [orario], count(distinct nome) as prenotazioni
FROM [muracms_apps].[dbo].[kitchen_choice_menu]
WHERE [data_prenotazione] = <cfqueryparam value="#dateformat(Now(),'yyyy-mm-dd')#" cfsqltype="cf_sql_date">
GROUP BY [menu], [orario]
</cfquery> 
<cfquery datasource="muracms_apps" name="kitchenReservations">
SELECT [menu], [orario], [nome]
FROM [muracms_apps].[dbo].[kitchen_choice_menu]
WHERE [data_prenotazione] = <cfqueryparam value="#dateformat(Now(),'yyyy-mm-dd')#" cfsqltype="cf_sql_date">
GROUP BY [orario], [menu], [nome]
ORDER BY [nome]
</cfquery> 
<cfset orari="11:45,12:30,13:30">
<cfif kitchenReservations.recordCount GT 0>
<cfsavecontent variable="report">
<h3>Kitchen Reservations <cfoutput>#dateformat(Now(),'dd/mm/yyyy')#</cfoutput></h3>
<cfoutput query="kitchenReservationsSum" group="orario">
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
<hr>
<h3>DETAIL</h3>
<cfloop list="#orari#" index="orariolist">
	<cfquery dbtype="query" name="q#replace(orariolist,":","")#">
		SELECT menu, orario, upper(nome)
		FROM kitchenReservations
		WHERE orario = '#orariolist#'
		ORDER BY nome
	</cfquery>	
</cfloop>
<cfloop list="#orari#" index="orariolist">
	<cfset i = 1>
	<cfoutput query="q#replace(orariolist,":","")#" group="orario">
		<h3>Time: #orario#</h3>
		<table cellpadding="2" cellspacing="0" border="1">
		<cfoutput>
		<tr>
			<td>#i#</td>
			<td align="center">#nome#</td>
			<td align="center">#menu#</td>
		</tr>
		<cfset i = i+1>
		</cfoutput>
		</table>
	</cfoutput>
</cfloop> 
</cfsavecontent>
<cfmail to="kitchenemail@oberalp.it" from="cfservice@oberalp.it" subject="Kitchen Reservations #dateformat(Now(),'dd/mm/yyyy')#" type="html">
#report#
</cfmail>
<cfoutput>#report#</cfoutput>
</cfif>
</body>
</html>

