<div class="hidden-xs">
<cfquery datasource="muracms_apps" name="queryFeeds">
SELECT *
FROM social_feeds
ORDER BY dateCreated DESC
</cfquery>
<h2>Social Networks</h2>
<div style="width:280px; height:900px; overflow: auto; overflow-x:hidden;font-size:12px">
 <cfoutput query="queryFeeds">
<p><img src="includes/display_objects/custom/#ReplaceNoCase(queryFeeds.brand,' ','','all')#.png" style="float:left; margin-right: 4px;" />#LSDateFormat(queryFeeds.dateCreated, "dd-mmm")# - <a href="#queryFeeds.link#" target="_blank">#queryFeeds.brand#</a><br />#queryFeeds.msg#<br /><img src="#queryFeeds.pic#" style="border:1px solid black;" /></p><hr />
</cfoutput>
</div>
</div>