<cfcomponent persistent="true"> 
    <cfproperty name="topSellingId" column="top_selling_id" fieldtype="id" generator="native"> 	
	<cfproperty name="rank" column="rank" ormtype="float"> 
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
</cfcomponent>