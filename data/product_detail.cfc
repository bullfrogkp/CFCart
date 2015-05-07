<cfcomponent extends="master"> 
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.productId = ListGetAt(CGI.PATH_INFO,2,"/")> 
		
		<cfset LOCAL.pageData.product = EntityLoadByPK("product",LOCAL.productId) />
		
		<cfset LOCAL.pageData.allImages = EntityLoad("product_image", {product = LOCAL.pageData.product})> 
		
		<cfset LOCAL.reviewStatusType = EntityLoad("review_status_type", {name = "approved"}, true)> 
		<cfset LOCAL.pageData.reviews = EntityLoad("review", {product = LOCAL.pageData.product, reviewStatusType = LOCAL.reviewStatusType})> 
		
		<cfset LOCAL.pageData.title = "#LOCAL.pageData.product.getDisplayName()# | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = LOCAL.pageData.product.getDescription() />
		<cfset LOCAL.pageData.keywords = LOCAL.pageData.product.getKeywords() />
														
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>