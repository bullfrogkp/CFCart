<cfoutput>
<section class="content-header">
	<h1>
		Reviews
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Reviews</li>
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
								<th>Subject</th>
								<th>Product</th>
								<th>Message</th>
								<th>Create Datetime</th>
								<th>Status</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<cfloop array="#REQUEST.pageData.reviews#" index="review">
								<tr>
									<td>#review.getSubject()#</td>
									<td>#review.getProduct().getDisplayName()#</td>
									<td>#review.getMessage()#</td>
									<td>#DateFormat(review.getCreatedDatetime(),"mmm dd,yyyy")#</td>
									<td>#review.getReviewStatusType().getDisplayName()#</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/review_detail.cfm?id=#review.getReviewId()#">View Detail</a></td>
								</tr>
							</cfloop>
						</tbody>
						<tfoot>
							<tr>
								<th>Subject</th>
								<th>Product</th>
								<th>Message</th>
								<th>Create Datetime</th>
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
