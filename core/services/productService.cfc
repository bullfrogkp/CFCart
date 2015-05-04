<cfcomponent extends="service" output="false" accessors="true">
    <cfproperty name="attributeSetId" type="numeric"> 
    <cfproperty name="parentProductId" type="numeric"> 
    <cfproperty name="categoryId" type="numeric"> 

	<cffunction name="_getQuery" output="false" access="private" returntype="array">
		<cfargument name="getCount" type="boolean" required="false" default="false" />
		<cfset LOCAL = {} />
		
		<cfif ARGUMENTS.getCount EQ false>
			<cfset LOCAL.ormOptions = getPaginationStruct() />
		<cfelse>
			<cfset LOCAL.ormOptions = {} />
		</cfif>
	   
		<cfquery name="LOCAL.query" ormoptions="#LOCAL.ormOptions#" dbtype="hql">	
			<cfif ARGUMENTS.getCount EQ true>
			SELECT COUNT(p.productId) 
			</cfif>
			FROM product p
			WHERE 1=1
			<cfif getSearchKeywords() NEQ "">	
			AND	(p.displayName like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" /> OR keywords like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" /> OR description like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" />)
			</cfif>
			<cfif NOT IsNull(getId())>
			AND p.productId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />
			</cfif>
			<cfif NOT IsNull(getIsEnabled())>
			AND p.isEnabled = <cfqueryparam cfsqltype="cf_sql_bit" value="#getIsEnabled()#" />
			</cfif>
			<cfif NOT IsNull(getIsDeleted())>
			AND p.isDeleted = <cfqueryparam cfsqltype="cf_sql_bit" value="#getIsDeleted()#" />
			</cfif>
			<cfif NOT IsNull(getCategoryId())>
			AND	EXISTS (FROM  p.categories c WHERE c.categoryId =	<cfqueryparam cfsqltype="cf_sql_integer" value="#getCategoryId()#" />)
			</cfif>
		</cfquery>

		<cfreturn LOCAL.query />
    </cffunction>
	
	<cffunction name="getCustomerGroupPrices" output="false" access="public" returntype="query">
		<cfset var LOCAL = {} />
			   
	    <cfquery name="LOCAL.getProductGroupPrices">
			SELECT	cg.customer_group_id AS customerGroupId
			,		cg.display_name AS groupDisplayName
			,		(	SELECT	pcgr.product_customer_group_rela_id
						FROM	product_customer_group_rela pcgr
						WHERE 	pcgr.product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />
						AND 	cg.customer_group_id = pcgr.customer_group_id) AS productCustomerGroupRelaId
			FROM	customer_group cg 
			ORDER BY cg.is_default DESC, cg.display_name
		</cfquery>
 
		<cfreturn LOCAL.getProductGroupPrices />
    </cffunction>
	
	<cffunction name="isProductAttributeComplete" output="false" access="public" returntype="boolean">
		<cfset var LOCAL = {} />
	   
		<cfset LOCAL.retValue = true />
		
		<cfset LOCAL.product = EntityLoadByPK("product",getId()) />
		
		<cfloop array="#LOCAL.product.getAttributeSet().getAttributeSetAttributeRelas()#" index="LOCAL.attributeSetAttributeRela">
			<cfif LOCAL.attributeSetAttributeRela.getRequired() EQ true>
				<cfset LOCAL.attribute = LOCAL.attributeSetAttributeRela.getAttribute() />
				<cfset LOCAL.productAttributeRela = EntityLoad("product_attribute_rela",{product=LOCAL.product,attribute=LOCAL.attribute},true) />
				<cfif IsNull(LOCAL.productAttributeRela) OR ArrayIsEmpty(LOCAL.productAttributeRela.getAttributeValues())>
					<cfset LOCAL.retValue = false />
					<cfbreak />
				</cfif>
			</cfif>
		</cfloop>
 
		<cfreturn LOCAL.retValue />
    </cffunction>
	
	<cffunction name="getProductShippingMethods" output="false" access="public" returntype="query">
		<cfset var LOCAL = {} />
	   
		<cfquery name="LOCAL.getProductShippingMethods">
			SELECT		sc.display_name AS shipping_carrier_name
			,			sc.image_name
			,			sm.display_name AS shipping_method_name
			,			sm.shipping_method_id
			,			(
							SELECT	product_shipping_method_rela_id 
							FROM 	product_shipping_method_rela psmr
							WHERE 	psmr.product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />	
							AND		psmr.shipping_method_id = sm.shipping_method_id
						) AS product_shipping_method_rela_id
			FROM		shipping_carrier sc
			JOIN		shipping_method sm ON sc.shipping_carrier_id = sm.shipping_carrier_id
			ORDER BY	sc.shipping_carrier_id
		</cfquery>
		 
		<cfreturn LOCAL.getProductShippingMethods />
    </cffunction>
	
</cfcomponent>