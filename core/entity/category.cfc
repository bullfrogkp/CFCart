<cfcomponent persistent="true"> 
    <cfproperty name="category_id" fieldtype="id" generator="increment"> 
    <cfproperty name="category_name" ormtype="string"> 
    <cfproperty name="category_display_name" ormtype="string"> 
    <cfproperty name="category_is_active" ormtype="string"> 
    <cfproperty name="create_datetime" ormtype="string"> 
    <cfproperty name="create_user" ormtype="string"> 
    <cfproperty name="update_datetime" ormtype="string"> 
    <cfproperty name="update_user" ormtype="string"> 
</cfcomponent>