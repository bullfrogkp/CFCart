<cfcomponent persistent="true"> 
    <cfproperty name="pageSectionAdvertisementId" column="page_section_advertisement_id" fieldtype="id" generator="native"> 
	<cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
	<cfproperty name="section" fieldtype="many-to-one" cfc="page_section" fkcolumn="page_section_id">
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="category" fieldtype="many-to-one" cfc="category" fkcolumn="category_id">
	
	<cffunction name="getImageLink" access="public" output="false" returnType="string">
		<cfargument name="type" type="string" required="false" default="" />
		
		<cfset var imageType = "" />
		<cfif Trim(ARGUMENTS.type) NEQ "">
			<cfset imageType = "#Trim(ARGUMENTS.type)#_" />
		</cfif>
		
		<cfreturn "#APPLICATION.absoluteUrlWeb#images/uploads/advertise/#imageType##getName()#" />
	</cffunction>
</cfcomponent>