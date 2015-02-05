<cfcomponent output="false" accessors="true">
    <cfproperty name="categoryId" type="numeric"> 
    <cfproperty name="parentCategoryId" type="numeric"> 
    <cfproperty name="categoryName" type="string"> 
    <cfproperty name="categorySearchKeywords" type="string"> 
    <cfproperty name="categoryDisplayName" type="string"> 
    <cfproperty name="categoryIsEnabled" type="boolean"> 
    <cfproperty name="categoryIsDeleted" type="boolean"> 
    <cfproperty name="showCategoryOnNav" type="boolean"> 
    <cfproperty name="offset" type="numeric"> 
    <cfproperty name="limit" type="numeric"> 

    <cffunction name="init" output="false" access="public" returntype="any" hint="Constructor">
       
		<cfargument name="categoryId" type="numeric" required="false"> 
		<cfargument name="parentPategoryId" type="numeric" required="false"> 
		<cfargument name="categoryName" type="string" required="false"> 
		<cfargument name="categoryDisplayName" type="string" required="false"> 
		<cfargument name="categoryIsEnabled" type="boolean" required="false"> 
		<cfargument name="categoryIsDeleted" type="boolean" required="false"> 
		<cfargument name="showCategoryOnNav" type="boolean" required="false"> 
		
		<cfif StructKeyExists(ARGUMENTS,"categoryId")>
			<cfset setCategoryId(ARGUMENTS.categoryId)>
		</cfif>
		<cfif StructKeyExists(ARGUMENTS,"parentPategoryId")>
			 <cfset setParentPategoryId(ARGUMENTS.parentPategoryId)>
		</cfif>
		<cfif StructKeyExists(ARGUMENTS,"categoryName")>
			<cfset setCategoryName(ARGUMENTS.categoryName)>
		</cfif>
		<cfif StructKeyExists(ARGUMENTS,"categoryDisplayName")>
			 <cfset setCategoryDisplayName(ARGUMENTS.categoryDisplayName)>
		</cfif>
		<cfif StructKeyExists(ARGUMENTS,"categoryIsEnabled")>
			<cfset setCategoryIsEnabled(ARGUMENTS.categoryIsEnabled)>
		</cfif>
		<cfif StructKeyExists(ARGUMENTS,"categoryIsDeleted")>
			<cfset setCategoryIsDeleted(ARGUMENTS.categoryIsDeleted)>
		</cfif>
        <cfif StructKeyExists(ARGUMENTS,"showCategoryOnNav")>
			 <cfset setShowCategoryOnNav(ARGUMENTS.showCategoryOnNav)>
		</cfif>
		
        <cfreturn this/>
    </cffunction>

    <cffunction name="getCategories" output="false" access="public" returntype="array">
		<cfset LOCAL = {} />
	   
	    <cfif getCategorySearchKeywords() NEQ "">
			<cfset LOCAL.qry = "from category where (category_display_name like '%#getCategorySearchKeywords()#%' or category_keywords like '%#getCategorySearchKeywords()#%' or category_description like '%#getCategorySearchKeywords()#%' )" > 
			
			<cfif NOT IsNull(getCategoryId())>
				<cfset LOCAL.qry = LOCAL.qry & "and category_id = '#getCategoryId()#' " />
			</cfif>
			<cfif NOT IsNull(getCategoryIsEnabled())>
				<cfset LOCAL.qry = LOCAL.qry & "and category_is_enabled = '#getCategoryIsEnabled()#' " />
			</cfif>
			
			<cfset LOCAL.categories = ORMExecuteQuery(LOCAL.qry)> 
		<cfelse>
			<cfset LOCAL.filter = {} />
			<cfif NOT IsNull(getCategoryId())>
				<cfset LOCAL.filter.categoryId = getCategoryId() />
			</cfif>
			<cfif NOT IsNull(getCategoryIsEnabled())>
				<cfset LOCAL.filter.categoryIsEnabled = getCategoryIsEnabled() />
			</cfif>
			
			<cfset LOCAL.categories = EntityLoad('category',LOCAL.filter)> 
		</cfif>
	   
		<cfreturn LOCAL.categories />
    </cffunction>
	
	<cffunction name="getCategoryTree" access="public" returntype="array">
		<cfargument name="parentCategoryId" type="numeric" required="false" default="0" />
		<cfargument name="categoryIsEnabled" type="boolean" required="false" default="true" />
		<cfargument name="showCategoryOnNav" type="boolean" required="false" default="true" />
		<cfargument name="orderBy" type="string" required="false" default="categoryDisplayName ASC" />
		
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.categories = EntityLoad("category", {parentCategoryId=ARGUMENTS.parentCategoryId, categoryIsEnabled = ARGUMENTS.categoryIsEnabled, categoryIsDeleted = false, showCategoryOnNav = ARGUMENTS.showCategoryOnNav}, ARGUMENTS.orderBy) />
	
		<cfloop array="#LOCAL.categories#" index="LOCAL.c">
			<cfset LOCAL.c.setSubCategories(getCategoryTree(parentCategoryId = LOCAL.c.getCategoryId())) />
		</cfloop>
		
        <cfreturn LOCAL.categories />
	</cffunction>
</cfcomponent>