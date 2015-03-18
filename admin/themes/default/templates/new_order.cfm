<cfoutput>
<section class="content-header">
	<h1>
		New Order
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">New Order</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
		<section class="col-lg-12"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Customer Information</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<label>First Name</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="first_name" value=""/>
					</div>
					<div class="form-group">
						<label>Middle Name</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="middle_name" value=""/>
					</div>
					<div class="form-group">
						<label>Last Name</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="last_name" value=""/>
					</div>
					<div class="form-group">
						<label>Phone</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="phone" value=""/>
					</div>
				</div>
			</div><!-- /.box (chat box) -->   
		</section>
	</div><!-- /.row (main row) -->
	
	<div class="row">
		<!-- Left col -->
		<section class="col-lg-6"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Billing Address</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<label>Company</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="billing_company" value="" />
					</div>
					<div class="form-group">
						<label>Street Address</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="billing_street" value="" />
					</div>
					<div class="form-group">
						<label>City</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="billing_city" value="" />
					</div>
					<div class="form-group">
						<label>State/Province</label>
						<select class="form-control" name="billing_province_id">
							<option value="">Please Select...</option>
							<cfloop array="#REQUEST.pageData.provinces#" index="province">
								<option value="#province.getProvinceId()#">#province.getDisplayName()#</option>
							</cfloop>
						</select>
					</div>
					<div class="form-group">
						<label>Zip/Postal Code</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="billing_postal_code" value="" />
					</div>
					<div class="form-group">
						<label>Country</label>
						<select class="form-control" name="billing_country_id">
							<option value="">Please Select...</option>
							<cfloop array="#REQUEST.pageData.countries#" index="country">
								<option value="#country.getCountryId()#">#country.getDisplayName()#</option>
							</cfloop>
						</select>
					</div>
				</div>
			</div><!-- /.box (chat box) -->   
		</section><!-- /.Left col -->
		<!-- right col (We are only adding the ID to make the widgets sortable)-->
		<section class="col-lg-6"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Shipping Address</h3>
					<div class="form-group pull-right" style="margin:10px 10px 0 0;">
						<input type="checkbox" class="form-control" checked />
						<label>Same As Shipping Address</label>
					</div>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<label>Company</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="shipping_company" value="" />
					</div>
					<div class="form-group">
						<label>Street Address</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="shipping_street" value="" />
					</div>
					<div class="form-group">
						<label>City</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="shipping_city" value="" />
					</div>
					<div class="form-group">
						<label>State/Province</label>
						<select class="form-control" name="shipping_province_id">
							<option value="">Please Select...</option>
							<cfloop array="#REQUEST.pageData.provinces#" index="province">
								<option value="#province.getProvinceId()#">#province.getDisplayName()#</option>
							</cfloop>
						</select>
					</div>
					<div class="form-group">
						<label>Zip/Postal Code</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="shipping_postal_code" value="" />
					</div>
					<div class="form-group">
						<label>Country</label>
						<select class="form-control" name="shipping_country_id">
							<option value="">Please Select...</option>
							<cfloop array="#REQUEST.pageData.countries#" index="country">
								<option value="#country.getCountryId()#">#country.getDisplayName()#</option>
							</cfloop>
						</select>
					</div>
				</div>
			</div>
			<!-- /.box -->
		</section><!-- right col -->
	</div><!-- /.row (main row) -->
	<div class="row">
		<section class="col-lg-12"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Products</h3>
					<a href="" class="add-filter-value" data-toggle="modal" data-target="##add-product-modal" style="line-height:40px;"><span class="label label-primary">Add Product</span></a>
				</div><!-- /.box-header -->
				<div class="box-body">
					<table class="table table-bordered table-striped">
						<thead>
							<th>Product</th>
							<th>Price</th>
							<th>Qty</th>
							<th>Shipping</th>
							<th>Subtotal</th>
						</thead>
						<tbody>
							<cfloop array="#REQUEST.pageData.order.getProducts()#" index="product">
							<tr>
								<td>#product.getDisplayName()#</td>
								<td>#product.getPrice()#</td>
								<td>#product.getQuantity()#</td>
								<td>#product.getShippingMethod()#</td>
								<td>#product.getSubtotal()#</td>
							</tr>
							</cfloop>
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
						<input type="text" class="form-control" placeholder="Enter ..." name="coupon" value="" />
					</div>
				</div>
			</div>
			<!-- /.box -->
		</section><!-- right col -->
	</div><!-- /.row (main row) -->
	<div class="row">
		<!-- Left col -->
		<section class="col-lg-12"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Payment Method</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<select class="form-control" name="payment_method_id">
							<option value="">Please Select...</option>
							<cfloop array="#REQUEST.pageData.paymentMethods#" index="method">
								<option value="#method.getPaymentMethodId()#">#method.getDisplayName()#</option>
							</cfloop>
						</select>
					</div>
				</div>
			</div><!-- /.box (chat box) -->   
		</section>
	</div><!-- /.row (main row) -->
	<div class="row">
		<!-- Left col -->
		<section class="col-lg-6"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Comments</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<textarea name="decription" class="form-control" rows="8" placeholder="Enter ..." style="height:170px;"></textarea>
					</div>
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
								<td>$250.30</td>
							</tr>
							<tr>
								<th>Shipping & Handling</th>
								<td>$10.34</td>
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
				</div>
			</div>
			<!-- /.box -->
		</section><!-- right col -->
	</div><!-- /.row (main row) -->
	<button name="submit_order" type="submit" class="btn btn-primary">Submit Order</button>
					
</section><!-- /.content -->
<!-- ADD PRODUCT MODAL -->
<div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add New Product</h4>
			</div>
		
			<div class="modal-body">
				<div class="form-group">
					<input id="new_product_id" name="new_product_id" type="text" class="form-control" placeholder="Product ID">
				</div>
				<div class="form-group">
					<select class="form-control" name="new_product_shipping_method_id">
						<option value="">Please Select Shipping...</option>
						<cfloop array="#REQUEST.pageData.shippinMethods#" index="method">
							<option value="#method.getShippingMethodId()#">#method.getDisplayName()#</option>
						</cfloop>
					</select>
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="add_new_product" type="submit" class="btn btn-primary pull-left"><i class="fa fa-check"></i> Add</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</cfoutput>