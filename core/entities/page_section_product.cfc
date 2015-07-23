<cfcomponent persistent="true"> 
    <cfproperty name="pageSectionProductId" column="page_section_product_id" fieldtype="id" generator="native"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
	<cfproperty name="section" fieldtype="many-to-one" cfc="page_section" fkcolumn="page_section_id">
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="category" fieldtype="many-to-one" cfc="category" fkcolumn="category_id">
</cfcomponent>