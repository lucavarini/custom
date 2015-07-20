<!---<cffunction name="onError" returnType="void" output="true">
    <cfargument name="exception" required="true">
    <cfargument name="eventname" type="string" required="true">
    <cfset var errortext = "">

    <cflog file="kitchen_error" text="#arguments.exception.message#">
    
    <cfsavecontent variable="errortext">
    <cfoutput>
    An error occurred: http://#cgi.server_name##cgi.script_name#?#cgi.query_string#<br />
    Time: #dateFormat(now(), "dd/mm/yyyy")# #timeFormat(now(), "short")#<br /><br>
    
    <cfdump var="#arguments.exception#" label="Error">
    <cfdump var="#form#" label="Form">
    <cfdump var="#url#" label="URL">
    
    </cfoutput>
    </cfsavecontent>
    
    <cfmail to="luca.varini@oberalp.it" from="cfservice@oberalp.it" subject="Error: #arguments.exception.message#" type="html">
        #errortext#
    </cfmail>
    
    <cflocation url="error.cfm">    
</cffunction>--->