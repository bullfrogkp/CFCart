<cfoutput>
<section class="content-header">
	<h1>
		Order ## #REQUEST.pageData.order.getOrderTrackingNumber()# | #DateFormat(REQUEST.pageData.order.getCreatedDatetime(),"mmm dd, yyyy")# #TimeFormat(REQUEST.pageData.order.getCreatedDatetime(),"hh:mm:ss")#
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Order Detail</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.order.getOrderId()#" />
<input type="hidden" name="tab_id" id="tab_id" value="#REQUEST.pageData.tabs.activeTabId#" />
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<!-- Custom Tabs -->
			<div class="nav-tabs-custom">
				<ul class="nav nav-tabs">
					<li class="tab-title #REQUEST.pageData.tabs['tab_1']#" tabid="tab_1"><a href="##tab_1" data-toggle="tab">Information</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_2']#" tabid="tab_2"><a href="##tab_2" data-toggle="tab">Tracking</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_3']#" tabid="tab_3"><a href="##tab_3" data-toggle="tab">Product Status</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_4']#" tabid="tab_4"><a href="##tab_4" data-toggle="tab">Invoice</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane #REQUEST.pageData.tabs['tab_1']#" id="tab_1">
						<section class="content">
							<div class="row">
								<div class="col-md-6">
									<div class="box box-primary">
										<div class="box-header">
											<h3 class="box-title">Order ## #REQUEST.pageData.order.getOrderTrackingNumber()#</h3>
										</div><!-- /.box-header -->
										<div class="box-body">
											<dl class="dl-horizontal">
												<dt>Order Date</dt>
												<dd>#DateFormat(REQUEST.pageData.order.getCreatedDatetime(),"mmm dd, yyyy")# #TimeFormat(REQUEST.pageData.order.getCreatedDatetime(),"hh:mm:ss")#</dd>
												<dt>Order Status</dt>
												<dd>#REQUEST.pageData.currentOrderStatus.getOrderStatusType().getDisplayName()#</dd>
												<dt>Placed from IP</dt>
												<dd>#REQUEST.pageData.order.getCreatedUser()#</dd>
											</dl>
										</div><!-- /.box-body -->
									</div><!-- /.box -->
								</div><!-- ./col -->
								<div class="col-md-6">
									<div class="box box-primary">
										<div class="box-header">
											<h3 class="box-title">Account Information</h3>
										</div><!-- /.box-header -->
										<div class="box-body">
											<dl class="dl-horizontal">
												<dt>Customer</dt>
												<dd>
													<cfif NOT IsNull(REQUEST.pageData.order.getCustomer())>
														#REQUEST.pageData.order.getCustomer().getFirstName()# #REQUEST.pageData.order.getCustomer().getMiddleName()# #REQUEST.pageData.order.getCustomer().getLastName()#
													</cfif>
												</dd>
												<dt>Email</dt>
												<dd>
													<cfif NOT IsNull(REQUEST.pageData.order.getCustomer())>
														#REQUEST.pageData.order.getCustomer().getEmail()#
													</cfif>
												</dd>
												<dt>Customer Group</dt>
												<dd>
													<cfif NOT IsNull(REQUEST.pageData.order.getCustomer())>
														#REQUEST.pageData.order.getCustomer().getCustomerGroup().getDisplayName()#
													</cfif>
												</dd>
											</dl>
										</div><!-- /.box-body -->
									</div><!-- /.box -->
								</div><!-- ./col -->
							</div><!-- /.row -->
							<div class="row">
								<div class="col-md-6">
									<div class="box box-primary">
										<div class="box-header">
											<h3 class="box-title">Billing Address</h3>
										</div><!-- /.box-header -->
										<div class="box-body">
											<dl>
												<dd>#REQUEST.pageData.order.getBillingStreet()#</dd>
												<dd>#REQUEST.pageData.order.getBillingCity()#</dd>
												<dd>#REQUEST.pageData.order.getBillingCountry().getDisplayName()#</dd>
												<dd>#REQUEST.pageData.order.getBillingProvince().getDisplayName()#</dd>
												<dd>#REQUEST.pageData.order.getBillingPostalCode()#</dd>
											</dl>
										</div><!-- /.box-body -->
									</div><!-- /.box -->
								</div><!-- ./col -->
								<div class="col-md-6">
									<div class="box box-primary">
										<div class="box-header">
											<h3 class="box-title">Shipping Address</h3>
										</div><!-- /.box-header -->
										<div class="box-body">
											<dl>
												<dd>#REQUEST.pageData.order.getShippingStreet()#</dd>
												<dd>#REQUEST.pageData.order.getShippingCity()#</dd>
												<dd>#REQUEST.pageData.order.getShippingCountry().getDisplayName()#</dd>
												<dd>#REQUEST.pageData.order.getShippingProvince().getDisplayName()#</dd>
												<dd>#REQUEST.pageData.order.getShippingPostalCode()#</dd>
											</dl>
										</div><!-- /.box-body -->
									</div><!-- /.box -->
								</div><!-- ./col -->
							</div><!-- /.row -->
							
							
							<div class="row">
								<div class="col-md-6">
									<div class="box box-primary">
										<div class="box-header">
											<h3 class="box-title">Payment Information</h3>
										</div><!-- /.box-header -->
										<div class="box-body">
											<dl>
												<dd>#REQUEST.pageData.order.getPaymentMethod().getDisplayName()#</dd>
											</dl>
										</div><!-- /.box-body -->
									</div><!-- /.box -->
								</div><!-- ./col -->
								<div class="col-md-6">
									<div class="box box-primary">
										<div class="box-header">
											<h3 class="box-title">Coupon Code</h3>
										</div><!-- /.box-header -->
										<div class="box-body">
											<dl>
												<dd>#REQUEST.pageData.order.getPaymentMethod().getDisplayName()#</dd>
											</dl>
										</div>
									</div>
								</div><!-- ./col -->
							</div><!-- /.row -->
							
							<div class="row">
								<section class="col-lg-12"> 
									<div class="box box-primary">
										<div class="box-header">
											<h3 class="box-title">Products</h3>
										</div><!-- /.box-header -->
										<div class="box-body">
											<table class="table table-bordered table-striped">
												
													<th>Product</th>
													<th>Name</th>
													<th>SKU</th>
													<th>Price</th>
													<th>Qty</th>
													<th>Shipping Method</th>
													<th>Status</th>
													<th>Subtotal</th>
													<th>Tax Amount</th>
													<th>Shipping Amount</th>
													<th>Tax Percentage</th>
													<th>Row Total</th>
												
													<cfloop array="#REQUEST.pageData.order.getProducts()#" index="product">
														<cfif NOT IsNull(product.getImageName())>
															<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/uploads/product/#product.getProductId()#/#product.getImageName()#" />
														<cfelse>
															<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/site/no_image_available.png" />
														</cfif>
														<tr>
															<td><img class="img-responsive" src="#imageLink#" style="width:100px;" /></td>
															<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#product.getProductId()#">#product.getProductName()#</a></td>
															<td>#product.getSKU()#</td>
															<td>#product.getOrderPrice()#</td>
															<td>#product.getQuantity()#</td>
															<td>#product.getShippingCarrierName()# - #product.getShippingMethodName()#</td>
															<td>#EntityLoad("order_product_status", {orderProduct = product,current = true}, true).getOrderProductStatusType().getDisplayName()#</td>
															<td>#product.getSubtotalAmount()#</td>
															<td>#product.getTaxAmount()#</td>
															<td>#product.getShippingAmount()#</td>
															<td>#product.getTaxRate()#</td>
															<td>#product.getShippingAmount() + product.getSubtotalAmount() + product.getTaxAmount()#</td>
														</tr>
													</cfloop>
												
											</table>
										</div>
									</div><!-- /.box (chat box) -->   
								</section>
							</div><!-- /.row (main row) -->
							
							<div class="row">
								<section class="col-lg-6"> 
									<div class="box box-primary">
										<div class="box-header">
											<h3 class="box-title">Status</h3>
										</div><!-- /.box-header -->
										
										<div class="box-body">
											<div class="form-group">
												<table class="table table-bordered table-striped">
													<tr>
														<th>Status</th>
														<th>Create Datetime</th>
														<th>End Datetime</th>
														<th>Comment</th>
													</tr>
												
													<cfloop array="#REQUEST.pageData.order.getOrderStatus()#" index="status">
													<tr>
														<td>#status.getOrderStatusType().getDisplayName()#</td>
														<td>#DateFormat(status.getStartDatetime(),"mmm dd, yyyy")# #TimeFormat(status.getStartDatetime(),"hh:mm:ss")#</td>
														<td>#DateFormat(status.getEndDatetime(),"mmm dd, yyyy")# #TimeFormat(status.getEndDatetime(),"hh:mm:ss")#</td>
														<td>#status.getComments()#</td>
													</tr>
													</cfloop>
												</table>
											</div>
											<div class="form-group">
												<select class="form-control" name="order_status_type_id">
													<option value="">Please Select Status...</option>
													<cfloop array="#REQUEST.pageData.orderStatusTypes#" index="type">
														<option value="#type.getOrderStatusTypeId()#">#type.getDisplayName()#</option>
													</cfloop>
												</select>
											</div>
											<div class="form-group">
												<textarea class="form-control" rows="8" placeholder="Comments..."></textarea>
											</div>
											<button name="save_order_status" type="submit" class="btn btn-primary">Save Status</button>
										</div>
									</div><!-- /.box (chat box) -->   
								</section><!-- /.Left col -->
								<!-- right col (We are only adding the ID to make the widgets sortable)-->
								<section class="col-lg-6"> 
									<div class="box box-primary">
										<div class="box-header">
											<h3 class="box-title">Order Totals</h3>
										</div><!-- /.box-header -->
										<div class="box-body">
											<div class="table-responsive">
												<table class="table">
													<tr>
														<th style="width:50%">Subtotal:</th>
														<td>#DollarFormat(REQUEST.pageData.orderSubtotalAmount)#</td>
													</tr>
													<tr>
														<th>Shipping & Handling</th>
														<td>#DollarFormat(REQUEST.pageData.orderShippingAmount)#</td>
													</tr>
													<tr>
														<th>Tax</th>
														<td>#DollarFormat(REQUEST.pageData.orderTaxAmount)#</td>
													</tr>
													<tr>
														<th>Total:</th>
														<td>#DollarFormat(REQUEST.pageData.orderTotalAmount)#</td>
													</tr>
												</table>
											</div>
										</div>
									</div>
									<!-- /.box -->
								</section><!-- right col -->
							</div><!-- /.row (main row) -->
						</section><!-- /.content -->
						
					</div>
					<div class="tab-pane #REQUEST.pageData.tabs['tab_2']#" id="tab_2">
					
						<div class="form-group">
							<label>Shipping Tracking Number</label>
							<input name="shipping_tracking_number" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.order.getShippingTrackingNumber()#"/>
						</div>
						<button name="save_shipping_tracking_number" type="submit" class="btn btn-primary">Submit</button>
						
					</div>
					<div class="tab-pane #REQUEST.pageData.tabs['tab_3']#" id="tab_3">
						<div class="row">
						<cfloop array="#REQUEST.pageData.order.getProducts()#" index="product">
							<div class="col-lg-6"> 
								<div class="box box-primary">
									<div class="box-header">
										<h3 class="box-title">#product.getDisplayName()#</h3>
									</div><!-- /.box-header -->
									
									<div class="box-body">
										<div class="form-group">
											<table class="table table-bordered table-striped">
											
												<tr>
													<th>Status</th>
													<th>Create Datetime</th>
													<th>End Datetime</th>
													<th>Comments</th>
												</tr>
										
												<cfloop array="#product.getOrderProductStatus()#" index="status">
												<tr>
													<td>#status.getOrderProductStatusType().getDisplayName()#</td>
													<td>#DateFormat(status.getStartDatetime(),"mmm dd, yyyy")# #TimeFormat(status.getStartDatetime(),"hh:mm:ss")#</td>
													<td>#DateFormat(status.getEndDatetime(),"mmm dd, yyyy")# #TimeFormat(status.getEndDatetime(),"hh:mm:ss")#</td>
													<td>#status.getComments()#</td>
												</tr>
												</cfloop>
												
											</table>
										</div>
										<div class="form-group">
											<select class="form-control" name="order_product_status_type_id">
												<option value="">Please Select Status...</option>
												<cfloop array="#REQUEST.pageData.orderProductStatusTypes#" index="type">
													<option value="#type.getOrderProductStatusTypeId()#">#type.getDisplayName()#</option>
												</cfloop>
											</select>
										</div>
										<div class="form-group">
											<textarea name="comments" class="form-control" rows="8" placeholder="Comments ..."></textarea>
										</div>
										<button name="save_product_status" type="submit" class="btn btn-primary">Save Status</button>
									</div>
								</div><!-- /.box (chat box) -->   
							</div>
						</cfloop>
						</div>
					</div>
					<div class="tab-pane #REQUEST.pageData.tabs['tab_4']#" id="tab_4">
						<!-- Main content -->
						<section class="content invoice">
							<!-- title row -->
							<div class="row">
								<div class="col-xs-12">
									<h2 class="page-header">
										<i class="fa fa-globe"></i> AdminLTE, Inc.
										<small class="pull-right">Date: 2/10/2014</small>
									</h2>
								</div><!-- /.col -->
							</div>
							<!-- info row -->
							<div class="row invoice-info">
								<div class="col-sm-4 invoice-col">
									From
									<address>
										<strong>Admin, Inc.</strong><br>
										795 Folsom Ave, Suite 600<br>
										San Francisco, CA 94107<br>
										Phone: (804) 123-5432<br/>
										Email: info@almasaeedstudio.com
									</address>
								</div><!-- /.col -->
								<div class="col-sm-4 invoice-col">
									To
									<address>
										<strong>John Doe</strong><br>
										795 Folsom Ave, Suite 600<br>
										San Francisco, CA 94107<br>
										Phone: (555) 539-1037<br/>
										Email: john.doe@example.com
									</address>
								</div><!-- /.col -->
								<div class="col-sm-4 invoice-col">
									<b>Invoice ##007612</b><br/>
									<br/>
									<b>Order ID:</b> 4F3S8J<br/>
									<b>Payment Due:</b> 2/22/2014<br/>
									<b>Account:</b> 968-34567
								</div><!-- /.col -->
							</div><!-- /.row -->

							<!-- Table row -->
							<div class="row">
								<div class="col-xs-12 table-responsive">
									<table class="table table-striped">
										<thead>
											<tr>
												<th>Qty</th>
												<th>Product</th>
												<th>Serial ##</th>
												<th>Description</th>
												<th>Subtotal</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>1</td>
												<td>Call of Duty</td>
												<td>455-981-221</td>
												<td>El snort testosterone trophy driving gloves handsome</td>
												<td>$64.50</td>
											</tr>
											<tr>
												<td>1</td>
												<td>Need for Speed IV</td>
												<td>247-925-726</td>
												<td>Wes Anderson umami biodiesel</td>
												<td>$50.00</td>
											</tr>
											<tr>
												<td>1</td>
												<td>Monsters DVD</td>
												<td>735-845-642</td>
												<td>Terry Richardson helvetica tousled street art master</td>
												<td>$10.70</td>
											</tr>
											<tr>
												<td>1</td>
												<td>Grown Ups Blue Ray</td>
												<td>422-568-642</td>
												<td>Tousled lomo letterpress</td>
												<td>$25.99</td>
											</tr>
										</tbody>
									</table>
								</div><!-- /.col -->
							</div><!-- /.row -->

							<div class="row">
								<!-- accepted payments column -->
								<div class="col-xs-6">
									<p class="lead">Payment Methods:</p>
									<img src="#SESSION.absoluteUrlThemeAdmin#img/credit/visa.png" alt="Visa"/>
									<img src="#SESSION.absoluteUrlThemeAdmin#img/credit/mastercard.png" alt="Mastercard"/>
									<img src="#SESSION.absoluteUrlThemeAdmin#img/credit/american-express.png" alt="American Express"/>
									<img src="#SESSION.absoluteUrlThemeAdmin#img/credit/paypal2.png" alt="Paypal"/>
									<p class="text-muted well well-sm no-shadow" style="margin-top: 10px;">
										Etsy doostang zoodles disqus groupon greplin oooj voxy zoodles, weebly ning heekya handango imeem plugg dopplr jibjab, movity jajah plickers sifteo edmodo ifttt zimbra.
									</p>
								</div><!-- /.col -->
								<div class="col-xs-6">
									<p class="lead">Amount Due 2/22/2014</p>
									<div class="table-responsive">
										<table class="table">
											<tr>
												<th style="width:50%">Subtotal:</th>
												<td>$250.30</td>
											</tr>
											<tr>
												<th>Tax (9.3%)</th>
												<td>$10.34</td>
											</tr>
											<tr>
												<th>Shipping:</th>
												<td>$5.80</td>
											</tr>
											<tr>
												<th>Total:</th>
												<td>$265.24</td>
											</tr>
										</table>
									</div>
								</div><!-- /.col -->
							</div><!-- /.row -->

							<!-- this row will not appear when printing -->
							<div class="row no-print">
								<div class="col-xs-12">
									<button class="btn btn-default" onclick="window.print();"><i class="fa fa-print"></i> Print</button>
									<button class="btn btn-success pull-right"><i class="fa fa-credit-card"></i> Submit Payment</button>
									<button class="btn btn-primary pull-right" style="margin-right: 5px;"><i class="fa fa-download"></i> Generate PDF</button>
								</div>
							</div>
						</section><!-- /.content -->
					</div>
				</div><!-- /.tab-content -->
			</div><!-- nav-tabs-custom -->
		</div><!-- /.col -->
		
	</div>   <!-- /.row -->
</section><!-- /.content -->
</form>
</cfoutput>