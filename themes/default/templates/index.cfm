<cfoutput>
<div id="slide-div" style="width:722px;float:right;">
	#REQUEST.pageData.slideContent#
</div>
<div id="top-sidebar">
	<img src="#SESSION.absoluteUrlTheme#images/week_deal.gif" style="width:230px;" />
	<div id="sidenav" style="display:block;position:relative;top:0;">
		<ul>
			<cfloop from="1" to="#ArrayLen(REQUEST.pageData.categoryTree)#" index="i">
				<cfset cat = REQUEST.pageData.categoryTree[i] />
				<li class="<cfif ArrayLen(cat.getSubCategories()) NEQ 0>has-sub-menu</cfif> first-level-menu" <cfif i EQ 1>style="margin-top:6px;<cfelseif i EQ ArrayLen(REQUEST.pageData.categoryTree)>style="margin-bottom:6px;</cfif>">
					<a href="#APPLICATION.absoluteUrlWeb#category_detail.cfm/#URLEncodedFormat(cat.getDisplayName())#/#cat.getCategoryId()#">#cat.getDisplayName()#</a>
					<cfif ArrayLen(cat.getSubCategories()) NEQ 0>
						<div class="cat-submenu">
							<div style="z-index:1;position: relative;">
								<cfloop array="#cat.getSubCategories()#" index="subCat">
									<dl>
										<div class="clear"></div>
										<dt><a href="#APPLICATION.absoluteUrlWeb#category_detail.cfm/#URLEncodedFormat(subCat.getDisplayName())#/#subCat.getCategoryId()#">#subCat.getDisplayName()#</a></dt>
										<cfloop array="#subCat.getSubCategories()#" index="thirdCat">
											<dd><a href="#APPLICATION.absoluteUrlWeb#category_detail.cfm/#URLEncodedFormat(thirdCat.getDisplayName())#/#thirdCat.getCategoryId()#">#thirdCat.getDisplayName()#</a></dd>
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
</div>
<div style="clear:both;"></div>
<div style="height: 34px;
	width: 100%;
	border-top:2px solid ##3A3939;border-bottom:2px solid ##3A3939;
	margin-top:2px;
	margin-bottom:7px;">
	<div style="border-top:1px dotted ##3A3939;margin:17px auto;width:100%;">
		<div style="margin:-9px auto;width:74px;padding:0 15px 0 15px;font-size: 14px;background-color:##fff;
			font-weight: bold;">DISCOVER</div>
	</div>
