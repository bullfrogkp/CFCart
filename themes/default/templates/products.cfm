<cfoutput>

<div id="slide-div" style="width:712px;float:right;">
	<div id="breadcrumb">
		<div class="breadcrumb-home-icon"></div>
		<cfloop array="#REQUEST.pageData.categoryArray#" index="category">
			<div class="breadcrumb-arrow-icon"></div>
			<span style="vertical-align:middle">
				<a href="#category.getDetailPageUrl()#">
				#category.getDisplayName()#
				</a>
			</span> 
		</cfloop>
	</div>
	
	<div style="border:1px solid ##CCC;width:692px;padding:10px;">
		<h1 style="border-bottom:1px solid ##CCC;padding-bottom:10px;">Keyboards <span style="font-size:12px;">(#ArrayLen(REQUEST.pageData.paginationInfo.records)# total)</span></h1> 
		
		<cfif NOT ArrayIsEmpty(REQUEST.pageData.category.getCategoryFilterRelas())>
			<table id="filters">
				<cfloop array="#REQUEST.pageData.category.getCategoryFilterRelas()#" index="categoryFilterRela">
					<cfset filter = categoryFilterRela.getFilter() />
					<tr>
						<td>#filter.getDisplayName()#:</td>
						<td>
							<ul>
								<cfif NOT IsNull(categoryFilterRela.getFilterValues())>
									<cfloop array="#categoryFilterRela.getFilterValues()#" index="filterValue">
										<li class="filter-value <cfif REQUEST.pageData.activeFilterValueIdList NEQ 0 AND ListFind(REQUEST.pageData.activeFilterValueIdList,filterValue.getFilterValueId())>active-filter</cfif>"
										<cfif filter.getDisplayName() EQ "color">style="background-color:#filterValue.getValue()#;border:1px solid ##ccc;width:20px;height:20px;"</cfif>
										>
										
										<cfif filter.getDisplayName() EQ "color">
											#filterValue.getValue()#
										<cfelse>
											#filterValue.getDisplayName()#
										</cfif>
										
										</li>
									</cfloop>
								</cfif>
							</ul>
						</td>
					</tr>
				</cfloop>
			</table>
		</cfif>
	</div>
	
	<div id="sort-by">
		<ul>
			<li style="border:none;margin-left:0;padding:left:0;">Sort By:</li>
			<li>Reviews</li>
			<li>Top Selling</li>
			<li>Price</li>
			<li>New Arrivals</li>
		</ul>
	</div>
	<div id="pages">
		<ul>
			<li style="">1</li>
			<li>2</li>
			<li>3</li>
			<li>4</li>
			<li>5</li>
			<li>></li>
			<li>>></li>
		</ul>
	</div>
	<div class="clear"></div>
	
	<div class="cat-thumbnails" style="margin-top:10px;">
		<div class="cat-thumbnail-section" style="border-top:none;">
			<ul class="rig columns-4">
				<cfloop array="#REQUEST.pageData.category.getProducts()#" index="product">
					<li class="single-products">
						<a href="#product.getDetailPageUrl()#">
							<img class="thumbnail-img" src="#product.getDefaultImageLink()#" />
						</a>
						<div class="thumbnail-name"><a href="#product.getDetailPageUrl()#">#product.getDisplayName()#</a></div>
						<div class="thumbnail-price">#DollarFormat(product.getPrice())#</div>
						<img class="free-shipping-icon" src="#APPLICATION.absoluteUrlWeb#images/freeshipping.jpg" style="width:120px;margin-top:7px;" />
						<div class="product-overlay">
							<div class="overlay-content">
								<div class="thumbnail-rating"></div>
								<div class="thumbnail-review"><a href="#product.getDetailPageUrl()#">(#ArrayLen(product.getReviews())# Reviews)</a></div>
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
	<div class="recommendation">
		Browse By Category
	</div>
	<div style="font-size:12px;padding-bottom:10px;margin-bottom:4px;border: 1px solid ##CCC;
margin-top: -1px;
padding: 0 8px 8px;">
		<div id="demo1_menu">
			<ul>
				<cfloop from="1" to="#ArrayLen(REQUEST.pageData.subCategoryTree)#" index="i">
					<cfset cat = REQUEST.pageData.categoryTree[i] />
					
					<li class="isFolder isExpanded has-child" title="Bookmarks">
						<a href="#cat.getDetailPageURL()#">
							#cat.getDisplayName()#
						</a>
						<ul>
							<cfloop array="#cat.getSubCategories()#" index="subCat">
								<li>
									<a href="#subCat.getDetailPageURL()#">
										#subCat.getDisplayName()#
									</a>
								</li>
							</cfloop>	
						</ul>
					</li>
				</cfloop>
			</ul>
		</div>
		<script>
		   $('##demo1_menu').easytree();
		   function changeTheme() {
			   var theme = $('##themes').val();
			   var stylesheet = $('.skins');
			   var href = stylesheet.attr('href');
			   stylesheet.attr('href', '/content/skin-' + theme + '/ui.easytree.css');
		   }
		</script>
	</div>
	<div class="recommendation">
		Best Sellers
	</div>
	<div class="recommendation-list" style="margin-bottom:8px;">
		<ul>
			<cfif NOT IsNull(REQUEST.pageData.bestSellerSection.getProducts())>
				<cfloop array="#REQUEST.pageData.bestSellerSection.getProducts()#" index="bs">	
					<cfset product = bs.getProduct() />
					<li>
						<img src="#SESSION.absoluteUrlTheme#images/#product.getDefaultImageLink()#" />
						<div class="recommendation-list-detail">
							<div class="recommendation-list-name">
								<a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm/#URLEncodedFormat(product.getDisplayName())#/#product.getProductId()#">
									#product.getDisplayName()#
								</a>
							</div>
							<div class="recommendation-list-price">#DollarFormat(product.getPrice())#</div>
							<div class="recommendation-list-review"></div>
							<div><a href="">(#ArrayLen(product.getReviews())# Reviews)</a></div>
						</div>
						<div style="clear:both;"></div>
					</li>
				</cfloop>
			</cfif>
		</ul>
	</div>
	<cfif NOT IsNull(REQUEST.pageData.advertisementSection.getAdvertisements())>
		<cfloop array="#REQUEST.pageData.advertisementSection.getAdvertisements()#" index="ad">	
			<img src="#APPLICATION.absoluteUrlWeb#images/uploads/advertise/#ad.getName()#" style="width:228px;border:1px solid ##CCC">
		</cfloop>
	</cfif>
	<div id="information" style="margin-top:14px;border-bottom:1px dotted ##3A3939;border-top:1px dotted ##3A3939;padding-bottom:8px;">
		<h2>INFORMATION</h2>
		<table style="width:100%;border-collapse: collapse;">
			<tr>
				<td>
					<ul>
						<li>Order Tracking</li>
						<li>Wholesale</li>
						<li>Shipping</li>
						<li>Returns</li>
						<li>Privacy Policy</li>
						<li>Contact Us</li>
						<li>About Us</li>
						<li>What We Sell</li>
						<li>Why choose TOMTOP</li>
						<li>FAQ's</li>
					</ul>
				</td>
			</tr>
		</table>
	</div>
</div>

</cfoutput>
