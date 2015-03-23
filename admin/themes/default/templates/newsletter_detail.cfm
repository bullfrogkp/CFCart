<cfoutput>

<script>
	$(document).ready(function() {
		CKEDITOR.replace('content');
	});
</script>
<section class="content-header">
	<h1>
		Newsletter Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Newsletter Detail</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				
				<div class="box-body">
					<div class="form-group">
						<label>Subject</label>
						<input type="text" name="subject" class="form-control" placeholder="Enter ..." value=""/>
					</div>
					 <div class="form-group">
						<label>Name</label>
						<input type="text" name="name" class="form-control" placeholder="Enter ..." value=""/>
					</div>
					<div class="form-group">
						<label>Type</label>
						<select class="form-control" name="type">
							<option value="">Please Select...</option>
							<option value="html" <cfif REQUEST.pageData.formData.type EQ "html">selected</cfif>>HTML</option>
							<option value="plaintext" <cfif REQUEST.pageData.formData.type EQ "plaintext">selected</cfif>>Plaintext</option>
						</select>
					</div>
					<div class="form-group">
						<label>Content</label>
						<textarea name="content" id="content" class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;">#REQUEST.pageData.formData.content#</textarea>
					</div>
					<button type="submit" name="save_item" class="btn btn-primary">Submit</button>
				</div><!-- /.box-body -->
				
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</form>
</cfoutput>