<cfprocessingdirective pageencoding="utf-8">
<cfimport taglib="CustomTags/" prefix="tmt">
<cfparam name="URL.ap" default="rodi">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Apartment reservation</title>
<link type="text/css" rel="stylesheet" href="css/style_form.css" />
<link rel="stylesheet" href="css/jquery-ui.min.css" type="text/css" />
<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="js/tmt_core.js"></script>
<script type="text/javascript" src="js/tmt_form.js"></script>
<script type="text/javascript" src="js/tmt_validator.js"></script>
<script type="text/javascript" src="js/tmt_net.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js" ></script>
<cfset todayDate = dateFormat(Now(),"dd/mm/yyyy")>
<!--- Email to address --->
<cfset mailRecipients ="apartmentsemail@oberalp.it">
<style>
.ui-widget {
  font-size: 11px;
}
</style>
<script>
$(document).ready(function() {
	$.datepicker.setDefaults($.datepicker.regional['it']);
	$("#arrival_datepicker").datepicker({
		language: "it",
		dateFormat: "dd/mm/yy"
	});
	$("#departure_datepicker").datepicker({
		language: "it",
		dateFormat: "dd/mm/yy"
	});
});
</script>
</head>
<body>
<cfif StructKeyExists(FORM, "name_surname")>
	<cfquery datasource="muracms_apps">
		INSERT INTO apartments_reservations
		   (name_surname
		   ,apartment
		   ,arrival_date
		   ,departure_date
		   ,notes)
	 VALUES
		   (<cfqueryparam value="#form.name_surname#" cfsqltype="cf_sql_varchar">
			,<cfqueryparam value="#form.apartment#" cfsqltype="cf_sql_varchar">
			,<cfqueryparam value="#dateformat(form.arrival_datepicker,'dd/mm/yyyy')#" cfsqltype="cf_sql_date">
			,<cfqueryparam value="#dateformat(form.departure_datepicker,'dd/mm/yyyy')#" cfsqltype="cf_sql_date">
		   ,<cfqueryparam value="#form.notes#" cfsqltype="cf_sql_varchar">)
	</cfquery>
	 <cfmail to = "#mailRecipients#" from="cfservice@oberalp.it" subject="Apartment Reservation #dateformat(Now(),'dd/mm/yyyy')#" type="html">
Un utente ha riservato un appartamento.<br />
Appartamento: #form.apartment#<br />
Nome: #form.name_surname#<br />
Data arrivo: #dateformat(form.arrival_datepicker,'dd/mm/yyyy')#<br />
Data partenza: #dateformat(form.departure_datepicker,'dd/mm/yyyy')#<br />
Note: #form.notes#<br />
<br /><br />
Per gestire le iscrizioni cliccare il seguente link<br />
<a href="javascript:;">Link pagina</a>
</cfmail>  
<table width="100%">
	<tr>
		<td>
			<div align="center">
			<p>Iscrizione avvenuta con successo</p>
			<p>Anmeldung erfolgreich abgeschlossen</p>
			<p><a href="javascript:window.parent.Shadowbox.close();">Chiudi questa finestra / Fenster schliessen</a></p>
			</div>
		</td>
	</tr>
</table>
<cfelse>
<form action="<cfoutput>#GetFileFromPath(GetTemplatePath())#</cfoutput>" method="post" tmt:validate="true">
	<fieldset>
		<table>
			<tr>
				<td>Nome-Cognome<br />Name-Nachname<span class="required">&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
				<td><input name="name_surname" type="text" size="30" tmt:required="true" tmt:message="Please insert your name" /></td>
			</tr>
			<tr>
				<td valign="top">Data arrivo<br />Anreise<span class="required">&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
				<td><input name="arrival_datepicker" type="text" id="arrival_datepicker" class="data" readonly="readonly" class="required" tmt:required="true" tmt:message="Please select an arrival date"></td>
			</tr>
			<tr>
				<td valign="top">Data partenza<br />Abreise<span class="required">&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
				<td><input name="departure_datepicker" type="text" id="departure_datepicker" class="data" readonly="readonly" class="required" tmt:required="true" tmt:message="Please select a departure date"></td>
			</tr>
			<tr>
				<td valign="top">Note<br />Anmerkungen</td>
				<td><textarea name="notes" cols="30" rows="10"></textarea></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input name="submit" type="submit" value="Anmeldung/Prenota" id="submit" /></td>
			</tr>
		</table>
		<input type="hidden" name="apartment" value="<cfoutput>#URL.ap#</cfoutput>">
	</fieldset>
</form>
</cfif>
</body>
</html>