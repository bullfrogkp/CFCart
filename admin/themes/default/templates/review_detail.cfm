<cfoutput>
<section class="content-header">
	<h1>
		Review Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Review Detail</li>
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
							<label>Product <a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#REQUEST.pageData.review.getProduct().getProductId()#" class="form-link" style="margin-left:18px;">#REQUEST.pageData.review.getProduct().getDisplayName()#</a></label>
						</div>
						<div class="form-group">
							<label>Post By <a href="" class="form-link">#REQUEST.pageData.createdUser#</a></label>
						</div>
						<div class="form-group">
							<label>Rating</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="r1" class="minimal" <cfif REQUEST.pageData.review.getRating() EQ 1>checked</cfif> /> 1 star&nbsp;&nbsp;&nbsp;
							<input type="radio" name="r1" class="minimal" <cfif REQUEST.pageData.review.getRating() EQ 2>checked</cfif>/> 2 stars&nbsp;&nbsp;&nbsp;
							<input type="radio" name="r1" class="minimal" <cfif REQUEST.pageData.review.getRating() EQ 3>checked</cfif>/> 3 stars&nbsp;&nbsp;&nbsp;
							<input type="radio" name="r1" class="minimal" <cfif REQUEST.pageData.review.getRating() EQ 4>checked</cfif>/> 4 stars&nbsp;&nbsp;&nbsp;
							<input type="radio" name="r1" class="minimal" <cfif REQUEST.pageData.review.getRating() EQ 5>checked</cfif>/> 5 stars
						</div>
						<div class="form-group">
							<label>Subject</label>
							<input type="text" name="subject" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.review.getSubject()#"/>
						</div>
						<div class="form-group">
							<label>Message</label>
							<textarea name="message" class="form-control" rows="5" placeholder="Enter ...">#REQUEST.pageData.review.getMessage()#</textarea>
						</div>
						<div class="form-group">
							<label>Status</label>
							<select class="form-control" name="review_status_id">
								<option value="">Please Select...</option>
								<cfloop array="#REQUEST.pageData.reviewStatus#" index="status">
									<option value="#status.getReviewStatusId()#"
									
									<cfif status.getReviewStatusId() EQ REQUEST.pageData.review.getStatus().getReviewStatusId()>
									selected
									</cfif>
									
									>#status.getDisplayName()#</option>
								</cfloop>
							</select>
						</div>
						<button type="submit" class="btn btn-primary">Submit</button>
					</div><!-- /.box-body -->
				</form>
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</cfoutput>