<cfoutput>
<div class="breadcrumb-box">
	<a href="##">Home</a>
	<a href="##">Dashboard</a>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="col-sm-9 col-sm-push-3">
			<div class="information-blocks">
				<div class="row">
					<div class="col-md-12 information-entry">
						<div class="article-container style-1">
							<p><h5>Account Settings</h5></p>
							<form>
								<label>Email Address</label>
								<input type="text" value="" placeholder="Enter Email Address" class="simple-field">
								<label>First Name</label>
								<input type="password" value="" placeholder="Enter First Name" class="simple-field">
								<label>Middle Name</label>
								<input type="password" value="" placeholder="Enter Middle Name" class="simple-field">
								<label>Last Name</label>
								<input type="password" value="" placeholder="Enter Last Name" class="simple-field">
								<label>Phone</label>
								<input type="password" value="" placeholder="Enter Phone" class="simple-field">
								<label>Company</label>
								<input type="password" value="" placeholder="Enter Company" class="simple-field">
								<label>Website</label>
								<input type="password" value="" placeholder="Enter Website" class="simple-field">
								<label class="checkbox-entry checkbox">
									<input type="checkbox" name="custom-name" checked> <span class="check"></span> <b>Subscribe Newsletters</b>
								</label><br/>
								<div class="button style-14">Save<input type="submit" value=""></div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<cfinclude template="nav.cfm" />
	</div>
</div>
</cfoutput>