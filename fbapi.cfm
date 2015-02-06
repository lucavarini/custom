<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Shitty FB</title>
</head>
<!--- 
salewa = 153693713493, salewa
dynafit = 202246342049, dynafit
wc= 97486098594, wild country
pomoca = 484832858228746, Pomoca Climbing Skins
 --->
<body>

<cffunction name="structToQuery" returntype="query" output="no">
	<cfargument name="cfData" type="struct" required="yes">
	<cfargument name="brand" type="string" required="yes">

	<cfset var feedOberalp_ordered = QueryNew("")>
	<cfset var nameArray = ArrayNew("1")>
	<cfset var msgArray = ArrayNew("1")>
	<cfset var picArray = ArrayNew("1")>
	<cfset var dateArray = ArrayNew("1")>
	<cfset var linkArray = ArrayNew("1")>
	<cfset var x = 1>
	<cfset var i = 1>

 	<cfloop index="i" from="1" to="#ArrayLen(cfData.data)#">
		<cfif (cfData.data[i].from.name EQ arguments.brand) AND StructKeyExists(cfData.data[i], "message")>
			<cfif StructKeyExists(cfData.data[i].from, "name")>
				<cfset nameArray[x] = cfData.data[i].from.name>
			</cfif>
			<cfif StructKeyExists(cfData.data[i], "message")>
				<cfset msgArray[x] = cfData.data[i].message>
			</cfif>
 			<cfif StructKeyExists(cfData.data[i], "picture")>
				<cfset picArray[x] = cfData.data[i].picture>
			</cfif>
			<cfif StructKeyExists(cfData.data[i], "created_time")>
				<cfset dateArray[x] = DateFormat(ListFirst(cfData.data[i].created_time, "T"),"yyyy-mm-dd")>
			</cfif>
			<cfif StructKeyExists(cfData.data[i], "link")>
				<cfset linkArray[x] = cfData.data[i].link>
			</cfif>
			<cfset x = x+1>
		</cfif> 
	</cfloop>	

	<cfset QueryAddColumn(feedOberalp_ordered, "brand", "VarChar", nameArray)>
	<cfset QueryAddColumn(feedOberalp_ordered, "msg", "VarChar", msgArray)>
	<cfset QueryAddColumn(feedOberalp_ordered, "pic", "VarChar", picArray)>
	<cfset QueryAddColumn(feedOberalp_ordered, "dateCreated", "Date", dateArray)>
	<cfset QueryAddColumn(feedOberalp_ordered, "link", "VarChar", linkArray)>

	<cfreturn feedOberalp_ordered>
</cffunction>


<cfhttp url="https://graph.facebook.com/153693713493/feed?access_token=729250300449784|LfJEa-QUW_dqBjJaRRGjZQ1HUj0&filter=nf"></cfhttp>
<cfset salewaJson=REReplace(cfhttp.FileContent, "^\s*[[:word:]]*\s*\(\s*","")>
<cfhttp url="https://graph.facebook.com/202246342049/feed?access_token=729250300449784|LfJEa-QUW_dqBjJaRRGjZQ1HUj0&filter=nf"></cfhttp>
<cfset dynafitJson=REReplace(cfhttp.FileContent, "^\s*[[:word:]]*\s*\(\s*","")>
<cfhttp url="https://graph.facebook.com/97486098594/feed?access_token=729250300449784|LfJEa-QUW_dqBjJaRRGjZQ1HUj0&filter=nf"></cfhttp>
<cfset wcJson=REReplace(cfhttp.FileContent, "^\s*[[:word:]]*\s*\(\s*","")>
<cfhttp url="https://graph.facebook.com/484832858228746/feed?access_token=729250300449784|LfJEa-QUW_dqBjJaRRGjZQ1HUj0&filter=nf"></cfhttp>
<cfset pomocaJson=REReplace(cfhttp.FileContent, "^\s*[[:word:]]*\s*\(\s*","")>




<cfif !IsJSON(salewaJson)>
    <h3>The URL you requested does not provide valid JSON</h3>
<!--- If the data is in JSON format, deserialize it. --->
<cfelse>
    <cfset salewaStruct=DeserializeJSON(salewaJson)>
	<cfset querySalewa = structToQuery(salewaStruct, "salewa")>
	
	<cfset dynafitStruct=DeserializeJSON(dynafitJson)>
	<cfset queryDynafit = structToQuery(dynafitStruct, "dynafit")>
	
	<cfset wcStruct=DeserializeJSON(wcJson)>
	<cfset queryWc = structToQuery(wcStruct, "wild country")>
	
	<cfset pomocaStruct=DeserializeJSON(pomocaJson)>
	<cfset queryPomoca = structToQuery(pomocaStruct, "Pomoca Climbing Skins")>
</cfif>

<cfquery name="queryFeeds" dbtype="query">
	SELECT * FROM querySalewa
	UNION
	SELECT * FROM queryDynafit
	UNION
	SELECT * FROM queryWc
	UNION
	SELECT * FROM queryPomoca
	ORDER BY dateCreated DESC
</cfquery>
<cfloop query="queryFeeds">
	<cfquery datasource="muracms_apps">
		INSERT INTO social_feeds
			   (brand
			   ,msg
			   ,pic
			   ,dateCreated
			   ,link)
		 VALUES
			   (queryFeeds.brand
			   ,queryFeeds.msg
			   ,queryFeeds.pic
			   ,queryFeeds.dateCreated
			   ,queryFeeds.link)
	</cfquery>
</cfloop>
<!--- <cfdump var="#queryFeeds#"> --->
<h2>Social Networks</h2>
<div style="width:280px; height:600px; overflow: auto;">
 <cfoutput query="queryFeeds">
<p><img src="includes/display_objects/custom/#ReplaceNoCase(queryFeeds.brand,' ','','all')#.jpg" style="float:left; margin-right: 4px;" />#LSDateFormat(queryFeeds.dateCreated, "dd-mmm")# - <a href="#queryFeeds.link#" target="_blank">#queryFeeds.brand#</a><br />
<br /><img src="#queryFeeds.pic#" style="float:left; margin-right: 4px;" />#queryFeeds.msg#</p><br /><hr />
</cfoutput>
</div>

</body>
</html>


