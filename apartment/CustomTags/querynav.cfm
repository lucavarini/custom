<cfsilent>
<!--- Ensure this file gets compiled using iso-8859-1 charset --->
<cfprocessingdirective pageencoding="iso-8859-1">
<!--- 
/**
* ColdFusion custom tag: "querynav"  
* 
* Create a navigation bar for a given query. 
* ColdFusion 6.1 or above required
* @author       Massimo Foti (massimo@massimocorner.com)
* @version      1.1, 2006-06-26
* 
* @param        query          Required. A query name (not a query object!)
* @param        maxrows        Optional. Amount of rows to show. Default to 10 
* @param        maxlinks       Optional. Amount of links to show. Default to 10
* @param        mode           Optional. Style used for links, it can be either linkList or pageList. Default to linkList
* @param        separator      Optional. Link's separator. Default to |
* @param        beforecurrent  Optional. String written before the "current" link. Default to <strong>
* @param        aftercurrent   Optional. String written after the "current" link. Default to </strong>
* @param        prevlink       Optional. Text used for "previous" link. Default to none
* @param        nextlink       Optional. Text used for "next" link. Default to none
 */
--->

<cfif thisTag.executionMode IS "end">
	<cfexit>
</cfif>

<!--- The query attribute takes a query name, not a query object --->
<cfparam name="attributes.query" type="variableName">
<!--- Optional attributes --->
<cfparam name="attributes.maxrows" type="numeric" default="10">
<cfparam name="attributes.maxlinks" type="numeric" default="10">
<cfparam name="attributes.mode" type="string" default="linklist">
<cfparam name="attributes.separator" type="string" default="|">
<cfparam name="attributes.beforecurrent" type="string" default="<strong>">
<cfparam name="attributes.aftercurrent" type="string" default="</strong>">
<cfparam name="attributes.prevlink" type="string" default="">
<cfparam name="attributes.nextlink" type="string" default="">

<!--- Wrong attribute value --->
<cfif NOT ListFind("linklist,pagelist", attributes.mode)>
	<cfthrow message="querynav: only modes available are linkList and pageList">
</cfif>

</cfsilent>
<cfscript>

currentPage = GetFileFromPath(GetTemplatePath());
pageNum = attributes.query & "Page";
maxRows = attributes.maxrows;
totalPages =  Ceiling(caller[attributes.query].RecordCount/maxRows);
startLink = Max(1, caller[pageNum] - int(attributes.maxlinks/2));
tempPos = startLink + attributes.maxlinks - 1;
endLink = min(tempPos, totalPages);
if(endLink NEQ tempPos){
	startLink = max(1, endLink - attributes.maxlinks + 1);
}

// Keep all the name/values pairs inside the querystring, apart from pageNum 
appendQueryString = "";
for(x in url){
	if(x NEQ pageNum){
		appendQueryString = appendQueryString & "&amp;" & LCase(x) & "=" &url[x];
	}
}

// Previous link
if(attributes.prevlink NEQ ""){
	prevNum = caller[pageNum] - 1;
	if(prevNum NEQ 0){
		WriteOutput(' <a href="#CurrentPage#?#pageNum#=#prevNum##appendQueryString#">#attributes.prevlink#</a> ');
	}
	else{
		WriteOutput(" " & attributes.prevlink & " ");
	}
}

// linkList mode
if(attributes.mode EQ "linklist"){
	for(i = startLink; i LTE endLink; i = i + 1){
		queryCount = (i - 1) * maxRows + 1;
		queryEndCount = Min(caller[attributes.query].Recordcount, queryCount + maxRows - 1);
		if(i NEQ caller[pageNum]){
			WriteOutput(' <a href="#CurrentPage#?#pageNum#=#i##appendQueryString#">#queryCount#-#queryEndCount#</a> ');
		}
		else{
			WriteOutput(attributes.beforecurrent & queryCount & "-" & queryEndCount & attributes.aftercurrent);
		}
		if(i NEQ endLink){
			WriteOutput(" " & attributes.separator & " ");
		}
	}
}

// pageList mode
if(attributes.mode EQ "pagelist"){
	for(i = startLink; i LTE endLink; i = i + 1){
		if(i NEQ caller[pageNum]){
			WriteOutput(' <a href="#CurrentPage#?#pageNum#=#i##appendQueryString#">#i#</a> ');
		}
		else{
			WriteOutput(attributes.beforecurrent & i & attributes.aftercurrent);
		}
		if(i NEQ endLink){
			WriteOutput(" " & attributes.separator & " ");
		}
	}
}

// Next link
if(attributes.nextlink NEQ ""){
	nextNum = caller[pageNum] + 1;
	if(nextNum LTE totalPages){
		WriteOutput(' <a href="#CurrentPage#?#pageNum#=#nextNum##appendQueryString#">#attributes.nextlink#</a> ');
	}
	else{
		WriteOutput(" " & attributes.nextlink & " ");
	}
}

</cfscript>