<cfcomponent extends="module">	
    <cffunction name="getFrondEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="getBackEndView" access="public" output="false" returnType="string">
		<cfset var LOCAL = {} />
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfif NOT IsNull(LOCAL.topSellingSection.getSectionData())>
			<cfloop array="#LOCAL.topSellingSection.getSectionData()#" index="LOCAL.sectionProduct">
				<cfif IsNumeric(FORM["top_selling_rank_#LOCAL.sectionProduct.getPageSectionProductId()#"])>
					<cfset LOCAL.sectionProduct.setRank(FORM["top_selling_rank_#LOCAL.sectionProduct.getPageSectionProductId()#"]) />
					<cfset EntitySave(LOCAL.sectionProduct) />
				</cfif>
			</cfloop>
		</cfif>
		
		
		<cfelseif StructKeyExists(FORM,"add_top_selling_product")>
		
			<cfif StructKeyExists(FORM,"top_selling_product_group_id")>			
				<cfloop list="#FORM.top_selling_product_group_id#" index="LOCAL.groupId">
					<cfset LOCAL.productGroup = EntityLoadByPK("product_group",LOCAL.groupId) />
					<cfloop array="#LOCAL.productGroup.getProducts()#" index="LOCAL.product">
						<cfset LOCAL.newSectionProduct = EntityNew("page_section_product") />
						<cfset LOCAL.newSectionProduct.setSection(LOCAL.topSellingSection) />
						<cfset LOCAL.newSectionProduct.setProduct(LOCAL.product) />
						<cfset EntitySave(LOCAL.newSectionProduct) />
					</cfloop>
				</cfloop>
			</cfif>
			
			<cfif IsNumeric(FORM.new_top_selling_product_id)>
				<cfset LOCAL.newProduct = EntityLoadByPK("product",FORM.new_top_selling_product_id) />
				<cfset LOCAL.newSectionProduct = EntityNew("page_section_product") />
				<cfset LOCAL.newSectionProduct.setSection(LOCAL.topSellingSection) />
				<cfset LOCAL.newSectionProduct.setProduct(LOCAL.newProduct) />
				<cfset EntitySave(LOCAL.newSectionProduct) />
			</cfif>
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been added.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?active_tab_id=tab_3" />
		

	<cfelseif StructKeyExists(FORM,"delete_top_selling_product")>
			
			<cfset LOCAL.product = EntityLoadByPK("product",FORM.deleted_top_selling_product_id) />
			<cfset LOCAL.sectionProduct = EntityLoad("page_section_product", {section = LOCAL.topSellingSection, sectionProduct = LOCAL.product}, true) />
			<cfset LOCAL.topSellingSection.removeProduct(LOCAL.sectionProduct) />
			
			<cfset EntitySave(LOCAL.topSellingSection) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?active_tab_id=tab_3" />		
		
		<cfreturn LOCAL />	
	</cffunction>
</cfcomponent>