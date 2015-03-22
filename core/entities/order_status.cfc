﻿<cfcomponent persistent="true"> 
    <cfproperty name="orderStatusId" column="order_status_id" fieldtype="id" generator="native"> 
    <cfproperty name="startDatetime" column="start_datetime" ormtype="string"> 
    <cfproperty name="endDatetime" column="end_datetime" ormtype="string"> 
    <cfproperty name="current" column="current" ormtype="boolean"> 
    <cfproperty name="comments" column="comments" ormtype="string"> 
	<cfproperty name="order" fieldtype="many-to-one" cfc="order" fkcolumn="order_id">
	<cfproperty name="orderStatusType" fieldtype="many-to-one" cfc="order_status_type" fkcolumn="order_status_type_id">
</cfcomponent>