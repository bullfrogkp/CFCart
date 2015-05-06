<cfcomponent extends="master"> 
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.productId = ListGetAt(CGI.PATH_INFO,2,"/")> 
		
		<cfset LOCAL.pageData.product = EntityLoadByPK("product",LOCAL.productId) />
		
		<cfset LOCAL.pageData.defaultImage = EntityLoad("product_image", {product = LOCAL.pageData.product, isDefault = true},true)> 
		<cfset LOCAL.pageData.allImages = EntityLoad("product_image", {product = LOCAL.pageData.product, isDefault = true})> 
		
		<cfset LOCAL.reviewStatusType = EntityLoad("review_status_type", {name = "approved"})> 
		<cfset LOCAL.pageData.reviews = EntityLoad("review", {product = LOCAL.pageData.product, reviewStatusType = LOCAL.reviewStatusType})> 
		
		<cfset LOCAL.pageData.title = "#LOCAL.pageData.product.getDisplayName()# | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = LOCAL.pageData.product.getDescription() />
		<cfset LOCAL.pageData.keywords = LOCAL.pageData.product.getKeywords() />
	
		<cfset LOCAL.pageData.categoryArray = _getCategoryArray(product = LOCAL.pageData.product) />
														
		<cfreturn LOCAL.pageData />	
	</cffunction>
	<!---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="_getCategoryArray" access="private" output="false" returnType="array">
		<cfargument name="product" type="any" required="true" />
		<cfset var LOCAL = {} />
				
		<cfset LOCAL.categoryArray = [] />
		<cfset LOCAL.product = ARGUMENTS.product />
		
		<cfset ArrayPrepend(LOCAL.categoryArray, LOCAL.product) />
			
		<cfloop condition = "NOT IsNull(LOCAL.category.getParentCategory())">
			<cfset LOCAL.category = LOCAL.category.getParentCategory() />
			<cfset ArrayPrepend(LOCAL.categoryArray, LOCAL.category) />
		</cfloop>
				
		<cfreturn LOCAL.categoryArray />	
	</cffunction>
</cfcomponent>