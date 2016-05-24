<cfcomponent extends="module">	
    <cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.ads = '<a href="">
						<img src="http://demo.fusioncloud.ca/images/uploads/advertise/ad1.jpg" style="width:100%;border:1px solid ##CCC">
					</a>
					
					<a href="">
						<img src="http://demo.fusioncloud.ca/images/uploads/advertise/ads3.jpg" style="width:100%;border:1px solid ##CCC">
					</a>
					
					<a href="">
						<img src="http://demo.fusioncloud.ca/images/uploads/advertise/ads5.jpg" style="width:100%;border:1px solid ##CCC">
					</a>
					
					<a href="">
						<img src="http://demo.fusioncloud.ca/images/uploads/advertise/ads2.jpg" style="width:100%;border:1px solid ##CCC">
					</a>
					
					<a href="">
						<img src="http://demo.fusioncloud.ca/images/uploads/advertise/ads4.jpg" style="width:100%;border:1px solid ##CCC">
					</a>' />
		<cfreturn LOCAL.retStruct />
	</cffunction>
	
	<cffunction name="getBackEndView" access="public" output="false" returnType="string">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.slideSection = "<p>aaa</p>" />
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>