<cfoutput>
<section class="content-header">
	<h1>
		Attribute Sets
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Attribute Sets</li>
	</ol>
</section>
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Attribute Sets</h3>
					<a href="#APPLICATION.absoluteUrlWeb#admin/discount_type_detail.cfm" class="btn btn-default btn-sm pull-right top-nav-anchor">Add New Attribute Set</a>
				</div><!-- /.box-header -->
				<div class="box-body table-responsive">
					<table class="table table-bordered table-hover data-table">
					
						<tr class="default">
							<th>ID</th>
							<th>Name</th>
							<th style="width:110px;">Action</th>
						</tr>
						
						<cfif ArrayLen(REQUEST.pageData.attributeSets) GT 0>
							<cfloop array="#REQUEST.pageData.attributeSets#" index="attributeSet">
								<tr>
									<td>#attributeSet.getAttributeSetId()#</td>
									<td>#attributeSet.getDisplayName()#</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/attribute_set_detail.cfm?id=#attributeSet.getAttributeSetId()#">View Detail</a></td>
								</tr>
							</cfloop>
						<cfelse>
							<tr>
								<td colspan="3">No data available</td>
							</tr>
						</cfif>
						
						<tr class="default">
							<th>ID</th>
							<th>Name</th>
							<th style="width:110px;">Action</th>
						</tr>
						
					</table>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div>
	</div>
</section><!-- /.content -->
</cfoutput>
