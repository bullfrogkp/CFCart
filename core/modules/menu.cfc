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
		
		<cfset LOCAL.retStruct.section1.subSection1 = {} />
		<cfset LOCAL.retStruct.section1.subSection1.label = "Men" />
		<cfset LOCAL.retStruct.section1.subSection1.products = ArrayNew(1) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.link = "" />
		<cfset LOCAL.product.label = "Pullover Batwing Sleeve Zigzag" />
		<cfset ArrayAppend(LOCAL.retStruct.section1.subSection1.products,LOCAL.product) />

		<cfset LOCAL.retStruct.section1.subSection2 = {} />
		<cfset LOCAL.retStruct.section1.subSection2.label = "Women" />
		<cfset LOCAL.retStruct.section1.subSection2.products = ArrayNew(1) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.link = "" />
		<cfset LOCAL.product.label = "Pullover Batwing Sleeve Zigzag" />
		<cfset ArrayAppend(LOCAL.retStruct.section1.subSection2.products,LOCAL.product) />
		
		<cfset LOCAL.retStruct.section1.subSection3 ={} />
		<cfset LOCAL.retStruct.section1.subSection3.label = "Recommended Products" />
		<cfset LOCAL.retStruct.section1.subSection3.products = ArrayNew(1) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.link = "" />
		<cfset LOCAL.product.image = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.price = 19.99 />
		<cfset LOCAL.product.label = "Pullover Batwing Sleeve Zigzag" />
		<cfset ArrayAppend(LOCAL.retStruct.section1.subSection3.products,LOCAL.product) />
		
		<cfset LOCAL.retStruct.section1.subSection4 ={} />
		<cfset LOCAL.retStruct.section1.subSection4.links = ArrayNew(1) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.href = "" />
		<cfset LOCAL.link.label = "Blazers" />
		<cfset ArrayAppend(LOCAL.retStruct.subSection4.links,LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.href = "" />
		<cfset LOCAL.link.label = "Jackets" />
		<cfset ArrayAppend(LOCAL.retStruct.subSection4.links,LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.href = "" />
		<cfset LOCAL.link.label = "Shoes" />
		<cfset ArrayAppend(LOCAL.retStruct.subSection4.links,LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.href = "" />
		<cfset LOCAL.link.label = "Bags" />
		<cfset ArrayAppend(LOCAL.retStruct.subSection4.links,LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.href = "" />
		<cfset LOCAL.link.label = "Special offers" />
		<cfset ArrayAppend(LOCAL.retStruct.subSection4.links,LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.href = "" />
		<cfset LOCAL.link.label = "Sales and discounts" />
		<cfset ArrayAppend(LOCAL.retStruct.subSection4.links,LOCAL.link) />
		
		<cfset LOCAL.retStruct.section1.subSection5 ={} />
		<cfset LOCAL.retStruct.section1.subSection5.message = "-20% sale only this week. Don’t miss buy something!" />
		<!---------------------------------------------------------------------------------->
		<cfset LOCAL.retStruct.section2.label ="Deals" />
		
		<cfset LOCAL.retStruct.section2.subSection1 = ArrayNew(1) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.link = "" />
		<cfset LOCAL.product.label = "Pullover Batwing Sleeve Zigzag" />
		<cfset ArrayAppend(LOCAL.retStruct.section2.subSection1,LOCAL.product) />
		
		<cfset LOCAL.retStruct.section2.subSection2 = ArrayNew(1) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.link = "" />
		<cfset LOCAL.product.label = "Pullover Batwing Sleeve Zigzag" />
		<cfset ArrayAppend(LOCAL.retStruct.section2.subSection2,LOCAL.product) />
		
		<cfset LOCAL.retStruct.section2.subSection3 = ArrayNew(1) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.link = "" />
		<cfset LOCAL.product.image = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.currentPrice = 9.99 />
		<cfset LOCAL.product.previousPrice = 19.99 />
		<cfset LOCAL.product.label = "Pullover Batwing Sleeve Zigzag" />
		<cfset ArrayAppend(LOCAL.retStruct.section2.subSection3,LOCAL.product) />
		<!---------------------------------------------------------------------------------->
		<cfset LOCAL.retStruct.section3.label ="Products" />
		<cfset LOCAL.retStruct.categories = ArrayNew(1) />
		
		<cfset LOCAL.category = {} />
		<cfset LOCAL.category.label = "Clothing" />
		<cfset LOCAL.category.subCategories = ArrayNew(1) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.label = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.label = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.label = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset ArrayAppend(LOCAL.retStruct.categories, LOCAL.category) />
		
		<cfset LOCAL.category = {} />
		<cfset LOCAL.category.label = "Makeup" />
		<cfset LOCAL.category.subCategories = ArrayNew(1) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.label = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.label = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.label = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset ArrayAppend(LOCAL.retStruct.categories, LOCAL.category) />
		
		<cfset LOCAL.category = {} />
		<cfset LOCAL.category.label = "Nutrition" />
		<cfset LOCAL.category.subCategories = ArrayNew(1) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.label = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.label = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.label = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset ArrayAppend(LOCAL.retStruct.categories, LOCAL.category) />
		
		<cfset LOCAL.category = {} />
		<cfset LOCAL.category.label = "Baby" />
		<cfset LOCAL.category.subCategories = ArrayNew(1) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.label = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.label = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.label = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset ArrayAppend(LOCAL.retStruct.categories, LOCAL.category) />
		
		<cfset LOCAL.category = {} />
		<cfset LOCAL.category.label = "Food" />
		<cfset LOCAL.category.subCategories = ArrayNew(1) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.label = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.label = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset LOCAL.subCategory = {} />
		<cfset LOCAL.subCategory.label = "Cate1"/>
		<cfset LOCAL.subCategory.link = "Cate1"/>
		<cfset ArrayAppend(LOCAL.category.subCategories, LOCAL.subCategory) />
		
		<cfset ArrayAppend(LOCAL.retStruct.categories, LOCAL.category) />
		<!---------------------------------------------------------------------------------->
		<cfset LOCAL.retStruct.blog.label = "Blog" />
		<cfset LOCAL.retStruct.blog.blogs = ArrayNew(1) />
		
		<cfset LOCAL.blog = {} />
		<cfset LOCAL.blog.label = "Blog1"/>
		<cfset LOCAL.blog.link = "Blog1"/>
		<cfset ArrayAppend(LOCAL.retStruct.blog.blogs, LOCAL.blog) />
		
		<cfset LOCAL.blog = {} />
		<cfset LOCAL.blog.label = "Blog2"/>
		<cfset LOCAL.blog.link = "Blog2"/>
		<cfset ArrayAppend(LOCAL.retStruct.blog.blogs, LOCAL.blog) />
		
		<cfset LOCAL.blog = {} />
		<cfset LOCAL.blog.label = "Blog3"/>
		<cfset LOCAL.blog.link = "Blog3"/>
		<cfset ArrayAppend(LOCAL.retStruct.blog.blogs, LOCAL.blog) />
		
		<cfset LOCAL.blog = {} />
		<cfset LOCAL.blog.label = "Blog4"/>
		<cfset LOCAL.blog.link = "Blog4"/>
		<cfset ArrayAppend(LOCAL.retStruct.blog.blogs, LOCAL.blog) />
		<!---------------------------------------------------------------------------------->
		<cfset LOCAL.retStruct.more.label ="More" />
		<cfset LOCAL.retStruct.more.links = ArrayNew(1) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.label = "Link1"/>
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