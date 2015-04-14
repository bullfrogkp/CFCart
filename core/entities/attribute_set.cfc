<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeSetId" column="attribute_set_id" fieldtype="id" generator="native">
	<cfproperty name="attributeSetAttributeRelas" type="array" fieldtype="one-to-many" cfc="attribute_set_attribute_rela" fkcolumn="attribute_set_id" singularname="attributeSetAttributeRela" cascade="delete-orphan">
	
	<cffunction name="removeAttributes" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getAttributeSetAttributeRelas())>
			<cfset ArrayClear(getAttributeSetAttributeRelas()) />
		</cfif>
	</cffunction>
</cfcomponent>