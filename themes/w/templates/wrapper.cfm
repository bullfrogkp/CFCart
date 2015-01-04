<cfoutput>
<!DOCTYPE html>
<html>
<head>
	<title>China Wholesale</title>
	<link rel="stylesheet" type="text/css" href="#SESSION.absolute_url_theme#css/style2.css" />
	<link rel="stylesheet" type="text/css" href="#SESSION.absolute_url_theme#css/style1.css" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
	<script type="text/javascript" src="#SESSION.absolute_url_theme##SESSION.absolute_url_theme#js/modernizr.custom.28468.js"></script>
	<script type="text/javascript" src="#SESSION.absolute_url_theme#http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script type="text/javascript" src="#SESSION.absolute_url_theme##SESSION.absolute_url_theme#js/jquery.cslider.js"></script>
	<script src="#SESSION.absolute_url_theme#//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
	<script src='#SESSION.absolute_url_theme#js/jquery.elevatezoom.js'></script>
	<script type="text/javascript">
		$(function() {
		
			$('##da-slider').cslider({
				autoplay	: true,
				bgincrement	: 0
			});
			
			$("##img_01").elevateZoom({gallery:'gallery_01', cursor: 'pointer', galleryActiveClass: 'active', borderSize: '1', imageCrossfade: true, loadingIcon: 'http://www.elevateweb.co.uk/spinner.gif'}); 
			$("##img_01").bind("click", function(e) { var ez = $('##img_01').data('elevateZoom');	$.fancybox(ez.getGalleryList()); return false; }); 
		
			var valueElement = $('##value');
			function incrementValue(e){
				valueElement.val(Math.max(parseInt(valueElement.val()) + e.data.increment, 0));
				return false;
			}

			$('##plus').bind('click', {increment: 1}, incrementValue);

			$('##minus').bind('click', {increment: -1}, incrementValue);
			
			$( "##product-description" ).tabs();
		});
	</script>
</head>

