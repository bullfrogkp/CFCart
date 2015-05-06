<cfoutput>

<div id="breadcrumb">
	<!---
	<div class="breadcrumb-home-icon"></div>
	<cfloop array="#REQUEST.pageData.categoryArray#" index="category">
		<div class="breadcrumb-arrow-icon"></div>
		<span style="vertical-align:middle">
			<a href="#category.getDetailPageURL()#">
			#category.getDisplayName()#
			</a>
		</span> 
	</cfloop>
	--->
</div>
<div style="width:413px;float:left;">
	<img src="#REQUEST.pageData.defaultImage.getImageLink()#" data-zoom-image="#REQUEST.pageData.defaultImage.getImageLink()#"/> 
	<div id="gallery_01"> 
		<cfloop array="#REQUEST.pageData.allImages#" index="img">
			<a href="##" data-image="#img.getImageLink()#" data-zoom-image="#img.getImageLink()#"> 
				<img src="#img.getImageLink()#" /> 
			</a> 
		</cfloop>
	</div>
	<!---
	<div id="videos"> 
		<div style="padding-bottom:5px;">Videos:</div>
		<a class="various fancybox.iframe" href="http://www.youtube.com/embed/L9szn1QQfas?autoplay=1">
			<img id="img_02" src="#SESSION.absoluteUrlTheme#images/thumb/image1.jpg" /> 
		</a> 
	</div>
	--->
