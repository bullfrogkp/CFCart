<cfoutput>
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
						<textarea name="banner" id="banner" class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;">#REQUEST.pageData.formData.custom_design#</textarea>
					</div>
					<div class="row">
						<cfloop array="#REQUEST.pageData.homepage.getImages()#" index="img">						
							<div class="col-xs-2">
								<div class="box <cfif img.getIsDefault() EQ true>box-danger</cfif>">
									<div class="box-body table-responsive no-padding">
										<table class="table table-hover">
											<tr <cfif img.getIsDefault() EQ true>class="danger"<cfelse>class="default"</cfif>>
												<th style="font-size:11px;line-height:20px;">#img.getName()#</th>
												<th><a imageid="#img.getCategoryImageId()#" href="" class="delete-image pull-right" data-toggle="modal" data-target="##delete-image-modal"><span class="label label-danger">Delete</span></a></th>
											</tr>
											<tr>
												<td colspan="2">
													<img class="img-responsive" src="#APPLICATION.absoluteUrlWeb#images/uploads/category/#REQUEST.pageData.category.getCategoryId()#/#img.getName()#" />
												</td>
											</tr>
											<tr>
												<td colspan="2">
													<table style="width:100%;">
														<tr>
															<td>
																<input class="form-control pull-left" type="radio" name="default_image_id" value="#img.getCategoryImageId()#" <cfif img.getIsDefault() EQ true>checked</cfif>/>
															</td>
															<td style="padding-left:5px;padding-top:1px;font-size:12px;">
																Set as Default
															</td>
															<td style="text-align:right">
																<input type="text" name="rank_#img.getCategoryImageId()#" value="#img.getRank()#" style="width:30px;text-align:center;" />
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</div><!-- /.box-body -->
								</div><!-- /.box -->
							</div>
						</cfloop>
					</div>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</form>
</cfoutput>