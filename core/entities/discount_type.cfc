<cfcomponent persistent="true"> 
    <cfproperty name="discountTypeId" column="discount_type_id" fieldtype="id" generator="native"> 
    <cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="displayName" column="display_name" ormtype="string"> 
    <cfproperty name="ccomponent" column="component" ormtype="string"> 
</cfcomponent>