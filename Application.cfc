<cfcomponent extends="admin.application">
	<!------------------------------------------------------------------------------->
	<cffunction name="_initPageObject" output="false" access="private" returnType="any">
		<cfargument type="string" name="pageName" required="true"/>
		
		<cfif FileExists("#APPLICATION.absolutePathRoot#data\#ARGUMENTS.pageName#.cfc")>
			<cfset var pageObj = new "#APPLICATION.componentPathRoot#data.#ARGUMENTS.pageName#"(pageName = ARGUMENTS.pageName) />
		<cfelse>
			<cfset var pageObj = new "#APPLICATION.componentPathRoot#data.master"(pageName = ARGUMENTS.pageName) />
		</cfif>
		
		<cfreturn pageObj />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_initGlobalPageObject" output="false" access="private" returnType="any">
		<cfargument type="string" name="pageName" required="true"/>
		
		<cfset var pageObj = new "#APPLICATION.componentPathRoot#data.global"(pageName = ARGUMENTS.pageName) />
		
		<cfreturn pageObj />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="onRequestStart" returntype="boolean" output="false">
		<cfargument type="String" name="targetPage" required="true"/>
		
		<cfset _setShoppingCart() />
		<cfset super.onRequestStart(targetPage=ARGUMENTS.targetPage) />
		
		<cfreturn true>
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_setShoppingCart"  access="private" returnType="void" output="false">
		<cfset var LOCAL = {} />
		
		<cfif NOT IsNull(SESSION.loggedinUserId)>
			<cfset LOCAL.shoppingCart = EntityLoad("tracking_entity",{userId = SESSION.loggedinUserId}, true) />
		</cfif>
		<cfif IsNull(LOCAL.shoppingCart)>
			<cfset LOCAL.shoppingCart = EntityLoad("tracking_entity",{cfid = COOKIE.cfid, cftoken = COOKIE.cftoken}, true) />
		</cfif>
		<cfif IsNull(shoppingCart)>
			<cfset LOCAL.shoppingCart = EntityNew("tracking_entity") />
		</cfif>
		
		<cfset shoppingCart.setCfid(COOKIE.cfid) />
		<cfset shoppingCart.setCftoken(COOKIE.cftoken) />
		<cfif NOT IsNull(SESSION.loggedinUserId)>
			<cfset shoppingCart.setUserId(SESSION.loggedinUserId) />
		</cfif>
		<cfset shoppingCart.setLastAccessDatetime(Now()) />
		<cfset EntitySave(shoppingCart) />
		
	</cffunction>
	<!------------------------------------------------------------------------------->
	<!----------------------------------------------------------------------------
	<cffunction name="onMissingTemplate" returnType="any">
	    <cfargument name="targetPage" type="string" required=true/>
   
		<cflog text="cannot find page: #ARGUMENTS.targetPage#" />
		
		<cflocation url="#APPLICATION.absoluteUrlWeb#error.cfm" addtoken="false" />
	</cffunction>--->
	<!------------------------------------------------------------------------------->
</cfcomponent>