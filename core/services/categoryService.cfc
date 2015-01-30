<cfcomponent output="false" accessors="true">
    <cfproperty name="categoryId" type="integer"> 
    <cfproperty name="parentCategoryId" type="integer"> 
    <cfproperty name="categoryName" type="string"> 
    <cfproperty name="categoryDisplayName" type="integer"> 
    <cfproperty name="rank" type="float"> 
    <cfproperty name="categoryIsEnabled" type="boolean"> 
    <cfproperty name="showCategoryOnNav" type="boolean"> 
	<cfproperty name="categoryTitle" type="string"> 
	<cfproperty name="categoryKeywords" type="string"> 
	<cfproperty name="categoryDescription" type="string"> 
	<cfproperty name="categoryCustomDesign" type="text"> 
    <cfproperty name="createDatetime" type="date"> 
    <cfproperty name="createUser" type="string"> 
    <cfproperty name="updateDatetime" type="date"> 
    <cfproperty name="updateUser" type="string"> 
    <cfproperty name="filters" type="array"> 

    <cffunction name="init" output="false" access="public" returntype="BrownPeanut" hint="Constructor">
       
		<cfargument name="categoryId" type="integer" required="false"> 
		<cfargument name="parentPategoryId" type="integer" required="false"> 
		<cfargument name="categoryName" type="string" required="false"> 
		<cfargument name="categoryDisplayName" type="integer" required="false"> 
		<cfargument name="rank" type="float" required="false"> 
		<cfargument name="categoryIsEnabled" type="boolean" required="false"> 
		<cfargument name="showCategoryOnNav" type="boolean" required="false"> 
		<cfargument name="categoryTitle" type="string" required="false"> 
		<cfargument name="categoryKeywords" type="string" required="false"> 
		<cfargument name="categoryDescription" type="string" required="false"> 
		<cfargument name="categoryCustomDesign" type="text" required="false"> 
		<cfargument name="createDatetime" type="date" required="false"> 
		<cfargument name="createUser" type="string" required="false"> 
		<cfargument name="updateDatetime" type="date" required="false"> 
		<cfargument name="updateUser" type="string" required="false"> 
		<cfargument name="filters" type="array" required="false"> 
		
		
        <cfset setcategoryId(arguments.myDouble)>
        <cfset setMyInteger(arguments.MyInteger)>
        <cfset setMyString(arguments.MyString)>
        <cfreturn this/>
    </cffunction>

    <cffunction name="setMyDouble" output="false" access="public" returntype="void"
        hint="Overrides default setter">
        <cfargument name="MyDouble" type="string" required="true"/>
        <!--- data type checking because ColdFusion does not natively make the distinction --->
        <cfset var jDouble = createObject("java", "java.lang.Double").init(arguments.myDouble)>
        <cfif jDouble.toString() NEQ arguments.myDouble>
            <cfthrow type="java.lang.IllegalArgumentException" message="Invalid double value '#arguments.MyDouble#'">
        </cfif>
        <cfset variables.MyDouble = arguments.MyDouble>
    </cffunction>

    <cffunction name="setMyInteger" output="false" access="public" returntype="void"
        hint="Overrides default setter">
        <cfargument name="MyInteger" type="string" required="true"/>
        <!--- data type checking because ColdFusion does not natively make the distinction --->
        <cfif NOT isValid("integer",arguments.MyInteger)>
            <cfthrow type="java.lang.IllegalArgumentException" message="Invalid integer value '#arguments.myInteger#'">
        </cfif>
        <cfset variables.myInteger = arguments.myInteger>
    </cffunction>
</cfcomponent>