<cfoutput>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script>
	$(document).ready(function() {
		$('##start_date').datepicker();
		$('##end_date').datepicker();
	});
</script>
<section class="content-header">
	<h1>
		Coupon Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Coupon Detail</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<form role="form">
					<div class="box-body">
						 <div class="form-group">
							<label>Code</label>
							<input type="text" name="coupon_code" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.coupon_code#"/>
						</div>
						<div class="form-group">
							<label>Discount Type</label>
							<select class="form-control" name="discount_type_id">
								<option value="">Please Select...</option>
								<cfloop array="#REQUEST.pageData.discountTypes#" index="type">
									<option value="#type.getDiscountTypeId()#"
									
									<cfif type.getDiscountTypeId() EQ REQUEST.pageData.coupon.getDiscountType().getDiscountTypeId()>
									selected
									</cfif>
									
									>#type.getDisplayName()#</option>
								</cfloop>
							</select>
						</div>
						<div class="form-group">
							<label>Status</label>
							<select class="form-control" name="coupon_status_id">
								<option value="">Please Select...</option>
								<cfloop array="#REQUEST.pageData.couponStatus#" index="status">
									<option value="#status.getCouponStatusId()#"
									
									<cfif status.getCouponStatusId() EQ REQUEST.pageData.review.getStatus().getCouponStatusId()>
									selected
									</cfif>
									
									>#status.getDisplayName()#</option>
								</cfloop>
							</select>
						</div>
						<div class="form-group">
							<label>Customer</label>
							<cfif NOT IsNull(REQUEST.pageData.coupon.getCustomer())>
							<a href="#APPLICATION.absoluteUrlWeb#admin/customer_detail.cfm?id=#REQUEST.pageData.coupon.getCustomer().getCustomerId()#" target="_blank">
							#REQUEST.pageData.coupon.getCustomer().getFirstName()# #REQUEST.pageData.coupon.getCustomer().getMiddleName()# #REQUEST.pageData.coupon.getCustomer().getLastName()#
							</a>
							<cfelse>
							Not assigned
							</cfif>
						</div>
						 <div class="form-group">
							<label>Start Date</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" class="form-control pull-right" id="start_date"/>
							</div><!-- /.input group -->
						</div><!-- /.form group -->
						 <div class="form-group">
							<label>End Date</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" class="form-control pull-right" id="end_date"/>
							</div><!-- /.input group -->
						</div><!-- /.form group -->
						<button type="submit" class="btn btn-primary">Submit</button>
					</div><!-- /.box-body -->
				</form>
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</cfoutput>