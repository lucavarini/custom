<style type="text/css">
	body{font-size: 12px; font-family: Verdana, Geneva, sans-serif;}
	.altRow{
		width:100%; 
		border-collapse:collapse; 
	}
	.altRow thead{ 
		font-weight: bold;
	}
	.altRow td{ 
		padding:7px; border:#4e95f4 1px solid;
		width:25%;
	}
	.alt{
		background-color: #b8d1f3;
	}​

	.altRowN{
		width:80%; 
		border-collapse:collapse; 
	}
	.altRowN thead{ 
		font-weight: bold;
	}
	.altRowN td{ 
		padding:7px; border:#ff6600 1px solid;
		width:25%;
	}
	.altN{
		background-color: #ff9900;
	}​
</style>
<cfquery datasource="muracms_apps" name="km_current">
	SELECT * FROM kitchen_menu_current_week_view
	ORDER BY giorno
</cfquery>
<cfquery datasource="muracms_apps" name="km_next">
	SELECT * FROM kitchen_menu_next_week_view
	ORDER BY giorno
</cfquery>

<table class="altRow">
 	<thead>
		<tr>
			<td style="width: 12%">Tag / Giorno</td>
			<td>Menu 1</td>
			<td>Menu 2</td>
			<td>Menu 3</td>
		</tr>
	</thead>
	<cfoutput query="km_current">
	<tr>
		<cfif km_current.currentrow mod 2 neq 0>
			<td rowspan="2" style="width: 8%">#LSdateformat(km_current.giorno,"ddd dd/mm")#</td>
		</cfif> 
		<td>#km_current.menu1#</td>
		<td>#km_current.menu2#</td>
		<td>#km_current.menu3#</td>
	</tr>
	</cfoutput>
</table>
<p>&nbsp;</p>
<cfif km_next.recordCount GT 0>
<table class="altRowN" style="border-collapse:collapse; width:100%; ">
 	<thead>
		<tr>
			<td style="width: 12%">Tag / Giorno</td>
			<td>Menu 1</td>
			<td>Menu 2</td>
			<td>Menu 3</td>
		</tr>
	</thead>
	<cfoutput query="km_next">
	<tr>
		<cfif km_next.currentrow mod 2 neq 0>
			<td rowspan="2" style="width: 8%">#LSdateformat(km_next.giorno,"ddd dd/mm")#</td>
		</cfif> 
		<td>#km_next.menu1#</td>
		<td>#km_next.menu2#</td>
		<td>#km_next.menu3#</td>
	</tr>
	</cfoutput>
</table>
</cfif>
<p>&nbsp;</p>
<script type="text/javascript">

$("table.altRow tr").filter(function() { 
  return $(this).children().length == 4;
}).filter(':even').addClass('alt');

$("tr.alt td[rowspan]").each(function() {
  $(this).parent().nextAll().slice(0, this.rowSpan - 1).addClass('alt');
});

$("table.altRowN tr").filter(function() { 
  return $(this).children().length == 4;
}).filter(':even').addClass('altN');

$("tr.altN td[rowspan]").each(function() {
  $(this).parent().nextAll().slice(0, this.rowSpan - 1).addClass('altN');
});

</script>