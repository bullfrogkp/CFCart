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
<input type="hidden" name="deleted_group_price_amount" id="deleted_group_price_amount" value="" />
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
						<div class="form-group">
							<label>Group Price(s)</label>
							<a href="" data-toggle="modal" data-target="##add-group-price-modal" style="margin-left:10px;"><span class="label label-primary">Add Group Price</span></a>
							<div class="row" style="margin-top:10px;">
								<cfif NOT IsNULL(REQUEST.pageData.groupPrices)>
									<cfloop array="#REQUEST.pageData.groupPrices#" index="price">								
										<div class="col-xs-3">
											<div class="box box-warning">
												<div class="box-body table-responsive no-padding">
													<table class="table table-hover">
														<tr>
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
								<input type="text" class="form-control pull-right" name="from_date" id="from_date" value="#REQUEST.pageData.formData.from_date#"/>
							</div><!-- /.input group -->
						</div><!-- /.form group -->
						<div class="form-group">
							<label>Special Price To Date</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" class="form-control pull-right" name="to_date" id="to_date" value="#REQUEST.pageData.formData.to_date#"/>
							</div><!-- /.input group -->
						</div><!-- /.form group -->
						<div class="form-group">
							<label>Tax Category</label>
							<select name="tax_category_id" class="form-control">
								<option value="">Please Select...</option>
								<cfloop array="#REQUEST.pageData.taxCategories#" index="tc">
									<option value="#tc.getTaxCategoryId()#"
									
									<cfif tc.getTaxCategoryId() EQ REQUEST.pageData.product.getTaxCategory().getTaxCategoryId()>
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
							<select name="attribute_set_id" class="form-control">
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
						
						<div class="form-group">
							<label>Attribute Option(s)</label>
							<cfif NOT IsNULL(REQUEST.pageData.attributes)>
								<div id="attributes" class="row" style="margin-top:10px;">
									<cfloop array="#REQUEST.pageData.attributes#" index="attribute">						
										<div class="col-xs-3">
											<div class="box box-warning">
												<div class="box-body table-responsive no-padding">
													<table class="table table-hover">
														<tr>
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
								</div>
							</cfif>
						</div>
						
						<cfif NOT IsNull(REQUEST.pageData.isProductAttributeComplete) AND REQUEST.pageData.isProductAttributeComplete EQ true>
							<div class="form-group">
								<label>Attribute Value(s)</label>
								<a href="" data-toggle="modal" data-target="##add-attribute-option-value-modal" style="margin-left:10px;"><span class="label label-primary">Add Value</span></a>
								
								<cfif NOT IsNull(REQUEST.pageData.subProductArray)>
									<div id="attributes" class="row" style="margin-top:10px;">
										<cfloop array="#REQUEST.pageData.subProductArray#" index="subProduct">					
											<div class="col-xs-3">
												<div class="box box-info">
													<div class="box-body table-responsive no-padding">
														<table class="table table-hover">
															<tr>
																<th><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#subProduct.productId#">ID: #subProduct.productId#</a></th>
																<th></th>
																<th>
																	<a subproductid="#subProduct.productId#" href="" class="delete-attribute-option-value pull-right" data-toggle="modal" data-target="##delete-attribute-option-value-modal"><span class="label label-primary">delete</span></a>
																	<!---
																	<a subproductid="#subProduct.productId#" href="" class="add-attribute-value pull-right" data-toggle="modal" data-target="##add-attribute-value-modal"><span class="label label-primary">update</span></a>
																	--->
																</th>
															</tr>
															
															<cfloop array="#subProduct.optionValues#" index="optionValue">
															<tr style="background-color:##f9f9f9;">
																<td>#LCase(optionValue.attributeName)#</td>
																<td>#optionValue.optionValue#</td>
																<td>
																<cfif optionValue.attributeName EQ "color">
																	<cfif optionValue.imageName NEQ "">
																		<div style="width:14px;height:14px;border:1px solid ##CCC;display:inline-block;vertical-align:middle">
																			<img src="#APPLICATION.absoluteUrlWeb#images/products/#REQUEST.pageData.product.getProductId()#/attributes/#optionValue.attributeId#/#optionValue.imageName#" style="width:100%;height:100%;" />
																		</div>
																	<cfelse>
																		<div style="width:14px;height:14px;border:1px solid ##CCC;background-color:#optionValue.optionValue#;display:inline-block;vertical-align:middle"></div>
																	</cfif>
																</cfif>
																</td>
															</tr>
															</cfloop>
															<tr>
																<td>price</td>
																<td colspan="2">#subProduct.price#</td>
															</tr>
															<tr>
																<td>stock</td>
																<td colspan="2">#subProduct.stock#</td>
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
						<table class="table table-bordered table-striped data-table">
							<thead>
								<tr>
									<th>Name</th>
									<th>Price</th>
									<th>Create Datetime</th>
									<th>SKU</th>
									<th>Status</th>
									<th>Link</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<cfif NOT IsNull(REQUEST.pageData.product.getRelatedProducts())>
								<cfloop array="#REQUEST.pageData.product.getRelatedProducts()#" index="product">
									<tr>
										<td>#product.getDisplayName()#</td>
										<td>#product.getPrice()#</td>
										<td>#DateFormat(product.getCreatedDatetime(),"mmm dd,yyyy")#</td>
										<td>#product.getSku()#</td>
										<td>#product.getIsEnabled()#</td>
										<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#product.getProductId()#">View Detail</a></td>
										<td><button name="remove_related_product" type="submit" class="btn btn-danger top-nav-button #REQUEST.pageData.deleteButtonClass#">Remove Product</button></td>
									</tr>
								</cfloop>
								</cfif>
							</tbody>
							<tfoot>
								<tr>
									<th>Name</th>
									<th>Price</th>
									<th>Create Datetime</th>
									<th>SKU</th>
									<th>Status</th>
									<th>Link</th>
									<th>Action</th>
								</tr>
							</tfoot>
						</table>
					</div>
					<div class="tab-pane #REQUEST.pageData.tabs['tab_7']#" id="tab_7">
						<table class="table table-bordered table-striped data-table">
							<thead>
								<tr>
									<th>Subject</th>
									<th>Message</th>
									<th>Rating</th>
									<th>Create Datetime</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<cfif NOT IsNull(REQUEST.pageData.product.getReviews())>
								<cfloop array="#REQUEST.pageData.product.getReviews()#" index="review">
								<tr>
									<td>#review.getSubject()#</td>
									<td>#review.getMessage()#</td>
									<td>#review.getRating()#</td>
									<td>#review.getCreatedDatetime()#</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/review_detail.cfm?id=#review.getReviewId()#">View Detail</a></td>
								</tr>
								</cfloop>
								</cfif>
							</tbody>
							<tfoot>
								<tr>
									<th>Subject</th>
									<th>Message</th>
									<th>Rating</th>
									<th>Create Datetime</th>
									<th>Action</th>
								</tr>
							</tfoot>
						</table>
					</div>
					<div class="tab-pane #REQUEST.pageData.tabs['tab_8']#" id="tab_8">
						<table class="table table-bordered table-striped data-table">
							<thead>
								<tr>
									<th>Name</th>
									<th>Description</th>
									<th>Component</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<cfloop array="#REQUEST.pageData.shippingMethods#" index="shipping">
								<tr>
									<td>#shipping.getDisplayName()#</td>
									<td>#shipping.getDescription()#</td>
									<td>#shipping.getCfc()#</td>
									<td><input type="checkbox" class="form-control" 

									<cfif REQUEST.pageData.product.getShippingMethodId() EQ shipping.getShippingMethodId>
									checked
									</cfif>
	
									/></td>
								</tr>
								</cfloop>
							</tbody>
							<tfoot>
								<tr>
									<th>Name</th>
									<th>Description</th>
									<th>Component</th>
									<th>Action</th>
								</tr>
							</tfoot>
						</table>
					</div>
				</div><!-- /.tab-content -->
			</div><!-- nav-tabs-custom -->
			<div class="form-group">
				<button name="save_item" type="submit" class="btn btn-primary top-nav-button">Save Product</button>
				<button name="delete_item" type="submit" class="btn btn-danger top-nav-button #REQUEST.pageData.deleteButtonClass#">Delete Product</button>
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
							<select class="form-control" name="new_attribute_value_#attribute.attributeId#">
								<option value="">#attribute.name#</option>
								<cfloop array="#attribute.attributeValueArray#" index="attributeValue">
									<option value="#attributeValue.value#">
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