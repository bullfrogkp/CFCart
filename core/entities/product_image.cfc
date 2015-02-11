﻿<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productImageId" column="product_image_id" fieldtype="id" generator="native"> 
    <cfproperty name="rank" column="rank" ormtype="float" default="1"> 
	<cfproperty name="product" fieldtype="many-to-one" cfc="product">
</cfcomponent>