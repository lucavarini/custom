<cfprocessingdirective pageencoding="utf-8">
<cfparam name="URL.auction_obj_id" default="">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Auction</title>
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
<cfif StructKeyExists(FORM, "offer_author")>
	<cfquery datasource="muracms_apps">
			INSERT INTO auction_offers
			   (obj_id
			   ,offer_author
			   ,offer_money)
		 VALUES
			   (<cfqueryparam value="#form.auction_obj_id#" cfsqltype="cf_sql_int">
			   ,<cfqueryparam value="#form.offer_author#" cfsqltype="cf_sql_varchar">
			   ,<cfqueryparam value="#form.offer_money#" cfsqltype="cf_sql_real">)
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
		<td><input name="offer_author" type="text" size="30" tmt:required="true" tmt:message="Please insert your name" /></td>
	</tr>
	<tr>
		<td>Angebot/Offerta<span class="required">&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
		<td><input name="offer_money" type="text" size="10" tmt:required="true" tmt:message="Please insert an offer. Use . for decimal places." tmt:filters="numbersdots" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>
			<input name="submit" type="submit" value="Submit" id="submit" />
		</td>
	</tr>
	</fieldset>
	<cfoutput><input name="auction_obj_id" type="hidden" value="#URL.auction_obj_id#"></cfoutput>
</form>
</table>
</cfif>
</body>
</html>