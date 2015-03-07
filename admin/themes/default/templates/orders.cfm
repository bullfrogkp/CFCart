<cfoutput>
<section class="content-header">
	<h1>
		Orders
		<small>order information</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Orders</li>
	</ol>
</section>
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-body table-responsive">
					<table class="table table-bordered table-striped data-table">
						<thead>
							<tr>
								<th>Order No.</th>
								<th>Email</th>
								<th>Name</th>
								<th>Total</th>
								<th>Create Datetime</th>
								<th>Status</th>
								<th>Invoice</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<cfloop array="#REQUEST.pageData.orders#" index="order">
								<tr>
									<td>#order.getTrackingNumber()#</td>
									<td>#order.getCustomer().getEmail()#</td>
									<td>#order.getCustomer().getFirstName()# #order.getCustomer().getMiddleName()# #order.getCustomer().getLastName()#</td>
									<td>#order.getTotal()#</td>
									<td>#DateFormat(order.getCreatedDatetime(),"mmm dd,yyyy")#</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/invoice_detail.cfm?id=#order.getOrderId()#">Invoice</a></td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/order_detail.cfm?id=#order.getOrderId()#">View Detail</a></td>
								</tr>
							</cfloop>
						</tbody>
						<tfoot>
							<tr>
								<th>Order No.</th>
								<th>Email</th>
								<th>Name</th>
								<th>Total</th>
								<th>Create Datetime</th>
								<th>Status</th>
								<th>Invoice</th>
								<th>Action</th>
							</tr>
						</tfoot>
					</table>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div>
	</div>
</section><!-- /.content -->
</cfoutput>