</div>
<div id="content">
	<div class="container">
		<div id="category-list">
			<div class="cat-thumbnails">
				<div class="cat-thumbnail-title"><a href="">Top Selling</a></div>
				<div class="cat-thumbnail-link"><a href="">More >></a></div>
				<div class="clear"></div>
				<div class="cat-thumbnail-section">
					<ul class="rig columns-4">
						<cfloop array="#REQUEST.pageData.topSellings#" index="topSell">
							<cfset product = topSell.getProduct() />
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
			<div class="cat-thumbnails">
				<div class="cat-thumbnail-title"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">Group Buying</a></div>
				<div class="cat-thumbnail-link"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">More >></a></div>
				<div class="clear"></div>
				<div class="cat-thumbnail-section">
					<ul class="rig columns-4">
						<cfloop array="#REQUEST.pageData.groupBuyings#" index="groupBuy">
							<cfset product = groupBuy.getProduct() />
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
			<div class="cat-thumbnails">
				<div class="cat-thumbnail-title"><a href="">Hot Categories</a></div>
				<div class="clear"></div>
				<div class="cat-thumbnail-section">
					<ul class="rig columns-3">
						<li>
							<img src="#SESSION.absoluteUrlTheme#images/cat1.jpg" />
							<div class="hot-cat-title"><a href="">RC Models and Accessories</a></div>
							<div class="hot-cat-list"><a href="">Walkera</a></div>
							<div class="hot-cat-list"><a href="">FPV system & Parts</a></div>
							<div class="hot-cat-list"><a href="">RC Cars & Parts</a></div>
							<div class="hot-cat-list"><a href="">Helicopters & Parts</a></div>
						</li>
						<li>
							<img src="#SESSION.absoluteUrlTheme#images/cat2.jpg" />
							<div class="hot-cat-title"><a href="">Tablet PCs & Cell Phone</a></div>
							<div class="hot-cat-list"><a href="">Accessories for iPhone</a></div>
							<div class="hot-cat-list"><a href="">Accessories For iPad</a></div>
							<div class="hot-cat-list"><a href="">Accessories for Tablet PC</a></div>
							<div class="hot-cat-list"><a href="">Tablet PC</a></div>
						</li>
						<li>
							<img src="#SESSION.absoluteUrlTheme#images/cat3.jpg" />
							<div class="hot-cat-title"><a href="">Lighting / Flashlights / LEDs</a></div>
							<div class="hot-cat-list"><a href="">LED Light Bulbs</a></div>
							<div class="hot-cat-list"><a href="">Wireless Presenters</a></div>
							<div class="hot-cat-list"><a href="">Lamps</a></div>
							<div class="hot-cat-list"><a href="">LED Strings & Decoration Lights</a></div>
						</li>
						<li>
							<img src="#SESSION.absoluteUrlTheme#images/cat4.jpg" />
							<div class="hot-cat-title"><a href="">Sports & Outdoor</a></div>
							<div class="hot-cat-list"><a href="">Golf Supplies</a></div>
							<div class="hot-cat-list"><a href="">Outdoor & Traveling Supplies</a></div>
							<div class="hot-cat-list"><a href="">Camping & Hiking</a></div>
							<div class="hot-cat-list"><a href="">Fishing</a></div>
						</li>
						<li>
							<img src="#SESSION.absoluteUrlTheme#images/cat5.jpg" />
							<div class="hot-cat-title"><a href="">Car Accessories</a></div>
							<div class="hot-cat-list"><a href="">More Car Accessories</a></div>
							<div class="hot-cat-list"><a href="">Car Alarms and Security</a></div>
							<div class="hot-cat-list"><a href="">Car Audio & Speakers</a></div>
							<div class="hot-cat-list"><a href="">Gadgets & Auto Parts</a></div>
						</li>
						<li>
							<img src="#SESSION.absoluteUrlTheme#images/cat6.jpg" />
							<div class="hot-cat-title"><a href="">Video & Audio</a></div>
							<div class="hot-cat-list"><a href="">Batteries & Chargers</a></div>
							<div class="hot-cat-list"><a href="">Headphones, Headsets</a></div>
							<div class="hot-cat-list"><a href="">Home Audio</a></div>
							<div class="hot-cat-list"><a href="">MP3 Players & Accessories</a></div>
						</li>
						<li>
							<img src="#SESSION.absoluteUrlTheme#images/cat7.jpg" />
							<div class="hot-cat-title"><a href="">Clothing / Accessories</a></div>
							<div class="hot-cat-list"><a href="">Hip Scarves</a></div>
							<div class="hot-cat-list"><a href="">Hats / Caps</a></div>
							<div class="hot-cat-list"><a href="">Swimwear</a></div>
							<div class="hot-cat-list"><a href="">Bags</a></div>
						</li>
						<li>
							<img src="#SESSION.absoluteUrlTheme#images/cat8.jpg" />
							<div class="hot-cat-title"><a href="">Home, Garden & Tools</a></div>
							<div class="hot-cat-list"><a href="">Gift & Lifestyle Gadgets</a></div>
							<div class="hot-cat-list"><a href="">Home Electronics</a></div>
							<div class="hot-cat-list"><a href="">Lighter & Cigar Supplies</a></div>
							<div class="hot-cat-list"><a href="">Home Living</a></div>
						</li>
						<li>
							<img src="#SESSION.absoluteUrlTheme#images/cat1.jpg" />
							<div class="hot-cat-title"><a href="">RC Models and Accessories</a></div>
							<div class="hot-cat-list"><a href="">Walkera</a></div>
							<div class="hot-cat-list"><a href="">FPV system & Parts</a></div>
							<div class="hot-cat-list"><a href="">RC Cars & Parts</a></div>
							<div class="hot-cat-list"><a href="">Helicopters & Parts</a></div>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div id="sidebar-wrapper">
			<img src="#SESSION.absoluteUrlTheme#images/ad1.jpg" style="width:100%;border:1px solid ##CCC">
			<img src="#SESSION.absoluteUrlTheme#images/ads2.jpg" style="width:100%;border:1px solid ##CCC">
			<img src="#SESSION.absoluteUrlTheme#images/ads3.jpg" style="width:100%;border:1px solid ##CCC">
			<img src="#SESSION.absoluteUrlTheme#images/ads4.jpg" style="width:100%;border:1px solid ##CCC">
			<img src="#SESSION.absoluteUrlTheme#images/ads5.jpg" style="width:100%;border:1px solid ##CCC">
			<img src="#SESSION.absoluteUrlTheme#images/ads3.jpg" style="width:100%;border:1px solid ##CCC">
			<div id="information" style="margin-top:14px;border-bottom:1px dotted ##3A3939;border-top:1px dotted ##3A3939;padding-bottom:8px;">
				<h2>INFORMATION</h2>
				<table style="width:100%;border-collapse: collapse;">
					<tr>
						<td>
							<ul>
								<li><a href="#APPLICATION.absoluteUrlWeb#payment_info.cfm">Payment Info</a></li>
								<li><a href="#APPLICATION.absoluteUrlWeb#shipping_info.cfm">Shipping Info</a></li>
								<li><a href="#APPLICATION.absoluteUrlWeb#estimate.cfm">Delivery Estimate</a></li>
								<li><a href="#APPLICATION.absoluteUrlWeb#locations.cfm">Locations</a></li>
								<li><a href="#APPLICATION.absoluteUrlWeb#privacy.cfm">Privacy Policy</a></li>
								<li><a href="#APPLICATION.absoluteUrlWeb#term_of_use.cfm">Terms of Use</a></li>
								<li><a href="#APPLICATION.absoluteUrlWeb#return_policy.cfm">Return Policy</a></li>
								<li><a href="#APPLICATION.absoluteUrlWeb#wholesale.cfm">Wholesale</a></li>
								<li><a href="#APPLICATION.absoluteUrlWeb#about_us.cfm">About Us</a></li>
								<li><a href="#APPLICATION.absoluteUrlWeb#contact_us.cfm">Contact Us</a></li>
								<li><a href="#APPLICATION.absoluteUrlWeb#faq.cfm">FAQs</a></li>
							</ul>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div style="clear:both;"></div>
	</div>
</div>

</cfoutput>
