<cfcomponent extends="modules.module">	
    <cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.categories = [] />
		
		<cfset LOCAL.category = {} />
		<cfset LOCAL.category.name = "Featured Products" />
		<cfset LOCAL.category.products = [] />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.image1 = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.image2 = "#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" />
		<cfset LOCAL.product.categoryName = "Men clothing" />
		<cfset LOCAL.product.previousPrice = "199,99" />
		<cfset LOCAL.product.currentPrice = "119,99" />
		<cfset LOCAL.product.stars = 5 />
		<cfset ArrayAppend(LOCAL.retStruct.categories, LOCAL.category) />
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>