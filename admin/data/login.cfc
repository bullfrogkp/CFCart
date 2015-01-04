<cfcomponent extends="master">	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfinvoke component="#APPLICATION.component_path_root#core.db.users" method="authUser" returnvariable="LOCAL.login_correct">
			<cfinvokeargument name="username" value="#FORM.username#">
			<cfinvokeargument name="password" value="#FORM.password#">
		</cfinvoke>

		<cfif LOCAL.login_correct EQ FALSE>
			<cfset LOCAL.redirect_url = "login.cfm" />
		<cfelse>
			<cfset SESSION.admin_user = "rona" />
			<cfset LOCAL.redirect_url = "index.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>