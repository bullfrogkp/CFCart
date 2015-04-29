﻿<cfcomponent persistent="true"> 
    <cfproperty name="trackingEntityId" column="tracking_entity_id" fieldtype="id" generator="native"> 
	<cfproperty name="cfid" column="cfid" ormtype="string">
	<cfproperty name="cftoken" column="cftoken" ormtype="string">
	<cfproperty name="jsessionid" column="jsessionid" ormtype="string">
	<cfproperty name="trackingRecords" type="array" fieldtype="one-to-many" cfc="tracking_record" fkcolumn="tracking_entity_id" singularname="trackingRecord" cascade="delete-orphan">
</cfcomponent>