<body>
	<div id="top-nav">
		<div class="container">
			<div id="top-info">
				<table>
					<tr>
						<td>
							<div id="top-currency-icon">USD</div>
						</td>
						<td style="padding-left:10px;">
							<div id="top-signin-icon"></div>
						</td>
						<td><a href="">Sign In</a> / <a href="">Create Account</a></td>
					</tr>
				</table>
			</div>
			<div id="cart">
				<table>
					<tr>
						<td>
							<div id="top-order-tracking-icon"></div>
						</td>
						<td><a href="">Order Tracking</a>&nbsp;&nbsp;&nbsp;</td>
						<td>
							<div id="top-myaccount-icon"></div>
						</td>
						<td><a href="">My Account</a>&nbsp;&nbsp;&nbsp;</td>
						<td>
							<div id="top-faq-icon"></div>
						</td>
						<td><a href="">FAQ</a></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div id="header" class="container">
		<div id="logo"></div>
		<div id="minicart">
			<div style="position:relative;">
				<a class="btn" href="">Shopping Cart </a>
				<div id="cart-info">12</div>
			</div>
		</div>
		<div id="search">
			<div id="search-label">Search: </div>
			<select id="search-category" name="search_category_id">
				<option value="0">All Categories</option>
				<option value="0">Computers / Networking</option>
				<option value="0">Tablet PCs &amp; Cell Phone</option>
				<option value="0">Home, Garden &amp; Tools</option>
				<option value="0">Sports &amp; Outdoor</option>
				<option value="0">Lighting / Flashlights / LEDs</option>
				<option value="0">Health / Beauty</option>
				<option value="0">Clothing / Accessories</option>
				<option value="0">Video &amp; Audio</option>
				<option value="0">Car Accessories</option>
				<option value="0">Cameras &amp; Photo Accessories</option>
				<option value="0">RC Models and Accessories</option>
				<option value="0">Toys / Hobbies</option>
				<option value="0">Jewelry</option>
				<option value="0">Video Games</option>
				<option value="0">Musical Instruments</option>
				<option value="0">Test Equipment &amp; Tools</option>
			</select>
			<input id="search-text" type="text" placeholder="Search..." />
			<img src="#SESSION.absolute_url_theme#images/search-img-up.png" style="height:28px;margin-top:1px;" />
		</div>
	</div>
	<div style="border-top:1px solid ##3A3939;border-bottom:1px solid ##3A3939;">
		<div id="nav">
			<div class="container">
				<ul>
					<li>
						Home
					</li>
					<li>|</li>
					<li>
						New Arrivals
					</li>
					<li>|</li>
					<li>
						Specials
					</li>
					<li>|</li>
					<li>
						Daily Deals
					</li>
					<li>|</li>
					<li>
						Clearance
					</li>
					<li>|</li>
					<li>
						Top Sellers
					</li>
					<li>|</li>
					<li>
						Your Account
						<ul>
							<li style="padding:0;">
								<div class="submenu" id="your-account">
									<table>
										<tbody>
											<tr>
												<td><a href="">Sign In</a></td>
											</tr>
											<tr>
												<td><a href="">New Customer Sign Up</a></td>
											</tr>
											<tr>
												<td><a href="">Order Tracking</a></td>
											</tr>
											<tr>
												<td><a href="">View History</a></td>
											</tr>
										</tbody>
									</table>
								</div>
							</li>
						</ul>
					</li>
					<li>|</li>
					<li>
						About Us
					</li>
					<li>|</li>
					<li>
						Contact Us
					</li>
				</ul>
				<div style="float:right;margin-top:5px;padding-right:8px;z-index:30;position:relative;">
				</div>
			</div>
		</div>
	</div>
	<div id="content-top" style="padding-top:2px;" class="container">
		<div id="breadcrumb" style="font-size:12px;margin-top:8px;margin-bottom:13px;">
			<div class="breadcrumb-home-icon">
			</div>
			<div class="breadcrumb-arrow-icon">
			</div>
			<span style="vertical-align:middle">My Account</span> 
			<div class="breadcrumb-arrow-icon">
			</div>
			<span style="vertical-align:middle">Dashboard</span> 
		</div>
		<div id="myaccount-sidenav">
			<div class="recommendation" style="width:188px;">
				My Account
			</div>
			<div class="recommendation-list" style="font-size:12px;padding-bottom:0;">
				<ul>
					<li>
						<a href="">Dashboard</a>
					</li>
					<li>
						<a href="">My Orders</a>
					</li>
					<li>
						<a href="">My Addresses</a>
					</li>
					<li>
						<a href="">My Product Reviews</a>
					</li>
					<li>
						<a href="">My Wishlist</a>
					</li>
					<li>
						<a href="">My Coupons</a>
					</li>
					<li>
						<a href="">My Subscriptions</a>
					</li>
					<li style="border-bottom:none;">
						<a href="">Change Password</a>
					</li>
				</ul>
			</div>
		</div>
		<div id="myaccount-content">
			<h1>My Orders</h1>
			<div style="margin-top:20px;">
				<div class="myaccount-table" >
					<table >
						<tr>
							<td>
								Order No.
							</td>
							<td >
									Email
							</td>
							<td>
									Name
							</td>
							<td >
								Total	
							</td>
							<td >
									Create Datetime	
							</td>
							<td >
									Status	
							</td>
							<td >
									Invoice
							</td>
						</tr>
						<tr>
							<td >
								OR20141227227 
							</td>
							<td>
								michelle@aaa.com
							</td>
							<td>
								Michell
							</td>
							<td>
								700
							</td>
							<td>
								2014 Dec 27 02:14:32
							</td>
							<td>
								Shipped
							</td>
							<td>
								<a href="">Invoice</a>
							</td>
						</tr>
						<tr>
							<td >
								OR20141227227 
							</td>
							<td>
								michelle@aaa.com
							</td>
							<td>
								Michell
							</td>
							<td>
								700
							</td>
							<td>
								2014 Dec 27 02:14:32
							</td>
							<td>
								Shipped
							</td>
							<td>
								<a href="">Invoice</a>
							</td>
						</tr>
						<tr>
							<td >
								OR20141227227 
							</td>
							<td>
								michelle@aaa.com
							</td>
							<td>
								Michell
							</td>
							<td>
								700
							</td>
							<td>
								2014 Dec 27 02:14:32
							</td>
							<td>
								Shipped
							</td>
							<td>
								<a href="">Invoice</a>
							</td>
						</tr>
						<tr>
							<td >
								OR20141227227 
							</td>
							<td>
								michelle@aaa.com
							</td>
							<td>
								Michell
							</td>
							<td>
								700
							</td>
							<td>
								2014 Dec 27 02:14:32
							</td>
							<td>
								Shipped
							</td>
							<td>
								<a href="">Invoice</a>
							</td>
						</tr>
						<tr>
							<td >
								OR20141227227 
							</td>
							<td>
								michelle@aaa.com
							</td>
							<td>
								Michell
							</td>
							<td>
								700
							</td>
							<td>
								2014 Dec 27 02:14:32
							</td>
							<td>
								Shipped
							</td>
							<td>
								<a href="">Invoice</a>
							</td>
						</tr>
						<tr>
							<td >
								OR20141227227 
							</td>
							<td>
								michelle@aaa.com
							</td>
							<td>
								Michell
							</td>
							<td>
								700
							</td>
							<td>
								2014 Dec 27 02:14:32
							</td>
							<td>
								Shipped
							</td>
							<td>
								<a href="">Invoice</a>
							</td>
						</tr>
					</table>
				</div>
				
				<div style="clear:both;"></div>
			</div>
		</div>
	</div>
	<div style="clear:both;"></div>
	<div id="company-info" style="background-color: ##efefef;padding-top:10px;margin-top:15px;">
		<div class="container">
			<div id="about-us" style="margin-bottom:14px;width:550px;float:left;">
				<h2>About Us</h2>
				<p style="font-size:12px;line-height:18px;margin:0;padding:0;">
					As a new and growing company in Canada, TOMTOP is dedicated to be one of the best supplier of high quality products. We have our own manufactory in China with more than 15-year history and our company goal is to have the larger selection of photographic supplies around at the best prices you will find anywhere. 
				</p>
				<div id="sidebar" style="margin:12px 0 10px 0">
					<form id="signup">
						<div class="signup-header">
							<h3>Newsletter Subscription</h3>
							<p>Get the latest product and promotion information!</p>
						</div>
						<div class="inputs">
							<input type="email" placeholder="Email" />
							<a id="submit" href="##">SIGN UP FOR SUBSCRIPTION</a>
						</div>
					</form>
				</div>
			</div>
			<div id="secure-shopping" style="margin-bottom:14px;width:350px;float:right;">
				<h2>Secure Shopping</h2>
				<p style="font-size:12px;line-height:18px;margin:0;padding:0;margin-bottom:12px;">
					We want you to have peace of mind when shopping online at TOMTOP. If you are not an existing TOMTOP customer, rest assured that shopping here is safe. Our security systems use up-to-date technology embodying industry standards, and secure shopping is our priority. The TOMTOP Secure Shopping Guarantee is our commitment to you. 
				</p>
				<img src="#SESSION.absolute_url_theme#images/visa1.gif">
				<img src="#SESSION.absolute_url_theme#images/mastercard1.gif">
				<img src="#SESSION.absolute_url_theme#images/amex1.gif">
				<img src="#SESSION.absolute_url_theme#images/paypal.gif" style="height:31px;">
			</div>
			<div style="clear:both;"></div>
		</div>
	</div>
	<div id="footer">
		<div class="container">
			<table>
				<tr>
					<td style="padding-bottom:10px;"><strong>CUSTOMER CARE</strong></td>
					<td style="width:60px;"></td>
					<td></td>
					<td style="width:60px;"></td>
					<td style="padding-bottom:10px;"><strong>INFORMATION</strong></td>
					<td style="width:200px;"></td>
					<td style="padding-bottom:10px;"><strong>CONNECT</strong></td>
				</tr>
				<tr>
					<td>Contact Us</td>
					<td></td>
					<td>Privacy Policy</td>
					<td></td>
					<td>About Us</td>
					<td></td>
					<td rowspan="5" valign="top">
						<div>
							<img src="#SESSION.absolute_url_theme#images/facebook.png" style="width:24px;margin-right:10px;">
							<img src="#SESSION.absolute_url_theme#images/google.png" style="width:24px;margin-right:10px;">
							<img src="#SESSION.absolute_url_theme#images/YouTube2.png" style="width:24px;margin-right:10px;">
							<img src="#SESSION.absolute_url_theme#images/Linkedein.png" style="width:24px;margin-right:10px;">
							<img src="#SESSION.absolute_url_theme#images/Instagram.png" style="width:24px;">
						</div>
						<div style="margin-top:20px;font-weight:bold;">CUSTOMER SERVICE:&nbsp;&nbsp;<span style="letter-spacing:1px;">416.666.6666</span></div>
						<div style="margin:20px 0 10px 0;">Get the latest product information!</div>
						<div style="margin:10px 0 0 0;"><input style="padding:4px 10px 4px 10px;border-radius:4px;width:230px;" type="text" name="subscription_email" placeholder="Please enter your Email" /></div>
					</td>
				</tr>
				<tr>
					<td>FAQs</td>
					<td></td>
					<td>Terms of Use</td>
					<td></td>
					<td>Careers</td>
					<td></td>
				</tr>
				<tr>
					<td>Shipping & Returns</td>
					<td></td>
					<td>Feedback</td>
					<td></td>
					<td>Affiliate</td>
					<td></td>
				</tr>
				<tr>
					<td>Guarantee</td>
					<td></td>
					<td>Gift Certificates</td>
					<td></td>
					<td>Press</td>
					<td></td>
				</tr>
				<tr>
					<td colspan="6">
						<div id="cards">
							<img src="#SESSION.absolute_url_theme#images/visa1.gif">
							<img src="#SESSION.absolute_url_theme#images/mastercard1.gif">
							<img src="#SESSION.absolute_url_theme#images/amex1.gif">
							<img src="#SESSION.absolute_url_theme#images/paypal.gif">
						</div>
						<div id="bottom-secure-shopping">
							SECURE SHOPPING
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="6" style="padding-top:15px;">
						1998 - 2014, TOMTOP, Inc. | Conditions of Use | Site Index
					</td>
					<td>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
</cfoutput>