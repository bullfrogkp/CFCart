<cfcomponent extends="modules.module">	
    <cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		
		<cfset LOCAL.retStruct.menu = {} />
		<cfset LOCAL.retStruct.menu.newArrivals = {} />
		<cfset LOCAL.retStruct.menu.deals = {} />
		<cfset LOCAL.retStruct.menu.products = {} />
		<cfset LOCAL.retStruct.menu.blog = {} />
		<cfset LOCAL.retStruct.menu.more = {} />
		<cfset LOCAL.retStruct.menu.specialCategories = ArrayNew(1) />	
		
		<cfset LOCAL.retStruct.menu.newArrivals.label ="Men" />
		<cfset LOCAL.retStruct.menu.newArrivals.men = ArrayNew(1) />
		<cfset LOCAL.retStruct.menu.newArrivals.women = ArrayNew(1) />
		<cfset LOCAL.retStruct.menu.newArrivals.recommended = ArrayNew(1) />
		
		<cfset LOCAL.retStruct.menu.newArrivals.label ="Women" />
		<cfset LOCAL.retStruct.menu.deals.onsale = ArrayNew(1) />
		<cfset LOCAL.retStruct.menu.deals.clearance = ArrayNew(1) />
		<cfset LOCAL.retStruct.menu.deals.recommended = ArrayNew(1) />
		
		<cfset LOCAL.retStruct.menu.newArrivals.label ="Products" />
		<cfset LOCAL.retStruct.menu.categories = ArrayNew(1) />
		
		<cfset LOCAL.category = {} />
		<cfset LOCAL.category.label = "" />
		
		<cfset LOCAL.retStruct.menu.blog.label ="Blog" />
		
		<cfset LOCAL.retStruct.menu.more.label ="More" />
		<cfset LOCAL.retStruct.menu.more.links = ArrayNew(1) />
		
		<cfset LOCAL.pageData.specialCategories = EntityLoad("category",{isSpecial = true, isEnabled = true, isDeleted = false},"rank Asc") />
				
		<cfloop array="#LOCAL.pageData.specialCategories#" index="LOCAL.category">
			<cfset LOCAL.newMenuItem = {} />
			<cfset LOCAL.newMenuItem.label = LOCAL.category.getDisplayName() />
			<cfset LOCAL.newMenuItem.link = "" />
			<cfset ArrayAppend(LOCAL.retStruct.menu.specialCategories, LOCAL.newMenuItem) />
		</cfloop>
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>