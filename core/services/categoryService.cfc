<cfcomponent extends="service" output="false" accessors="true">
	<cfproperty name="parentCategoryId" type="numeric"> 
	<cfproperty name="showCategoryOnNavigation" type="boolean"> 

    <cffunction name="getCategories" output="false" access="public" returntype="array">
		<cfset LOCAL = {} />
	   
	    <cfif getSearchKeywords() NEQ "">
			<cfset LOCAL.qry = "from category where (display_name like '%#getSearchKeywords()#%' or keywords like '%#getSearchKeywords()#%' or description like '%#getSearchKeywords()#%' )" > 
			
			<cfif NOT IsNull(getCategoryId())>
				<cfset LOCAL.qry = LOCAL.qry & "and category_id = '#getCategoryId()#' " />
			</cfif>
			<cfif NOT IsNull(getIsEnabled())>
				<cfset LOCAL.qry = LOCAL.qry & "and is_enabled = '#getIsEnabled()#' " />
			</cfif>
			<cfif NOT IsNull(getIsDeleted())>
				<cfset LOCAL.qry = LOCAL.qry & "and is_deleted = '#getIsDeleted()#' " />
			</cfif>
			
			<cfset LOCAL.categories = ORMExecuteQuery(LOCAL.qry, false, getPaginationStruct())> 
		<cfelse>
			<cfset LOCAL.filter = {} />
			<cfif NOT IsNull(getId())>
				<cfset LOCAL.filter.categoryId = getId() />
			</cfif>
			<cfif NOT IsNull(getIsEnabled())>
				<cfset LOCAL.filter.isEnabled = getIsEnabled() />
			</cfif>
			<cfif NOT IsNull(getIsDeleted())>
				<cfset LOCAL.filter.isDeleted = getIsDeleted() />
			</cfif>
			
			<cfset LOCAL.categories = EntityLoad('category', LOCAL.filter, getPaginationStruct())> 
		</cfif>
	   
		<cfreturn LOCAL.categories />
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