<cfcomponent extends="modules.module">	
    <cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.section1 = {} />
		<cfset LOCAL.retStruct.section2 = {} />
		<cfset LOCAL.retStruct.section3 = {} />
		<cfset LOCAL.retStruct.section4 = {} />
		<cfset LOCAL.retStruct.section5 = {} />
		<cfset LOCAL.retStruct.specialCategories = ArrayNew(1) />	
		<!---------------------------------------------------------------------------------->
		<cfset LOCAL.retStruct.section1.label ="New Arrival" />
		
		<cfset LOCAL.retStruct.section1.subSection1 = ArrayNew(1) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.link = "" />
		<cfset LOCAL.product.text = "Pullover Batwing Sleeve Zigzag" />
		<cfset ArrayAppend(LOCAL.retStruct.section1.subSection1,LOCAL.product) />

		<cfset LOCAL.retStruct.section1.subSection2 = ArrayNew(1) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.link = "" />
		<cfset LOCAL.product.text = "Pullover Batwing Sleeve Zigzag" />
		<cfset ArrayAppend(LOCAL.retStruct.section1.subSection2,LOCAL.product) />
		
		<cfset LOCAL.retStruct.section1.subSection3 = ArrayNew(1) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.link = "" />
		<cfset LOCAL.product.image = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.price = 19.99 />
		<cfset LOCAL.product.text = "Pullover Batwing Sleeve Zigzag" />
		<cfset ArrayAppend(LOCAL.retStruct.section1.subSection3,LOCAL.product) />
		<!---------------------------------------------------------------------------------->
		<cfset LOCAL.retStruct.section2.label ="Deals" />
		
		<cfset LOCAL.retStruct.section2.subSection1 = ArrayNew(1) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.link = "" />
		<cfset LOCAL.product.text = "Pullover Batwing Sleeve Zigzag" />
		<cfset ArrayAppend(LOCAL.retStruct.section2.subSection1,LOCAL.product) />
		
		<cfset LOCAL.retStruct.section2.subSection2 = ArrayNew(1) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.link = "" />
		<cfset LOCAL.product.text = "Pullover Batwing Sleeve Zigzag" />
		<cfset ArrayAppend(LOCAL.retStruct.section2.subSection2,LOCAL.product) />
		
		<cfset LOCAL.retStruct.section2.subSection3 = ArrayNew(1) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.link = "" />
		<cfset LOCAL.product.image = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.currentPrice = 9.99 />
		<cfset LOCAL.product.previousPrice = 19.99 />
		<cfset LOCAL.product.text = "Pullover Batwing Sleeve Zigzag" />
		<cfset ArrayAppend(LOCAL.retStruct.section2.subSection3,LOCAL.product) />
		<!---------------------------------------------------------------------------------->
		<cfset LOCAL.retStruct.section3.label ="Products" />
		<cfset LOCAL.retStruct.categories = ArrayNew(1) />
		
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
		
		<cfset ArrayAppend(LOCAL.retStruct.categories, LOCAL.category) />
		
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
		
		<cfset ArrayAppend(LOCAL.retStruct.categories, LOCAL.category) />
		
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
		
		<cfset ArrayAppend(LOCAL.retStruct.categories, LOCAL.category) />
		
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
		
		<cfset ArrayAppend(LOCAL.retStruct.categories, LOCAL.category) />
		
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
		
		<cfset ArrayAppend(LOCAL.retStruct.categories, LOCAL.category) />
		<!---------------------------------------------------------------------------------->
		<cfset LOCAL.retStruct.blog.label = "Blog" />
		<cfset LOCAL.retStruct.blog.blogs = ArrayNew(1) />
		
		<cfset LOCAL.blog = {} />
		<cfset LOCAL.blog.text = "Blog1"/>
		<cfset LOCAL.blog.link = "Blog1"/>
		<cfset ArrayAppend(LOCAL.retStruct.blog.blogs, LOCAL.blog) />
		
		<cfset LOCAL.blog = {} />
		<cfset LOCAL.blog.text = "Blog2"/>
		<cfset LOCAL.blog.link = "Blog2"/>
		<cfset ArrayAppend(LOCAL.retStruct.blog.blogs, LOCAL.blog) />
		
		<cfset LOCAL.blog = {} />
		<cfset LOCAL.blog.text = "Blog3"/>
		<cfset LOCAL.blog.link = "Blog3"/>
		<cfset ArrayAppend(LOCAL.retStruct.blog.blogs, LOCAL.blog) />
		
		<cfset LOCAL.blog = {} />
		<cfset LOCAL.blog.text = "Blog4"/>
		<cfset LOCAL.blog.link = "Blog4"/>
		<cfset ArrayAppend(LOCAL.retStruct.blog.blogs, LOCAL.blog) />
		<!---------------------------------------------------------------------------------->
		<cfset LOCAL.retStruct.more.label ="More" />
		<cfset LOCAL.retStruct.more.links = ArrayNew(1) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.text = "Link1"/>
		<cfset LOCAL.link.link = "Link1"/>
		<cfset ArrayAppend(LOCAL.retStruct.more.links, LOCAL.link) />
		<!---------------------------------------------------------------------------------->
		<cfset LOCAL.specialCategories = EntityLoad("category",{isSpecial = true, isEnabled = true, isDeleted = false},"rank Asc") />
		
		<cfset LOCAL.retStruct.specialCategories = ArrayNew(1) />
				
		<cfloop array="#LOCAL.specialCategories#" index="LOCAL.category">
			<cfset LOCAL.newMenuItem = {} />
			<cfset LOCAL.newMenuItem.label = LOCAL.category.getDisplayName() />
			<cfset LOCAL.newMenuItem.link = "" />
			<cfset ArrayAppend(LOCAL.retStruct.specialCategories, LOCAL.newMenuItem) />
		</cfloop>
		<!---------------------------------------------------------------------------------->
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>