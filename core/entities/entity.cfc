<cfcomponent output="false" mappedsuperclass="true" accessors="true"> 
	<cfproperty name="name" column="name" ormtype="string" default=""> 
    <cfproperty name="displayName" column="name" ormtype="string" default=""> 
	<cfproperty name="description" column="description" ormtype="string" default=""> 
    <cfproperty name="isEnabled" column="image_is_enabled" ormtype="boolean" default="true"> 
    <cfproperty name="isDeleted" column="image_is_deleted" ormtype="boolean" default="false"> 
    <cfproperty name="createdDatetime" column="created_datetime" ormtype="date"> 
    <cfproperty name="createdUser" column="create_user" ormtype="string" default=""> 
    <cfproperty name="updatedDatetime" column="updated_datetime" ormtype="date"> 
    <cfproperty name="updatedUser" column="update_user" ormtype="string" default=""> 
	
	<cffunction name="init" output="false">
		
		<cfset setCreatedDatetime(Now()) />
		<cfset setUpdatedDatetime(Now()) />
		
		<cfreturn this>
	</cffunction>
</cfcomponent>