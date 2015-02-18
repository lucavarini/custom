<!--- Convert a JPG image to a binary object. --->
<cffile action="readBinary" file="#ExpandPath('\')#default/includes/display_objects/custom/cristina.jpg" variable="binaryObject">
<!--- Create a cfimage from the binary object variable. --->
<!--- <cfset myImage=ImageNew(binaryObject)> --->
<!--- <img src="<cfoutput>#binaryObject#</cfoutput>"> --->
<cfquery datasource="muracms_apps">
	INSERT INTO birthdays_no_ad
	(
	userPrincipalName
   ,cn
   ,title
   ,mail
   ,c
   ,homePhone
   ,jpegPhoto)
	VALUES(
		'test',
		'test',
		'test',
		'test',
		'IT',
		'1900-02-19',
		<cfqueryparam value="#binaryObject#" cfsqltype="cf_sql_blob">
	)
</cfquery>