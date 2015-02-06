<cfprocessingdirective pageencoding="utf-8">
<cfimport taglib="CustomTags/" prefix="tmt">
<!--- Kitchen opening hours --->
<cfset orario1 = "11:45">
<cfset orario2 = "12:30">
<cfset orario3 = "13:30">
<cfset todayDate = dateFormat(Now(),"dd/mm/yyyy")>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Kitchen reservation</title>
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
	$.get("kitchen_seats.cfm?datepicker=<cfoutput>#todayDate#</cfoutput>&orario=<cfoutput>#orario1#</cfoutput>", {}, function(res,code) {
									status1.html(res);
									document.getElementById("orario1").disabled = false;
									if(res != ""){document.getElementById("orario1").disabled = true;}
									});
	$.get("kitchen_seats.cfm?datepicker=<cfoutput>#todayDate#</cfoutput>&orario=<cfoutput>#orario2#</cfoutput>", {}, function(res,code) {
									status2.html(res);
									document.getElementById("orario2").disabled = false;
									if(res != ""){document.getElementById("orario2").disabled = true;}
									});
	$.get("kitchen_seats.cfm?datepicker=<cfoutput>#todayDate#</cfoutput>&orario=<cfoutput>#orario3#</cfoutput>", {}, function(res,code) {
									status3.html(res);
									document.getElementById("orario3").disabled = false;
									if(res != ""){document.getElementById("orario3").disabled = true;}
									});
	$(".data:input").datepicker({
							onSelect: function(dateText) {
								$.get("kitchen_seats.cfm?datepicker=" + dateText + "&orario=<cfoutput>#orario1#</cfoutput>", {}, function(res,code) {
									status1.html(res);
									document.getElementById("orario1").disabled = false;
									if(res != ""){document.getElementById("orario1").disabled = true; document.getElementById("orario1").checked = false;}
									});
								$.get("kitchen_seats.cfm?datepicker=" + dateText + "&orario=<cfoutput>#orario2#</cfoutput>", {}, function(res,code) {
									status2.html(res);
									document.getElementById("orario2").disabled = false;
									if(res != ""){document.getElementById("orario2").disabled = true; document.getElementById("orario2").checked = false;}
									});
								$.get("kitchen_seats.cfm?datepicker=" + dateText + "&orario=<cfoutput>#orario3#</cfoutput>", {}, function(res,code) {
									status3.html(res);
									document.getElementById("orario3").disabled = false;
									if(res != ""){document.getElementById("orario3").disabled = true; document.getElementById("orario3").checked = false;}
									});
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
		INSERT INTO kitchen
		   (nome
		   ,orario
		   ,data_prenotazione
		   ,menu)
	 VALUES
		   (<cfqueryparam value="#form.nome#" cfsqltype="cf_sql_varchar">
		   ,<cfqueryparam value="#form.orario#" cfsqltype="cf_sql_varchar">
		   ,<cfqueryparam value="#dateformat(form.datepicker,'dd/mm/yyyy')#" cfsqltype="cf_sql_date">
		   ,<cfqueryparam value="#form.menu#" cfsqltype="cf_sql_varchar">)
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
		<td>Name/Nome<span class="required">&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
		<td><input name="nome" type="text" size="30" tmt:required="true" tmt:message="Please insert your name" /></td>
	</tr>
	<tr>
		<td>Datum/Data<span class="required">&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
		<td><input name="datepicker" type="text" id="datepicker" class="data" readonly="readonly" class="required" tmt:required="true" tmt:message="Please select a date"></td>
	</tr>
	<tr>
		<td valign="top">Uhrzeit/Orario<span class="required">&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
		<td>
			<input name="orario" type="radio" class="boxes" value="<cfoutput>#orario1#</cfoutput>" tmt:required="true" tmt:message="Please select your lunch time" id="orario1" /> <cfoutput>#orario1#</cfoutput> <span id="status1" class="full"></span><br />
			<input name="orario" type="radio" class="boxes" value="<cfoutput>#orario2#</cfoutput>"  tmt:required="true" tmt:message="Please select your lunch time" id="orario2" /> <cfoutput>#orario2#</cfoutput> <span id="status2" class="full"></span><br />
			<input name="orario" type="radio" class="boxes" value="<cfoutput>#orario3#</cfoutput>"  tmt:required="true" tmt:message="Please select your lunch time" id="orario3" /> <cfoutput>#orario3#</cfoutput> <span id="status3" class="full"></span></td>
	</tr>
	<tr>
		<td valign="top">Menuwahl/<br />Scelta menu<span class="required">&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
		<td>
			<input name="menu" type="radio" class="boxes" value="menu 1" tmt:required="true" tmt:message="Please select a menu"/> Menu 1<br />
			<input name="menu" type="radio" class="boxes" value="menu 2" /> Menu 2<br />
			<input name="menu" type="radio" class="boxes" value="menu 3" /> Menu 3<br /><br />
		</td>
	</tr>
	<tr>
		<td colspan="2"><input name="submit" type="submit" value="Reservieren/Prenotare" id="submit" /></td>
	</tr>
	</fieldset>
</form>
</table>
</cfif>
</body>
</html>