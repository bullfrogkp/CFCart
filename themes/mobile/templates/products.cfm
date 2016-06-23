<cfoutput>
<div class="breadcrumb-box">
	<a href="##">Home</a>	
	<cfloop array="#REQUEST.pageData.breadcrumbCategoryArray#" index="category">
		<a href="#category.getDetailPageURL()#">#category.getDisplayName()#</a>
	</cfloop>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="col-md-9 col-md-push-3 col-sm-8 col-sm-push-4">
			<div class="page-selector">
				<div class="pages-box hidden-xs">
					<cfif ArrayLen(REQUEST.pageData.pageArray) GT 1>
						<cfloop array="#REQUEST.pageData.pageArray#" index="page">
							<a href="#page.link#" class="square-button <cfif page.selected>active</cfif>">#page.number#</a>
						</cfloop>
						<div class="divider">...</div>
						<a href="##" class="square-button"><i class="fa fa-angle-right"></i></a>
					</cfif>
				</div>
				<div class="shop-grid-controls">
					<div class="entry">
						<div class="inline-text">Sorty by</div>
						<div class="simple-drop-down">
							<select>
								<option>Position</option>
								<option>Price</option>
								<option>Category</option>
								<option>Rating</option>
								<option>Color</option>
							</select>
						</div>
						<div class="sort-button"></div>
					</div>
					<div class="entry">
						<div class="view-button active grid"><i class="fa fa-th"></i></div>
						<div class="view-button list"><i class="fa fa-list"></i></div>
					</div>
					<div class="entry">
						<div class="inline-text">Show</div>
						<div class="simple-drop-down" style="width: 75px;">
							<select>
								<option>12</option>
								<option>20</option>
								<option>30</option>
								<option>40</option>
								<option>all</option>
							</select>
						</div>
						<div class="inline-text">per page</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
			<cfif REQUEST.pageData.category.getDisplayCustomDesign() EQ true>
				#REQUEST.pageData.category.getCustomDesign()#
			</cfif>
			<div class="row shop-grid grid-view">	
				<cfloop array="#REQUEST.pageData.paginationInfo.records#" index="product">
					<div class="col-md-3 col-sm-4 shop-grid-item">
						<div class="product-slide-entry shift-image">
							<div class="product-image">
								<!--- <img class="thumbnail-img" src="#product.getDefaultImageLink(type='small')#" /> --->
								<img src="#SESSION.absoluteUrlTheme#images/product-minimal-1.jpg" alt="" />
								<img src="#SESSION.absoluteUrlTheme#images/product-minimal-11.jpg" alt="" />
								<div class="bottom-line left-attached">
									<a class="bottom-line-a square"><i class="fa fa-shopping-cart"></i></a>
									<a class="bottom-line-a square"><i class="fa fa-heart"></i></a>
									<a class="bottom-line-a square"><i class="fa fa-retweet"></i></a>
									<a class="bottom-line-a square"><i class="fa fa-expand"></i></a>
								</div>
							</div>
							<a class="tag" href="##">Men clothing</a>
							<a class="title" href="#product.getDetailPageURL()#">#product.getDisplayName()#</a>
							<div class="rating-box">
								<div class="star"><i class="fa fa-star"></i></div>
								<div class="star"><i class="fa fa-star"></i></div>
								<div class="star"><i class="fa fa-star"></i></div>
								<div class="star"><i class="fa fa-star"></i></div>
								<div class="star"><i class="fa fa-star"></i></div>
								<div class="reviews-number">25 reviews</div>
							</div>
							<div class="article-container style-1">
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
							</div>
							<div class="price">
								<div class="prev">$#LSCurrencyFormat(product.getPrice(customerGroupName = SESSION.user.customerGroupName, currencyId = SESSION.currency.id),"local",SESSION.currency.locale)#</div>
								<div class="current">$#LSCurrencyFormat(product.getPrice(customerGroupName = SESSION.user.customerGroupName, currencyId = SESSION.currency.id),"local",SESSION.currency.locale)#</div>
							</div>
							<div class="list-buttons">
								<a class="button style-10">Add to cart</a>
								<a class="button style-11"><i class="fa fa-heart"></i> Add to Wishlist</a>
							</div>
						</div>
						<div class="clear"></div>
					</div>
				</cfloop>
			</div>
			<div class="page-selector">
				<div class="description">Showing: 1-3 of #ArrayLen(REQUEST.pageData.paginationInfo.records)#</div>
				<div class="pages-box">
					<cfif ArrayLen(REQUEST.pageData.pageArray) GT 1>
						<cfloop array="#REQUEST.pageData.pageArray#" index="page">
							<a href="#page.link#" class="square-button <cfif page.selected>active</cfif>">#page.number#</a>
						</cfloop>
						<div class="divider">...</div>
						<a href="##" class="square-button"><i class="fa fa-angle-right"></i></a>
					</cfif>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		<div class="col-md-3 col-md-pull-9 col-sm-4 col-sm-pull-8 blog-sidebar">
		
			<div class="information-blocks categories-border-wrapper">
				<div class="block-title size-3">Categories</div>
				<div class="accordeon">
					<cfloop from="1" to="#ArrayLen(REQUEST.pageData.categoryTree)#" index="i">
						<cfset cat = REQUEST.pageData.categoryTree[i] />
						<div class="accordeon-title">#cat.getDisplayName()#</div>
						<div class="accordeon-entry" style="
							<cfif cat.getIsExpanded()>
							display:block;
							</cfif>
							"
							>
							<div class="article-container style-1">
								<ul>
									<cfloop array="#cat.getSubCategories()#" index="subCat">
										<li><a href="#subCat.getDetailPageURL()#" <cfif subCat.getIsActive()>text-color:##fff;background-color:##000;</cfif>>#subCat.getDisplayName()#</a></li>
									</cfloop>
									<li><a href="#cat.getDetailPageURL()#" <cfif cat.getIsActive()>text-color:##fff;background-color:##000;</cfif>>View All</a></li>
								</ul>
							</div>
						</div>
					</cfloop>
				</div>
			</div>

			<cfif REQUEST.pageData.category.getDisplayFilter() EQ true>
				<cfif NOT ArrayIsEmpty(REQUEST.pageData.category.getCategoryFilterRelas())>
					<div style="border:1px solid ##CCC;width:692px;padding:10px;">
						<table id="filters">
							<cfloop array="#REQUEST.pageData.filterArray#" index="filter">
								<tr>
									<td>#filter.filterName#:</td>
									<td>
										<ul>
											<cfloop array="#filter.filterValueArray#" index="filterValue">
												<a href="#filterValue.link#">
												<li class="filter-value <cfif filterValue.selected>active-filter</cfif>"
												<cfif filter.filterName EQ "color">style="background-color:#filterValue.value#;width:20px;height:20px;padding:0;"</cfif>
												>
												
												<cfif filter.filterName NEQ "color">
													#filterValue.name#
												</cfif>
												
												</li>
												</a>
											</cfloop>
										</ul>
									</td>
								</tr>
							</cfloop>
						</table>
					</div>
				</cfif>
				
				<div class="information-blocks">
					<div class="block-title size-2">Sort by sizes</div>
					<div class="range-wrapper">
						<div id="prices-range"></div>
						<div class="range-price">
							Price: 
							<div class="min-price"><b>&pound;<span>0</span></b></div>
							<b>-</b>
							<div class="max-price"><b>&pound;<span>200</span></b></div>
						</div>
						<a class="button style-14">filter</a>
					</div>
				</div>

				<div class="information-blocks">
					<div class="block-title size-2">Sort by sizes</div>
					<div class="size-selector">
						<div class="entry active">xs</div>
						<div class="entry">s</div>
						<div class="entry">m</div>
						<div class="entry">l</div>
						<div class="entry">xl</div>
						<div class="spacer"></div>
					</div>
				</div>

				<div class="information-blocks">
					<div class="block-title size-2">Sort by brands</div>
					<div class="row">
						<div class="col-xs-6">
							<label class="checkbox-entry">
								<input type="checkbox" /> <span class="check"></span> Armani
							</label>
							<label class="checkbox-entry">
								<input type="checkbox" /> <span class="check"></span> Bershka Co
							</label>
							<label class="checkbox-entry">
								<input type="checkbox" /> <span class="check"></span> Nelly.com
							</label>
							<label class="checkbox-entry">
								<input type="checkbox" /> <span class="check"></span> Zigzag Inc
							</label>  
						</div>
						<div class="col-xs-6">
							<label class="checkbox-entry">
								<input type="checkbox" /> <span class="check"></span> Armani
							</label>
							<label class="checkbox-entry">
								<input type="checkbox" /> <span class="check"></span> Bershka Co
							</label>
							<label class="checkbox-entry">
								<input type="checkbox" /> <span class="check"></span> Nelly.com
							</label>
							<label class="checkbox-entry">
								<input type="checkbox" /> <span class="check"></span> Zigzag Inc
							</label> 
						</div>
					</div>
				</div>

				<div class="information-blocks">
					<div class="block-title size-2">Sort by colours</div>
					<div class="color-selector detail-info-entry">
						<div style="background-color: ##cf5d5d;" class="entry active"></div>
						<div style="background-color: ##c9459f;" class="entry"></div>
						<div style="background-color: ##689dd4;" class="entry"></div>
						<div style="background-color: ##68d4aa;" class="entry"></div>
						<div style="background-color: ##a8d468;" class="entry"></div>
						<div style="background-color: ##d4c368;" class="entry"></div>
						<div style="background-color: ##c2c2c2;" class="entry"></div>
						<div style="background-color: ##000000;" class="entry"></div>
						<div style="background-color: ##f0f0f0;" class="entry"></div>
						<div class="spacer"></div>
					</div>
				</div>
			</cfif>
		</div>
	</div>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="col-sm-4 information-entry">
			<h3 class="block-title inline-product-column-title">Featured products</h3>
			<div class="inline-product-entry">
				<a href="##" class="image"><img alt="" src="#SESSION.absoluteUrlTheme#images/product-image-inline-1.jpg"></a>
				<div class="content">
					<div class="cell-view">
						<a href="##" class="title">Ladies Pullover Batwing Sleeve Zigzag</a>
						<div class="price">
							<div class="prev">$199,99</div>
							<div class="current">$119,99</div>
						</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>

			<div class="inline-product-entry">
				<a href="##" class="image"><img alt="" src="#SESSION.absoluteUrlTheme#images/product-image-inline-2.jpg"></a>
				<div class="content">
					<div class="cell-view">
						<a href="##" class="title">Ladies Pullover Batwing Sleeve Zigzag</a>
						<div class="price">
							<div class="prev">$199,99</div>
							<div class="current">$119,99</div>
						</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>

			<div class="inline-product-entry">
				<a href="##" class="image"><img alt="" src="#SESSION.absoluteUrlTheme#images/product-image-inline-3.jpg"></a>
				<div class="content">
					<div class="cell-view">
						<a href="##" class="title">Ladies Pullover Batwing Sleeve Zigzag</a>
						<div class="price">
							<div class="prev">$199,99</div>
							<div class="current">$119,99</div>
						</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		<div class="col-sm-4 information-entry">
			<h3 class="block-title inline-product-column-title">Featured products</h3>
			<div class="inline-product-entry">
				<a href="##" class="image"><img alt="" src="#SESSION.absoluteUrlTheme#images/product-image-inline-1.jpg"></a>
				<div class="content">
					<div class="cell-view">
						<a href="##" class="title">Ladies Pullover Batwing Sleeve Zigzag</a>
						<div class="price">
							<div class="prev">$199,99</div>
							<div class="current">$119,99</div>
						</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>

			<div class="inline-product-entry">
				<a href="##" class="image"><img alt="" src="#SESSION.absoluteUrlTheme#images/product-image-inline-2.jpg"></a>
				<div class="content">
					<div class="cell-view">
						<a href="##" class="title">Ladies Pullover Batwing Sleeve Zigzag</a>
						<div class="price">
							<div class="prev">$199,99</div>
							<div class="current">$119,99</div>
						</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>

			<div class="inline-product-entry">
				<a href="##" class="image"><img alt="" src="#SESSION.absoluteUrlTheme#images/product-image-inline-3.jpg"></a>
				<div class="content">
					<div class="cell-view">
						<a href="##" class="title">Ladies Pullover Batwing Sleeve Zigzag</a>
						<div class="price">
							<div class="prev">$199,99</div>
							<div class="current">$119,99</div>
						</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		<div class="col-sm-4 information-entry">
			<h3 class="block-title inline-product-column-title">Featured products</h3>
			<div class="inline-product-entry">
				<a href="##" class="image"><img alt="" src="#SESSION.absoluteUrlTheme#images/product-image-inline-1.jpg"></a>
				<div class="content">
					<div class="cell-view">
						<a href="##" class="title">Ladies Pullover Batwing Sleeve Zigzag</a>
						<div class="price">
							<div class="prev">$199,99</div>
							<div class="current">$119,99</div>
						</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>

			<div class="inline-product-entry">
				<a href="##" class="image"><img alt="" src="#SESSION.absoluteUrlTheme#images/product-image-inline-2.jpg"></a>
				<div class="content">
					<div class="cell-view">
						<a href="##" class="title">Ladies Pullover Batwing Sleeve Zigzag</a>
						<div class="price">
							<div class="prev">$199,99</div>
							<div class="current">$119,99</div>
						</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>

			<div class="inline-product-entry">
				<a href="##" class="image"><img alt="" src="#SESSION.absoluteUrlTheme#images/product-image-inline-3.jpg"></a>
				<div class="content">
					<div class="cell-view">
						<a href="##" class="title">Ladies Pullover Batwing Sleeve Zigzag</a>
						<div class="price">
							<div class="prev">$199,99</div>
							<div class="current">$119,99</div>
						</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
		</div>
	</div>
</div>
</cfoutput>
