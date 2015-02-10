<cfprocessingdirective pageencoding="utf-8">
<cfimport taglib="CustomTags/" prefix="tmt">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Event reservation</title>
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
</head>
<body>
<cfif StructKeyExists(FORM, "nome")>
	<cfquery datasource="muracms_apps">
		INSERT INTO event_subscription
		   (nome
		   ,opzione)
	 VALUES
		   (<cfqueryparam value="#form.nome#" cfsqltype="cf_sql_varchar">
		   ,<cfqueryparam value="#form.opzione#" cfsqltype="cf_sql_bit">)
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
				<td>Name-Nachname<br />Nome-Cognome<span class="required">&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
				<td><input name="nome" type="text" size="30" tmt:required="true" tmt:message="Please insert your name" /></td>
			</tr>
			<tr>
				<td valign="top">Rodel ausleihen<br />Noleggio slitta<span class="required">&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
				<td>
					<input name="opzione" type="radio" class="boxes" value="1" tmt:required="true" tmt:message="Please select an option"/> Ja/Si<br />
					<input name="opzione" type="radio" class="boxes" value="0" /> Nein/No<br />
				</td>
			</tr>
			<tr>
				<td colspan="2"><input name="submit" type="submit" value="Anmeldung/Iscrizione" id="submit" /></td>
			</tr>
		</table>
	</fieldset>
</form>
</cfif>
</body>
</html>