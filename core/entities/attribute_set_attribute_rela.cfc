<cfcomponent persistent="true"> 
    <cfproperty name="attributeSetAttributeRelaId" column="attribute_set_attribute_rela_id" fieldtype="id" generator="native">
	<cfproperty name="required" column="required" ormtype="boolean"> 
	
	<cfproperty name="attributeSet" fieldtype="many-to-one" cfc="attribute_set" fkcolumn="attribute_set_id">
	<cfproperty name="attribute" fieldtype="many-to-one" cfc="attribute" fkcolumn="attribute_id">
</cfcomponent>
