<section class="content-header">
	<h1>
		Page Detail
		<small>website info</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Page Detail</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title"><cfoutput>#REQUEST.page_data.site_page_display_name#</cfoutput></h3>
				</div><!-- /.box-header -->
				<!-- form start -->
				<form role="form" method="post">
					<input type="hidden" name="site_page_id" value="<cfoutput>#REQUEST.page_data.site_page_id#</cfoutput>" />
					<div class="box-body">
						<div class="form-group">
							<label>Title</label>
							<input type="text" name="site_page_title" class="form-control" placeholder="Enter ..." value="<cfoutput>#Trim(REQUEST.page_data.site_page_title)#</cfoutput>"/>
						</div>
						 <div class="form-group">
							<label>Keywords</label>
							<textarea id="site_page_keywords" name="site_page_keywords" rows="5" class="form-control" cols="80"><cfoutput>#Trim(REQUEST.page_data.site_page_keywords)#</cfoutput></textarea>
						</div>
						 <div class="form-group">
							<label>Description</label>
							<textarea id="site_page_description" name="site_page_description" rows="5" class="form-control" cols="80"><cfoutput>#Trim(REQUEST.page_data.site_page_description)#</cfoutput></textarea>
						</div>
						<div class="form-group">
							<label>Content</label>
							<textarea id="site_page_content" name="site_page_content" rows="20" class="form-control" cols="80"><cfoutput>#Trim(REQUEST.page_data.site_page_content)#</cfoutput></textarea>
						</div>
					</div><!-- /.box-body -->
					 <div class="box-footer">
						<button type="submit" class="btn btn-primary">Submit</button>
					</div>
				</form>
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->