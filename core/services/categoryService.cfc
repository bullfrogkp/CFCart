﻿<cfcomponent output="false" accessors="true">
    <cfproperty name="categoryId" type="integer"> 
    <cfproperty name="parentCategoryId" type="integer"> 
    <cfproperty name="categoryName" type="string"> 
    <cfproperty name="categoryDisplayName" type="string"> 
    <cfproperty name="categoryIsEnabled" type="boolean"> 
    <cfproperty name="categoryIsDeleted" type="boolean"> 
    <cfproperty name="showCategoryOnNav" type="boolean"> 
    <cfproperty name="offset" type="integer"> 
    <cfproperty name="limit" type="integer"> 

    <cffunction name="init" output="false" access="public" returntype="any" hint="Constructor">
       
		<cfargument name="categoryId" type="numeric" required="false"> 
		<cfargument name="parentPategoryId" type="integer" required="false"> 
		<cfargument name="categoryName" type="string" required="false"> 
		<cfargument name="categoryDisplayName" type="integer" required="false"> 
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
	   
	    <cfif getSearchCategoryKeyword() NEQ "">
			<cfset LOCAL.qry = "from category and (category_display_name like '#getSearchCategoryKeyword()#' or category_keyword like '#getSearchCategoryKeyword()#' or category_description like '#getSearchCategoryKeyword()#' )" > 
			
			<cfif NOT IsNull(getCategoryId())>
				<cfset LOCAL.qry = LOCAL.qry & "and category_id = '#getCategoryId()#' " />
			</cfif>
			<cfif NOT IsNull(getCategoryIsEnabled())>
				<cfset LOCAL.qry = LOCAL.qry & "and category_is_enabled = '#getCategoryIsEnabled()#' " />
			</cfif>
			<cfif NOT IsNull(getCategoryIsDeleted())>
				<cfset LOCAL.qry = LOCAL.qry & "and category_is_deleted = '#getCategoryIsDeleted()#' " />
			</cfif>
			
			<cfset LOCAL.categories = ORMExecuteQuery(LOCAL.qry)> 
		<cfelse>
			<cfset LOCAL.filter = {} />
			<cfif NOT IsNull(getCategoryId())>
				<cfset LOCAL.filter.categoryId = getCategoryId() />
			</cfif>
			<cfset LOCAL.categories = EntityLoad('category',LOCAL.filter)> 
		</cfif>
	   
		<cfreturn LOCAL.categories />
    </cffunction>
</cfcomponent>