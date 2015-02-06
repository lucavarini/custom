<cfimport taglib="CustomTags" prefix="tmt">
<link type="text/css" rel="stylesheet" href="<cfoutput>#$.globalConfig('context')#/#$.siteConfig('siteID')#/includes/display_objects/custom/event/</cfoutput>css/style_table.css" />
<cfquery datasource="muracms_apps" name="reservationsQuery">
SELECT *
FROM event_subscription
ORDER BY nome ASC
</cfquery>
<!--- confirm delete function --->
<script language = "javascript">
    function confirmDelete(firstName, resID){
        action = false;
        action = confirm("Are you sure you want to delete: " + firstName);
        if (action){
            window.location = "<cfoutput>#$.globalConfig('context')#/#$.siteConfig('siteID')#</cfoutput>/includes/display_objects/custom/event/event_delete.cfm?id="+resID
        }
    }
</script>
<cfparam name="reservationsQueryPage" default="1">
<cfset reservationsQueryMaxRows = 20>
<cfset reservationsQueryStartRow = Min((reservationsQueryPage-1)*reservationsQueryMaxRows+1, Max(reservationsQuery.RecordCount, 1))>
<table id="hor-minimalist-b">
	<thead>
		<tr>
			<th colspan="5"><div align="center"><a rel="shadowbox;width=360;height=280" class="btn btn-larg btn-primary" href="<cfoutput>#$.globalConfig('context')#/#$.siteConfig('siteID')#/includes/display_objects/custom/event/event_reservation.cfm</cfoutput>">Iscrizione/Anmeldung</a></div></th>
		</tr>
		<tr>
			<th scope="col">Nome<br />Name</th>
			<th scope="col">Noleggio slitta<br />Rodel ausleihen</th>
			<th scope="col">Data<br />Datum</th>
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
				<td>#reservationsQuery.nome#</td>
				<td><cfif reservationsQuery.opzione EQ 0>Nein/No<cfelse>Ja/Si</cfif></td>
				<td>#DateFormat(reservationsQuery.sys_date, "dd/mm/yy")#</td>
				<td><a href="javascript: confirmDelete('#reservationsQuery.Nome#',#reservationsQuery.id_prenotazione#);">Delete</a></td>
		</cfoutput>	
	</tbody>
</table>
