<cfoutput>
<div class="parallax-slide fullwidth-block small-slide" style="margin-bottom: 30px; margin-top: -25px;">
	<div class="swiper-container" data-autoplay="5000" data-loop="1" data-speed="500" data-center="0" data-slides-per-view="1">
		<div class="swiper-wrapper">
			#REQUEST.pageData.modules.slide.slideSection#
		</div>
		<div class="pagination"></div>
	</div>
</div>

<div class="information-blocks">
	<div class="row">
		<cfloop array="#REQUEST.pageData.modules.index_s1.categories#" index="category">
			<div class="col-sm-4 information-entry">
				<div class="special-item-entry">
					<img src="#category.image#" alt="" />
					<h3 class="title">Check out this weekend <span>#category.name#</span></h3>
					<a class="button style-6" href="##">shop now</a>
				</div>
			</div>
		</cfloop>
	</div>
</div>

<div class="information-blocks">
	<div class="tabs-container">
		<div class="swiper-tabs tabs-switch">
			<div class="title">Products</div>
			<div class="list">
				<cfloop from="1" to="#ArrayLen(REQUEST.pageData.modules.index_s2.tabs)#" index="tabIdx">
					<a class="block-title tab-switcher <cfif tabIdx EQ 1>active</cfif>">#REQUEST.pageData.modules.index_s2.tabs[tabIdx].name#</a>
				</cfloop>
				<div class="clear"></div>
			</div>
		</div>
		<div>
			<cfloop array="#REQUEST.pageData.modules.index_s2.tabs#" index="tab">
				<div class="tabs-entry">
					<div class="products-swiper">
						<div class="swiper-container" data-autoplay="0" data-loop="0" data-speed="500" data-center="0" data-slides-per-view="responsive" data-xs-slides="2" data-int-slides="2" data-sm-slides="3" data-md-slides="4" data-lg-slides="5" data-add-slides="5">
							<div class="swiper-wrapper">
								<cfloop array="#tab.products#" index="product">
									<div class="swiper-slide"> 
										<div class="paddings-container">
											<div class="product-slide-entry shift-image">
												<div class="product-image">
													<img src="#product.image1#" alt="" />
													<img src="#product.image2#" alt="" />
													<a class="top-line-a right open-product"><i class="fa fa-expand"></i> <span>Quick View</span></a>
													<div class="bottom-line">
														<div class="right-align">
															<a class="bottom-line-a square"><i class="fa fa-retweet"></i></a>
															<a class="bottom-line-a square"><i class="fa fa-heart"></i></a>
														</div>
														<div class="left-align">
															<a class="bottom-line-a"><i class="fa fa-shopping-cart"></i> Add to cart</a>
														</div>
													</div>
												</div>
												<a class="tag" href="##">#product.categoryName#</a>
												<a class="title" href="##">#product.name#</a>
												<div class="rating-box">
													<div class="star"><i class="fa fa-star"></i></div>
													<div class="star"><i class="fa fa-star"></i></div>
													<div class="star"><i class="fa fa-star"></i></div>
													<div class="star"><i class="fa fa-star"></i></div>
													<div class="star"><i class="fa fa-star"></i></div>
												</div>
												<div class="price">
													<div class="prev">$#product.previousPrice#</div>
													<div class="current">$#product.currentPrice#</div>
												</div>
											</div>
										</div>
									</cfloop>
								</div>
							</div>
							<div class="pagination"></div>
						</div>
					</div>
				</div>
			</cfloop>
		</div>
	</div>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="information-entry col-md-6">
			<div class="image-text-widget" style="background-image: url(#SESSION.absoluteUrlTheme#images/image-text-widget-1.jpg);">
				<div class="hot-mark red">hot</div>
				<h3 class="title">Woman category</h3>
				<div class="article-container style-1">
					<p>Lorem ipsum dolor sit amet, consectetur adipisc elit, sed do eiusmod tempor incididunt ut labore consectetur.</p>
					<ul>
						<li><a href="##">Evening dresses</a></li>
						<li><a href="##">Jackets and coats</a></li>
						<li><a href="##">Tops and Sweatshirts</a></li>
						<li><a href="##">Blouses and shirts</a></li>
						<li><a href="##">Trousers and Shorts</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="information-entry col-md-6">
			<div class="image-text-widget" style="background-image: url(#SESSION.absoluteUrlTheme#images/image-text-widget-2.jpg);">
				<div class="hot-mark red">hot</div>
				<h3 class="title">Man category</h3>
				<div class="article-container style-1">
					<p>Lorem ipsum dolor sit amet, consectetur adipisc elit, sed do eiusmod tempor incididunt ut labore consectetur.</p>
					<ul>
						<li><a href="##">Evening dresses</a></li>
						<li><a href="##">Jackets and coats</a></li>
						<li><a href="##">Tops and Sweatshirts</a></li>
						<li><a href="##">Blouses and shirts</a></li>
						<li><a href="##">Trousers and Shorts</a></li>
					</ul>
				</div>
			</div>
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