﻿<cfoutput>
<script>
	$(document).ready(function() {		
		CKEDITOR.replace( 'banner',
		{
			filebrowserBrowseUrl :'#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserImageBrowseUrl : '#SESSION.absoluteUrlThemeAdmin#js/plugins//ckeditor/filemanager/index.html',
			filebrowserFlashBrowseUrl :'#SESSION.absoluteUrlThemeAdmin#js/plugins//ckeditor/filemanager/index.html'}
		 );
	});
</script>
<section class="content-header">
	<h1>
		Home Page
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Home Page</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<cfif IsDefined("REQUEST.pageData.message") AND NOT StructIsEmpty(REQUEST.pageData.message)>
				<div class="alert #REQUEST.pageData.message.messageType# alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					<cfloop array="#REQUEST.pageData.message.messageArray#" index="msg">
					#msg#<br/>
					</cfloop>
				</div>
			</cfif>
		</div>
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<div class="box-body">
					<div class="form-group">
						<label>Slide</label>
						<textarea name="slide" id="slide" class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;">#REQUEST.pageData.formData.homepage1#</textarea>
					</div>
					<div class="form-group">
						<label>Advertise Images</label>
						<div class="row" style="margin-top:10px;">
							<cfloop array="#REQUEST.pageData.homepage.getHomePageImages()#" index="img">						
								<div class="col-xs-3">
									<div class="box">
										<div class="box-body table-responsive no-padding">
											<table class="table table-hover">
												<tr class="default">
													<th>
														<input type="text" name="rank_#img.getHomePageImageId()#" value="#img.getRank()#" style="width:30px;text-align:center;" />
													</th>
													<th><a imageid="#img.getCategoryImageId()#" href="" class="delete-image pull-right" data-toggle="modal" data-target="##delete-image-modal"><span class="label label-danger">Delete</span></a></th>
												</tr>
												<tr>
													<td colspan="2">
														<img class="img-responsive" src="#APPLICATION.absoluteUrlWeb#images/uploads/homepage/#img.getName()#" />
													</td>
												</tr>
											</table>
										</div><!-- /.box-body -->
									</div><!-- /.box -->
								</div>
							</cfloop>
						</div>
					</div>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
<!-- DELETE IMAGE MODAL -->
<div class="modal fade" id="delete-image-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this image?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_image" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</form>
</cfoutput>