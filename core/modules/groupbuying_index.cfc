<cfcomponent extends="module">	
    <cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.products = '<li class="single-products">
									<a href="/product_detail.cfm/Expansion%20Pack%20for%20N64/32">
										<img class="thumbnail-img" src="http://demo.fusioncloud.ca/images/uploads/product/32/small_expansion Pack N641.jpg">
									</a>
									<div class="thumbnail-name"><a href="/product_detail.cfm/Expansion%20Pack%20for%20N64/32">Expansion Pack for N64</a></div>
									<div class="thumbnail-price">$35.00</div>
									
									<div class="product-overlay">
										<div class="overlay-content">
											<div class="thumbnail-rating"></div>
											<div class="thumbnail-review"><a href="/product_detail.cfm/Expansion%20Pack%20for%20N64/32">(0 Reviews)</a></div>
											<div class="thumbnail-cart"><a class="btn add-to-cart" style="padding-right:13px;">Add to cart</a></div>
										</div>
									</div>
								</li>
							
								<li class="single-products">
									<a href="/product_detail.cfm/EMS%20Passport%20Plus%20III%20for%20N64/33">
										<img class="thumbnail-img" src="http://demo.fusioncloud.ca/images/uploads/product/33/small_EMS N64 Passport plus III1.jpg">
									</a>
									<div class="thumbnail-name"><a href="/product_detail.cfm/EMS%20Passport%20Plus%20III%20for%20N64/33">EMS Passport Plus III for N64</a></div>
									<div class="thumbnail-price">$40.00</div>
									
									<div class="product-overlay">
										<div class="overlay-content">
											<div class="thumbnail-rating"></div>
											<div class="thumbnail-review"><a href="/product_detail.cfm/EMS%20Passport%20Plus%20III%20for%20N64/33">(0 Reviews)</a></div>
											<div class="thumbnail-cart"><a class="btn add-to-cart" style="padding-right:13px;">Add to cart</a></div>
										</div>
									</div>
								</li>' />
		<cfreturn LOCAL.retStruct />
	</cffunction>
	
	<cffunction name="getBackEndView" access="public" output="false" returnType="string">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.slideSection = "<p>aaa</p>" />
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>