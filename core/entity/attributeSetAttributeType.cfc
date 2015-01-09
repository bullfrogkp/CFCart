<cfcomponent output="false" accessors="true">

    <cfproperty name="productId" type="integer" />
    <cfproperty name="categoryId" type="integer" />
    <cfproperty name="atributeSetId" type="integer" />
    <cfproperty name="productName" type="string" />
    <cfproperty name="productDisplayName" type="string" />
    <cfproperty name="user" type="string" />

    <cffunction name="init" output="false">
       <cfreturn this>
    </cffunction>

    <cffunction name="save" output="false" returntype="integer">
		<cfset var productId = "" />
		
		<cfif IsNumeric(this.getProductId())>
			<cfset productId = _addProduct() />
		<cfelse>
			<cfset productId = _updateProduct() /> 
		</cfif>
		
		<cfreturn productId />
    </cffunction>
	
	<cffunction name="_addProduct" output="false" returntype="integer">
		
		<cfquery name="LOCAL.addProduct"/>
			INSERT INTO products
			(
			
			)
		</cfquery>
		
		<cfreturn productId />
    </cffunction>
	
	<cffunction name="_updateProduct" output="false" returntype="integer">
		
		<cfquery name="LOCAL.addProduct"/>
			UPDATE products
			(
			
			)
		</cfquery>
		
		<cfreturn productId />
    </cffunction>
	
</cfcomponent>