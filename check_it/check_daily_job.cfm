<cfprocessingdirective pageencoding="utf-8">
<!--- do not send the report Saturday or Sunday --->
<cfif (dateformat(now(),'ddd') NEQ "Sat") OR (dateformat(now(),'ddd') NEQ "Sun")>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<cfquery name="check_open_activity" datasource="muracms_apps">
SELECT     check_activity.id_activity, check_activity.id_category, check_activity.id_technician, check_activity.id_technician_backup, check_activity.title, check_activity.description, check_activity.activity_time, 
                      check_activity.reminder_email, check_activity.who_notify, check_activity.login_infos, check_activity.comments, check_technicians.tech_name, check_technicians.tech_lastname, 
                      check_technicians_1.tech_name AS tech_backup_name, check_technicians_1.tech_lastname AS tech_backup_lastname, check_technicians_1.id_technician AS Expr1
FROM         check_technicians INNER JOIN
                      check_activity ON check_technicians.id_technician = check_activity.id_technician INNER JOIN
                      check_technicians AS check_technicians_1 ON check_activity.id_technician_backup = check_technicians_1.id_technician LEFT OUTER JOIN
                      check_activity_today_log_view ON check_activity.id_activity = check_activity_today_log_view.id_activity
WHERE     (check_activity_today_log_view.id_activity IS NULL)
</cfquery>

<body>
<cfset activityFound = 0>
<cfsavecontent variable="report">
<div style="font-family: Arial, Helvetica">
<h3>IT activity checklist <cfoutput>#dateformat(Now(),'dd/mm/yyyy')#</cfoutput></h3>
<h3>Attenzione! Le seguenti attività risultano ancora aperte</h3>
<table cellpadding="2" cellspacing="2" border="1" style="font-family: Arial, Helvetica">
<tr>
	<td>Attività</td>
	<td>Ora check</td>
	<td>Tecnico</td>
	<td>Backup</td>
</tr>
<cfoutput query="check_open_activity">
	<!--- skip the activity in the future --->
	<cfif check_open_activity.activity_time LT timeFormat(Now(),"HH:mm")>
		<tr>
			<td>#description#</td>
			<td>#timeFormat(activity_time, "HH:mm")#</td>
			<td>#tech_name# #tech_lastname#</td>
			<td>#tech_backup_name# #tech_backup_lastname#</td>
		</tr>
		<cfif description NEQ "">
			<cfset activityFound = activityFound + 1>
		</cfif>
	</cfif>
</cfoutput>
</table><br><br>
<div><a href="http://intra.intranet.salewa.com/default/index.cfm/departments/it-checklist/">Maggiori dettagli</a></div>
</div>
</cfsavecontent>
<!--- send email only if an acitivity was found --->
<cfif activityFound GT 0>
	<cfmail to="luca.varini@oberalp.it" from="cfservice@oberalp.it" subject="IT activity checklist #dateformat(Now(),'dd/mm/yyyy')#" type="html">
	#report#
	</cfmail>
</cfif>
</cfif>
<cfdump var="#check_open_activity#" />
</body>
</html>