<cfprocessingdirective pageencoding="utf-8">
<cfimport taglib="CustomTags/" prefix="tmt">
<cfquery datasource="muracms_apps" name="getTechs">
SELECT *
FROM check_technicians
ORDER BY tech_name
</cfquery>
<cfset orario1 = "11:45">
<cfset orario2 = "12:30">
<cfset orario3 = "13:30">
<cfset todayDate = dateFormat(Now(),"dd/mm/yyyy")>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Check activity</title>
<link type="text/css" rel="stylesheet" href="css/style_form.css" />
<link rel="stylesheet" href="css/jquery-ui.min.css" type="text/css" />
<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="js/tmt_core.js"></script>
<script type="text/javascript" src="js/tmt_form.js"></script>
<script type="text/javascript" src="js/tmt_validator.js"></script>
<script type="text/javascript" src="js/tmt_net.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js" ></script>
<style>
.ui-widget {
  font-size: 11px;
}
</style>
<script>
$(document).ready(function() {
	var status1 = $("#status1");
	var status2 = $("#status2");
	var status3 = $("#status3");
	$.datepicker.setDefaults($.datepicker.regional['it']);
	$(".data:input").datepicker({
		onSelect: function(dateText){
		$(this).change();
	}
	});
	$(".data:input").datepicker("option", "dateFormat", "dd/mm/yy" );
	$(".data:input").datepicker('setDate', new Date());
	$(".data:input").datepicker("option", "firstDay", 1);
});
</script>
</head>
<body>
<cfif StructKeyExists(FORM, "nome")>
	<cfquery datasource="muracms_apps">
		INSERT INTO check_log
		   (id_technician
		   ,id_activity
		   ,check_comment)
	 VALUES
		   (<cfqueryparam value="#form.nome#" cfsqltype="cf_sql_int">
		   ,<cfqueryparam value="#form.id_activity#" cfsqltype="cf_sql_int">
		   ,<cfqueryparam value="#form.comments#" cfsqltype="cf_sql_varchar">)
	</cfquery>
	<p>Ok!</p>
	<script>
		parent.location.reload(true);
		window.parent.Shadowbox.close();
	</script>
<cfelse>
<form action="<cfoutput>#GetFileFromPath(GetTemplatePath())#</cfoutput>" method="post" tmt:validate="true">
	<fieldset>
	<table>
	<tr>
		<td>Name<span class="required">&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
		<td>
			<select name="nome">
				<cfoutput query="getTechs">
					<option value="#id_technician#" <cfif getTechs.id_technician EQ URL.id_technician>selected="selected"</cfif>>#tech_name# #tech_lastname#</option>	
				</cfoutput>
			</select>
		</td>
	</tr>
	<!--- <tr>
			<td>Date<span class="required">&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
			<td><input name="datepicker" type="text" id="datepicker" class="data" readonly="readonly" class="required" tmt:required="true" tmt:message="Please select a date"></td>
		</tr> --->
	<tr>
		<td>Comments</td>
		<td>
			 <textarea rows="5" cols="30" name="comments"></textarea> 
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>
			<input type="hidden" name="id_activity" value="<cfoutput>#URL.id_activity#</cfoutput>">
			<input name="submit" type="submit" value="Check done!" id="submit" /><br><br>
			<span style="font-size:10px">Time/Date: <cfoutput>#timeFormat(Now(),"HH:mm")# #dateFormat(Now(),"dd/mm/yyyy")#</cfoutput></span>
		</td>
	</tr>
	</fieldset>
</form>
</table>
</cfif>
</body>
</html>