<cfcomponent output="false" accessors="true">

    <cfproperty name="filter" type="struct" />

    <cffunction name="init" output="false">
       <cfreturn this>
    </cffunction>

    <cffunction name="getProducts" output="false" returntype="query">
        
		<cfset var filter = this.getFilter() />
		
		<cfquery name="LOCAL.getProducts"/>
		
		</cfquery>
    </cffunction>

</cfcomponent>