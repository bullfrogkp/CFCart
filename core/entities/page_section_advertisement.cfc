<cfcomponent persistent="true"> 
    <cfproperty name="pageSectionAdvertisementId" column="page_section_advertisement_id" fieldtype="id" generator="native"> 
	<cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
	<cfproperty name="section" fieldtype="many-to-one" cfc="page_section" fkcolumn="page_section_id">
</cfcomponent>