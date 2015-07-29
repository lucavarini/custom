<cfprocessingdirective pageencoding="utf-8">
<cfimport taglib="CustomTags/" prefix="tmt">
<cfquery datasource="muracms_apps" name="getActivity">
SELECT *
FROM check_activity_view
WHERE id_activity = <cfqueryparam value="#URL.id_activity#" cfsqltype="cf_sql_numeric">
</cfquery>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Check detail</title>
<link type="text/css" rel="stylesheet" href="css/style_form.css" />
<table>
	<cfoutput query="getActivity">
	<tr>
		<td><strong>Title</strong></td>
		<td>
			#title#
		</td>
	</tr>
	<tr>
		<td><strong>Description</strong></td>
		<td>
			#description#
		</td>
	</tr>
	<tr>
		<td><strong>Category</strong></td>
		<td>
			#category_description#
		</td>
	</tr>
	<tr>
		<td><strong>Due time</strong></td>
		<td>
			#TimeFormat(activity_time, "HH:mm")#
		</td>
	</tr>
	<tr>
		<td><strong>Technician</strong></td>
		<td>
			#technician_name# #technician_lastname#
		</td>
	</tr>
	<tr>
		<td><strong>Backup</strong></td>
		<td>
			#technician_backup_name# #technician_backup_lastname#
		</td>
	</tr>
	<tr>
		<td><strong>Reminder email</strong></td>
		<td>
			#reminder_email#
		</td>
	</tr>
	<tr>
		<td><strong>Who to notify</strong></td>
		<td>
			#who_notify#
		</td>
	</tr>
	<tr>
		<td><strong>Comments</strong></td>
		<td>
			#comments#
		</td>
	</tr>
	<tr>
		<td><strong>Onenote Link</strong></td>
		<td>
			<cfif #onenote# NEQ "">
				<a href="#onenote#">#URLdecode(onenote)#</a>
			</cfif>
		</td>
	</tr>
	
	</cfoutput>
</table>
</body>
</html>