<cfoutput>
<section class="content-header">
	<h1>
		Discount Types
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Discount Types</li>
	</ol>
</section>
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-primary">
				<div class="box-body table-responsive">
					<table class="table table-bordered table-striped data-table">
						<thead>
							<tr>
								<th>Name</th>
								<th>Calculation Type</th>
								<th>Amount</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<cfloop array="#REQUEST.pageData.discountTypes#" index="type">
								<tr>
									<td>#type.getDisplayName()#</td>
									<td>#type.getCalculationType().getDisplayName()#</td>
									<td>#type.getAmount()#</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/discount_type_detail.cfm?id=#type.getDiscountTypeId()#">View Detail</a></td>
								</tr>
							</cfloop>
						</tbody>
						<tfoot>
							<tr>
								<th>Name</th>
								<th>Calculation Type</th>
								<th>Amount</th>
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
