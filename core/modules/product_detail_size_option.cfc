<cfcomponent extends="modules.module">	
    <cffunction name="getFrontendView" access="public" output="false" returnType="string">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retVal = '<div class="size-selector detail-info-entry">
					<div class="detail-info-entry-title">Size</div>
					<div class="entry active">xs</div>
					<div class="entry">s</div>
					<div class="entry">m</div>
					<div class="entry">l</div>
					<div class="entry">xl</div>
					<div class="spacer"></div>
				</div>' />
		
		<cfreturn LOCAL.retVal />
	</cffunction>
</cfcomponent>