<cfcomponent persistent="true"> 
    <cfproperty name="pageSectionId" column="page_section_id" fieldtype="id" generator="native">
    <cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="content" column="content" ormtype="text"> 
	<cfproperty name="page" fieldtype="many-to-one" cfc="page" fkcolumn="page_id">
	<cfproperty name="products" type="array" fieldtype="one-to-many" cfc="page_section_product" fkcolumn="page_section_id" singularname="product" orderby="rank">
	<cfproperty name="advertisements" type="array" fieldtype="one-to-many" cfc="page_section_advertisement" fkcolumn="page_section_id" singularname="advertisement" orderby="rank">
	
	<cfproperty name="category" persistent="false" type="any"> 
	<cfproperty name="product" persistent="false" type="any"> 
	
	<cffunction name="getSectionData" access="public" output="false" returnType="any">
		
		<cfset var sectionData = "" />
		<cfset var page = getPage() />
		
		<cfif page.getName() EQ "index" AND getName() EQ "slide">
			<cfset sectionData = getContent() />
		<cfelseif  page.getName() EQ "index" AND getName() EQ "advertisement">
			<cfset sectionData = getAdvertisements() />
		<cfelseif  page.getName() EQ "index" AND getName() EQ "top selling">
			<cfset sectionData = getProducts() />
		<cfelseif  page.getName() EQ "index" AND getName() EQ "group buying">
			<cfset sectionData = getProducts() />
		<cfelseif  page.getName() EQ "products" AND getName() EQ "advertisement">
			<cfset sectionData = EntityLoad("page_section_advertisement", {section = this, category = getCategory()})> 
		<cfelseif  page.getName() EQ "products" AND getName() EQ "best seller">
			<cfset sectionData = EntityLoad("page_section_product", {section = this, category = getCategory()})> 
		</cfif>
		
		<cfreturn sectionData />
	</cffunction>
	
	<cffunction name="removeAllProducts" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getProducts())>
			<cfset ArrayClear(getProducts()) />
		</cfif>
	</cffunction>
</cfcomponent>