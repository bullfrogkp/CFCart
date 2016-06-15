<cfcomponent extends="modules.module">	
    <cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		
		<cfset LOCAL.retStruct.menu = {} />
		<cfset LOCAL.retStruct.menu.section1 = {} />
		<cfset LOCAL.retStruct.menu.section2 = {} />
		<cfset LOCAL.retStruct.menu.section3 = {} />
		<cfset LOCAL.retStruct.menu.section4 = {} />
		<cfset LOCAL.retStruct.menu.section5 = {} />
		<cfset LOCAL.retStruct.menu.specialCategories = ArrayNew(1) />	
		<!---------------------------------------------------------------------------------->
		<cfset LOCAL.retStruct.menu.section1.label ="Men" />
		<cfset LOCAL.retStruct.menu.section1.men = ArrayNew(1) />
		<cfset LOCAL.retStruct.menu.section1.women = ArrayNew(1) />
		<cfset LOCAL.retStruct.menu.section1.recommended = ArrayNew(1) />
		
		<cfset LOCAL.retStruct.menu.section1.label ="Women" />
		<cfset LOCAL.retStruct.menu.section2.onsale = ArrayNew(1) />
		<cfset LOCAL.retStruct.menu.section2.clearance = ArrayNew(1) />
		<cfset LOCAL.retStruct.menu.section2.recommended = ArrayNew(1) />
		<!---------------------------------------------------------------------------------->
		<cfset LOCAL.retStruct.menu.section1.label ="Products" />
		<cfset LOCAL.retStruct.menu.categories = ArrayNew(1) />
		
		<cfset LOCAL.category = {} />
		<cfset LOCAL.category.label = "Clothing" />
		<cfset LOCAL.category.subCategories = ArrayNew(1) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.text = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.text = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.text = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset ArrayAppend(LOCAL.retStruct.menu.categories, LOCAL.category) />
		
		<cfset LOCAL.category = {} />
		<cfset LOCAL.category.label = "Makeup" />
		<cfset LOCAL.category.subCategories = ArrayNew(1) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.text = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.text = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.text = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset ArrayAppend(LOCAL.retStruct.menu.categories, LOCAL.category) />
		
		<cfset LOCAL.category = {} />
		<cfset LOCAL.category.label = "Nutrition" />
		<cfset LOCAL.category.subCategories = ArrayNew(1) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.text = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.text = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.text = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset ArrayAppend(LOCAL.retStruct.menu.categories, LOCAL.category) />
		
		<cfset LOCAL.category = {} />
		<cfset LOCAL.category.label = "Baby" />
		<cfset LOCAL.category.subCategories = ArrayNew(1) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.text = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.text = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.text = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset ArrayAppend(LOCAL.retStruct.menu.categories, LOCAL.category) />
		
		<cfset LOCAL.category = {} />
		<cfset LOCAL.category.label = "Food" />
		<cfset LOCAL.category.subCategories = ArrayNew(1) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.text = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.text = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.text = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset ArrayAppend(LOCAL.retStruct.menu.categories, LOCAL.category) />
		<!---------------------------------------------------------------------------------->
		<cfset LOCAL.retStruct.menu.blog.label = "Blog" />
		<cfset LOCAL.retStruct.menu.blog.blogs = ArrayNew(1) />
		
		<cfset LOCAL.blog = {} />
		<cfset LOCAL.blog.text = "Blog1"/>
		<cfset LOCAL.blog.link = "Blog1"/>
		<cfset ArrayAppend(LOCAL.retStruct.menu.blog.blogs, LOCAL.blog) />
		
		<cfset LOCAL.blog = {} />
		<cfset LOCAL.blog.text = "Blog2"/>
		<cfset LOCAL.blog.link = "Blog2"/>
		<cfset ArrayAppend(LOCAL.retStruct.menu.blog.blogs, LOCAL.blog) />
		
		<cfset LOCAL.blog = {} />
		<cfset LOCAL.blog.text = "Blog3"/>
		<cfset LOCAL.blog.link = "Blog3"/>
		<cfset ArrayAppend(LOCAL.retStruct.menu.blog.blogs, LOCAL.blog) />
		
		<cfset LOCAL.blog = {} />
		<cfset LOCAL.blog.text = "Blog4"/>
		<cfset LOCAL.blog.link = "Blog4"/>
		<cfset ArrayAppend(LOCAL.retStruct.menu.blog.blogs, LOCAL.blog) />
		<!---------------------------------------------------------------------------------->
		<cfset LOCAL.retStruct.menu.more.label ="More" />
		<cfset LOCAL.retStruct.menu.more.links = ArrayNew(1) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.text = "Link1"/>
		<cfset LOCAL.link.link = "Link1"/>
		<cfset ArrayAppend(LOCAL.retStruct.menu.more.links, LOCAL.link) />
		<!---------------------------------------------------------------------------------->
		<cfset LOCAL.specialCategories = EntityLoad("category",{isSpecial = true, isEnabled = true, isDeleted = false},"rank Asc") />
		
		<cfset LOCAL.retStruct.menu.specialCategories = ArrayNew(1) />
				
		<cfloop array="#LOCAL.specialCategories#" index="LOCAL.category">
			<cfset LOCAL.newMenuItem = {} />
			<cfset LOCAL.newMenuItem.label = LOCAL.category.getDisplayName() />
			<cfset LOCAL.newMenuItem.link = "" />
			<cfset ArrayAppend(LOCAL.retStruct.menu.specialCategories, LOCAL.newMenuItem) />
		</cfloop>
		<!---------------------------------------------------------------------------------->
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>