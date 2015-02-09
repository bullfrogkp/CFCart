<cfcomponent output="false" mappedsuperclass="true" accessors="true"> 
    <cfproperty name="createdDatetime" column="created_datetime" ormtype="date"> 
    <cfproperty name="createdUser" column="create_user" ormtype="string"> 
    <cfproperty name="updatedDatetime" column="updated_datetime" ormtype="date"> 
    <cfproperty name="updatedUser" column="update_user" ormtype="string"> 
	
	<cffunction name="init" output="false">
		
		<cfset setCreatedDatetime(Now()) />
		<cfset setUpdatedDatetime(Now()) />
		<cfset setCreatedUser("") />
		<cfset setUpdatedUser("") />
		
		<cfreturn this>
	</cffunction>
</cfcomponent>