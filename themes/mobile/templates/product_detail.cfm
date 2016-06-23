<cfoutput>
<div class="information-blocks">
	<div class="row">
		<div class="col-sm-5 col-md-4 col-lg-5 information-entry">
			<div class="product-preview-box">
				<div class="swiper-container product-preview-swiper" data-autoplay="0" data-loop="1" data-speed="500" data-center="0" data-slides-per-view="1">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<div class="product-zoom-image">
								<img src="#SESSION.absoluteUrlTheme#images/product-main-1.jpg" alt="" data-zoom="#SESSION.absoluteUrlTheme#images/product-main-1-zoom.jpg" />
							</div>
						</div>
						<div class="swiper-slide">
							<div class="product-zoom-image">
								<img src="#SESSION.absoluteUrlTheme#images/product-main-2.jpg" alt="" data-zoom="#SESSION.absoluteUrlTheme#images/product-main-2-zoom.jpg" />
							</div>
						</div>
						<div class="swiper-slide">
							<div class="product-zoom-image">
								<img src="#SESSION.absoluteUrlTheme#images/product-main-3.jpg" alt="" data-zoom="#SESSION.absoluteUrlTheme#images/product-main-3-zoom.jpg" />
							</div>
						</div>
						<div class="swiper-slide">
							<div class="product-zoom-image">
								<img src="#SESSION.absoluteUrlTheme#images/product-main-4.jpg" alt="" data-zoom="#SESSION.absoluteUrlTheme#images/product-main-4-zoom.jpg" />
							</div>
						</div>
					</div>
					<div class="pagination"></div>
					<div class="product-zoom-container">
						<div class="move-box">
							<img class="default-image" src="#SESSION.absoluteUrlTheme#images/product-main-1.jpg" alt="" />
							<img class="zoomed-image" src="#SESSION.absoluteUrlTheme#images/product-main-1-zoom.jpg" alt="" />
						</div>
						<div class="zoom-area"></div>
					</div>
				</div>
				<div class="swiper-hidden-edges">
					<div class="swiper-container product-thumbnails-swiper" data-autoplay="0" data-loop="0" data-speed="500" data-center="0" data-slides-per-view="responsive" data-xs-slides="3" data-int-slides="3" data-sm-slides="3" data-md-slides="4" data-lg-slides="4" data-add-slides="4">
						<div class="swiper-wrapper">
							<div class="swiper-slide selected">
								<div class="paddings-container">
									<img src="#SESSION.absoluteUrlTheme#images/product-main-1.jpg" alt="" />
								</div>
							</div>
							<div class="swiper-slide">
								<div class="paddings-container">
									<img src="#SESSION.absoluteUrlTheme#images/product-main-2.jpg" alt="" />
								</div>
							</div>
							<div class="swiper-slide">
								<div class="paddings-container">
									<img src="#SESSION.absoluteUrlTheme#images/product-main-3.jpg" alt="" />
								</div>
							</div>
							<div class="swiper-slide">
								<div class="paddings-container">
									<img src="#SESSION.absoluteUrlTheme#images/product-main-4.jpg" alt="" />
								</div>
							</div>
						</div>
						<div class="pagination"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-7 col-md-4 information-entry">
			<div class="product-detail-box">
				<h1 class="product-title">#REQUEST.pageData.product.getDisplayName()#</h1>
				<h3 class="product-subtitle">SKU:#REQUEST.pageData.product.getSku()#</h3>
				<div class="rating-box">
					<cfloop from="1" to="#ArrayLen(REQUEST.pageData.stars)#">
						<div class="star"><i class="fa fa-star"></i></div>
					</cfloop>
					<cfloop from="#ArrayLen(REQUEST.pageData.stars)#" to="#5 - ArrayLen(REQUEST.pageData.stars)#">
						<div class="star"><i class="fa fa-star-o"></i></div>
					</cfloop>
					<div class="rating-number">#ArrayLen(REQUEST.pageData.reviews)# Reviews</div>
				</div>
				<div class="product-description detail-info-entry">
				#REQUEST.pageData.product.getDetail()#
				</div>
				<div class="price detail-info-entry">
					<div class="prev">$90,00</div>
					<div class="current">$70,00</div>
				</div>
				<div class="size-selector detail-info-entry">
					<div class="detail-info-entry-title">Size</div>
					<div class="entry active">xs</div>
					<div class="entry">s</div>
					<div class="entry">m</div>
					<div class="entry">l</div>
					<div class="entry">xl</div>
					<div class="spacer"></div>
				</div>
				<div class="color-selector detail-info-entry">
					<div class="detail-info-entry-title">Color</div>
					<div class="entry active" style="background-color: ##d23118;">&nbsp;</div>
					<div class="entry" style="background-color: ##2a84c9;">&nbsp;</div>
					<div class="entry" style="background-color: ##000;">&nbsp;</div>
					<div class="entry" style="background-color: ##d1d1d1;">&nbsp;</div>
					<div class="spacer"></div>
				</div>
				<div class="quantity-selector detail-info-entry">
					<div class="detail-info-entry-title">Quantity</div>
					<div class="entry number-minus">&nbsp;</div>
					<div class="entry number">10</div>
					<div class="entry number-plus">&nbsp;</div>
				</div>
				<div class="detail-info-entry">
					<a class="button style-10">Add to cart</a>
					<a class="button style-11"><i class="fa fa-heart"></i> Add to Wishlist</a>
					<div class="clear"></div>
				</div>
				<div class="tags-selector detail-info-entry">
					<div class="detail-info-entry-title">Tags:</div>
					<a href="##">bootstrap</a>/
					<a href="##">collections</a>/
					<a href="##">color/</a>
					<a href="##">responsive</a>
				</div>
				<div class="share-box detail-info-entry">
					<div class="title">Share in social media</div>
					<div class="socials-box">
						<a href="##"><i class="fa fa-facebook"></i></a>
						<a href="##"><i class="fa fa-twitter"></i></a>
						<a href="##"><i class="fa fa-google-plus"></i></a>
						<a href="##"><i class="fa fa-youtube"></i></a>
						<a href="##"><i class="fa fa-linkedin"></i></a>
						<a href="##"><i class="fa fa-instagram"></i></a>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</div>
		<div class="clear visible-xs visible-sm"></div>
		<div class="col-md-4 col-lg-3 information-entry product-sidebar">
			<div class="row">
				<div class="col-md-12">
					<div class="information-blocks production-logo">
						<div class="background">
							<div class="logo"><img src="#SESSION.absoluteUrlTheme#images/production-logo.png" alt="" /></div>
							<a href="##">Review this producent</a>
						</div>
					</div>
				</div>
				<div class="col-md-12">
					<div class="information-blocks">
						<div class="information-entry products-list">
							<h3 class="block-title inline-product-column-title">Featured products</h3>
							<div class="inline-product-entry">
								<a href="##" class="image"><img alt="" src="#SESSION.absoluteUrlTheme#images/product-image-inline-1.jpg"></a>
								<div class="content">
									<div class="cell-view">
										<a href="##" class="title">Pullover Batwing Sleeve Zigzag</a>
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
										<a href="##" class="title">Pullover Batwing Sleeve Zigzag</a>
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
										<a href="##" class="title">Pullover Batwing Sleeve Zigzag</a>
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
			</div>
		</div>
	</div>
