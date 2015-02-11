<cfimport taglib="CustomTags" prefix="tmt">
<link type="text/css" rel="stylesheet" href="<cfoutput>#$.globalConfig('context')#/#$.siteConfig('siteID')#/includes/display_objects/custom/event/</cfoutput>css/style_table.css" />
<cfset ap= $.content('ap')>
<cfquery datasource="muracms_apps" name="reservationsQuery">
SELECT *
FROM apartments_reservations_view
WHERE apartment=<cfqueryparam value="#ap#" cfsqltype="cf_sql_varchar">
ORDER BY arrival_date
</cfquery>
<!--- confirm delete function --->
<script language = "javascript">
    function confirmDelete(firstName, resID){
        action = false;
        action = confirm("Are you sure you want to delete: " + firstName);
        if (action){
            window.location = "<cfoutput>#$.globalConfig('context')#/#$.siteConfig('siteID')#</cfoutput>/includes/display_objects/custom/apartment/apartment_delete.cfm?id="+resID
        }
    }
</script>
<cfparam name="reservationsQueryPage" default="1">
<cfset reservationsQueryMaxRows = 20>
<cfset reservationsQueryStartRow = Min((reservationsQueryPage-1)*reservationsQueryMaxRows+1, Max(reservationsQuery.RecordCount, 1))>
<table id="hor-minimalist-b">
	<thead>
		<tr>
			<th colspan="5"><div align="center"><a rel="shadowbox;width=360;height=280" class="btn btn-larg btn-primary" href="<cfoutput>#$.globalConfig('context')#/#$.siteConfig('siteID')#/includes/display_objects/custom/apartment/apartment_reservation.cfm?ap=#ap#</cfoutput>">Iscrizione/Anmeldung</a></div></th>
		</tr>
		<tr>
			<th scope="col">Nome<br />
			Name</th>
			<th scope="col">Data arrivo<br />Anreise</th>
			<th scope="col">Data partenza<br />Abreise</th>
			<th scope="col">Note<br />Anmerkung</th>
			<th scope="col">&nbsp;</th>
		</tr>
	</thead>
	<tfoot>
		<tr>
			<td colspan="5" style="text-align:center"><tmt:querynav query="reservationsQuery" maxrows="#reservationsQueryMaxRows#" mode="pagelist" prevlink="prev" nextlink="next" /></td>
		</tr>
	</tfoot>
	<tbody>
		<cfoutput query="reservationsQuery" startRow="#reservationsQueryStartRow#" maxRows="#reservationsQueryMaxRows#">
			<tr>
				<td>#reservationsQuery.name_surname#</td>
				<td>#DateFormat(reservationsQuery.arrival_date, "dd/mm/yy")#</td>
				<td>#DateFormat(reservationsQuery.departure_date, "dd/mm/yy")#</td>
				<td>#reservationsQuery.notes#</td>
				<td><a href="javascript: confirmDelete('#reservationsQuery.name_surname#',#reservationsQuery.id_reservation#);">Delete</a></td>
		</cfoutput>	
	</tbody>
</table>
