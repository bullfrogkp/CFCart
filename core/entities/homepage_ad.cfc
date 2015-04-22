<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="homepageAdId" column="homepage_ad_id" fieldtype="id" generator="native"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
</cfcomponent>