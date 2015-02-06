<cffeed action="read" source="https://www.facebook.com/feeds/page.php?format=rss20&id=153693713493" 
query="feedQuery_salewa" properties="feedMetadata" >
<cffeed action="read" source="https://www.facebook.com/feeds/page.php?format=rss20&id=202246342049" 
query="feedQuery_dynafit" properties="feedMetadata" >
<cffeed action="read" source="https://www.facebook.com/feeds/page.php?format=rss20&id=484832858228746" 
query="feedQuery_pomoca" properties="feedMetadata" >
<cffeed action="read" source="https://www.facebook.com/feeds/page.php?format=rss20&id=97486098594" 
query="feedQuery_wc" properties="feedMetadata" >
<!--- 
salewa = 153693713493
dynafit = 202246342049
wc= 97486098594
pomoca = 484832858228746
 --->

<!--- 
<cfoutput query="feedQuery"><p>#feedQuery.content#</p></cfoutput>

<cfdump var="#feedQuery#">
 --->
 
<cfquery name="feedOberalp" dbtype="query">
SELECT *
FROM feedQuery_salewa
UNION
SELECT *
FROM feedQuery_dynafit
UNION
SELECT *
FROM feedQuery_pomoca
UNION
SELECT *
FROM feedQuery_wc
</cfquery>

<cfquery name="feedOberalp_ordered" dbtype="query">
SELECT *, CAST(PUBLISHEDDATE as date) AS datapubb
FROM feedOberalp
ORDER BY datapubb DESC
</cfquery>
<h2>Social Networks</h2>
<div style="width:280px; height:600px; overflow: auto;">
<cfoutput query="feedOberalp_ordered">
<p><img src="includes/display_objects/custom/#ReplaceNoCase(feedOberalp_ordered.AUTHOREMAIL,' ','','all')#.jpg" style="float:left; margin-right: 4px;" />#LSDateFormat(feedOberalp_ordered.datapubb, "dd-mmm")# - <a href="#feedOberalp_ordered.rsslink#" target="_blank">#feedOberalp_ordered.title#</a><br />
<br />#feedOberalp_ordered.content#</p><hr />
</cfoutput>
</div>

<!--- <cfoutput query="feedQuery" maxrows="3"><p><a href="https://www.facebook.com/SalewaTeam" target="_blank">#feedQuery.title#</a><br />#feedQuery.content#</p><hr /></cfoutput> --->
<!--- <iframe allowtransparency="true" frameborder="0" scrolling="yes" src="http://intra.intranet.salewa.com/default/includes/display_objects/custom/fb.cfm" style="border:none; overflow:hidden; width:280px; height:597px;"></iframe> --->
<!--- <iframe allowtransparency="true" frameborder="0" scrolling="no" src="//www.facebook.com/plugins/likebox.php?href=https%3A%2F%2Fwww.facebook.com%2Fsalewateam&amp;width=280&amp;height=597&amp;colorscheme=light&amp;show_faces=false&amp;header=false&amp;stream=false&amp;show_border=false&amp;appId=119186211516331" style="border:none; overflow:hidden; width:280px; height:597px;"></iframe>
<br />
<iframe allowtransparency="true" frameborder="0" scrolling="no" src="//www.facebook.com/plugins/likebox.php?href=https%3A%2F%2Fwww.facebook.com%2Fdynafit&amp;width=280&amp;height=597&amp;colorscheme=light&amp;show_faces=false&amp;header=false&amp;stream=true&amp;show_border=false&amp;appId=119186211516331" style="border:none; overflow:hidden; width:280px; height:597px;"></iframe>
 --->