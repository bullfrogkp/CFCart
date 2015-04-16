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
			SELECT COUNT(productId) 
			</cfif>
			FROM product 
			WHERE 1=1
			<cfif getSearchKeywords() NEQ "">	
			AND	(displayName like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" /> OR keywords like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" /> OR description like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" />)
			</cfif>
			<cfif NOT IsNull(getId())>
			AND productId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />
			</cfif>
			<cfif NOT IsNull(getIsEnabled())>
			AND isEnabled = <cfqueryparam cfsqltype="cf_sql_bit" value="#getIsEnabled()#" />
			</cfif>
			<cfif NOT IsNull(getIsDeleted())>
			AND isDeleted = <cfqueryparam cfsqltype="cf_sql_bit" value="#getIsDeleted()#" />
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
	   
		<cfquery name="LOCAL.getAttributes">
			SELECT	attr.attribute_id
			FROM	attribute attr
			JOIN	attribute_set_attribute_rela asar ON asar.attribute_id = attr.attribute_id
			WHERE	asar.attribute_set_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getAttributeSetId()#" /> 
			AND		asar.required = <cfqueryparam cfsqltype="cf_sql_bit" value="1" />
		</cfquery>
		
		<cfquery name="LOCAL.getAttributeValues">
			SELECT	DISTINCT attribute_id
			FROM	product_attribute_rela
			WHERE	product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />
		</cfquery>

		<cfif Find(ListSort(ValueList(LOCAL.getAttributes.attribute_id),"numeric"),ListSort(ValueList(LOCAL.getAttributeValues.attribute_id),"numeric"))>
			<cfset LOCAL.retValue = true />
		<cfelse>
			<cfset LOCAL.retValue = false />
		</cfif>
 
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