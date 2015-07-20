<cfprocessingdirective pageencoding="utf-8">
<link type="text/css" rel="stylesheet" href="<cfoutput>#$.globalConfig('context')#/#$.siteConfig('siteID')#/includes/display_objects/custom/kitchen/</cfoutput>css/style_table.css" />
<cfquery datasource="muracms_apps" name="auctionsQuery">
SELECT *
FROM auctions_offers_view
</cfquery>
 <cffunction name="getName"> 
    <cfargument name="auction_obj_id" type="numeric" required="true"> 
	<cfquery name="getNameQuery" datasource="muracms_apps" > 
	        SELECT offer_author
	        FROM auction_offers
	        WHERE obj_id = #auction_obj_id#
	        ORDER BY offer_money DESC
	 </cfquery> 
	 <cfreturn getNameQuery.offer_author> 
</cffunction> 
<table id="hor-minimalist-b">
	<thead>
		<tr>
			<th scope="col">Nome <br> Name des Objektes</th>
			<th scope="col">Foto <br> Bild</th>
			<th scope="col">Cos'è? <br> Was ist es?</th>
			<th scope="col">Base d'asta <br> Preis</th>
			<th scope="col">Offerta <br> Gebot</th>
			<th scope="col">&nbsp;</th>
		</tr>
	</thead>
	<tbody>
		<cfoutput query="auctionsQuery">
			<tr>
				<td>#auctionsQuery.obj_name#</td>
				<td><img src="#$.globalConfig('context')#/#$.siteConfig('siteID')#/includes/display_objects/custom/auction/images/#auctionsQuery.obj_id#.jpg"></td>
				<td>#auctionsQuery.obj_description#</td>
				<td>#auctionsQuery.obj_start_price#</td>
				<td>#auctionsQuery.maxoffer# <br> #getName(auctionsQuery.obj_id)#</td>
				<td>
				<a rel="shadowbox;width=360;height=120" class="btn btn-larg btn-primary" href="#$.globalConfig('context')#/#$.siteConfig('siteID')#/includes/display_objects/custom/auction/auction_offer.cfm?auction_obj_id=#auctionsQuery.obj_id#">Offerta <br> Angebot</a></td>
		</cfoutput>	
	</tbody>
</table>
