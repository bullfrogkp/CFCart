<cfcomponent extends="shipping" output="false" accessors="true">
	<!------------------------------------------------------------------------------->
	<cffunction name="_parseResponse" access="private" returntype="struct">
		<cfargument name="response" type="any" required="true">
	
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfdump var="#response#" abort>
		<cfset LOCAL.retStruct.rate = ARGUMENTS.response["RatingServiceSelectionResponse"]["RatedShipment"]["TotalCharges"]["MonetaryValue"].xmlText />
		
		<cfreturn LOCAL.retStruct>
	</cffunction>	
	<!------------------------------------------------------------------------------->	
	<cffunction name="_createShippingRateXml" displayname="Create XML Documents" description="Creates the XML needed to send to UPS" access="private" output="false" returntype="Any">
		<cfargument name="fromAddress" type="struct" required="true">
		<cfargument name="toAddress" type="struct" required="true">
		<cfargument name="serviceCode" type="string" required="true">
		
		<cfset var LOCAL = {} />
		
		<cfsavecontent variable="LOCAL.xmlShippingData">
			<?xml version="1.0"?>
			
				<mailing-scenario>
					<parcel-characteristics>
						<weight>0.9</weight>
					</parcel-characteristics>
					<services>
						<service-code>DOM.XP</service-code>
					</services>
					<origin-postal-code>L4S2S1</origin-postal-code>
					<destination>
						<domestic>
							<postal-code>M2M4M6</postal-code>
						</domestic>
					</destination>
				</mailing-scenario>
			
		</cfsavecontent>	
		<cfreturn LOCAL.xmlShippingData>
	</cffunction>
	<!------------------------------------------------------------------------------->
</cfcomponent>