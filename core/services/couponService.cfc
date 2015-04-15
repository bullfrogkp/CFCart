<cfcomponent extends="service" output="false" accessors="true">
    
	<cffunction name="getRecords" output="false" access="public" returntype="struct">
		<cfset LOCAL = {} />
		
		<cfset LOCAL.records = _getQuery() /> 
		<cfset LOCAL.totalCount = _getQuery(getCount=true)[1] /> 
		<cfset LOCAL.totalPages = Ceiling(LOCAL.totalCount / APPLICATION.recordsPerPage) /> 
	
		<cfreturn LOCAL />
    </cffunction>
	
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
			SELECT COUNT(couponId) 
			</cfif>
			FROM coupon 
			WHERE 1=1
			<cfif getSearchKeywords() NEQ "">	
			AND	displayName like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" />
			</cfif>
			<cfif NOT IsNull(getId())>
			AND couponId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />
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
</cfcomponent>