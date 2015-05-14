<cfcomponent persistent="true"> 
    <cfproperty name="attributeValueId" column="attribute_value_id" fieldtype="id" generator="native">
	<cfproperty name="name" column="name" ormtype="string">
	<cfproperty name="displayName" column="display_name" ormtype="string">
    <cfproperty name="thumbnailLabel" column="thumbnail" ormtype="string">
    <cfproperty name="thumbnailImageName" column="thumbnail_image_name" ormtype="string">
    <cfproperty name="imageName" column="image_name" ormtype="string">
    <cfproperty name="value" column="value" ormtype="string">
	<cfproperty name="productAttributeRela" fieldtype="many-to-one" cfc="product_attribute_rela" fkcolumn="product_attribute_rela_id">
	
	<cffunction name="getThumbnailImageLink" access="public" output="false" returnType="string">
		<cfreturn "#APPLICATION.absoluteUrlWeb#images/uploads/product/#getProductAttributeRela().getProduct().getProductId()#/#getThumbnailImageName()#" />
	</cffunction>
	
	<cffunction name="getImageLink" access="public" output="false" returnType="string">
		<cfargument name="type" type="string" required="false" default="" />
		
		<cfset var imageType = "" />
		<cfif Trim(ARGUMENTS.type) NEQ "">
			<cfset imageType = "#Trim(ARGUMENTS.type)#_" />
		</cfif>
		
		<cfset var imageLink = "" />
		
		<cfif NOT IsNull(getProductAttributeRela().getProduct().getParentProduct())>
			<cfset LOCAL.productId = getProductAttributeRela().getProduct().getParentProduct().getProductId() />
		<cfelse>
			<cfset LOCAL.productId = getProductAttributeRela().getProduct().getProductId() />
		</cfif>
		
		<cfif IsNull(getImageName())>
			<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/site/no_image_available.png" />
		<cfelse>
			<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/uploads/product/#LOCAL.productId#/#imageType##getImageName()#" />
		</cfif>
		
		<cfreturn imageLink />
	</cffunction>
</cfcomponent>
