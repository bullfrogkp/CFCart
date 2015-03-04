<cfoutput>
<section class="content-header">
	<h1>
		Customers
		<small>customer information</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Customers</li>
	</ol>
</section>
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Customers</h3>
					<a href="#APPLICATION.absoluteUrlWeb#admin/customer_detail.cfm" class="btn btn-default btn-sm pull-right top-nav-anchor">Add New Customer</a>
				</div><!-- /.box-header -->
				<div class="box-body table-responsive">
					<table class="table table-bordered table-striped data-table">
						<thead>
							<tr>
								<th>Name</th>
								<th>Email</th>
								<th>Phone</th>
								<th>Group</th>
								<th>Subscribed</th>
								<th>Create Datetime</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<cfloop array="#REQUEST.pageData.customers#" index="c">
								<tr>
									<td>#c.getFirstName()# #c.getMiddleName()# #c.getLastName()#</td>
									<td>#c.getEmail()#</td>
									<td>#c.getPhone()#</td>
									<td>#c.getGroup()#</td>
									<td>#c.getSubscribed()#</td>
									<td>#DateFormat(c.getCreatedDatetime(),"mmm dd,yyyy")#</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/customer_detail.cfm?id=#c.getCustomerId()#">View Detail</a></td>
								</tr>
							</cfloop>
						</tbody>
						<tfoot>
							<tr>
								<th>Name</th>
								<th>Email</th>
								<th>Phone</th>
								<th>Group</th>
								<th>Subscribed</th>
								<th>Create Datetime</th>
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
