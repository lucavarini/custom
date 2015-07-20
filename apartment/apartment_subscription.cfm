<cfimport taglib="CustomTags" prefix="tmt">
<link type="text/css" rel="stylesheet" href="<cfoutput>#$.globalConfig('context')#/#$.siteConfig('siteID')#/includes/display_objects/custom/event/</cfoutput>css/style_table.css" />
<cfset ap= $.content('ap')>
<p><div align="center"><a rel="shadowbox;width=420;height=380;" class="btn btn-larg btn-primary" href="<cfoutput>#$.globalConfig('context')#/#$.siteConfig('siteID')#/includes/display_objects/custom/apartment/apartment_reservation.cfm?ap=#ap#</cfoutput>">Reservierungsanfrage/Richiesta</a></div></p>