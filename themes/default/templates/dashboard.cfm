<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">My Account</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Dashboard</span> 
</div>
				
<cfinclude template="myaccount_sidenav.cfm" />
<div style="width:750px;float:right;font-size:12px;">
	<div style="line-height:18px;">
	<strong>Hello, #REQUEST.pageData.customer.getFirstName()# !</strong>
	<p>From your My Account Dashboard you have the ability to view a snapshot of your recent account activity and update your account information. Select a link below to view or edit information.</p>
	</div>
	<div style="background-color:##F2F2F2;padding:20px;">
		<ul style="margin-left:-0.5%;list-style-type:none;">
			<li style="width:29%;float:left;margin-left:0.5%;padding-right:20px;height:171px;">
				<div style="font-weight:bold;padding-bottom:10px;margin-bottom:5px;border-bottom:1px solid ##CCC;line-height:20px;">
					Contact Information
					<button style="float:right;font-size:12px;">Edit</button>
				</div>
				
				<p>Name: #REQUEST.pageData.customer.getFullName()#</p>
				<p>Email: #REQUEST.pageData.customer.getEmail()#</p>
				<p>Phone: #REQUEST.pageData.customer.getPhone()#</p>
				<p>Company: #REQUEST.pageData.customer.getCompany()#</p>
			</li>
			<li style="width:29%;float:left;margin-left:0.5%;padding-left:20px;padding-right:20px;border-left:1px solid ##CCC;height:171px;">
				<div style="font-weight:bold;padding-bottom:10px;margin-bottom:5px;border-bottom:1px solid ##CCC;line-height:20px;">
					Subscription
					<button style="float:right;font-size:12px;">Edit</button>
				</div>
				<p>You are currently subscribed to our newsletter.</p>
			</li>
			<li style="width:29%;float:left;margin-left:0.5%;padding-left:20px;height:171px;border-left:1px solid ##CCC;">
				<div style="font-weight:bold;padding-bottom:10px;margin-bottom:5px;border-bottom:1px solid ##CCC;line-height:20px;">
					Primary Shipping Address
					<button style="float:right;font-size:12px;">Edit</button>
				</div>
				<p>366 Adelaide Street West, Suite 701</p>
				<p>Toronto, ON M5V 1R9</p>
			</li>
		</ul>
		<div style="clear:both;"></div>
	</div>
</div>
</cfoutput>