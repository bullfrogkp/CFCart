<section class="content-header">
	<h1>
		Products
		<small>product information</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Products</li>
	</ol>
</section>
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-body table-responsive">
					<table id="example2" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>Company Name</th>
								<th>Category Name</th>
								<th>Phone</th>
								<th>Product Name</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
						
							<tr>
								<td>#REQUEST.requests.company_name#</td>
								<td>#REQUEST.requests.name#</td>
								<td>#REQUEST.requests.phone#</td>
								<td>#REQUEST.requests.product_name#</td>
								<td><a href="request_detail.cfm?request_id=#REQUEST.requests.request_id#">View Detail</a></td>
							</tr>
							
						</tbody>
						<tfoot>
							<tr>
								<th>Company Name</th>
								<th>Category Name</th>
								<th>Phone</th>
								<th>Product Name</th>
								<th>Action</th>
							</tr>
						</tfoot>
					</table>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div>
	</div>
</section><!-- /.content -->

