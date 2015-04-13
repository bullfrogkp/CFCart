<cfcomponent persistent="true"> 
    <cfproperty name="paymentSolutionId" column="payment_solution_id" fieldtype="id" generator="native"> 
	<cfproperty name="name" column="name" ormtype="string"> 
	<cfproperty name="displayName" column="display_name" ormtype="string"> 
	<cfproperty name="imageName" column="image_name" ormtype="string"> 
	<cfproperty name="component" column="function" ormtype="string"> 
	<cfproperty name="paymentMethods" type="array" fieldtype="one-to-many" cfc="payment_method" fkcolumn="payment_solution_id" singularname="paymentMethod" cascade="delete-orphan">
</cfcomponent>
