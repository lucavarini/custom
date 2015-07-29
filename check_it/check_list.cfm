<cfimport taglib="CustomTags" prefix="tmt">
<link type="text/css" rel="stylesheet" href="<cfoutput>#$.globalConfig('context')#/#$.siteConfig('siteID')#/includes/display_objects/custom/check_it/</cfoutput>css/style_table.css" />
<cfquery datasource="muracms_apps" name="activityQuery">
SELECT *
FROM check_activity_view
ORDER BY technician_name, technician_backup_name, title
</cfquery>
<cfquery datasource="muracms_apps" name="activityDoneToday">
SELECT check_activity.id_activity, check_log.sysdate
FROM check_activity INNER JOIN
	check_log ON check_activity.id_activity = check_log.id_activity
WHERE CONVERT(date,check_log.sysdate) = CONVERT(date, GETDATE())
</cfquery>
<cfset activityDoneList = valueList(activityDoneToday.id_activity)>
<cfparam name="activityQueryPage" default="1">

<cffunction name="getCheckTime">
	<cfargument name="check_id" type="numeric" required="true">
	<cfquery name="getTime" dbtype="query">
		SELECT sysdate
		FROM activityDoneToday
		WHERE id_activity = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.check_id#">
	</cfquery>
	<cfreturn getTime.sysdate>
</cffunction>

<cfset activityQuerymaxrows = 20>
<cfset activityMaxRows = Min((activityQueryPage-1)*activityQuerymaxrows+1, Max(activityQuery.RecordCount, 1))>
<h2>Day <cfoutput>#dateFormat(Now(),"dd/mm/yyyy")#</cfoutput></h2>
<table id="hor-minimalist-b">
	<thead>
		<tr>
			<th scope="col">Title</th>
			<th scope="col">Description</th>
			<th scope="col">Due time</th>
			<th scope="col">Technician</th>
			<th scope="col">Backup</th>
			<th scope="col">&nbsp;</th>
		</tr>
	</thead>
	<tfoot>
		<tr>
			<td colspan="9" style="text-align:center"><tmt:querynav query="activityQuery" maxrows="#activityQuerymaxrows#" mode="pagelist" prevlink="prev" nextlink="next" /></td>
		</tr>
	</tfoot>
	<tbody>
		<cfoutput query="activityQuery" startRow="#activityMaxRows#" maxRows="#activityQuerymaxrows#">
			<tr>
				<td><a rel="shadowbox;width=420;height=280" href="#$.globalConfig('context')#/#$.siteConfig('siteID')#/includes/display_objects/custom/check_it/check_detail.cfm?id_activity=#activityQuery.id_activity#">#activityQuery.title#</a></td>
				<td>#activityQuery.description#</td>
				<td>#TimeFormat(activityQuery.activity_time, "HH:mm")#</td>
				<td>#activityQuery.technician_name# #Left(activityQuery.technician_lastname, 1)#.</td>
				<td>#activityQuery.technician_backup_name# #Left(activityQuery.technician_backup_lastname, 1)#.</td>
				<td align="center">
					<cfif listFind("#activityDoneList#","#activityQuery.id_activity#")>
						<span style="color: green">OK! - #timeFormat(getCheckTime(activityQuery.id_activity),"HH:mm")#</span>
					<cfelse>
						<a rel="shadowbox;width=420;height=280" class="btn btn-larg btn-primary" href="#$.globalConfig('context')#/#$.siteConfig('siteID')#/includes/display_objects/custom/check_it/check_confirm.cfm?id_activity=#activityQuery.id_activity#&id_technician=#activityQuery.id_technician#">Check!</a>
					</cfif>
				</td>
		</cfoutput>	
	</tbody>
</table>