<cfoutput>
<!DOCTYPE html>
<html>
<head>
	<title>China Wholesale</title>
	<link rel="stylesheet" type="text/css" href="#SESSION.absolute_url_theme#css/style2.css" />
	<link rel="stylesheet" type="text/css" href="#SESSION.absolute_url_theme#css/style1.css" />
	<link rel="stylesheet" href="#SESSION.absolute_url_theme#css/jquery-ui.css">
	<link rel="stylesheet" href="#SESSION.absolute_url_theme#css/ui.easytree.css">
		
	<script type="text/javascript" src="#SESSION.absolute_url_theme#js/modernizr.custom.28468.js"></script>
	<script type="text/javascript" src="#SESSION.absolute_url_theme#js/jquery.min.js"></script>
	<script type="text/javascript" src="#SESSION.absolute_url_theme#js/jquery.cslider.js"></script>
	<script src="#SESSION.absolute_url_theme#js/jquery-ui.js"></script>
	<script src='#SESSION.absolute_url_theme#js/jquery.elevatezoom.js'></script>
	<script src='#SESSION.absolute_url_theme#js/jquery.easytree.min.js'></script>
	<script type="text/javascript">
		$(function() {
		
			$('##da-slider').cslider({
				autoplay	: true,
				bgincrement	: 0
			});
			
			$("##img_01").elevateZoom({gallery:'gallery_01', cursor: 'pointer', galleryActiveClass: 'active', borderSize: '1', imageCrossfade: true, loadingIcon: '#SESSION.absolute_url_theme#images/loader.gif'}); 
			$("##img_01").bind("click", function(e) { var ez = $('##img_01').data('elevateZoom');	$.fancybox(ez.getGalleryList()); return false; }); 
		
			var valueElement = $('##value');
			function incrementValue(e){
				valueElement.val(Math.max(parseInt(valueElement.val()) + e.data.increment, 0));
				return false;
			}

			$('##plus').bind('click', {increment: 1}, incrementValue);

			$('##minus').bind('click', {increment: -1}, incrementValue);
			
			$( "##product-description" ).tabs();
		
		
    var dialog, form,
 
       emailRegex = /^[a-zA-Z0-9.!##$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
      name = $( "##name" ),
      email = $( "##email" ),
      password = $( "##password" ),
      allFields = $( [] ).add( name ).add( email ).add( password ),
      tips = $( ".validateTips" );
 
    function updateTips( t ) {
      tips
        .text( t )
        .addClass( "ui-state-highlight" );
      setTimeout(function() {
        tips.removeClass( "ui-state-highlight", 1500 );
      }, 500 );
    }
 
    function checkLength( o, n, min, max ) {
      if ( o.val().length > max || o.val().length < min ) {
        o.addClass( "ui-state-error" );
        updateTips( "Length of " + n + " must be between " +
          min + " and " + max + "." );
        return false;
      } else {
        return true;
      }
    }
 
    function checkRegexp( o, regexp, n ) {
      if ( !( regexp.test( o.val() ) ) ) {
        o.addClass( "ui-state-error" );
        updateTips( n );
        return false;
      } else {
        return true;
      }
    }
 
    function addUser() {
      var valid = true;
      allFields.removeClass( "ui-state-error" );
 
      valid = valid && checkLength( name, "username", 3, 16 );
      valid = valid && checkLength( email, "email", 6, 80 );
      valid = valid && checkLength( password, "password", 5, 16 );
 
      valid = valid && checkRegexp( name, /^[a-z]([0-9a-z_\s])+$/i, "Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter." );
      valid = valid && checkRegexp( email, emailRegex, "eg. ui@jquery.com" );
      valid = valid && checkRegexp( password, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9" );
 
      if ( valid ) {
        $( "##users tbody" ).append( "<tr>" +
          "<td>" + name.val() + "</td>" +
          "<td>" + email.val() + "</td>" +
          "<td>" + password.val() + "</td>" +
        "</tr>" );
        dialog.dialog( "close" );
      }
      return valid;
    }
 
    dialog = $( "##dialog-form" ).dialog({
      autoOpen: false,
      height: 350,
      width: 300,
      modal: true,
	  show: 'fade',
	  hide: 'fade',
	  dialogClass: 'main-dialog-class',
      buttons: [
        
        {
            text: "Checkout",
            "class": 'checkoutButtonClass',
            click: function() {
			window.location.href='#APPLICATION.absolute_url_web#cart.cfm';
            }
        },
		{
            text: "Continute Shopping",
            "class": 'continuteButtonClass',
            click: function() {
			dialog.dialog('close');
            }
        }
    ],
	open: function(event) {
     $('.ui-dialog-buttonpane').find('button:contains("Continute Shopping")').css("margin-right","-9px");
 },
      close: function() {
       
      },
	
    });
 
    form = dialog.find( "form" ).on( "submit", function( event ) {
      event.preventDefault();
      addUser();
    });
 
    $( ".add-to-cart" ).on( "click", function() {
      dialog.dialog( "open" );
    });
	
	});
	</script>
</head>

<body>

	<div id="dialog-form" title="Product has been added to the cart">
		<div style="margin-top:10px;text-align:center;">
			
			<img class="thumbnail-img" src="#SESSION.absolute_url_theme#images/t1.jpg" />
		
			<p>7 Colors Changing Glow LED Light Water Stream Faucet Tap</p>
		</div>
	</div>
 
 

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
						<td><a href="#APPLICATION.absolute_url_web#login.cfm">Sign In</a> / <a href="#APPLICATION.absolute_url_web#login.cfm">Create Account</a></td>
					</tr>
				</table>
			</div>
			<div id="cart">
				<table>
					<tr>
						<td>
							<div id="top-order-tracking-icon"></div>
						</td>
						<td><a href="#APPLICATION.absolute_url_web#order_tracking.cfm">Order Tracking</a>&nbsp;&nbsp;&nbsp;</td>
						<td>
							<div id="top-myaccount-icon"></div>
						</td>
						<td><a href="#APPLICATION.absolute_url_web#myaccount/dashboard.cfm">My Account</a>&nbsp;&nbsp;&nbsp;</td>
						<td>
							<div id="top-faq-icon"></div>
						</td>
						<td><a href="#APPLICATION.absolute_url_web#faq.cfm">FAQs</a></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div id="header" class="container">
		<a href="#APPLICATION.absolute_url_web#index.cfm"><div id="logo"></div></a>
		<div id="minicart">
			<div style="position:relative;">
				<a class="btn" href="#APPLICATION.absolute_url_web#cart.cfm">Shopping Cart </a>
				<div id="cart-info">12</div>
			</div>
		</div>
		<div id="search">
			<form method="post">
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
			<input type="image" id="search-img" name="search" src="#SESSION.absolute_url_theme#images/search-img-up.png" />
			</form>
		</div>
	</div>
	<div id="nav-wrapper">
		<div id="nav">
			<div class="container">
				<ul>
					<li>
						<a href="#APPLICATION.absolute_url_web#index.cfm">Home</a>
					</li>
					<li>|</li>
					<li>
						<a href="#APPLICATION.absolute_url_web#products_new.cfm">New Arrivals</a>
					</li>
					<li>|</li>
					<li>
						<a href="#APPLICATION.absolute_url_web#products_specials.cfm">Specials</a>
					</li>
					<li>|</li>
					<li>
						<a href="#APPLICATION.absolute_url_web#products_deals.cfm">Weekly Deals</a>
					</li>
					<li>|</li>
					<li>
						<a href="#APPLICATION.absolute_url_web#products_clearance.cfm">Clearance</a>
					</li>
					<li>|</li>
					<li>
						<a href="#APPLICATION.absolute_url_web#products_top.cfm">Top Sellers</a>
					</li>
					<li>|</li>
					<li>
						<a href="#APPLICATION.absolute_url_web#about_us.cfm">About Us</a>
					</li>
					<li>|</li>
					<li>
						<a href="#APPLICATION.absolute_url_web#contact_us.cfm">Contact Us</a>
					</li>
					<li>|</li>
					<li>
						<a href="#APPLICATION.absolute_url_web#view_history.cfm">View History</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	
	<div id="content-top" class="container">
		<cfinclude template="#REQUEST.page_data.template_path#" />
	</div>
	
	<div style="clear:both;"></div>
	<div id="company-info">
		<div class="container">
			<div id="about-us">
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
					<td style="padding-bottom:10px;"><strong>INFORMATION</strong></td>
					<td style="width:60px;"></td>
					<td></td>
					<td style="width:60px;"></td>
					<td style="padding-bottom:10px;"><strong>COMPANY INFO</strong></td>
					<td style="width:200px;"></td>
					<td style="padding-bottom:10px;"><strong>CONNECT</strong></td>
				</tr>
				<tr>
					<td><a href="#APPLICATION.absolute_url_web#payment_info.cfm">Payment Info</a></td>
					<td></td>
					<td><a href="#APPLICATION.absolute_url_web#privacy.cfm">Privacy Policy</a></td>
					<td></td>
					<td><a href="#APPLICATION.absolute_url_web#about_us.cfm">About Us</a></td>
					<td></td>
					<td rowspan="5" valign="top">
						<div>
							<a href="#APPLICATION.absolute_url_web#">
							<img src="#SESSION.absolute_url_theme#images/facebook.png" style="width:24px;margin-right:10px;">
							</a>
							<a href="#APPLICATION.absolute_url_web#">
							<img src="#SESSION.absolute_url_theme#images/google.png" style="width:24px;margin-right:10px;">
							</a>
							<a href="#APPLICATION.absolute_url_web#">
							<img src="#SESSION.absolute_url_theme#images/YouTube2.png" style="width:24px;margin-right:10px;">
							</a>
							<a href="#APPLICATION.absolute_url_web#">
							<img src="#SESSION.absolute_url_theme#images/Linkedein.png" style="width:24px;margin-right:10px;">
							</a>
							<a href="#APPLICATION.absolute_url_web#">
							<img src="#SESSION.absolute_url_theme#images/Instagram.png" style="width:24px;">
							</a>
						</div>
						<div style="margin-top:20px;font-weight:bold;">CUSTOMER SERVICE:&nbsp;&nbsp;<span style="letter-spacing:1px;">416.666.6666</span></div>
						<div style="margin:20px 0 10px 0;">Get the latest product information!</div>
						<div style="margin:10px 0 0 0;"><input style="padding:4px 10px 4px 10px;border-radius:4px;width:230px;" type="text" name="subscription_email" placeholder="Please enter your Email" /></div>
					</td>
				</tr>
				<tr>
					<td><a href="#APPLICATION.absolute_url_web#shipping_info.cfm">Shipping Info</a></td>
					<td></td>
					<td><a href="#APPLICATION.absolute_url_web#term_of_use.cfm">Terms of Use</a></td>
					<td></td>
					<td><a href="#APPLICATION.absolute_url_web#contact_us.cfm">Contact Us</a></td>
					<td></td>
				</tr>
				<tr>
					<td><a href="#APPLICATION.absolute_url_web#estimate.cfm">Delivery Estimate</a></td>
					<td></td>
					<td><a href="#APPLICATION.absolute_url_web#return_policy.cfm">Return Policy</a></td>
					<td></td>
					<td><a href="#APPLICATION.absolute_url_web#faq.cfm">FAQs</a></td>
					<td></td>
				</tr>
				<tr>
					<td><a href="#APPLICATION.absolute_url_web#locations.cfm">Locations</a></td>
					<td></td>
					<td><a href="#APPLICATION.absolute_url_web#wholesale.cfm">Wholesale</a></td>
					<td></td>
					<td><a href="#APPLICATION.absolute_url_web#report_problems.cfm">Report Problems</a></td>
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
							<a href="#APPLICATION.absolute_url_web#secure_shopping.cfm" style="color:##333;">SECURE SHOPPING</a>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="6" style="padding-top:15px;">
						1998 - 2014, TOMTOP, Inc. | <a href="#APPLICATION.absolute_url_web#conditions_of_use.cfm">Conditions of Use</a> | <a href="#APPLICATION.absolute_url_web#site_index.cfm">Site Index</a>
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