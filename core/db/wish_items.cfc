<cfcomponent persistent="true"> 
    <cfproperty name="site_page_id" fieldtype="id" generator="increment"> 
    <cfproperty name="site_page_name" ormtype="string"> 
    <cfproperty name="site_page_display_name" ormtype="string"> 
    <cfproperty name="site_page_title" ormtype="string"> 
    <cfproperty name="site_page_keywords" ormtype="text"> 
    <cfproperty name="site_page_description" ormtype="text"> 
    <cfproperty name="site_page_content" ormtype="text"> 
</cfcomponent>