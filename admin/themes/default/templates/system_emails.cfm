<cfoutput>
<section class="content-header">
	<h1>
		System Emails
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">System Emails</li>
	</ol>
</section>
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-header">
					<h3 class="box-title">System Emails</h3>
					<a href="#APPLICATION.absoluteUrlWeb#admin/newsletter_detail.cfm" class="btn btn-default btn-sm pull-right top-nav-anchor">Add New System Email</a>
				</div><!-- /.box-header -->
				<div class="box-body table-responsive">
					<table class="table table-bordered table-striped data-table">
						<thead>
							<tr>
								<th>Name</th>
								<th>Date Added</th>
								<th>Date Updated</th>
								<th>Subject</th>
								<th>Type</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<cfloop array="#REQUEST.pageData.newsletters#" index="newsletter">
							<tr>
								<td>#newsletter.getDisplayName()#</td>
								<td>#newsletter.getCreatedDatetime()#</td>
								<td>#newsletter.getUpdatedDatetime()#</td>
								<td>#newsletter.getSubject()#</td>
								<td>#newsletter.getType()#</td>
								<td><a href="#APPLICATION.absoluteUrlWeb#admin/newsletter_detail.cfm?id=#newsletter.getNewsletterId()#">View Detail</a></td>
							</tr>
							</cfloop>
						</tbody>
						<tfoot>
							<tr>
								<th>Name</th>
								<th>Date Added</th>
								<th>Date Updated</th>
								<th>Subject</th>
								<th>Type</th>
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
