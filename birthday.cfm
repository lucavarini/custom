<style>
	.details{
		font-size: 14px;	
	}
	.person_photo{
		/*float: left;
		margin-right: 4px;
		margin-top: 4px;*/
	}
	.photo_table td{
		padding:4px;
	}
</style>
<cfquery datasource="muracms_apps" name="birthday">
	select *
	from birthdays_view
	order by birthdayDate
</cfquery>
<table class="photo_table">
<cfoutput query="birthday">
	<tr>
		<td valign="top" align="center">
			<div class="details" style="margin-left:auto;margin-right:auto;text-align:center">
				<cfif Len(birthday.jpegPhoto)>
					<div class="person_photo"><cfimage source="#birthday.jpegPhoto#" action="writeToBrowser"></div>
				<cfelse>
					<img src="#$.siteConfig('themeAssetPath')#/images/person.gif" class="person_photo" />
				</cfif>
			</div>
		</td>
		<td valign="top">
			<p class="details">#cn#<br />
			#title# (#c#)<br />
			#dateformat(birthdayDate, "dd mmmm")#</p>
		</td>
	</tr>
</cfoutput>
</table>