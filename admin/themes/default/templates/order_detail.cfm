<cfoutput>
<section class="content-header">
	<h1>
		Order ## 100000102 | 6 Mar 2015 15:41:02
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
					<li class="active"><a href="##tab_1" data-toggle="tab">Information</a></li>
					<li><a href="##tab_2" data-toggle="tab">Tracking</a></li>
					<li><a href="##tab_3" data-toggle="tab">Transaction</a></li>
					<li><a href="##tab_4" data-toggle="tab">Invoice</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="tab_1">
						<section class="content">
							<div class="row">
								<div class="col-md-6">
									<div class="box box-primary">
										<div class="box-header">
											<h3 class="box-title">Order ## 100000102</h3>
										</div><!-- /.box-header -->
										<div class="box-body">
											<dl class="dl-horizontal">
												<dt>Order Date</dt>
												<dd>6 Mar 2015 15:41:02</dd>
												<dt>Order Status</dt>
												<dd>Complete</dd>
												<dt>Placed from IP</dt>
												<dd>149.172.246.154</dd>
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
												<dd>Horst alfons</dd>
												<dt>Email</dt>
												<dd>abc@me.com</dd>
												<dt>Customer Group</dt>
												<dd>NOT LOGGED IN</dd>
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
												<dd>123 adlims st.</dd>
												<dd>Richmond</dd>
												<dd>Canada</dd>
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
												<dd>123 adlims st.</dd>
												<dd>Richmond</dd>
												<dd>Canada</dd>
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
												<dd>Credit Card</dd>
											</dl>
										</div><!-- /.box-body -->
									</div><!-- /.box -->
								</div><!-- ./col -->
								<div class="col-md-6">
									<div class="box box-primary">
										<div class="box-header">
											<h3 class="box-title">Shipping Information</h3>
										</div><!-- /.box-header -->
										<div class="box-body">
											<dl>
												<dd>Flat Rate - Fixed £5.00</dd>
											</dl>
										</div><!-- /.box-body -->
									</div><!-- /.box -->
								</div><!-- ./col -->
							</div><!-- /.row -->
							
							
							<div class="row">
								<section class="col-lg-12"> 
									<div class="box box-primary">
										<div class="box-header">
											<h3 class="box-title">Items Ordered</h3>
										</div><!-- /.box-header -->
										<div class="box-body">
											<table class="table table-bordered table-striped">
												<thead>
													<th>Product</th>
													<th>Item Status</th>
													<th>Original Price</th>
													<th>Price</th>
													<th>Qty</th>
													<th>Subtotal</th>
													<th>Tax Amount</th>
													<th>Tax Percentage</th>
													<th>Row Total</th>
												</thead>
												<tbody>
													<tr>
														<td>
															juta
															SKU: fvvdx
														</td>
														<td>$1000.00</td>
														<td>1</td>
														<td>$1000.00</td>
														<td>$1000.00</td>
														<td>$1000.00</td>
														<td>$1000.00</td>
														<td>$1000.00</td>
														<td>$1000.00</td>
													</tr>
													<tr>
														<td>
															juta
															SKU: fvvdx
														</td>
														<td>$1000.00</td>
														<td>1</td>
														<td>$1000.00</td>
														<td>$1000.00</td>
														<td>$1000.00</td>
														<td>$1000.00</td>
														<td>$1000.00</td>
														<td>$1000.00</td>
													</tr>
													<tr>
														<td>
															juta
															SKU: fvvdx
														</td>
														<td>$1000.00</td>
														<td>1</td>
														<td>$1000.00</td>
														<td>$1000.00</td>
														<td>$1000.00</td>
														<td>$1000.00</td>
														<td>$1000.00</td>
														<td>$1000.00</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div><!-- /.box (chat box) -->   
								</section>
							</div><!-- /.row (main row) -->
							<div class="row">
								<section class="col-lg-12"> 
									<div class="box box-primary">
										<div class="box-header">
											<h3 class="box-title">Coupon Code</h3>
										</div><!-- /.box-header -->
										<div class="box-body">
											<div class="form-group">
												<input type="text" class="form-control" placeholder="Enter ..." value="3VE01719SL0474839" />
											</div>
										</div>
									</div>
									<!-- /.box -->
								</section><!-- right col -->
							</div><!-- /.row (main row) -->
							<div class="row">
								<!-- Left col -->
								<section class="col-lg-6"> 
									<div class="box box-primary">
										<div class="box-header">
											<h3 class="box-title">Status</h3>
										</div><!-- /.box-header -->
										
										<div class="box-body">
											<table class="table table-bordered table-striped">
												<thead>
													<tr>
														<th>Status</th>
														<th>Create Datetime</th>
														<th>End Datetime</th>
														<th>Comment</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>Order Placed</td>
														<td>2014 Dec 27 02:15:27</td>
														<td>2014 Dec 27 02:15:27</td>
														<td></td>
													</tr>
													<tr>
														<td>Pending Shipment</td>
														<td>2014 Dec 27 02:15:27</td>
														<td>2015 Jan 02 08:25:02</td>
														<td></td>
													</tr>
													<tr>
														<td>Shipped</td>
														<td>2015 Jan 02 08:25:02</td>
														<td></td>
														<td></td>
													</tr>
												</tbody>
											</table>
											<div class="form-group">
												<label>Status</label>
												<select class="form-control" name="parent_category_id">
													<option value="0">Shipped</option>
													<option value="">Preparing</option>
												</select>
											</div>
											<div class="form-group">
												<label>Comments</label>
												<textarea class="form-control" rows="8" placeholder="Enter ..."></textarea>
											</div>
											<button type="submit" class="btn btn-primary">Submit</button>
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
											<div class="form-group">
												<label>Subtotal</label>
												<input type="text" class="form-control" placeholder="Enter ..." value="$100.00" disabled />
											</div>
											<div class="form-group">
												<label>Shipping & Handling</label>
												<input type="text" class="form-control" placeholder="Enter ..." value="$100.00" disabled />
											</div>
											<div class="form-group">
												<label>Grand Total</label>
												<input type="text" class="form-control" placeholder="Enter ..." value="$100.00" disabled />
											</div>
											<div class="form-group">
												<label>Total Paid</label>
												<input type="text" class="form-control" placeholder="Enter ..." value="$100.00" disabled />
											</div>
											<div class="form-group">
												<label>Total Refunded</label>
												<input type="text" class="form-control" placeholder="Enter ..." value="$100.00" disabled />
											</div>
											<div class="form-group">
												<label>Total Due</label>
												<input type="text" class="form-control" placeholder="Enter ..." value="$100.00" disabled />
											</div>
										</div>
									</div>
									<!-- /.box -->
								</section><!-- right col -->
							</div><!-- /.row (main row) -->
						</section><!-- /.content -->
						
					</div>
					<div class="tab-pane" id="tab_2">
					
						<div class="form-group">
							<label>Tracking Number</label>
							<input name="tracking_number" type="text" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						<button name="save_tracking_number" type="submit" class="btn btn-primary">Submit</button>
						
					</div>
					<div class="tab-pane" id="tab_3">
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Transaction Type</th>
									<th>Transaction ID</th>
									<th>Create Datetime</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>purchase</td>
									<td>3VE01719SL0474839</td>
									<td>2014 Dec 27 02:15:27</td>
								</tr>
							</tbody>
						</table>
						 <div class="form-group">
							<label>Transaction ID</label>
							<input type="text" class="form-control" placeholder="Enter ..." value="3VE01719SL0474839" disabled/>
						</div>
						<div class="form-group">
							<label>Refund Type</label>
							<select class="form-control" name="parent_category_id">
								<option value="0">Full</option>
								<option value="">Partial</option>
							</select>
						</div>
						<div class="form-group">
							<label>Amount</label>
							<input type="text" class="form-control" placeholder="Enter ..." value="22.22" />
						</div>
						<div class="form-group">
							<label>Memo</label>
							<textarea class="form-control" rows="5" placeholder="Enter ..."></textarea>
						</div>
						<button name="refund" type="submit" class="btn btn-primary">Submit</button>
					
					</div>
					<div class="tab-pane" id="tab_4">
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