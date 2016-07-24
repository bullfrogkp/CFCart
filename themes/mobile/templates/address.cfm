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
							<p><h5>Address Information <a style="margin-left:10px;font-weight:normal">EDIT</a></h5></p>
							<div class="row">
								<div class="col-md-4 information-entry">
									<div class="article-container style-1">
										Kevin Pan<br/>
										5940 Yonge St.<br/>
										North York, Ontario, M2M4M6<br/>
										Canada<br/>
										<div class="button style-14">Edit<input type="submit" value=""></div>
									</div>
								</div>
								<div class="col-md-4 information-entry">
									<div class="article-container style-1">
										Kevin Pan<br/>
										5940 Yonge St.<br/>
										North York, Ontario, M2M4M6<br/>
										Canada<br/>
										<div class="button style-14">Edit<input type="submit" value=""></div>
									</div>
								</div>
								<div class="col-md-4 information-entry">
									<div class="article-container style-1">
										Kevin Pan<br/>
										5940 Yonge St.<br/>
										North York, Ontario, M2M4M6<br/>
										Canada<br/>
										<div class="button style-14">Edit<input type="submit" value=""></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 information-entry">
						<div class="article-container style-1">
							<p><h5>Add New Address</h5></p>
							<form>
								<label>First Name</label>
								<input type="text" value="" placeholder="Current Password" class="simple-field">
								<label>Middle Name</label>
								<input type="password" value="" placeholder="New Password" class="simple-field">
								<label>Last Name</label>
								<input type="password" value="" placeholder="Confirm New Password" class="simple-field">
								<label>Phone</label>
								<input type="password" value="" placeholder="Confirm New Password" class="simple-field">
								<label>Company</label>
								<input type="password" value="" placeholder="Confirm New Password" class="simple-field">
								<label>Unit</label>
								<input type="password" value="" placeholder="Confirm New Password" class="simple-field">
								<label>Street</label>
								<input type="password" value="" placeholder="Confirm New Password" class="simple-field">
								<label>City</label>
								<input type="password" value="" placeholder="Confirm New Password" class="simple-field">
								<label>Postal Code</label>
								<input type="password" value="" placeholder="Confirm New Password" class="simple-field">
								<label>Province</label>
								<div class="simple-drop-down simple-field">
									<select name="province_id" id="province-id">
										<option value="">Province</option>
									</select>
								</div>
								<label>Country</label>
								<div class="simple-drop-down simple-field">
									<select name="province_id" id="province-id">
										<option value="">Country</option>
									</select>
								</div>
								<div class="button style-14">Add Address<input type="submit" value=""></div>
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