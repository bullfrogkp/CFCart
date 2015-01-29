<cfoutput>
<section class="content-header">
	<h1>
		Customer Groups
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Customer Groups</li>
	</ol>
</section>
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Customer Groups</h3>
					<a href="#APPLICATION.absolute_url_web#admin/customer_group_detail.cfm" class="btn btn-default btn-sm pull-right top-nav-anchor">Add New Customer Group</a>
				</div><!-- /.box-header -->
				<div class="box-body table-responsive">
					<table id="example2" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>Group Name</th>
								<th>Tax Class</th>
								<th>Discount Type</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Group 1</td>
								<td>First Class</td>
								<td>10 dollor off</td>
								<td><a href="#APPLICATION.absolute_url_web#admin/customer_group_detail.cfm?category_id=1">View Detail</a></td>
							</tr>
							<tr>
								<td>Group 1</td>
								<td>First Class</td>
								<td>10 dollor off</td>
								<td><a href="#APPLICATION.absolute_url_web#admin/customer_group_detail.cfm?category_id=1">View Detail</a></td>
							</tr>
							<tr>
								<td>Group 1</td>
								<td>First Class</td>
								<td>10 dollor off</td>
								<td><a href="#APPLICATION.absolute_url_web#admin/customer_group_detail.cfm?category_id=1">View Detail</a></td>
							</tr>
							<tr>
								<td>Group 1</td>
								<td>First Class</td>
								<td>10 dollor off</td>
								<td><a href="#APPLICATION.absolute_url_web#admin/customer_group_detail.cfm?category_id=1">View Detail</a></td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<th>Group Name</th>
								<th>Tax Class</th>
								<th>Discount Type</th>
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
