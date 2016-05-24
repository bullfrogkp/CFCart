<cfcomponent extends="module">	
    <cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.slideSection = "<p><img alt='' src='#APPLICATION.absoluteUrlWeb#images/site/iPhone-7-Concept.jpg' style='height:406px; width:722px'></p>" />
		<cfreturn LOCAL.retStruct />
	</cffunction>
	
	<cffunction name="getBackEndView" access="public" output="false" returnType="string">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.slideSection = "<p>aaa</p>" />
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>