<cfoutput>
<cfloop index="i" to="15" from="0" >
    chr(#i#) : #chr(i)# <br>
</cfloop>
</cfoutput>
<cfscript>
	writeDump(deserializeJSON(serializeJSON({"test" = "3D"})));
</cfscript>