</div>

<div class="information-blocks">
	<div class="tabs-container style-1">
		<div class="swiper-tabs tabs-switch">
			<div class="title">Product info</div>
			<div class="list">
				<a class="tab-switcher active">Product description</a>
				<a class="tab-switcher">SHIPPING &amp; RETURNS</a>
				<a class="tab-switcher">Reviews (25)</a>
				<div class="clear"></div>
			</div>
		</div>
		<div>
			<div class="tabs-entry">
				<div class="article-container style-1">
					<div class="row">
						<div class="col-md-6 information-entry">
							<h4>RETURNS POLICY</h4>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit.</p>
							<ul>
								<li>Any Product types that You want - Simple, Configurable</li>
								<li>Downloadable/Digital Products, Virtual Products</li>
								<li>Inventory Management with Backordered items</li>
								<li>Customer Personal Products - upload text for embroidery, monogramming</li>
								<li>Create Store-specific attributes on the fly</li>
							</ul>
						</div>
						<div class="col-md-6 information-entry">
							<h4>SHIPPING</h4>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.</p>
							<ul>
								<li>Any Product types that You want - Simple, Configurable</li>
								<li>Downloadable/Digital Products, Virtual Products</li>
								<li>Inventory Management with Backordered items</li>
								<li>Customer Personal Products - upload text for embroidery, monogramming</li>
								<li>Create Store-specific attributes on the fly</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="tabs-entry">
				<div class="article-container style-1">
					<div class="row">
						<div class="col-md-6 information-entry">
							<h4>RETURNS POLICY</h4>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit.</p>
							<ul>
								<li>Any Product types that You want - Simple, Configurable</li>
								<li>Downloadable/Digital Products, Virtual Products</li>
								<li>Inventory Management with Backordered items</li>
								<li>Customer Personal Products - upload text for embroidery, monogramming</li>
								<li>Create Store-specific attributes on the fly</li>
							</ul>
						</div>
						<div class="col-md-6 information-entry">
							<h4>SHIPPING</h4>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.</p>
							<ul>
								<li>Any Product types that You want - Simple, Configurable</li>
								<li>Downloadable/Digital Products, Virtual Products</li>
								<li>Inventory Management with Backordered items</li>
								<li>Customer Personal Products - upload text for embroidery, monogramming</li>
								<li>Create Store-specific attributes on the fly</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="tabs-entry">
				<div class="article-container style-1">
					<div class="row">
						<div class="col-md-6 information-entry">
							<h4>RETURNS POLICY</h4>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit.</p>
							<ul>
								<li>Any Product types that You want - Simple, Configurable</li>
								<li>Downloadable/Digital Products, Virtual Products</li>
								<li>Inventory Management with Backordered items</li>
								<li>Customer Personal Products - upload text for embroidery, monogramming</li>
								<li>Create Store-specific attributes on the fly</li>
							</ul>
						</div>
						<div class="col-md-6 information-entry">
							<h4>SHIPPING</h4>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.</p>
							<ul>
								<li>Any Product types that You want - Simple, Configurable</li>
								<li>Downloadable/Digital Products, Virtual Products</li>
								<li>Inventory Management with Backordered items</li>
								<li>Customer Personal Products - upload text for embroidery, monogramming</li>
								<li>Create Store-specific attributes on the fly</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="information-blocks">
	<div class="tabs-container">
		<div class="swiper-tabs tabs-switch">
			<div class="title">Products</div>
			<div class="list">
				<a class="block-title tab-switcher active">Featured Products</a>
				<a class="block-title tab-switcher">Popular Products</a>
				<a class="block-title tab-switcher">New Arrivals</a>
				<div class="clear"></div>
			</div>
		</div>
		<div>
			<div class="tabs-entry">
				<div class="products-swiper">
					<div class="swiper-container" data-autoplay="0" data-loop="0" data-speed="500" data-center="0" data-slides-per-view="responsive" data-xs-slides="2" data-int-slides="2" data-sm-slides="3" data-md-slides="4" data-lg-slides="5" data-add-slides="5">
						<div class="swiper-wrapper">
							<div class="swiper-slide"> 
								<div class="paddings-container">
									<div class="product-slide-entry shift-image">
										<div class="product-image">
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-1.jpg" alt="" />
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-11.jpg" alt="" />
											<a class="top-line-a left"><i class="fa fa-retweet"></i></a>
											<a class="top-line-a right"><i class="fa fa-heart"></i></a>
											<div class="bottom-line">
												<a class="bottom-line-a"><i class="fa fa-shopping-cart"></i> Add to cart</a>
											</div>
										</div>
										<a class="tag" href="##">Men clothing</a>
										<a class="title" href="##">Blue Pullover Batwing Sleeve Zigzag</a>
										<div class="rating-box">
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
										</div>
										<div class="price">
											<div class="prev">$199,99</div>
											<div class="current">$119,99</div>
										</div>
									</div>
								</div>
							</div>
							<div class="swiper-slide"> 
								<div class="paddings-container">
									<div class="product-slide-entry shift-image">
										<div class="product-image">
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" alt="" />
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" alt="" />
											<a class="top-line-a right"><i class="fa fa-expand"></i> <span>Quick View</span></a>
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
										<a class="tag" href="##">Men clothing</a>
										<a class="title" href="##">Blue Pullover Batwing Sleeve Zigzag</a>
										<div class="rating-box">
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
										</div>
										<div class="price">
											<div class="prev">$199,99</div>
											<div class="current">$119,99</div>
										</div>
									</div>
								</div>
							</div>
							<div class="swiper-slide"> 
								<div class="paddings-container">
									<div class="product-slide-entry shift-image">
										<div class="product-image">
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-3.jpg" alt="" />
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-11.jpg" alt="" />
											<div class="bottom-line left-attached">
												<a class="bottom-line-a square"><i class="fa fa-shopping-cart"></i></a>
												<a class="bottom-line-a square"><i class="fa fa-heart"></i></a>
												<a class="bottom-line-a square"><i class="fa fa-retweet"></i></a>
												<a class="bottom-line-a square"><i class="fa fa-expand"></i></a>
											</div>
										</div>
										<a class="tag" href="##">Men clothing</a>
										<a class="title" href="##">Blue Pullover Batwing Sleeve Zigzag</a>
										<div class="rating-box">
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
										</div>
										<div class="price">
											<div class="prev">$199,99</div>
											<div class="current">$119,99</div>
										</div>
									</div>
								</div>
							</div>
							<div class="swiper-slide"> 
								<div class="paddings-container">
									<div class="product-slide-entry shift-image">
										<div class="product-image">
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-4.jpg" alt="" />
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" alt="" />
											<a class="top-line-a right"><i class="fa fa-expand"></i> <span>Quick View</span></a>
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
										<a class="tag" href="##">Men clothing</a>
										<a class="title" href="##">Blue Pullover Batwing Sleeve Zigzag</a>
										<div class="rating-box">
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
										</div>
										<div class="price">
											<div class="prev">$199,99</div>
											<div class="current">$119,99</div>
										</div>
									</div>
								</div>
							</div>
							<div class="swiper-slide"> 
								<div class="paddings-container">
									<div class="product-slide-entry shift-image">
										<div class="product-image">
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-5.jpg" alt="" />
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-11.jpg" alt="" />
											<a class="top-line-a right"><i class="fa fa-expand"></i> <span>Quick View</span></a>
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
										<a class="tag" href="##">Men clothing</a>
										<a class="title" href="##">Blue Pullover Batwing Sleeve Zigzag</a>
										<div class="rating-box">
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
										</div>
										<div class="price">
											<div class="prev">$199,99</div>
											<div class="current">$119,99</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="pagination"></div>
					</div>
				</div>
			</div>
			<div class="tabs-entry">
				<div class="products-swiper">
					<div class="swiper-container" data-autoplay="0" data-loop="0" data-speed="500" data-center="0" data-slides-per-view="responsive" data-xs-slides="2" data-int-slides="2" data-sm-slides="3" data-md-slides="4" data-lg-slides="5" data-add-slides="5">
						<div class="swiper-wrapper">
							<div class="swiper-slide"> 
								<div class="paddings-container">
									<div class="product-slide-entry shift-image">
										<div class="product-image">
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-6.jpg" alt="" />
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" alt="" />
											<a class="top-line-a left"><i class="fa fa-retweet"></i></a>
											<a class="top-line-a right"><i class="fa fa-heart"></i></a>
											<div class="bottom-line">
												<a class="bottom-line-a"><i class="fa fa-shopping-cart"></i> Add to cart</a>
											</div>
										</div>
										<a class="tag" href="##">Men clothing</a>
										<a class="title" href="##">Blue Pullover Batwing Sleeve Zigzag</a>
										<div class="rating-box">
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
										</div>
										<div class="price">
											<div class="prev">$199,99</div>
											<div class="current">$119,99</div>
										</div>
									</div>
								</div>
							</div>
							<div class="swiper-slide"> 
								<div class="paddings-container">
									<div class="product-slide-entry shift-image">
										<div class="product-image">
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-7.jpg" alt="" />
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-11.jpg" alt="" />
											<a class="top-line-a right"><i class="fa fa-expand"></i> <span>Quick View</span></a>
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
										<a class="tag" href="##">Men clothing</a>
										<a class="title" href="##">Blue Pullover Batwing Sleeve Zigzag</a>
										<div class="rating-box">
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
										</div>
										<div class="price">
											<div class="prev">$199,99</div>
											<div class="current">$119,99</div>
										</div>
									</div>
								</div>
							</div>
							<div class="swiper-slide"> 
								<div class="paddings-container">
									<div class="product-slide-entry shift-image">
										<div class="product-image">
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-8.jpg" alt="" />
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" alt="" />
											<div class="bottom-line left-attached">
												<a class="bottom-line-a square"><i class="fa fa-shopping-cart"></i></a>
												<a class="bottom-line-a square"><i class="fa fa-heart"></i></a>
												<a class="bottom-line-a square"><i class="fa fa-retweet"></i></a>
												<a class="bottom-line-a square"><i class="fa fa-expand"></i></a>
											</div>
										</div>
										<a class="tag" href="##">Men clothing</a>
										<a class="title" href="##">Blue Pullover Batwing Sleeve Zigzag</a>
										<div class="rating-box">
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
										</div>
										<div class="price">
											<div class="prev">$199,99</div>
											<div class="current">$119,99</div>
										</div>
									</div>
								</div>
							</div>
							<div class="swiper-slide"> 
								<div class="paddings-container">
									<div class="product-slide-entry shift-image">
										<div class="product-image">
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-9.jpg" alt="" />
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-11.jpg" alt="" />
											<a class="top-line-a right"><i class="fa fa-expand"></i> <span>Quick View</span></a>
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
										<a class="tag" href="##">Men clothing</a>
										<a class="title" href="##">Blue Pullover Batwing Sleeve Zigzag</a>
										<div class="rating-box">
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
										</div>
										<div class="price">
											<div class="prev">$199,99</div>
											<div class="current">$119,99</div>
										</div>
									</div>
								</div>
							</div>
							<div class="swiper-slide"> 
								<div class="paddings-container">
									<div class="product-slide-entry shift-image">
										<div class="product-image">
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-10.jpg" alt="" />
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" alt="" />
											<a class="top-line-a right"><i class="fa fa-expand"></i> <span>Quick View</span></a>
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
										<a class="tag" href="##">Men clothing</a>
										<a class="title" href="##">Blue Pullover Batwing Sleeve Zigzag</a>
										<div class="rating-box">
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
										</div>
										<div class="price">
											<div class="prev">$199,99</div>
											<div class="current">$119,99</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="pagination"></div>
					</div>
				</div>
			</div>
			<div class="tabs-entry">
				<div class="products-swiper">
					<div class="swiper-container" data-autoplay="0" data-loop="0" data-speed="500" data-center="0" data-slides-per-view="responsive" data-xs-slides="2" data-int-slides="2" data-sm-slides="3" data-md-slides="4" data-lg-slides="5" data-add-slides="5">
						<div class="swiper-wrapper">
							<div class="swiper-slide"> 
								<div class="paddings-container">
									<div class="product-slide-entry shift-image">
										<div class="product-image">
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-1.jpg" alt="" />
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-11.jpg" alt="" />
											<a class="top-line-a left"><i class="fa fa-retweet"></i></a>
											<a class="top-line-a right"><i class="fa fa-heart"></i></a>
											<div class="bottom-line">
												<a class="bottom-line-a"><i class="fa fa-shopping-cart"></i> Add to cart</a>
											</div>
										</div>
										<a class="tag" href="##">Men clothing</a>
										<a class="title" href="##">Blue Pullover Batwing Sleeve Zigzag</a>
										<div class="rating-box">
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
										</div>
										<div class="price">
											<div class="prev">$199,99</div>
											<div class="current">$119,99</div>
										</div>
									</div>
								</div>
							</div>
							<div class="swiper-slide"> 
								<div class="paddings-container">
									<div class="product-slide-entry shift-image">
										<div class="product-image">
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-3.jpg" alt="" />
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-11.jpg" alt="" />
											<a class="top-line-a right"><i class="fa fa-expand"></i> <span>Quick View</span></a>
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
										<a class="tag" href="##">Men clothing</a>
										<a class="title" href="##">Blue Pullover Batwing Sleeve Zigzag</a>
										<div class="rating-box">
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
										</div>
										<div class="price">
											<div class="prev">$199,99</div>
											<div class="current">$119,99</div>
										</div>
									</div>
								</div>
							</div>
							<div class="swiper-slide"> 
								<div class="paddings-container">
									<div class="product-slide-entry shift-image">
										<div class="product-image">
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-5.jpg" alt="" />
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-11.jpg" alt="" />
											<div class="bottom-line left-attached">
												<a class="bottom-line-a square"><i class="fa fa-shopping-cart"></i></a>
												<a class="bottom-line-a square"><i class="fa fa-heart"></i></a>
												<a class="bottom-line-a square"><i class="fa fa-retweet"></i></a>
												<a class="bottom-line-a square"><i class="fa fa-expand"></i></a>
											</div>
										</div>
										<a class="tag" href="##">Men clothing</a>
										<a class="title" href="##">Blue Pullover Batwing Sleeve Zigzag</a>
										<div class="rating-box">
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
										</div>
										<div class="price">
											<div class="prev">$199,99</div>
											<div class="current">$119,99</div>
										</div>
									</div>
								</div>
							</div>
							<div class="swiper-slide"> 
								<div class="paddings-container">
									<div class="product-slide-entry shift-image">
										<div class="product-image">
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-7.jpg" alt="" />
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-11.jpg" alt="" />
											<a class="top-line-a right"><i class="fa fa-expand"></i> <span>Quick View</span></a>
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
										<a class="tag" href="##">Men clothing</a>
										<a class="title" href="##">Blue Pullover Batwing Sleeve Zigzag</a>
										<div class="rating-box">
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
										</div>
										<div class="price">
											<div class="prev">$199,99</div>
											<div class="current">$119,99</div>
										</div>
									</div>
								</div>
							</div>
							<div class="swiper-slide"> 
								<div class="paddings-container">
									<div class="product-slide-entry shift-image">
										<div class="product-image">
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-9.jpg" alt="" />
											<img src="#SESSION.absoluteUrlTheme#images/product-minimal-11.jpg" alt="" />
											<a class="top-line-a right"><i class="fa fa-expand"></i> <span>Quick View</span></a>
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
										<a class="tag" href="##">Men clothing</a>
										<a class="title" href="##">Blue Pullover Batwing Sleeve Zigzag</a>
										<div class="rating-box">
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
										</div>
										<div class="price">
											<div class="prev">$199,99</div>
											<div class="current">$119,99</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="pagination"></div>
					</div>
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
