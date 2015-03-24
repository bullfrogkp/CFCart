<cfoutput>
<section class="content-header">
	<h1>
		Coupons
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Coupons</li>
	</ol>
</section>
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Coupons</h3>
					<a href="#APPLICATION.absoluteUrlWeb#admin/coupon_detail.cfm" class="btn btn-default btn-sm pull-right top-nav-anchor">Add New Coupon</a>
				</div><!-- /.box-header -->
				<div class="box-body table-responsive">
					<table class="table table-bordered table-striped data-table">
						<thead>
							<tr>
								<th>Code</th>
								<th>Date Start</th>
								<th>Date Expire</th>
								<th>Status</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<cfloop array="#REQUEST.pageData.coupons#" index="coupon">
								<tr>
									<td>#coupon.getCouponCode()#</td>
									<td>#DateFormat(coupon.getStartDate(),"mmm dd,yyyy")#</td>
									<td>#DateFormat(coupon.getEndDate(),"mmm dd,yyyy")#</td>
									<td>#coupon.getCouponStatusType().getDisplayName()#</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/coupon_detail.cfm?id=#coupon.getCouponId()#">View Detail</a></td>
								</tr>
							</cfloop>
						</tbody>
						<tfoot>
							<tr>
								<th>Code</th>
								<th>Date Start</th>
								<th>Date Expire</th>
								<th>Status</th>
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
