<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="discountTypeId" column="discount_type_id" fieldtype="id" generator="native"> 
    <cfproperty name="component" column="function" ormtype="string"> 
</cfcomponent>