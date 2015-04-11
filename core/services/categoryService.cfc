<cfcomponent extends="service" output="false" accessors="true">
	<cfproperty name="parentCategoryId" type="numeric"> 
	<cfproperty name="showCategoryOnNavigation" type="boolean"> 

    <cffunction name="getCategories" output="false" access="public" returntype="struct">
		<cfset LOCAL = {} />
	   
		<cfif getSearchKeywords() NEQ "">	
			<cfset LOCAL.qry = "from category where (display_name like '%#getSearchKeywords()#%' or keywords like '%#getSearchKeywords()#%' or description like '%#getSearchKeywords()#%' )" /> 
		<cfelse>
			<cfset LOCAL.qry = "from category where 1=1 " /> 
		</cfif>
		
		<cfif NOT IsNull(getId())>
			<cfset LOCAL.qry = LOCAL.qry & "and category_id = '#getId()#' " />
		</cfif>
		<!---
		<cfif NOT IsNull(getIsEnabled())>
			<cfset LOCAL.qry = LOCAL.qry & "and is_enabled = '#getIsEnabled()#' " />
		</cfif>
		<cfif NOT IsNull(getIsDeleted())>
			<cfset LOCAL.qry = LOCAL.qry & "and is_deleted = '#getIsDeleted()#' " />
		</cfif>
		--->
		<cfset LOCAL.records = ORMExecuteQuery(LOCAL.qry, false, getPaginationStruct()) /> 
		<cfset LOCAL.totalCount = ORMExecuteQuery( "select count(category_id) as count " & LOCAL.qry, true) /> 
		<cfset LOCAL.totalPages = Ceiling(LOCAL.totalCount / APPLICATION.recordsPerPage) /> 
	
		<cfreturn LOCAL />
    </cffunction>
	
	<cffunction name="getCategoryTree" access="public" returntype="array">
		<cfargument name="parentCategoryId" type="numeric" required="false" />
		<cfargument name="isEnabled" type="boolean" required="false" default="true" />
		<cfargument name="showCategoryOnNavigation" type="boolean" required="false" default="true" />
		<cfargument name="orderBy" type="string" required="false" default="displayName ASC" />
		
		<cfset var LOCAL = {} />
		
		<cfif IsNull(ARGUMENTS.parentCategoryId)>
			<cfset LOCAL.categories = EntityLoad("category", {parentCategory=JavaCast("NULL",""), isEnabled = ARGUMENTS.isEnabled, isDeleted = false, showCategoryOnNavigation = ARGUMENTS.showCategoryOnNavigation}, ARGUMENTS.orderBy) />
		<cfelse>
			<cfset LOCAL.categories = EntityLoad("category", {parentCategory=EntityLoadByPK("category",ARGUMENTS.parentCategoryId), isEnabled = ARGUMENTS.isEnabled, isDeleted = false, showCategoryOnNavigation = ARGUMENTS.showCategoryOnNavigation}, ARGUMENTS.orderBy) />
		</cfif>
		
		<cfloop array="#LOCAL.categories#" index="LOCAL.c">
			<cfset LOCAL.c.setSubCategories(getCategoryTree(parentCategoryId = LOCAL.c.getCategoryId())) />
		</cfloop>
		
        <cfreturn LOCAL.categories />
	</cffunction>
</cfcomponent>