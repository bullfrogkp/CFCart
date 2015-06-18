<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productId" column="product_id" fieldtype="id" generator="native">
	<cfproperty name="sku" column="sku" ormtype="string"> 
	<cfproperty name="title" column="title" ormtype="string"> 
	<cfproperty name="keywords" column="keywords" ormtype="string"> 
	<cfproperty name="stock" column="stock" ormtype="integer"> 
	<cfproperty name="detail" column="detail" ormtype="text"> 
	<cfproperty name="length" column="length" ormtype="float"> 
	<cfproperty name="width" column="width" ormtype="float"> 
	<cfproperty name="height" column="height" ormtype="float"> 
	<cfproperty name="weight" column="weight" ormtype="float"> 
	<cfproperty name="attributeSet" fieldtype="many-to-one" cfc="attribute_set" fkcolumn="attribute_set_id">
	<cfproperty name="taxCategory" fieldtype="many-to-one" cfc="tax_category" fkcolumn="tax_category_id">
	<cfproperty name="productAttributeRelas" type="array" fieldtype="one-to-many" cfc="product_attribute_rela" fkcolumn="product_id" singularname="productAttributeRela" cascade="delete-orphan">
	<cfproperty name="productVideos" type="array" fieldtype="one-to-many" cfc="product_video" fkcolumn="product_id" singularname="productVideo" cascade="delete-orphan">
	<cfproperty name="parentProduct" fieldtype="many-to-one" cfc="product" fkcolumn="parent_product_id">
	<cfproperty name="subProducts" type="array" fieldtype="one-to-many" cfc="product" fkcolumn="parent_product_id" singularname="subProduct" cascade="delete-orphan">
	<cfproperty name="reviews" type="array" fieldtype="one-to-many" cfc="review" fkcolumn="product_id" singularname="review" cascade="delete-orphan">
	<cfproperty name="images" type="array" fieldtype="one-to-many" cfc="product_image" fkcolumn="product_id" singularname="image" cascade="delete-orphan" orderby="rank">
	<cfproperty name="productCustomerGroupRelas" type="array" fieldtype="one-to-many" cfc="product_customer_group_rela" fkcolumn="product_id" singularname="productCustomerGroupRela" cascade="delete-orphan">
	<cfproperty name="productShippingMethodRelas" type="array" fieldtype="one-to-many" cfc="product_shipping_method_rela" fkcolumn="product_id" singularname="productShippingMethodRela" cascade="delete-orphan">
	<cfproperty name="categories" fieldtype="many-to-many" cfc="category" linktable="category_product_rela" fkcolumn="product_id" inversejoincolumn="category_id" singularname="category">
	<cfproperty name="relatedProducts" fieldtype="many-to-many" cfc="product" linktable="related_product_rela" fkcolumn="product_id" inversejoincolumn="related_parent_product_id" singularname="relatedProduct">
	<cfproperty name="relatedParentProducts" fieldtype="many-to-many" cfc="product" linktable="related_product_rela" fkcolumn="related_parent_product_id" inversejoincolumn="product_id" singularname="relatedParentProduct">
	<cfproperty name="searchKeyword" type="string" persistent="false"> 
		
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeAllCategories" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getCategories())>
			<cfset ArrayClear(getCategories()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeSubProducts" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getSubProducts())>
			<cfset ArrayClear(getSubProducts()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeProductAttributeRelas" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getProductAttributeRelas())>
			<cfset ArrayClear(getProductAttributeRelas()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeProductShippingMethodRelas" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getProductShippingMethodRelas())>
			<cfset ArrayClear(getProductShippingMethodRelas()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getPrice" access="public" output="false" returnType="string">
		<cfargument name="customerGroupName" type="string" required="true">
		
		<cfset var customerGroup = EntityLoad("customer_group",{name = ARGUMENTS.customerGroupName},true) />
		<cfset var product = EntityLoadByPK("product",getProductId()) />
		<cfset var productCustomeGroupRela = EntityLoad("product_customer_group_rela",{customerGroup=customerGroup,product=product},true) />
		<cfset var price = 0 />
		
		<cfif NOT IsNull(productCustomeGroupRela)>
			<cfif IsNumeric(productCustomeGroupRela.getSpecialPrice())>
				<cfif IsDate(productCustomeGroupRela.getSpecialPriceFromDate()) AND IsDate(productCustomeGroupRela.getSpecialPriceToDate())>
					<cfif 	DateCompare(productCustomeGroupRela.getSpecialPriceFromDate(), DateFormat(Now())) LTE 0
							AND
							DateCompare(DateFormat(Now()), productCustomeGroupRela.getSpecialPriceToDate()) LTE 0>
						<cfset price = productCustomeGroupRela.getSpecialPrice() />
					<cfelse>
						<cfset price = productCustomeGroupRela.getPrice() />
					</cfif>
				<cfelseif IsDate(productCustomeGroupRela.getSpecialPriceFromDate())>
					<cfif DateCompare(productCustomeGroupRela.getSpecialPriceFromDate(), DateFormat(Now())) LTE 0>
						<cfset price = productCustomeGroupRela.getSpecialPrice() />
					<cfelse>
						<cfset price = productCustomeGroupRela.getPrice() />
					</cfif>
				<cfelseif IsDate(productCustomeGroupRela.getSpecialPriceToDate())>
					<cfif 	DateCompare(DateFormat(Now()), productCustomeGroupRela.getSpecialPriceToDate()) LTE 0>
						<cfset price = productCustomeGroupRela.getSpecialPrice() />
					<cfelse>
						<cfset price = productCustomeGroupRela.getPrice() />
					</cfif>
				<cfelse>
					<cfset price = productCustomeGroupRela.getPrice() />
				</cfif>
			<cfelse>
				<cfset price = productCustomeGroupRela.getPrice() />
			</cfif>
		</cfif>
		
		<cfreturn NumberFormat(price,"0.00") />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDefaultImageLink" access="public" output="false" returnType="string">
		<cfargument name="type" type="string" required="false" default="" />
		
		<cfset var imageType = "" />
		<cfif Trim(ARGUMENTS.type) NEQ "">
			<cfset imageType = "#Trim(ARGUMENTS.type)#_" />
		</cfif>
		
		<cfset var imageLink = "" />
		<cfset var productImg = EntityLoad("product_image",{product = this, isDefault = true},true) />
		
		<cfif IsNull(productImg)>
			<cfif NOT IsNull(getImages()) AND ArrayLen(getImages()) GT 0>
				<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/uploads/product/#getProductId()#/#imageType##getImages()[1].getName()#" />
			<cfelse>
				<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/site/no_image_available.png" />
			</cfif>
		<cfelse>
			<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/uploads/product/#getProductId()#/#imageType##productImg.getName()#" />
		</cfif>
		
		<cfreturn imageLink />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="isFreeShipping" access="public" output="false" returnType="boolean">
		<cfset var LOCAL = {} />
		<cfset var retValue = false />
		
		<cfquery name="LOCAL.checkFreeShipping">
			SELECT	1
			FROM	product_shipping_method_rela psmr
			JOIN	shipping_method sm ON psmr.shipping_method_id = sm.shipping_method_id
			WHERE	sm.name = 'chinapost'
			AND		psmr.product_id = #getProductId()#
		</cfquery>
		
		<cfif LOCAL.checkFreeShipping.recordCount GT 0>
			<cfset retValue = true />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDetailPageURL" access="public" output="false" returnType="string">
		<cfset var pageUrl = "" />
		<cfset pageUrl = "#APPLICATION.absoluteUrlWeb#product_detail.cfm/#URLEncodedFormat(getDisplayName())#/#getProductId()#" />
		<cfreturn pageUrl />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getTaxRate" access="public" output="false" returnType="string">
		<cfargument name="provinceId" type="numeric" required="true" />
				
		<cfset var tax = EntityLoad("tax",{province=EntityLoadByPK("province",ARGUMENTS.provinceId), taxCategory=getTaxCategory()},true) />
		
		<cfreturn tax.getRate() />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getShippingFee" access="public" output="false" returnType="numeric">
		<cfargument name="address" type="struct" required="true" />
		<cfargument name="shippingMethodId" type="numeric" required="true" />
		<cfargument name="customerGroupName" type="string" required="true" />
		
		<cfset var LOCAL = {} />
		
		<cfif NOT IsNull(getWeight())>
			<cfset LOCAL.shippingMethod = EntityLoadByPK("shipping_method",ARGUMENTS.shippingMethodId) />
			<cfset LOCAL.componentName = LOCAL.shippingMethod.getShippingCarrier().getComponent() />
		
			<cfset LOCAL.shippingComponent = new "#APPLICATION.componentPathRoot#core.shipping.#LOCAL.componentName#"() />
						
			<cfset LOCAL.shippingComponent.setShippingMethodId(ARGUMENTS.shippingMethodId) />
			<cfset LOCAL.shippingComponent.setAddress(ARGUMENTS.address) />
			<cfset LOCAL.shippingComponent.setProductId(LOCAL.productId) />
			
			<cfset LOCAL.shippingFee = LOCAL.shippingComponent.getShippingFee() />
		<cfelse>
			<cfset LOCAL.shippingFee = getPrice(customerGroupName = ARGUMENTS.customerGroupName) />
		</cfif>
		
		<cfreturn NumberFormat(LOCAL.shippingFee,"0.00") />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="isProductAttributeComplete" output="false" access="public" returntype="boolean">
		<cfset var LOCAL = {} />
	   
		<cfset LOCAL.retValue = true />
		
		<cfif IsNull(getAttributeSet())>
			<cfset LOCAL.retValue = false />
		<cfelse>
			<cfloop array="#getAttributeSet().getAttributeSetAttributeRelas()#" index="LOCAL.attributeSetAttributeRela">
				<cfif LOCAL.attributeSetAttributeRela.getRequired() EQ true>
					<cfset LOCAL.attribute = LOCAL.attributeSetAttributeRela.getAttribute() />
					<cfset LOCAL.productAttributeRela = EntityLoad("product_attribute_rela", {product=this,attribute=LOCAL.attribute, required=true},true) />
					<cfif IsNull(LOCAL.productAttributeRela) OR ArrayIsEmpty(LOCAL.productAttributeRela.getAttributeValues())>
						<cfset LOCAL.retValue = false />
						<cfbreak />
					</cfif>
				</cfif>
			</cfloop>
		</cfif>
		
		<cfreturn LOCAL.retValue />
		<!------------------------------------------------------------------------------->	
    </cffunction>
</cfcomponent>
