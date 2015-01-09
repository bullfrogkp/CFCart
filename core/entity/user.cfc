<cfcomponent persistent="true"> 
    <cfproperty name="user_id" fieldtype="id" generator="increment"> 
    <cfproperty name="username" ormtype="string"> 
    <cfproperty name="password" ormtype="string"> 

	<cffunction name="authUser" access="public" output="false" returnType="numeric">
		<cfargument name="username" type="string" required="true" />
		<cfargument name="password" type="string" required="true" />
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.user_exists = FALSE />
				
		<cfquery name="LOCAL.getUser">
			SELECT 	1
			FROM	users
			WHERE	username = <cfqueryparam value="#ARGUMENTS.username#" cfsqltype="cf_sql_varchar" />
			AND		password = <cfqueryparam value="#HASH(ARGUMENTS.password)#" cfsqltype="cf_sql_varchar" />
			;
		</cfquery>
		
		<cfif LOCAL.getUser.recordCount EQ 1>
			<cfset LOCAL.user_exists = TRUE />
		</cfif>
		
		<cfreturn LOCAL.user_exists />
	</cffunction>	
	
	<cffunction name="updateUser" access="public" output="false" returnType="void">
		<cfargument name="username" type="string" required="true" />
		<cfargument name="password" type="string" required="true" />
		<cfargument name="user" type="string" required="true" />
		
		<cfset var LOCAL = {} />
		
		<cfquery name="LOCAL.updateUser">
			UPDATE	users
			SET		password = <cfqueryparam value="#HASH(ARGUMENTS.password)#" cfsqltype="cf_sql_varchar" />
			,		update_user = <cfqueryparam value="#ARGUMENTS.user#" cfsqltype="cf_sql_varchar" />
			WHERE	username = <cfqueryparam value="#ARGUMENTS.username#" cfsqltype="cf_sql_varchar" />
			;
		</cfquery>		
	</cffunction>	
</cfcomponent>