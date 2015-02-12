<cfcomponent output="false" mappedsuperclass="true" accessors="true"> 
	<cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="displayName" column="display_name" ormtype="string"> 
	<cfproperty name="description" column="description" ormtype="string"> 
    <cfproperty name="isEnabled" column="is_enabled" ormtype="boolean"> 
    <cfproperty name="isDeleted" column="is_deleted" ormtype="boolean"> 
    <cfproperty name="createdDatetime" column="created_datetime" ormtype="date"> 
    <cfproperty name="createdUser" column="create_user" ormtype="string"> 
    <cfproperty name="updatedDatetime" column="updated_datetime" ormtype="date"> 
    <cfproperty name="updatedUser" column="update_user" ormtype="string"> 
	
	<cffunction name="init" output="false">
		
		<cfset setCreatedDatetime(Now()) />
		<cfset setUpdatedDatetime(Now()) />
		<cfset setIsDeleted(false) />
		
		<cfreturn this>
	</cffunction>
</cfcomponent>