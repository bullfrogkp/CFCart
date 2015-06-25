﻿<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="currencyId" column="currency_id" fieldtype="id" generator="native"> 
	<cfproperty name="isDefault" column="is_default" ormtype="boolean"> 
	<cfproperty name="code" column="code" ormtype="string"> 
	<cfproperty name="multiplier" column="multiplier" ormtype="float"> 
	<cfproperty name="positionX" column="position_x" ormtype="string"> 
	<cfproperty name="positionY" column="position_y" ormtype="string"> 
</cfcomponent>