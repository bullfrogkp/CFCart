<section class="content-header">
	<h1>
		Pages
		<small>site pages</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Pages</li>
	</ol>
</section>
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-header">
					<h3 class="box-title">Pages Information</h3>
				</div><!-- /.box-header -->
				<div class="box-body table-responsive">
					<table id="example2" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>Name</th>
								<th>Title</th>
								<th>Keywords</th>
								<th>Description</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<cfloop array="#REQUEST.page_data.site_pages#" index="page_detail">
								<cfoutput>
								<tr>
									<td>#page_detail.getSite_page_display_name()#</td>
									<td>#page_detail.getSite_page_title()#</td>
									<td>#page_detail.getSite_page_keywords()#</td>
									<td>#page_detail.getSite_page_description()#</td>
									<td><a href="page_detail.cfm?site_page_id=#page_detail.getSite_page_id()#">View Detail</a></td>
								</tr>
								</cfoutput>
							</cfloop>
						</tbody>
						<tfoot>
							<tr>
								<th>Name</th>
								<th>Title</th>
								<th>Keywords</th>
								<th>Description</th>
								<th>Action</th>
							</tr>
						</tfoot>
					</table>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div>
	</div>
</section><!-- /.content -->

