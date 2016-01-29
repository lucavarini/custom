<style type="text/css">
	body{font-size: 12px; font-family: Verdana, Geneva, sans-serif;}
	.altRow{
		width:100%; 
		border-collapse:collapse; 
		font-size: 10px;
	}
	.altRow thead{ 
		font-weight: bold;
		text-align: center;
	}
	.altRow td{ 
		padding:7px; border:#4e95f4 1px solid;
		width:8%;
	}
	.alt{
		background-color: #b8d1f3;
	}​

	.altRowN{
		width:100%; 
		border-collapse:collapse;
		font-size: 10px;
	}
	.altRowN thead{ 
		font-weight: bold;
		text-align: center;
	}
	.altRowN td{ 
		padding:7px; border:#ff6600 1px solid;
		width:8%;
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
<table class="altRow" style="font-size:10px;" cellpadding="0" cellspacing="0">
 	<thead>
		<tr>
			<td>Tag / Giorno</td>
			<td>Menu 1</td>
			<td>Menu 2</td>
			<td>Menu 3</td>
			<td>Menu 4</td>
			<td>Menu 5</td>
			<td>Menu 6</td>
			<td>Menu 7</td>
			<td>Menu 8</td>
			<td>Menu 9</td>
			<td>Menu 10</td>
			<td>Menu 11</td>
		</tr>
	</thead>
	<cfoutput query="km_current">
	<tr>
		<cfif km_current.currentrow mod 2 neq 0>
			<td rowspan="2" style="">#LSdateformat(km_current.giorno,"ddd dd/mm")#</td>
		</cfif> 
		<td>#km_current.menu1#</td>
		<td>#km_current.menu2#</td>
		<td>#km_current.menu3#</td>
		<td>#km_current.menu4#</td>
		<td>#km_current.menu5#</td>
		<td>#km_current.menu6#</td>
		<td>#km_current.menu7#</td>
		<td>#km_current.menu8#</td>
		<td>#km_current.menu9#</td>
		<td>#km_current.menu10#</td>
		<td>#km_current.menu11#</td>
	</tr>
	</cfoutput>
</table>
<p>&nbsp;</p>
<cfif km_next.recordCount GT 0>
<table class="altRowN" style="border-collapse:collapse; width:100%; font-size:10px;" cellspacing="0" cellpadding="0">
 	<thead>
		<tr>
			<td>Tag / Giorno</td>
			<td>Menu 1</td>
			<td>Menu 2</td>
			<td>Menu 3</td>
			<td>Menu 4</td>
			<td>Menu 5</td>
			<td>Menu 6</td>
			<td>Menu 7</td>
			<td>Menu 8</td>
			<td>Menu 9</td>
			<td>Menu 10</td>
			<td>Menu 11</td>
		</tr>
	</thead>
	<cfoutput query="km_next">
	<tr>
		<cfif km_next.currentrow mod 2 neq 0>
			<td rowspan="2" style="">#LSdateformat(km_next.giorno,"ddd dd/mm")#</td>
		</cfif> 
		<td>#km_next.menu1#</td>
		<td>#km_next.menu2#</td>
		<td>#km_next.menu3#</td>
		<td>#km_next.menu4#</td>
		<td>#km_next.menu5#</td>
		<td>#km_next.menu6#</td>
		<td>#km_next.menu7#</td>
		<td>#km_next.menu8#</td>
		<td>#km_next.menu9#</td>
		<td>#km_next.menu10#</td>
		<td>#km_next.menu11#</td>
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