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
			<form>
				<div class="box box-default">
					<div class="box-body">
						<div class="row">
							<div class="col-xs-2">
								<input type="text" name="id" class="form-control" placeholder="ID" <cfif StructKeyExists(URL,"id")>value="#URL.id#"</cfif>>
							</div>
							<div class="col-xs-3">
								<select class="form-control" name="is_enabled">
									<option value="">All Status</option>
									<option value="1" <cfif StructKeyExists(URL,"is_enabled") AND URL.is_enabled EQ 1>selected</cfif>>Enabled</option>
									<option value="0" <cfif StructKeyExists(URL,"is_enabled") AND URL.is_enabled EQ 0>selected</cfif>>Disabled</option>
								</select>
							</div>
							<div class="col-xs-5">
								<input type="text" name="search_keyword" class="form-control" placeholder="Keywords" <cfif StructKeyExists(URL,"search_keyword")>value="#URL.search_keyword#"</cfif>>
							</div>
							<div class="col-xs-2">
								<button name="search_category" type="submit" class="btn btn-sm btn-primary search-button pull-right">Search</button>
							</div>
						</div>
					</div>
				</div>
			</form>
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Customers</h3>
					<a href="#APPLICATION.absoluteUrlWeb#admin/customer_detail.cfm" class="btn btn-default btn-sm pull-right top-nav-anchor">Add New Customer</a>
				</div><!-- /.box-header -->
				<div class="box-body table-responsive">
					<table class="table table-bordered table-hover">
						<tr class="default">
							<th>Name</th>
							<th>Email</th>
							<th>Phone</th>
							<th>Group</th>
							<th>Subscribed</th>
							<th>Create Datetime</th>
							<th>Action</th>
						</tr>
					
						<cfloop array="#REQUEST.pageData.customers#" index="c">
							<tr>
								<td>#c.getFirstName()# #c.getMiddleName()# #c.getLastName()#</td>
								<td>#c.getEmail()#</td>
								<td>#c.getPhone()#</td>
								<td>#c.getCustomerGroup().getDisplayName()#</td>
								<td>#c.getSubscribed()#</td>
								<td>#DateFormat(c.getCreatedDatetime(),"mmm dd,yyyy")#</td>
								<td><a href="#APPLICATION.absoluteUrlWeb#admin/customer_detail.cfm?id=#c.getCustomerId()#">View Detail</a></td>
							</tr>
						</cfloop>
					
						<tr class="default">
							<th>Name</th>
							<th>Email</th>
							<th>Phone</th>
							<th>Group</th>
							<th>Subscribed</th>
							<th>Create Datetime</th>
							<th>Action</th>
						</tr>
					</table>
				</div><!-- /.box-body -->
				<div class="box-footer clearfix">
					<ul class="pagination pagination-sm no-margin pull-right">
						<li><a href="##">&laquo;</a></li>
						<li><a href="##">1</a></li>
						<li><a href="##">2</a></li>
						<li><a href="##">3</a></li>
						<li><a href="##">&raquo;</a></li>
					</ul>
				</div>
			</div><!-- /.box -->
		</div>
	</div>
</section><!-- /.content -->
</cfoutput>
