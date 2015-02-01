﻿<cfcomponent output="false" accessors="true">
    <cfproperty name="categoryId" type="integer"> 
    <cfproperty name="parentCategoryId" type="integer"> 
    <cfproperty name="categoryName" type="string"> 
    <cfproperty name="categoryDisplayName" type="string"> 
    <cfproperty name="categoryIsEnabled" type="boolean"> 
    <cfproperty name="categoryIsDeleted" type="boolean"> 
    <cfproperty name="showCategoryOnNav" type="boolean"> 

    <cffunction name="init" output="false" access="public" returntype="BrownPeanut" hint="Constructor">
       
		<cfargument name="categoryId" type="integer" required="false"> 
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

    <cffunction name="getCategories" output="false" access="public" returntype="query">
	   <cfset LOCAL = {} />
	   
	   <cfquery name="LOCAL.categories">
			SELECT	*
			FROM	categories
			WHERE	1=1
			<cfif getCategoryId() NEQ "">
			AND		category_id = <cfqueryparam value="#getCategoryId()#" cfsqltype="cf_sql_integer" />
			</cfif>
	   </cfquery>
    </cffunction>
</cfcomponent>