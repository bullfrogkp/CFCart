<cfoutput>

<script>
	$(document).ready(function() {
		CKEDITOR.replace('detail');
		
		$(".top-level-tab").click(function() {
		  $("##tab_id").val($(this).attr('tabid'));
		});
		
		$("##group_price_tabs li:first-child").addClass("active");
		$("##group_price_tab_content div:first-child").addClass("active");
		
		$("##uploader").plupload({
			// General settings
			runtimes: 'html5,flash,silverlight,html4',
			
			url: "#APPLICATION.absoluteUrlWeb#admin/ajax/upload_product_images.cfm",

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
		
		$('##from_date').datepicker();
		$('##to_date').datepicker();
				
		$( ".add-new-attribute-option" ).click(function() {
			$("##new_attribute_option_attribute_id").val($(this).attr('attributeid'));
		});
		
		$( ".delete-attribute-option" ).click(function() {
			$("##deleted_attribute_value_id").val($(this).attr('attributevalueid'));
		});
		
		$( ".delete-attribute-option-value" ).click(function() {
			$("##sub_product_id").val($(this).attr('subproductid'));
		});
		
		$( ".delete-related-product" ).click(function() {
			$("##delete_related_product_id").val($(this).attr('relatedproductid'));
		});
		
		$( ".delete-group-price" ).click(function() {
			$("##deleted_group_price_amount").val($(this).attr('grouppriceamount'));
		});
		
		
		$( ".new-attribute-option-value-attribute-id" ).change(function() {
			$("##new_attribute_imagename").val($(this).find(":selected").attr('imagename'));
		});
		
		
		
		var attributesets = new Object();
		var attributeset, attribute, key;
		
		<cfloop array="#REQUEST.pageData.attributeSets#" index="aset">
			
			key = 'attribute_set_' + '#aset.getAttributeSetId()#';
			
			attributes = new Array();

			<cfloop array="#aset.getAttributeSetAttributeRelas()#" index="attr">
				attribute = new Object();
				attribute.name = '#attr.getAttribute().getDisplayName()#';
				attributes.push(attribute);
			</cfloop>
			
			attributesets[key] = attributes;
		</cfloop>
				
		
		$( "##attribute_set_id" ).change(function() {
			<cfif NOT IsNull(REQUEST.pageData.product.getAttributeSet())>		
			if($( "##attribute_set_id" ).val() != #REQUEST.pageData.product.getAttributeSet().getAttributeSetId()#)
			{
				$('##attributes').hide();
				$('##new_attributes').empty();
				$('##attribute_option_values').hide();
				
				current_key = 'attribute_set_' + $( "##attribute_set_id" ).val();
			
				for(var i=0;i<attributesets[current_key].length;i++)
				{
					$('##new_attributes').append('<div class="col-xs-3"><div class="box box-warning"><div class="box-body table-responsive no-padding"><table class="table table-hover"><tr><th>'+attributesets[current_key][i].name+'</th></tr></table></div></div></div>'); 
				}
			}
			else
			{
				$('##new_attributes').empty();
				$('##attributes').show();
				$('##attribute_option_values').show();
			}
			<cfelse>
			$('##attributes').hide();
			$('##new_attributes').empty();
			$('##attribute_option_values').hide();
			
			current_key = 'attribute_set_' + $( "##attribute_set_id" ).val();
		
			for(var i=0;i<attributesets[current_key].length;i++)
			{
				$('##new_attributes').append('<div class="col-xs-3"><div class="box box-warning"><div class="box-body table-responsive no-padding"><table class="table table-hover"><tr><th>'+attributesets[current_key][i].name+'</th></tr></table></div></div></div>'); 
			}
			</cfif>
			
		});
		
	});
</script>

<section class="content-header">
	<h1>
		Product Detail
		<small>product information</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Product Detail</li>
	</ol>
</section>

<!-- Main content -->
<form method="post" enctype="multipart/form-data">
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.product.getProductId()#" />
<input type="hidden" name="tab_id" id="tab_id" value="#REQUEST.pageData.tabs.activeTabId#" />
<input type="hidden" name="new_attribute_option_attribute_id" id="new_attribute_option_attribute_id" value="" />
<input type="hidden" name="deleted_attribute_value_id" id="deleted_attribute_value_id" value="" />
<input type="hidden" name="sub_product_id" id="sub_product_id" value="" />
<input type="hidden" name="delete_related_product_id" id="delete_related_product_id" value="" />
<input type="hidden" name="deleted_group_price_amount" id="deleted_group_price_amount" value="" />
<input type="hidden" name="new_attribute_imagename" id="new_attribute_imagename" value="" />
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
			<!-- Custom Tabs -->
			<div class="nav-tabs-custom">
				<ul class="nav nav-tabs">
					<li class="tab-title top-level-tab #REQUEST.pageData.tabs['tab_1']#" tabid="tab_1"><a href="##tab_1" data-toggle="tab">General Information</a></li>
					<li class="tab-title top-level-tab #REQUEST.pageData.tabs['tab_2']#" tabid="tab_2"><a href="##tab_2" data-toggle="tab">Meta Data</a></li>
					<li class="tab-title top-level-tab #REQUEST.pageData.tabs['tab_3']#" tabid="tab_3"><a href="##tab_3" data-toggle="tab">Price</a></li>
					<li class="tab-title top-level-tab #REQUEST.pageData.tabs['tab_4']#" tabid="tab_4"><a href="##tab_4" data-toggle="tab">Images</a></li>
					<li class="tab-title top-level-tab #REQUEST.pageData.tabs['tab_5']#" tabid="tab_5"><a href="##tab_5" data-toggle="tab">Attributes</a></li>
					<li class="tab-title top-level-tab #REQUEST.pageData.tabs['tab_6']#" tabid="tab_6"><a href="##tab_6" data-toggle="tab">Related Products</a></li>
					<li class="tab-title top-level-tab #REQUEST.pageData.tabs['tab_7']#" tabid="tab_7"><a href="##tab_7" data-toggle="tab">Reviews</a></li>
					<li class="tab-title top-level-tab #REQUEST.pageData.tabs['tab_8']#" tabid="tab_8"><a href="##tab_8" data-toggle="tab">Shipping</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane #REQUEST.pageData.tabs['tab_1']#" id="tab_1">
						 <div class="form-group">
							<label>Product Name</label>
							<input name="display_name" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.display_name#"/>
						</div>
						<div class="form-group">
							<label>Category</label>
							<select name="category_id" multiple class="form-control">
								<cfloop array="#REQUEST.pageData.categories#" index="category">
									<option value="#category.getCategoryId()#"
									<cfif NOT IsNull(REQUEST.pageData.product.getCategories()) AND ArrayContains(REQUEST.pageData.product.getCategories(),category)>
									selected
									</cfif>
									>#category.getDisplayName()#</option>
								</cfloop>
							</select>
						</div>
						<div class="form-group">
							<label>SKU</label>
							<input name="sku" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.sku#"/>
						</div>
						<div class="form-group">
							<label>Status</label>
							 <select class="form-control" name="is_enabled">
								<option value="1" <cfif REQUEST.pageData.formData.is_enabled EQ TRUE>selected</cfif>>Enabled</option>
								<option value="0" <cfif REQUEST.pageData.formData.is_enabled EQ FALSE>selected</cfif>>Disabled</option>
							</select>
						</div>
						<div class="form-group">
							<label>Product Detail</label>
							<textarea name="detail" id="detail" class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;">#REQUEST.pageData.formData.detail#</textarea>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_2']#" id="tab_2">
						
						 <div class="form-group">
							<label>Title</label>
							<input name="title" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.title#"/>
						</div>
						<div class="form-group">
							<label>Description</label>
							<textarea name="description" class="form-control" rows="3" placeholder="Enter ...">#REQUEST.pageData.formData.description#</textarea>
						</div>
						<div class="form-group">
							<label>Keywords</label>
							<textarea name="keywords" class="form-control" rows="3" placeholder="Enter ...">#REQUEST.pageData.formData.keywords#</textarea>
						</div>
						
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_3']#" id="tab_3">
						<div class="form-group">
							<label>Price</label>
							<input type="text" name="price" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.price#"/>
						</div>
						<div class="form-group #REQUEST.pageData.groupPriceClass#">
							<label>Group Price(s)</label>
							<a href="" data-toggle="modal" data-target="##add-group-price-modal" style="margin-left:10px;"><span class="label label-primary">Add Group Price</span></a>
							<div class="row" style="margin-top:10px;">
								<cfif NOT IsNULL(REQUEST.pageData.groupPrices)>
									<cfloop array="#REQUEST.pageData.groupPrices#" index="price">								
										<div class="col-xs-3">
											<div class="box box-warning">
												<div class="box-body table-responsive no-padding">
													<table class="table table-hover">
														<tr class="warning">
															<th>#DollarFormat(price.price)#</th>
															<th><a grouppriceamount="#price.price#" href="" class="delete-group-price pull-right" data-toggle="modal" data-target="##delete-group-price-modal"><span class="label label-danger">Delete</span></a></th>
														</tr>
														<cfloop array="#REQUEST.pageData.customerGroups#" index="group">
														<tr>
															<td>#group.getDisplayName()#</td>
															<td>
																<cfif ListFind(price.customerGroupIdList,group.getCustomerGroupId())>
																<i class="fa fa-check-square pull-right" style="margin-top:3px;"></i>
																</cfif>
															</td>
														</tr>
														</cfloop>
													</table>
												</div><!-- /.box-body -->
											</div><!-- /.box -->
										</div>
									</cfloop>
								</cfif>
							</div>
						</div>
						
						 <div class="form-group">
							<label>Special Price</label>
							<input name="special_price" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.special_price#"/>
						</div>
						 <div class="form-group">
							<label>Special Price From Date</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" class="form-control pull-right" name="special_price_from_date" id="from_date" value="#REQUEST.pageData.formData.from_date#"/>
							</div><!-- /.input group -->
						</div><!-- /.form group -->
						<div class="form-group">
							<label>Special Price To Date</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" class="form-control pull-right" name="special_price_to_date" id="to_date" value="#REQUEST.pageData.formData.to_date#"/>
							</div><!-- /.input group -->
						</div><!-- /.form group -->
						<div class="form-group">
							<label>Tax Category</label>
							<select name="tax_category_id" class="form-control">
								<option value="">Please Select...</option>
								<cfloop array="#REQUEST.pageData.taxCategories#" index="tc">
									<option value="#tc.getTaxCategoryId()#"
									
									<cfif NOT IsNull(REQUEST.pageData.product.getTaxCategory()) AND tc.getTaxCategoryId() EQ REQUEST.pageData.product.getTaxCategory().getTaxCategoryId()>
									selected
									</cfif>
									
									>#tc.getDisplayName()#</option>
								</cfloop>
							</select>
						</div>
					</div><!-- /.tab-pane -->
					
					<div class="tab-pane #REQUEST.pageData.tabs['tab_4']#" id="tab_4">
						<div class="row">
							<cfif NOT IsNull(REQUEST.pageData.product.getImages())>
								<cfloop array="#REQUEST.pageData.product.getImages()#" index="img">
									<div class="col-lg-3 col-md-4 col-xs-6 thumb">
										<a class="thumbnail" href="#APPLICATION.absoluteUrlWeb#images/uploads/product/#REQUEST.pageData.product.getProductId()#/#img.getName()#" target="_blank">
											<img class="img-responsive" src="#APPLICATION.absoluteUrlWeb#images/uploads/product/#REQUEST.pageData.product.getProductId()#/#img.getName()#" />
										</a>
									</div>
								</cfloop>
							</cfif>
						</div>
						<div class="form-group">
							<div id="uploader">
								<p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
							</div>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_5']#" id="tab_5">
						<!-- text input -->
						<div class="form-group">
							<label>Attribute Set</label>
							<select name="attribute_set_id" id="attribute_set_id" class="form-control">
								<option value="">Please Select...</option>
								<cfloop array="#REQUEST.pageData.attributeSets#" index="as">
									<option value="#as.getAttributeSetId()#"
									
									<cfif NOT IsNull(REQUEST.pageData.product.getAttributeSet()) AND as.getAttributeSetId() EQ REQUEST.pageData.product.getAttributeSet().getAttributeSetId()>
									selected
									</cfif>
									
									>#as.getDisplayName()#</option>
								</cfloop>
							</select>
						</div>
						
						<label>Attribute Option(s)</label>
						<div id="attributes" class="row" style="margin-top:10px;">
							<cfif NOT IsNULL(REQUEST.pageData.attributes)>
								<cfloop array="#REQUEST.pageData.attributes#" index="attribute">						
									<div class="col-xs-3">
										<div class="box box-warning">
											<div class="box-body table-responsive no-padding">
												<table class="table table-hover">
													<tr class="warning">
														<th>#attribute.name#<cfif attribute.required> (required)</cfif></th>
														<cfif attribute.name EQ "color">
														<th></th>
														</cfif>
														<th><a attributeid="#attribute.attributeId#" href="" class="add-new-attribute-option pull-right" data-toggle="modal" data-target="##add-new-attribute-option-modal"><span class="label label-primary">Add Option</span></a></th>
													</tr>
													
													<cfloop array="#attribute.attributeValueArray#" index="attributeValue">
													<tr>
														<td>#attributeValue.value#</td>
														<cfif attribute.name EQ "color">
														<td>
															<cfif attributeValue.imageName NEQ "">
																<div style="width:14px;height:14px;border:1px solid ##CCC;display:inline-block;vertical-align:middle">
																	<img src="#APPLICATION.absoluteUrlWeb#images/uploads/product/#REQUEST.pageData.product.getProductId()#/attribute/#attribute.attributeId#/#attributeValue.imageName#" style="width:100%;height:100%;vertical-align:top;" />
																</div>
															<cfelse>
																<div style="width:14px;height:14px;border:1px solid ##CCC;background-color:#attributeValue.value#;display:inline-block;vertical-align:middle"></div>
															</cfif>
														</td>
														</cfif>
														
														<td>
															<a attributevalueid="#attributeValue.attributeValueId#" href="" class="delete-attribute-option pull-right" data-toggle="modal" data-target="##delete-attribute-option-modal"><span class="label label-danger">Delete</span></a>
														</td>
													</tr>
													</cfloop>
												</table>
											</div><!-- /.box-body -->
										</div><!-- /.box -->
									</div>
								</cfloop>
							</cfif>
						</div>
						<div id="new_attributes" class="row" style="margin-top:10px;">
						</div>
						
						<cfif NOT IsNull(REQUEST.pageData.isProductAttributeComplete) AND REQUEST.pageData.isProductAttributeComplete EQ true>
							<div class="form-group" id="attribute_option_values">
								<label>Attribute Value(s)</label>
								<a href="" data-toggle="modal" data-target="##add-attribute-option-value-modal" style="margin-left:10px;"><span class="label label-primary">Add Value</span></a>
								
								<cfif NOT IsNull(REQUEST.pageData.product.getSubProducts())>
									<div id="attributes" class="row" style="margin-top:10px;">
										<cfloop array="#REQUEST.pageData.product.getSubProducts()#" index="p">	
											<div class="col-xs-3">
												<div class="box box-info">
													<div class="box-body table-responsive no-padding">
														<table class="table table-hover">
															<tr class="success">
																<th><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#p.getProductId()#">ID: #p.getProductId()#</a></th>
																<th></th>
																<th>
																	<a subproductid="#p.getProductId()#" href="" class="delete-attribute-option-value pull-right" data-toggle="modal" data-target="##delete-attribute-option-value-modal"><span class="label label-primary">delete</span></a>
																</th>
															</tr>
															
															<cfloop array="#p.getAttributeValues()#" index="optionValue">
															<tr style="background-color:##f9f9f9;">
																<td>#LCase(optionValue.getAttribute().getDisplayName())#</td>
																<td>#optionValue.getValue()#</td>
																<td>
																<cfif optionValue.getAttribute().getDisplayName() EQ "color">
																	<cfif optionValue.getImageName() NEQ "">
																		<div style="width:14px;height:14px;border:1px solid ##CCC;display:inline-block;vertical-align:middle">
																			<img src="#APPLICATION.absoluteUrlWeb#images/uploads/product/#REQUEST.pageData.product.getProductId()#/attribute/#optionValue.getAttribute().getAttributeId()#/#optionValue.getImageName()#" style="width:100%;height:100%;vertical-align:top;" />
																		</div>
																	<cfelse>
																		<div style="width:14px;height:14px;border:1px solid ##CCC;background-color:#optionValue.getValue()#;display:inline-block;vertical-align:middle"></div>
																	</cfif>
																</cfif>
																</td>
															</tr>
															</cfloop>
															<tr>
																<td>price</td>
																<td colspan="2">#p.getPrice()#</td>
															</tr>
															<tr>
																<td>stock</td>
																<td colspan="2">#p.getStock()#</td>
															</tr>
														</table>
													</div><!-- /.box-body -->
												</div><!-- /.box -->
											</div>
										</cfloop>
									</div>
								</cfif>
							</div>
						</cfif>
					</div>
					<div class="tab-pane #REQUEST.pageData.tabs['tab_6']#" id="tab_6">
						<div class="row">
							<div class="col-xs-12">
								<div class="box box-primary">
									<div class="box-header">
										<h3 class="box-title">Related Products</h3>
										<a data-toggle="modal" data-target="##add-product-modal" href="" class="btn btn-default btn-sm pull-right" style="margin:10px 10px 0 0">Add New Product</a>
									</div><!-- /.box-header -->
									<div class="box-body table-responsive">
										<table class="table table-bordered table-hover">
										
											<tr class="default">
												<th>Name</th>
												<th>Price</th>
												<th>Create Datetime</th>
												<th>SKU</th>
												<th>Status</th>
												<th>Link</th>
												<th>Action</th>
											</tr>
									
											<cfif NOT IsNull(REQUEST.pageData.product.getRelatedProducts()) AND ArrayLen(REQUEST.pageData.product.getRelatedProducts()) GT 0>
												<cfloop array="#REQUEST.pageData.product.getRelatedProducts()#" index="relatedProduct">
													<tr>
														<td>#relatedProduct.getProduct().getDisplayName()#</td>
														<td>#relatedProduct.getProduct().getPrice()#</td>
														<td>#DateFormat(relatedProduct.getProduct().getCreatedDatetime(),"mmm dd,yyyy")#</td>
														<td>#relatedProduct.getProduct().getSku()#</td>
														<td>#relatedProduct.getProduct().getIsEnabled()#</td>
														<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#relatedProduct.getProduct().getProductId()#">View Detail</a></td>
														<td><a relatedproductid="#relatedProduct.getRelatedProductId()#" class="delete-related-product" href="" data-toggle="modal" data-target="##delete-product-modal"><span class="label label-danger">Delete</span></a></td>
													</tr>
												</cfloop>
											<cfelse>
												<tr>
													<td colspan="7">No data available</td>
												</tr>
											</cfif>
										
											<tr class="default">
												<th>Name</th>
												<th>Price</th>
												<th>Create Datetime</th>
												<th>SKU</th>
												<th>Status</th>
												<th>Link</th>
												<th>Action</th>
											</tr>
										</table>
									</div>
									<div class="box-footer clearfix">
										<ul class="pagination pagination-sm no-margin pull-right">
											<li><a href="##">&laquo;</a></li>
											<li><a href="##">1</a></li>
											<li><a href="##">2</a></li>
											<li><a href="##">3</a></li>
											<li><a href="##">&raquo;</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane #REQUEST.pageData.tabs['tab_7']#" id="tab_7">
						<div class="row">
							<div class="col-xs-12">
								<div class="box box-primary">
									<div class="box-header">
										<h3 class="box-title">Related Products</h3>
										<a data-toggle="modal" data-target="##add-product-modal" href="" class="btn btn-default btn-sm pull-right" style="margin:10px 10px 0 0">Add New Product</a>
									</div><!-- /.box-header -->
									<div class="box-body table-responsive">
										<table class="table table-bordered table-hover">
										
											<tr class="default">
												<th>Subject</th>
												<th>Message</th>
												<th>Rating</th>
												<th>Create Datetime</th>
												<th>Action</th>
											</tr>
										
											<cfif NOT IsNull(REQUEST.pageData.product.getReviews()) AND ArrayLen(REQUEST.pageData.product.getReviews()) GT 0>
												<cfloop array="#REQUEST.pageData.product.getReviews()#" index="review">
												<tr>
													<td>#review.getSubject()#</td>
													<td>#review.getMessage()#</td>
													<td>#review.getRating()#</td>
													<td>#review.getCreatedDatetime()#</td>
													<td><a href="#APPLICATION.absoluteUrlWeb#admin/review_detail.cfm?id=#review.getReviewId()#">View Detail</a></td>
												</tr>
												</cfloop>
											<cfelse>
												<tr>
													<td colspan="5">No data available</td>
												</tr>
											</cfif>
									
											<tr class="default">
												<th>Subject</th>
												<th>Message</th>
												<th>Rating</th>
												<th>Create Datetime</th>
												<th>Action</th>
											</tr>
										</table>
									</div>
									<div class="box-footer clearfix">
										<ul class="pagination pagination-sm no-margin pull-right">
											<li><a href="##">&laquo;</a></li>
											<li><a href="##">1</a></li>
											<li><a href="##">2</a></li>
											<li><a href="##">3</a></li>
											<li><a href="##">&raquo;</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane #REQUEST.pageData.tabs['tab_8']#" id="tab_8">
						<div class="form-group">
							<label>Length</label>
							<input name="length" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.length#"/>
						</div>
						<div class="form-group">
							<label>Width</label>
							<input name="width" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.width#"/>
						</div>
						<div class="form-group">
							<label>Height</label>
							<input name="height" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.height#"/>
						</div>
						<div class="form-group">
							<label>Weight</label>
							<input name="weight" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.weight#"/>
						</div>
						<div class="form-group">
							<label>Shipping Methods</label>
							<div class="row" style="margin-top:10px;">
								<cfif NOT IsNULL(REQUEST.pageData.shippingCarriers)>
									<cfloop array="#REQUEST.pageData.shippingCarriers#" index="carrier">						
										<div class="col-xs-3">
											<div class="box box-warning">
												<div class="box-body table-responsive no-padding">
													<table class="table table-hover">
														<tr>
															<th><img src="#APPLICATION.absoluteUrlWeb#images/uploads/shipping/#carrier.getImageName()#" style="height:25px;vertical-align:top;" /></th>
															<th style="width:40px;"></th>
														</tr>
														
														<cfloop array="#carrier.getShippingMethods()#" index="shippingMethod">
														<tr>
															<td>#shippingMethod.getDisplayName()#</td>
															<td>
																<input type="checkbox" class="form-control pull-right" name="shipping_method_id" value="#shippingMethod.getShippingMethodId()#"

																<cfif NOT IsNull(REQUEST.pageData.product.getShippingMethods()) AND REQUEST.pageData.product.hasShippingMethod(shippingMethod)>
																checked
																</cfif>

																/>
															</td>
														</tr>
														</cfloop>
													</table>
												</div><!-- /.box-body -->
											</div><!-- /.box -->
										</div>
									</cfloop>
								</cfif>
							</div>
						</div>
					</div>
				</div><!-- /.tab-content -->
			</div><!-- nav-tabs-custom -->
			<div class="form-group">
				<button name="save_item" type="submit" class="btn btn-primary top-nav-button">Save Product</button>
				<button name="delete_item" type="submit" class="btn btn-danger top-nav-button pull-right #REQUEST.pageData.deleteButtonClass#">Delete Product</button>
			</div>
		</div><!-- /.col -->
		
	</div>   <!-- /.row -->
</section><!-- /.content -->
<!-- ADD GROUP PRICE MODAL -->
<div class="modal fade" id="add-group-price-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add New Group Price</h4>
			</div>
		
			<div class="modal-body">
				<div class="form-group">
					<input id="new_group_price" name="new_group_price" type="text" class="form-control" placeholder="Group price">
				</div>	
				<div class="form-group">
					<select class="form-control" name="customer_group_id" multiple>
						<cfloop array="#REQUEST.pageData.customerGroups#" index="group">
						<option value="#group.getCustomerGroupId()#">#group.getDisplayName()#</option>
						</cfloop>
					</select>
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="add_new_group_price" type="submit" class="btn btn-primary pull-left"><i class="fa fa-check"></i> Add</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE GROUP PRICE MODAL -->
<div class="modal fade" id="delete-group-price-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this group price?</h4>
			</div>
		
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_group_price" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- ADD OPTION MODAL -->
<div class="modal fade" id="add-new-attribute-option-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add New Attribute Option</h4>
			</div>
		
			<div class="modal-body">
				<div class="form-group">
					<input id="new_attribute_option" name="new_attribute_option" type="text" class="form-control" placeholder="Attribute option">
				</div>	
				 <div class="form-group">
					<div class="btn btn-success btn-file">
						<i class="fa fa-paperclip"></i> Attachment
						<input type="file" name="new_attribute_option_attachment"/>
					</div>
					<p class="help-block">Max. 32MB</p>
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="add_new_attribute_option" type="submit" class="btn btn-primary pull-left"><i class="fa fa-check"></i> Add</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE OPTION MODAL -->
<div class="modal fade" id="delete-attribute-option-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this option?</h4>
			</div>
		
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_attribute_option" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- ADD PRODUCT MODAL -->
<div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add Related Product</h4>
			</div>
		
			<div class="modal-body">
				<div class="form-group">
					<input id="new_related_product_id" name="new_related_product_id" type="text" class="form-control" placeholder="Product ID">
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="add_related_product" type="submit" class="btn btn-primary pull-left"><i class="fa fa-check"></i> Add</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE PRODUCT MODAL -->
<div class="modal fade" id="delete-product-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this related product?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_related_product" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- ADD/UPDATE ATTRIBUTE VALUE MODAL -->
<cfif NOT IsNull(REQUEST.pageData.isProductAttributeComplete) AND REQUEST.pageData.isProductAttributeComplete EQ true>
<div class="modal fade" id="add-attribute-option-value-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add New Attribute Value</h4>
			</div>
			<div class="modal-body">
				<cfloop array="#REQUEST.pageData.attributes#" index="attribute">
					<cfif attribute.required EQ true>
						<div class="form-group">
							<select class="form-control<cfif attribute.name EQ "color"> new-attribute-option-value-attribute-id</cfif>" name="new_attribute_value_#attribute.attributeId#">
								<option value="">#attribute.name#</option>
								<cfloop array="#attribute.attributeValueArray#" index="attributeValue">
									<option value="#attributeValue.value#" imagename="#attributeValue.imageName#">
										#attributeValue.value#
									</option>
								</cfloop>
							</select>
						</div>	
					</cfif>
				</cfloop>
				<div class="form-group">
					<input id="new_price" name="new_price" type="text" class="form-control" placeholder="Price">
				</div>	
				<div class="form-group">
					<input id="new_stock" name="new_stock" type="text" class="form-control" placeholder="Stock">
				</div>	
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="add_new_attribute_option_value" type="submit" class="btn btn-primary pull-left"><i class="fa fa-check"></i> Add</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE ATTRIBUTE VALUE MODAL -->
<div class="modal fade" id="delete-attribute-option-value-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this attribute value?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_attribute_option_value" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</cfif>
</form>
</cfoutput>