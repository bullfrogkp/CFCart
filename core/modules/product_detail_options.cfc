<cfcomponent extends="modules.module">	
    <cffunction name="getFrontendView" access="public" output="false" returnType="string">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retVal = '<div class="color-selector detail-info-entry">
					<div class="detail-info-entry-title">Color</div>
					<div class="entry active" style="background-color: ##d23118;">&nbsp;</div>
					<div class="entry" style="background-color: ##2a84c9;">&nbsp;</div>
					<div class="entry" style="background-color: ##000;">&nbsp;</div>
					<div class="entry" style="background-color: ##d1d1d1;">&nbsp;</div>
					<div class="spacer"></div>
				</div><div class="size-selector detail-info-entry">
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