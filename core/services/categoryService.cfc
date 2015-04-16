<cfcomponent extends="service" output="false" accessors="true">
	<cfproperty name="parentCategoryId" type="numeric"> 
	<cfproperty name="showCategoryOnNavigation" type="boolean"> 
	
	<cffunction name="_getQuery" output="false" access="private" returntype="array">
		<cfargument name="getCount" type="boolean" required="false" default="false" />
		<cfset LOCAL = {} />
		
		<cfif ARGUMENTS.getCount EQ false>
			<cfset LOCAL.ormOptions = getPaginationStruct() />
		<cfelse>
			<cfset LOCAL.ormOptions = {} />
		</cfif>
	   
		<cfquery name="LOCAL.query" ormoptions="#LOCAL.ormOptions#" dbtype="hql">	
			<cfif ARGUMENTS.getCount EQ true>
			SELECT COUNT(categoryId) 
			</cfif>
			FROM category 
			WHERE 1=1
			<cfif getSearchKeywords() NEQ "">	
			AND	(displayName like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" /> OR keywords like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" /> OR description like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" />)
			</cfif>
			<cfif NOT IsNull(getId())>
			AND categoryId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />
			</cfif>
			<cfif NOT IsNull(getIsEnabled())>
			AND isEnabled = <cfqueryparam cfsqltype="cf_sql_bit" value="#getIsEnabled()#" />
			</cfif>
			<cfif NOT IsNull(getIsDeleted())>
			AND isDeleted = <cfqueryparam cfsqltype="cf_sql_bit" value="#getIsDeleted()#" />
			</cfif>
		</cfquery>
	
		<cfreturn LOCAL.query />
    </cffunction>
	
	<cffunction name="_getProductQuery" output="false" access="private" returntype="array">
		<cfargument name="getCount" type="boolean" required="false" default="false" />
		<cfset LOCAL = {} />
		
		<cfif ARGUMENTS.getCount EQ false>
			<cfset LOCAL.ormOptions = getPaginationStruct() />
		<cfelse>
			<cfset LOCAL.ormOptions = {} />
		</cfif>
	  
		<cfquery name="LOCAL.query" ormoptions="#LOCAL.ormOptions#" dbtype="hql">	
			<cfif ARGUMENTS.getCount EQ true>
			SELECT COUNT(p) 
			</cfif>
			FROM product p
			JOIN p.categories cat
			WHERE cat.categoryId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />
		</cfquery>
	
		<cfreturn LOCAL.query />
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
	
	<cffunction name="getProducts" output="false" access="public" returntype="struct">
		<cfset LOCAL = {} />
		
		<cfset LOCAL.records = _getProductQuery() /> 
		<cfset LOCAL.totalCount = _getProductQuery(getCount=true)[1] />
		<cfset LOCAL.totalPages = Ceiling(LOCAL.totalCount / APPLICATION.recordsPerPage) /> 
	
		<cfreturn LOCAL />
    </cffunction>
</cfcomponent>