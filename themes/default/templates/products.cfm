<cfoutput>

<div id="slide-div" style="width:712px;float:right;">
	<div id="breadcrumb">
		<div class="breadcrumb-home-icon"></div>
		<cfloop array="#REQUEST.pageData.categoryNameArray#" index="categoryName">
			<div class="breadcrumb-arrow-icon"></div>
			<span style="vertical-align:middle">Computers / Networking</span> 
		</cfloop>
	</div>
	
	<div style="border:1px solid ##CCC;width:692px;padding:10px;">
		<h1 style="border-bottom:1px solid ##CCC;padding-bottom:10px;">Keyboards <span style="font-size:12px;">(#ArrayLen(REQUEST.pageData.paginationInfo.records)# total)</span></h1> 
		<style>
		##filters {
		 font-size:12px;
		 font-weight:bold;
		}
		
		##filters tr td:first-child { 
		width:60px;
		height:40px;
		color:##F2A000;
		}
		
		##filters ul {
		 margin-left:-5px;
		 list-style-type:none;
		}
		
		##filters ul li {
		 float:left;
		 margin-left:10px;
		 cursor:hand;
		 cursor:pointer;
		}
		
		##filters ul li:hover {
		color:##fff;
		background-color:##F2A000;
		}
		
		.price td ul li {
		border:1px solid ##ccc;
		padding:4px 7px;
		}
		
		.brand td ul li {
		border:1px solid ##ccc;
		padding:4px 7px;
		}
		
		.color td ul li {
		border:1px solid ##ccc;
		width:20px;
		height:20px;
		}
		
		.color td ul li:hover {
		border:1px solid blue;
		}
		
		.active-filter {
		color:##fff;
		background-color:##F2A000;
		}
		</style>
		
		<cfif NOT ArrayIsEmpty(REQUEST.pageData.category.getCategoryFilterRelas()))>
			<table id="filters">
				<cfloop array="#REQUEST.pageData.category.getCategoryFilterRelas()#" index="categoryFilterRela">
					<cfset filter = categoryFilterRela.getFilter() />
					<tr class="#filter.getName()#">
						<td>#filter.getDisplayName()#:</td>
						<td>
							<ul>
								<cfif NOT IsNull(categoryFilterRela.getFilterValues())>
									<cfloop array="#categoryFilterRela.getFilterValues()#" index="filterValue">
										<li 
										<cfif ListFind(REQUEST.pageData.activeFilterValueIdList,filterValue.getFilterValueId())>class="active-filter"</cfif>
										<cfif filter.getName() EQ "color">style="background-color:#filterValue.getValue()#;"</cfif>
										>#filterValue.getValue()#</li>
									</cfloop>
								</cfif>
							</ul>
						</td>
					</tr>
				</cfloop>
			</table>
		</cfif>
	</div>
	
	<style>
	##sort-by {
	 font-size:12px;
	 margin-top:20px;
	 float:left;
	}
	
	##sort-by ul {
	 margin-left:-5px;
	 list-style-type:none;
	 float:left;
	}
	
	##sort-by ul li {
	 float:left;
	 margin-left:10px;
	 cursor:hand;
	 cursor:pointer;
	}
	
	##sort-by ul li:hover {
	color:##fff;
	background-color:##ccc;
	}
	
	##sort-by ul li {
	border:1px solid ##ccc;
	padding:4px 7px;
	}
	
	
	##pages {
	 font-size:12px;
	 margin-top:20px;
	 float:right;
	}
	
	##pages .active {
	 color:##fff;
	 background-color:##CCC;
	}
	
	##pages ul {
	 margin-left:-5px;
	 list-style-type:none;
	 float:left;
	}
	
	##pages ul li {
	 float:left;
	 margin-left:10px;
	 cursor:hand;
	 cursor:pointer;
	}
	
	##pages ul li:hover {
	color:##fff;
	background-color:##CCC;
	}
	
	##pages ul li {
	border:1px solid ##ccc;
	width:20px;
	height:20px;
	line-height:20px;
	text-align:center;
	}
	</style>
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
				<cfloop array="REQUEST.pageData.getProducts()" array="product">
					<cfset productLink = "#APPLICATION.absoluteUrlWeb#product_detail.cfm/#URLEncodedFormat(product.getDisplayName())#/#product.getProductId()#" />
					<li class="single-products">
						<a href="#productLink#">
							<img class="thumbnail-img" src="#product.getDefaultImageLink()#" />
						</a>
						<div class="thumbnail-name"><a href="#productLink#">#product.getDisplayName()#</a></div>
						<div class="thumbnail-price">#product.getPrice()#</div>
						<img class="free-shipping-icon" src="#APPLICATION.absoluteUrlWeb#images/freeshipping.jpg" style="width:120px;margin-top:7px;" />
						<div class="product-overlay">
							<div class="overlay-content">
								<div class="thumbnail-rating"></div>
								<div class="thumbnail-review"><a href="#productLink#">(#ArrayLen(product.getReviews())# Reviews)</a></div>
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
						<a href="#APPLICATION.absoluteUrlWeb#products.cfm/#URLEncodedFormat(cat.getDisplayName())#/#cat.getCategoryId()#">#cat.getDisplayName()#</a>
						<cfif ArrayLen(cat.getSubCategories()) NEQ 0>
							<div class="cat-submenu">
								<div style="z-index:1;position: relative;">
									<cfloop array="#cat.getSubCategories()#" index="subCat">
										<dl>
											<div class="clear"></div>
											<dt><a href="#APPLICATION.absoluteUrlWeb#products.cfm/#URLEncodedFormat(subCat.getDisplayName())#/#subCat.getCategoryId()#">#subCat.getDisplayName()#</a></dt>
											<cfloop array="#subCat.getSubCategories()#" index="thirdCat">
												<dd><a href="#APPLICATION.absoluteUrlWeb#products.cfm/#URLEncodedFormat(thirdCat.getDisplayName())#/#thirdCat.getCategoryId()#">#thirdCat.getDisplayName()#</a></dd>
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
						<a href="#APPLICATION.absoluteUrlWeb#products.cfm/#URLEncodedFormat(cat.getDisplayName())#/#cat.getCategoryId()#">
							#cat.getDisplayName()#
						</a>
						<ul>
							<cfloop array="#cat.getSubCategories()#" index="subCat">
								<li>
									<a href="#APPLICATION.absoluteUrlWeb#products.cfm/#URLEncodedFormat(subCat.getDisplayName())#/#subCat.getCategoryId()#">
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
		<style>
		   .grey_background {
			   background-color: ##cccccc;
		   }
		   .green_background {
			   background-color: ##909B19;
		   }
		   .red {
			   color: ##FF0000;
		   }
		   .blue {
			   color: ##0000FF;
		   }
		</style>
	</div>
	<div class="recommendation">
		Best Sellers
	</div>
	<div class="recommendation-list">
		<ul>
			<li>
				<img src="#SESSION.absoluteUrlTheme#images/b1.jpg" />
				<div class="recommendation-list-detail">
					<div class="recommendation-list-name"><a href="">PC VGA to S-Video AV RCA TV Out</a></div>
					<div class="recommendation-list-price">US $4.08</div>
					<div class="recommendation-list-review"></div>
					<div><a href="">(26 Reviews)</a></div>
				</div>
				<div style="clear:both;"></div>
			</li>
			<li>
				<img src="#SESSION.absoluteUrlTheme#images/b2.jpg" />
				<div class="recommendation-list-detail">
					<div class="recommendation-list-name"><a href="">PC VGA to S-Video AV RCA TV Out</a></div>
					<div class="recommendation-list-price">US $4.08</div>
					<div class="recommendation-list-review"></div>
					<div><a href="">(26 Reviews)</a></div>
				</div>
				<div style="clear:both;"></div>
			</li>
			<li>
				<img src="#SESSION.absoluteUrlTheme#images/b3.jpg" />
				<div class="recommendation-list-detail">
					<div class="recommendation-list-name"><a href="">PC VGA to S-Video AV RCA TV Out</a></div>
					<div class="recommendation-list-price">US $4.08</div>
					<div class="recommendation-list-review"></div>
					<div><a href="">(26 Reviews)</a></div>
				</div>
				<div style="clear:both;"></div>
			</li>
			<li>
				<img src="#SESSION.absoluteUrlTheme#images/b4.jpg" />
				<div class="recommendation-list-detail">
					<div class="recommendation-list-name"><a href="">PC VGA to S-Video AV RCA TV Out</a></div>
					<div class="recommendation-list-price">US $4.08</div>
					<div class="recommendation-list-review"></div>
					<div><a href="">(26 Reviews)</a></div>
				</div>
				<div style="clear:both;"></div>
			</li>
			<li>
				<img src="#SESSION.absoluteUrlTheme#images/b5.jpg" />
				<div class="recommendation-list-detail">
					<div class="recommendation-list-name"><a href="">PC VGA to S-Video AV RCA TV Out</a></div>
					<div class="recommendation-list-price">US $4.08</div>
					<div class="recommendation-list-review"></div>
					<div><a href="">(26 Reviews)</a></div>
				</div>
				<div style="clear:both;"></div>
			</li>
			<li>
				<img src="#SESSION.absoluteUrlTheme#images/b6.jpg" />
				<div class="recommendation-list-detail">
					<div class="recommendation-list-name"><a href="">PC VGA to S-Video AV RCA TV Out</a></div>
					<div class="recommendation-list-price">US $4.08</div>
					<div class="recommendation-list-review"></div>
					<div><a href="">(26 Reviews)</a></div>
				</div>
				<div style="clear:both;"></div>
			</li>
			<li>
				<img src="#SESSION.absoluteUrlTheme#images/b7.jpg" />
				<div class="recommendation-list-detail">
					<div class="recommendation-list-name"><a href="">PC VGA to S-Video AV RCA TV Out</a></div>
					<div class="recommendation-list-price">US $4.08</div>
					<div class="recommendation-list-review"></div>
					<div><a href="">(26 Reviews)</a></div>
				</div>
				<div style="clear:both;"></div>
			</li>
			<li>
				<img src="#SESSION.absoluteUrlTheme#images/b1.jpg" />
				<div class="recommendation-list-detail">
					<div class="recommendation-list-name"><a href="">PC VGA to S-Video AV RCA TV Out</a></div>
					<div class="recommendation-list-price">US $4.08</div>
					<div class="recommendation-list-review"></div>
					<div><a href="">(26 Reviews)</a></div>
				</div>
				<div style="clear:both;"></div>
			</li>
		</ul>
	</div>
	<img src="#SESSION.absoluteUrlTheme#images/ad1.jpg" style="width:228px;border:1px solid ##CCC;margin-top:8px;">
		<img src="#SESSION.absoluteUrlTheme#images/ads2.jpg" style="width:228px;border:1px solid ##CCC">
		<img src="#SESSION.absoluteUrlTheme#images/ads3.jpg" style="width:228px;border:1px solid ##CCC">
		<img src="#SESSION.absoluteUrlTheme#images/ads4.jpg" style="width:228px;border:1px solid ##CCC">
		<img src="#SESSION.absoluteUrlTheme#images/ads5.jpg" style="width:228px;border:1px solid ##CCC">
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
