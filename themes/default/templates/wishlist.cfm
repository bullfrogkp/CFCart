<cfoutput>

<div id="slide-div" style="width:712px;float:right;">
	<div id="breadcrumb">
		<div class="breadcrumb-home-icon"></div>
		<div class="breadcrumb-arrow-icon"></div>
		<span style="vertical-align:middle">
			Wishlist
		</span> 
	</div>
	
	<h1>Wishlist</h1> 
	
	<div class="cat-thumbnails" style="margin-top:10px;">
		<div class="cat-thumbnail-section" style="border-top:none;">
			<ul class="rig columns-4">
				<cfloop array="#REQUEST.pageData.paginationInfo.records#" index="product">
					<li class="single-products">
						<a href="#product.getDetailPageURL()#">
							<img class="thumbnail-img" src="#product.getDefaultImageLink(type='small')#" />
						</a>
						<div class="thumbnail-name"><a href="#product.getDetailPageURL()#">#product.getDisplayName()#</a></div>
						<div class="thumbnail-price">#DollarFormat(product.getPrice(customerGroupName = SESSION.user.customerGroupName))#</div>
						<cfif product.isFreeShipping()>
						<img class="free-shipping-icon" src="#APPLICATION.absoluteUrlWeb#images/freeshipping.jpg" style="width:120px;margin-top:7px;" />
						</cfif>
						<div class="product-overlay">
							<div class="overlay-content">
								<div class="thumbnail-rating"></div>
								<div class="thumbnail-review"><a href="#product.getDetailPageURL()#">(#ArrayLen(product.getReviews())# Reviews)</a></div>
								<div class="thumbnail-cart"><a class="btn add-to-cart" style="padding-right:13px;">Add to cart</a></div>
							</div>
						</div>
					</li>
				</cfloop>
			</ul>
		</div>
	</div>
</div>
<div id="top-sidebar">
	<div id="all-categories">
		<ul>
		<li>
		<span id="all-category-text">All Categories</span>
		<img src="#SESSION.absoluteUrlTheme#images/arrow_down.png" style="float:right;margin-right:10px;margin-top:-5px;width:28px;" />
		<div id="sidenav">
			<ul>
				<cfloop from="1" to="#ArrayLen(REQUEST.pageData.categoryTree)#" index="i">
					<cfset cat = REQUEST.pageData.categoryTree[i] />
					<li class="<cfif ArrayLen(cat.getSubCategories()) NEQ 0>has-sub-menu</cfif> first-level-menu" <cfif i EQ 1>style="margin-top:6px;<cfelseif i EQ ArrayLen(REQUEST.pageData.categoryTree)>style="margin-bottom:6px;</cfif>">
						<a href="#cat.getDetailPageURL()#">#cat.getDisplayName()#</a>
						<cfif ArrayLen(cat.getSubCategories()) NEQ 0>
							<div class="cat-submenu">
								<div style="z-index:1;position: relative;">
									<cfloop array="#cat.getSubCategories()#" index="subCat">
										<dl>
											<div class="clear"></div>
											<dt><a href="#subCat.getDetailPageURL()#">#subCat.getDisplayName()#</a></dt>
											<cfloop array="#subCat.getSubCategories()#" index="thirdCat">
												<dd><a href="#thirdCat.getDetailPageURL()#">#thirdCat.getDisplayName()#</a></dd>
											</cfloop>
										</dl>
									</cfloop>
									<div class="clear"></div>
								</div>
							</div>
						</cfif>
					</li>
				</cfloop>
			</ul>
		</div>
		</li>
		</ul>
	</div>
</div>
</cfoutput>
