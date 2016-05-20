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
		
		<cfif NOT IsNull(LOCAL.groupBuyingSection.getSectionData())>
			<cfloop array="#LOCAL.groupBuyingSection.getSectionData()#" index="LOCAL.sectionProduct">
				<cfif IsNumeric(FORM["group_buying_rank_#LOCAL.sectionProduct.getPageSectionProductId()#"])>
					<cfset LOCAL.sectionProduct.setRank(FORM["group_buying_rank_#LOCAL.sectionProduct.getPageSectionProductId()#"]) />
					<cfset EntitySave(LOCAL.sectionProduct) />
				</cfif>
			</cfloop>
		</cfif>
		
		<cfelseif StructKeyExists(FORM,"add_group_buying_product")>
		
			<cfif StructKeyExists(FORM,"group_buying_product_group_id")>			
				<cfloop list="#FORM.group_buying_product_group_id#" index="LOCAL.groupId">
					<cfset LOCAL.productGroup = EntityLoadByPK("product_group",LOCAL.groupId) />
					<cfloop array="#LOCAL.productGroup.getProducts()#" index="LOCAL.product">
						<cfset LOCAL.newSectionProduct = EntityNew("page_section_product") />
						<cfset LOCAL.newSectionProduct.setSection(LOCAL.groupBuyingSection) />
						<cfset LOCAL.newSectionProduct.setProduct(LOCAL.product) />
						<cfset EntitySave(LOCAL.newSectionProduct) />
					</cfloop>
				</cfloop>
			</cfif>
			
			<cfif IsNumeric(FORM.new_group_buying_product_id)>
				<cfset LOCAL.newProduct = EntityLoadByPK("product",FORM.new_group_buying_product_id) />
				<cfset LOCAL.newSectionProduct = EntityNew("page_section_product") />
				<cfset LOCAL.newSectionProduct.setSection(LOCAL.groupBuyingSection) />
				<cfset LOCAL.newSectionProduct.setProduct(LOCAL.newProduct) />
				<cfset EntitySave(LOCAL.newSectionProduct) />
			</cfif>
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been added.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?active_tab_id=tab_4" />
			
		<cfelseif StructKeyExists(FORM,"delete_group_buying_product")>
		
			<cfset LOCAL.product = EntityLoadByPK("product",FORM.deleted_group_buying_product_id) />
			<cfset LOCAL.sectionProduct = EntityLoad("page_section_product", {section = LOCAL.groupBuyingSection, sectionProduct = LOCAL.product}, true) />
			<cfset LOCAL.groupBuyingSection.removeProduct(LOCAL.sectionProduct) />
			
			<cfset EntitySave(LOCAL.groupBuyingSection) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?active_tab_id=tab_4" />
		<cfreturn LOCAL />	
	</cffunction>
</cfcomponent>