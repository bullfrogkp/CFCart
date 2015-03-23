<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="newsletterId" column="newsletter_id" fieldtype="id" generator="native"> 
    <cfproperty name="subject" column="subject" ormtype="string"> 
    <cfproperty name="content" column="rating" ormtype="integer"> 
    <cfproperty name="type" column="rating" ormtype="string"> 
</cfcomponent>