</div>
<div style="width:523px;float:right;">
	<div id="product-name" style="font-size:18px;font-weight:bold;">
		#REQUEST.pageData.product.getDisplayName()#
	</div>
	<div id="product-share" style="margin-top:10px;">
		<img class="logo facebook-logo" onclick="affShareOnFacebook('http://www.tomtop.com/usb-to-pc-game-controller-adapter-converter-for-ps2-game006.html')" title="Share on Facebook" src="#SESSION.absoluteUrlTheme#images/p_facebook-color.png">
		<img class="logo twitter-logo" onclick="affShareOnTwitter('http://www.tomtop.com/usb-to-pc-game-controller-adapter-converter-for-ps2-game006.html')" title="Share on Twitter" src="#SESSION.absoluteUrlTheme#images/p_tweet.png">
		<img class="logo google-logo" onclick="affShareGooglePlus('http://www.tomtop.com/usb-to-pc-game-controller-adapter-converter-for-ps2-game006.html')" title="Share on Google Plus" src="#SESSION.absoluteUrlTheme#images/p_gplus-color.png">
		<img src="#SESSION.absoluteUrlTheme#images/p_pinterest.png">
	</div>
	<div id="product-sku" style="font-size:12px;margin-top:10px;">
		SKU:#REQUEST.pageData.product.getSku()#
	</div>
	<div id="product-price" style="font-size:18px;font-weight:bold;color:##C20000;margin-top:20px;">
		#DollarFormat(REQUEST.pageData.product.getPrice())#
	</div>
	<div id="product-addtocart" style="margin-top:30px;">
		<span style="font-size:13px;">Qty: </span>
		<button id="minus">-</button>
		<input id="value" type="text" value="0" style="width:30px;text-align:center;" />
		<button id="plus">+</button>
		<a class="btn add-to-cart" style="padding-right:13px;margin-left:15px;">Add to Cart</a>
		<a class="btn-wish" style="padding-right:13px;">Add to Wishlist</a>
	</div>
	
	<div id="product-description">
		<ul>
			<li><a href="##tabs-1">Product Description</a></li>
			<li><a href="##tabs-2">Reviews</a></li>
		</ul>
		<div id="tabs-1">
			#REQUEST.pageData.product.getProductDetail()#
		</div>
	  <div id="tabs-2">
		<cfloop array="#REQUEST.pageData.reviews#" index="review">
			<div style="border-bottom: 1px dashed ##CCCCCC;">
				<p style="font-weight:bold;">#review.getSubject()# Review by #review.getName()#</p>
				<p style="width:200px;height: 13px;
					background: url(#SESSION.absoluteUrlTheme#images/breadcrub20140512.png);
					background-position: left -1500px;
					background-repeat: no-repeat;"></p>
				<p>#review.getMessage()#</p>
				<p>(Posted on #DateFormat(review.getCreatedDatetime(),"mmm dd, yyyy")#)</p>
			</div>
		</cfloop>
		<div>
			<p style="font-weight:bold;">Write Your Own Review</p>
			<p style="font-weight:bold;">How do you rate this product?</p>
			<p style="width:200px;height: 13px;
						background: url(#SESSION.absoluteUrlTheme#images/breadcrub20140512.png);
						background-position: left -1500px;
						background-repeat: no-repeat;"></p>
			<p style="font-weight:bold;">Name</p>
			<p><input type="text" style="width:100%;" /></p>
			<p style="font-weight:bold;">Subject</p>
			<p><input type="text" style="width:100%;" /></p>
			<p style="font-weight:bold;">Content</p>
			<p><textarea style="width:100%;height:100px;" /></textarea></p>
			<p><input type="button" value="Submit" style="padding:5px 10px;" /></p>
		</div>
	  </div>
	</div>
</div>
</div>
<div style="clear:both;"></div>
<div class="container">
<div class="related-thumbnails">
	<div class="cat-thumbnail-title"><a href="">Related Products</a></div>
	<div class="clear"></div>
	<div class="cat-thumbnail-section">
		<ul class="rig columns-4">
			<li class="single-products">
				<img class="thumbnail-img" src="#SESSION.absoluteUrlTheme#images/t1.jpg">
				<div class="thumbnail-name"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">7 Colors Changing Glow LED Light Water Stream Faucet Tap</a></div>
				<div class="thumbnail-price">US$4.51</div>
				<img src="#SESSION.absoluteUrlTheme#images/freeshipping.jpg" style="width:120px;">
				<div class="product-overlay">
					<div class="overlay-content">
						<div class="thumbnail-overlay-name" style="margin-top:10px;width:100%"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm" title="">7 Colors Changing Glow LED Light Water Stream Faucet Tap</a></div>
						<div class="thumbnail-overlay-price">$4.51</div>
						<div class="thumbnail-rating" style="background-position: 32px -1512px;"></div>
						<div class="thumbnail-review"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">(13 Reviews)</a></div>
						<div class="thumbnail-cat-name"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">In Home Living</a></div>
						<div class="thumbnail-cart"><a href="##" class="btn" style="padding-right:13px;">Add to cart</a></div>
					</div>
				</div>
			</li>
			<li class="single-products">
				<img class="thumbnail-img" src="#SESSION.absoluteUrlTheme#images/t2.jpg">
				<div class="thumbnail-name"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">2.4GHz Wireless Optical Pen Mouse Adjustable 500/1000DPI</a></div>
				<div class="thumbnail-price">US$40.23</div>
				<div class="product-overlay">
					<div class="overlay-content">
						<div class="thumbnail-overlay-name" style="margin-top:10px;width:100%"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm" title="">2.4GHz Wireless Optical Pen Mouse Adjustable 500/1000DPI</a></div>
						<div class="thumbnail-overlay-price">$40.23</div>
						<div class="thumbnail-rating" style="background-position: 32px -1512px;"></div>
						<div class="thumbnail-review"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">(13 Reviews)</a></div>
						<div class="thumbnail-cat-name"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">In Home Living</a></div>
						<div class="thumbnail-cart"><a href="##" class="btn" style="padding-right:13px;">Add to cart</a></div>
					</div>
				</div>
			</li>
			<li class="single-products">
				<img class="thumbnail-img" src="#SESSION.absoluteUrlTheme#images/t3.jpg">
				<div class="thumbnail-name"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">160 Lumen CREE Q5 LED Headlamp Zoomable Headlight</a></div>
				<div class="thumbnail-price">US$68.51</div>
				<img src="#SESSION.absoluteUrlTheme#images/freeshipping.jpg" style="width:120px;">
				<div class="product-overlay">
					<div class="overlay-content">
						<div class="thumbnail-overlay-name" style="margin-top:10px;width:100%"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm" title="">160 Lumen CREE Q5 LED Headlamp Zoomable Headlight</a></div>
						<div class="thumbnail-overlay-price">$68.51</div>
						<div class="thumbnail-rating" style="background-position: 32px -1512px;"></div>
						<div class="thumbnail-review"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">(13 Reviews)</a></div>
						<div class="thumbnail-cat-name"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">In Home Living</a></div>
						<div class="thumbnail-cart"><a href="##" class="btn" style="padding-right:13px;">Add to cart</a></div>
					</div>
				</div>
			</li>
			<li class="single-products">
				<img class="thumbnail-img" src="#SESSION.absoluteUrlTheme#images/t4.jpg">
				<div class="thumbnail-name"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">USB TO PC Game Controller Adapter Converter For PS2</a></div>
				<div class="thumbnail-price">US$14.51</div>
				<div class="product-overlay">
					<div class="overlay-content">
						<div class="thumbnail-overlay-name" style="margin-top:10px;width:100%"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm" title="">USB TO PC Game Controller Adapter Converter For PS2</a></div>
						<div class="thumbnail-overlay-price">$14.51</div>
						<div class="thumbnail-rating" style="background-position: 32px -1512px;"></div>
						<div class="thumbnail-review"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">(13 Reviews)</a></div>
						<div class="thumbnail-cat-name"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">In Home Living</a></div>
						<div class="thumbnail-cart"><a href="##" class="btn" style="padding-right:13px;">Add to cart</a></div>
					</div>
				</div>
			</li>
			<li class="single-products">
				<img class="thumbnail-img" src="#SESSION.absoluteUrlTheme#images/t5.jpg">
				<div class="thumbnail-name"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">Safety Knife Innovative Pocket Credit Card Size Folding S...</a></div>
				<div class="thumbnail-price">US$2.51</div>
				<div class="product-overlay">
					<div class="overlay-content">
						<div class="thumbnail-overlay-name" style="margin-top:10px;width:100%"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm" title="Safety Knife Innovative Pocket Credit Card Size Folding Safe">Safety Knife Innovative Pocket Credit Card Size Folding S...</a></div>
						<div class="thumbnail-overlay-price">$2.51</div>
						<div class="thumbnail-rating" style="background-position: 32px -1512px;"></div>
						<div class="thumbnail-review"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">(13 Reviews)</a></div>
						<div class="thumbnail-cat-name"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">In Home Living</a></div>
						<div class="thumbnail-cart"><a href="##" class="btn" style="padding-right:13px;">Add to cart</a></div>
					</div>
				</div>
			</li>
			<li class="single-products">
				<img class="thumbnail-img" src="#SESSION.absoluteUrlTheme#images/t6.jpg">
				<div class="thumbnail-name"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">6pcs 150XL/.009in Electric Guitar Amp Strings Set</a></div>
				<div class="thumbnail-price">US$57.51</div>
				<img src="#SESSION.absoluteUrlTheme#images/freeshipping.jpg" style="width:120px;">
				<div class="product-overlay">
					<div class="overlay-content">
						<div class="thumbnail-overlay-name" style="margin-top:10px;width:100%"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm" title="6pcs 150XL/.009in Electric Guitar Amp Strings Set">6pcs 150XL/.009in Electric Guitar Amp Strings Set</a></div>
						<div class="thumbnail-overlay-price">$57.51</div>
						<div class="thumbnail-rating" style="background-position: 32px -1512px;"></div>
						<div class="thumbnail-review"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">(13 Reviews)</a></div>
						<div class="thumbnail-cat-name"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">In Home Living</a></div>
						<div class="thumbnail-cart"><a href="##" class="btn" style="padding-right:13px;">Add to cart</a></div>
					</div>
				</div>
			</li>
			<li class="single-products">
				<img class="thumbnail-img" src="#SESSION.absoluteUrlTheme#images/t6.jpg">
				<div class="thumbnail-name"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">6pcs 150XL/.009in Electric Guitar Amp Strings Set</a></div>
				<div class="thumbnail-price">US$57.51</div>
				<img src="#SESSION.absoluteUrlTheme#images/freeshipping.jpg" style="width:120px;">
				<div class="product-overlay">
					<div class="overlay-content">
						<div class="thumbnail-overlay-name" style="margin-top:10px;width:100%"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm" title="6pcs 150XL/.009in Electric Guitar Amp Strings Set">6pcs 150XL/.009in Electric Guitar Amp Strings Set</a></div>
						<div class="thumbnail-overlay-price">$57.51</div>
						<div class="thumbnail-rating" style="background-position: 32px -1512px;"></div>
						<div class="thumbnail-review"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">(13 Reviews)</a></div>
						<div class="thumbnail-cat-name"><a href="#APPLICATION.absoluteUrlWeb#product_detail.cfm">In Home Living</a></div>
						<div class="thumbnail-cart"><a href="##" class="btn" style="padding-right:13px;">Add to cart</a></div>
					</div>
				</div>
			</li>
		</ul>
	</div>
</div>
		
</cfoutput>
	