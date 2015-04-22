<cfoutput>
<script>
	$(document).ready(function() {		
		CKEDITOR.replace( 'slide_content',
		{
			filebrowserBrowseUrl :'#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserImageBrowseUrl : '#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserFlashBrowseUrl :'#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html'}
		);
		
		$("##uploader").plupload({
			// General settings
			runtimes: 'html5,flash,silverlight,html4',
			
			url: "#APPLICATION.absoluteUrlWeb#admin/ajax/upload_category_images.cfm",

			// Maximum file size
			max_file_size: '1000mb',

			// User can upload no more then 20 files in one go (sets multiple_queues to false)
			max_file_count: 20,
			
			chunk_size: '1mb',

			// Resize images on clientside if we can
			resize : {
				width: 200, 
				height: 200, 
				quality: 90,
				crop: true // crop to exact dimensions
			},

			// Specify what files to browse for
			filters: [
				{ title: "Image files", extensions: "jpg,gif,png" }
			],

			// Rename files by clicking on their titles
			rename: true,
			
			// Sort files
			sortable: true,

			// Enable ability to drag'n'drop files onto the widget (currently only HTML5 supports that)
			dragdrop: true,

			// Views to activate
			views: {
				thumbs: true,
				list: false,
				active: 'thumbs'
			},

			// Flash settings
			flash_swf_url : 'http://rawgithub.com/moxiecode/moxie/master/bin/flash/Moxie.cdn.swf',

			// Silverlight settings
			silverlight_xap_url : 'http://rawgithub.com/moxiecode/moxie/master/bin/silverlight/Moxie.cdn.xap'
		});
		
		$( ".delete-ad" ).click(function() {
			$("##deleted_ad_id").val($(this).attr('adid'));
		});
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
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.formData.id#" />
<input type="hidden" name="deleted_ad_id" id="deleted_ad_id" value="" />
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
						<textarea name="slide_content" id="slide_content" class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;">#REQUEST.pageData.formData.slide_content#</textarea>
					</div>
					<div class="form-group">
						<label>Advertise Images</label>
						<div class="row">
							<cfloop array="#REQUEST.pageData.homepageAds#" index="ad">						
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
						
						<div class="form-group">
							<div id="uploader">
								<p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
							</div>
						</div>
					</div>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
<!-- DELETE AD MODAL -->
<div class="modal fade" id="delete-ad-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this Ad?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_ad" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</form>
</cfoutput>