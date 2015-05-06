<cfcomponent extends="master"> 
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.productId = ListGetAt(CGI.PATH_INFO,2,"/")> 
		
		<cfset LOCAL.pageData.product = EntityLoadByPK("product",LOCAL.productId) />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		<cfset LOCAL.productService = new "#APPLICATION.componentPathRoot#core.services.productService"() />
		
		<cfset LOCAL.pageData.defaultImage = EntityLoad("product_image", {product = LOCAL.pageData.product, isDefault = true, isDeleted = false},true)> 
		<cfset LOCAL.pageData.allImages = EntityLoad("product_image", {product = LOCAL.pageData.product, isDefault = true, isDeleted = false})> 
		
		<!---
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
		<cfset LOCAL.pageData.subCategoryTree = LOCAL.categoryService.getCategoryTree(parentCategoryId = LOCAL.categoryId) />
		--->
		<cfset LOCAL.pageData.title = "#LOCAL.pageData.product.getDisplayName()# | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = LOCAL.pageData.product.getDescription() />
		<cfset LOCAL.pageData.keywords = LOCAL.pageData.product.getKeywords() />
	<!---	<cfset LOCAL.pageData.categoryArray = _getCategoryArray(product = LOCAL.pageData.product) />
	
		<cfset LOCAL.pageData.currentPage = EntityLoad("page", {name = getPageName()},true)> 
		<cfset LOCAL.pageData.advertisementSection = EntityLoad("page_section", {name="advertisement",page=LOCAL.pageData.currentPage},true)> 
		<cfset LOCAL.pageData.advertisementSection.setProduct(LOCAL.pageData.product) />
	--->
														
		<cfreturn LOCAL.pageData />	
	</cffunction>
	<!---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="_getCategoryArray" access="private" output="false" returnType="array">
		<cfargument name="category" type="any" required="true" />
		<cfset var LOCAL = {} />
				
		<cfset LOCAL.categoryArray = [] />
		<cfset LOCAL.category = ARGUMENTS.category />
		
		<cfset ArrayPrepend(LOCAL.categoryArray, LOCAL.category) />
			
		<cfloop condition = "NOT IsNull(LOCAL.category.getParentCategory())">
			<cfset LOCAL.category = LOCAL.category.getParentCategory() />
			<cfset ArrayPrepend(LOCAL.categoryArray, LOCAL.category) />
		</cfloop>
				
		<cfreturn LOCAL.categoryArray />	
	</cffunction>
</cfcomponent>