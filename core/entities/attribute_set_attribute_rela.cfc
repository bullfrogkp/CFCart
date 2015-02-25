<cfcomponent persistent="true"> 
    <cfproperty name="attributeSetAttributeRelaId" column="attribute_set_attribute_rela_id" fieldtype="id" generator="native">
	<cfproperty name="attributeSetId" column="attribute_set_id" ormtype="integer"> 
	<cfproperty name="attributeId" column="attribute_id" ormtype="integer"> 
	<cfproperty name="required" column="required" ormtype="boolean"> 
</cfcomponent>
