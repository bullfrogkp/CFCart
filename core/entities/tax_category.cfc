<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="taxCategoryId" column="tax_category_id" fieldtype="id" generator="native"> 
    <cfproperty name="rate" column="rate" ormtype="float"> 
</cfcomponent>