<cfoutput>
<section class="content-header">
	<h1>
		Attribute Set Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Attribute Set Detail</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.formData.id#" />
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
						<label>Name</label>
						<input name="display_name" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.display_name#"/>
					</div>
					<div class="form-group">
						<table class="table table-bordered table-hover">
							<tr class="default">
								<th>Name</th>
								<th style="width:100px;">Required</th>
								<th style="width:140px;">Action</th>
							</tr>
							
							<cfif ArrayLen(REQUEST.pageData.attributes) GT 0>
								<cfloop array="#REQUEST.pageData.attributes#" index="attribute">
									<cfset rela = EntityLoad("attribute_set_attribute_rela",{attribute=attribute,attributeSet=REQUEST.pageData.attributeSet},true) />
									<tr>
										<td>#attribute.getAttributeId()#</td>
										<td>
											<select class="form-control" name="attribute_required_#attribute.getAttributeId()#">
												<option value="1" <cfif NOT IsNull(rela) AND rela.getRequired() EQ true>selected</cfif>>Yes</option>
												<option value="0" <cfif NOT(NOT IsNull(rela) AND rela.getRequired() EQ true)>selected</cfif>>No</option>
											</select>
										</td>
										<td>
											<input type="checkbox" name="attribute_#attribute.getAttributeId()#" class="form-control"

											<cfif  NOT IsNull(rela)>
											checked
											</cfif>
											
											/>
										</td>
									</tr>
								</cfloop>
							<cfelse>
								<tr>
									<td colspan="3">No data available</td>
								</tr>
							</cfif>
							
							<tr class="default">
								<th>Name</th>
								<th>Required</th>
								<th>Action</th>
							</tr>
						</table>
					</div>
					<button name="save_item" type="submit" class="btn btn-primary">Submit</button>
					<button type="button" class="btn btn-danger pull-right #REQUEST.pageData.deleteButtonClass#" data-toggle="modal" data-target="##delete-current-entity-modal">Delete Attribute Set</button>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
<!-- DELETE ENTITY MODAL -->
<div class="modal fade" id="delete-current-entity-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this attribute set?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_item" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</form>
</cfoutput>