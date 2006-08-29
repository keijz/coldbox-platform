<cfsetting enablecfoutputonly=true>
<!---
	Name         : forums.cfm
	Author       : Raymond Camden 
	Created      : June 10, 2004
	Last Updated : September 15, 2005
	History      : Support for UUID (rkc 1/27/05)
				   Display lastmsg, msgcount (rkc 4/6/05)
				   Fixed code that gets # of pages (rkc 4/8/05)				
				   Right colspan if no data (rkc 4/15/05)
				   Pass mode to pagination tag, used to hide/show subscribe button (rkc 7/29/05)
				   Remove mappings (8/27/05)
				   Support for sorting (rkc 9/15/05)
	Purpose		 : Displays forums for conference
--->
<!--- Get Reference --->
<cfset data = getValue("data")>

<!--- Displays pagination on right side, plus left side buttons for threads --->
<cfmodule template="../tags/pagination.cfm" pages="#getValue("pages")#" mode="conference" />

<!--- Now display the table. This changes based on what our data is. --->
<cfoutput>
<p>
<table width="100%" cellpadding="6" class="tableDisplay" cellspacing="1" border="0">
	<tr class="tableHeader">
		<td colspan="5" class="tableHeader">Conference: #request.conference.name#</td>
	</tr>
	<tr class="tableSubHeader">
		<td class="tableSubHeader">#request.udf.headerLink("Forum","name")#</td>
		<td class="tableSubHeader">#request.udf.headerLink("Description")#</td>
		<td class="tableSubHeader">#request.udf.headerLink("Messages","messagecount")#</td>
		<td class="tableSubHeader">#request.udf.headerLink("Last Post","lastpost")#</td>
		<td class="tableSubHeader">#request.udf.headerLink("Read Only","readonly")#</td>
	</tr>
	<cfif data.recordCount>
		<cfloop query="data" startrow="#(getValue("page")-1)*application.settings.perpage+1#" endrow="#(getValue("page")-1)*application.settings.perpage+application.settings.perpage#">
			<tr class="tableRow#currentRow mod 2#">
				<td><a href="index.cfm?event=ehForums.dspThreads&forumid=#id#">#name#</a></td>
				<td>#description#</td>
				<td>#messagecount#</td>
				<td><a href="index.cfm?event=ehForums.dspMessages&threadid=#threadidfk###last">#dateFormat(lastpost,"m/d/yy")# #timeFormat(lastpost,"h:mm tt")#</a></td>
				<td>#yesNoFormat(readonly)#</td>
			</tr>
		</cfloop>
	<cfelse>
		<tr class="tableRow1">
			<td colspan="5">Sorry, but there are no forums available for this conference.</td>
		</tr>
	</cfif>
</table>
</p>
</cfoutput>
	
<cfsetting enablecfoutputonly=false>
