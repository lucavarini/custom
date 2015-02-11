?!<cfprocessingdirective pageencoding="utf-8">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Apartment reservation delete</title>
<link type="text/css" rel="stylesheet" href="css/style_form.css" />
</head>
<body>
<cfif StructKeyExists(URL, "id")>
	<cfquery datasource="muracms_apps">
		DELETE FROM apartments_reservations
		WHERE id_reservation = <cfqueryparam value="#URL.id#" cfsqltype="cf_sql_numeric">
	</cfquery>
	<p>Ok!</p>
</cfif>
<cflocation url="../../../../index.cfm/4-you/benefits/apartments/rodi-rules/">
</body>
</html>