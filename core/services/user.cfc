<cfcomponent output="false" accessors="true">
	<cfproperty name="username" type="string"> 
    <cfproperty name="password" type="string"> 
	
    <cffunction name="isUserValid" output="false" access="private" returntype="boolean">
		<cfset LOCAL = {} />
		<cfset LOCAL.retValue = false />
		
		<cfset LOCAL.user = EntityLoad("user",{username=getUsername(),password=Hash(getPassword())},true) />
		<cfif NOT IsNull(LOCAL.user)>
			<cfset LOCAL.retValue = true />
		</cfif>
	
		<cfreturn LOCAL.retValue />
    </cffunction>
</cfcomponent>