<cfsilent>

<!--- <cfldap action="QUERY"
name="ldap"
attributes="jpegPhoto"
start="dc=intranet,dc=salewa,dc=com"
filter="sAMAccountName=lucav"
server="itdc01.intranet.salewa.com"
username="salewacom\lucav"
password="specialized"> --->

<!--- <cfscript>
     ldapPhoto = toString(ldap.jpegPhoto);

     ldapPhoto = binaryDecode(ldapPhoto, "base64");
</cfscript>
 --->
</cfsilent>
<!--- <cfcontent type="image/jpeg" variable="#ldapPhoto#"> --->
<!--- <cfimage source="#ldap.jpegPhoto#" action="writeToBrowser"> --->
<!--- USE IPPHONE TO STORE BIRTHDAY ---> 
<cfldap action="QUERY"
name="activeusers"
attributes="userPrincipalName,cn,title,mail,c,ipPhone,jpegPhoto"
start="OU=All Users,DC=intranet,DC=salewa,DC=com"
filter="(&(objectCategory=Person)(objectClass=User)(samAccountType:1.2.840.113556.1.4.803:=805306368)(!(userAccountControl:1.2.840.113556.1.4.803:=2)))"
server="itdc01.intranet.salewa.com"
username="salewacom\lucav"
password="specialized">
<!--- <cfdump var="#activeusers#"> --->
<cfquery datasource="muracms_apps">
	DELETE FROM birthdays
</cfquery>
<cfloop query="activeusers">
	 <!--- Insert only users with birthday date (homePhone) not NULL --->
	<cfif trim(activeusers.ipPhone) NEQ "" AND isdate(activeusers.ipPhone)>
		<cfquery datasource="muracms_apps">
			INSERT INTO birthdays
			(
			userPrincipalName
           ,cn
		   ,title
           ,mail
           ,c
           ,homePhone
           ,jpegPhoto)
			VALUES(
				<cfqueryparam value="#activeusers.userPrincipalName#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#activeusers.cn#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#activeusers.title#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#activeusers.mail#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#activeusers.c#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#CreateODBCDate(Dateformat(activeusers.ipPhone, 'dd-mm-yyyy'))#" cfsqltype="cf_sql_date">,
				<cfqueryparam value="#activeusers.jpegPhoto#" cfsqltype="cf_sql_blob" null="#NOT len(trim(tostring(activeusers.jpegPhoto)))#">
			)
		</cfquery>
	</cfif>
</cfloop>
<cfquery datasource="muracms_apps" name="birthday">
	select *
	from birthdays_view
	order by birthdayDate
</cfquery>
<cfoutput query="birthday">
	<cfif Len(birthday.jpegPhoto)>
		<cfimage source="#birthday.jpegPhoto#" action="writeToBrowser"><br />
	<cfelse>
		<img src="person.gif" />
	</cfif>
	<a href="mailto:#mail#">#cn#</a><br />
	#title# (#c#)<br />
	#dateformat(birthdayDate, "dd mmmm")#<br />
</cfoutput>



