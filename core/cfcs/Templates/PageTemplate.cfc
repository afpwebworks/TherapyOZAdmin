<cfcomponent displayname="PageTemplate" output="false" hint="A bean which models the PageTemplate record.">
<cfsilent>
<!----
==========================================================================================================
Filename:    PageTemplate.cfc
Description: A bean which models the PageTemplate record
Client:      Therapy OZ Admin
Date:        17/Oct/2015
Author:      Michael Kear

Revision history:

==========================================================================================================
This bean was generated by the Beanbuilder Generator with the following template:
Bean Name: PageTemplate
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
PageTemplateID numeric 0 
PageTemplateDescription string 
PageTemplateExtraDescription string 
IsVisible boolean true 
DateAdded date #now()# 
AddedBy string 
DateUPdated date #now()# 
UpdatedBy string 

Create getSnapshot method: true
Create setSnapshot method: true
Create setStepInstance method: false
Create validate method: true
Create validate interior: true
Create LTO methods: false
Path to LTO: 
Date Format: DD/MM/YYYY
--->
</cfsilent>
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="PageTemplate" output="false">
    
<cfargument name="PageTemplateID" type="numeric" required="true" default="0" />
    <cfargument name="PageTemplateDescription" type="string" required="false" default="" />
    <cfargument name="PageTemplateExtraDescription" type="string" required="false" default="" />
    <cfargument name="IsVisible" type="boolean" required="false" default="true" />
    <cfargument name="DateAdded" type="date" required="true" default="#now()#" />
    <cfargument name="AddedBy" type="string" required="false" default="" />
    <cfargument name="DateUPdated" type="date" required="true" default="#now()#" />
    <cfargument name="UpdatedBy" type="string" required="false" default="" />
    
    
    <cfscript>
// run setters

     setPageTemplateID(arguments.PageTemplateID);
     setPageTemplateDescription(arguments.PageTemplateDescription);
     setPageTemplateExtraDescription(arguments.PageTemplateExtraDescription);
     setIsVisible(arguments.IsVisible);
     setDateAdded(arguments.DateAdded);
     setAddedBy(arguments.AddedBy);
     setDateUPdated(arguments.DateUPdated);
     setUpdatedBy(arguments.UpdatedBy);
     return this;
	</cfscript>
 	</cffunction>
	<!---[ 	PUBLIC FUNCTIONS  ]--->
	<cffunction name="getSnapshot" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
    
            <cffunction name="validate" access="public" returntype="any" output="false">
                    <cfargument name="eH" required="true" type="any" />
            <!-----[ validation parameters  (customise to suit) then remove comments     

                  <!----[ PageTemplateID ]---->
                <cfif ( getPageTemplateID() eq whatever )>
                    <cfset arguments.eH.setError("PageTemplateID", "PageTemplateID This is the error message") />
                </cfif>
  
                  <!----[ PageTemplateDescription ]---->
                <cfif ( getPageTemplateDescription() eq whatever )>
                    <cfset arguments.eH.setError("PageTemplateDescription", "PageTemplateDescription This is the error message") />
                </cfif>
  
                  <!----[ PageTemplateExtraDescription ]---->
                <cfif ( getPageTemplateExtraDescription() eq whatever )>
                    <cfset arguments.eH.setError("PageTemplateExtraDescription", "PageTemplateExtraDescription This is the error message") />
                </cfif>
  
                  <!----[ IsVisible ]---->
                <cfif ( getIsVisible() eq whatever )>
                    <cfset arguments.eH.setError("IsVisible", "IsVisible This is the error message") />
                </cfif>
  
                  <!----[ DateAdded ]---->
                <cfif ( getDateAdded() eq whatever )>
                    <cfset arguments.eH.setError("DateAdded", "DateAdded This is the error message") />
                </cfif>
  
                  <!----[ AddedBy ]---->
                <cfif ( getAddedBy() eq whatever )>
                    <cfset arguments.eH.setError("AddedBy", "AddedBy This is the error message") />
                </cfif>
  
                  <!----[ DateUPdated ]---->
                <cfif ( getDateUPdated() eq whatever )>
                    <cfset arguments.eH.setError("DateUPdated", "DateUPdated This is the error message") />
                </cfif>
  
                  <!----[ UpdatedBy ]---->
                <cfif ( getUpdatedBy() eq whatever )>
                    <cfset arguments.eH.setError("UpdatedBy", "UpdatedBy This is the error message") />
                </cfif>
  
   ]---->
		<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS  ]--->
    
    <cffunction name="setPageTemplateID" access="public" returntype="void" output="false">
            <cfargument name="PageTemplateID" type="numeric" required="true" />
            <cfset variables.instance.PageTemplateID = arguments.PageTemplateID />
	    </cffunction>
    <cffunction name="getPageTemplateID" access="public" returntype="numeric" output="false">
		   <cfreturn variables.instance.PageTemplateID />
		</cffunction>
    <cffunction name="setPageTemplateDescription" access="public" returntype="void" output="false">
            <cfargument name="PageTemplateDescription" type="string" required="true" />
            <cfset variables.instance.PageTemplateDescription = arguments.PageTemplateDescription />
	    </cffunction>
    <cffunction name="getPageTemplateDescription" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.PageTemplateDescription />
		</cffunction>
    <cffunction name="setPageTemplateExtraDescription" access="public" returntype="void" output="false">
            <cfargument name="PageTemplateExtraDescription" type="string" required="true" />
            <cfset variables.instance.PageTemplateExtraDescription = arguments.PageTemplateExtraDescription />
	    </cffunction>
    <cffunction name="getPageTemplateExtraDescription" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.PageTemplateExtraDescription />
		</cffunction>
    <cffunction name="setIsVisible" access="public" returntype="void" output="false">
            <cfargument name="IsVisible" type="boolean" required="true" />
            <cfset variables.instance.IsVisible = arguments.IsVisible />
	    </cffunction>
    <cffunction name="getIsVisible" access="public" returntype="boolean" output="false">
		   <cfreturn variables.instance.IsVisible />
		</cffunction>
    <cffunction name="setDateAdded" access="public" returntype="void" output="false">
            <cfargument name="DateAdded" type="date" required="true" />
            <cfset variables.instance.DateAdded = arguments.DateAdded />
	    </cffunction>
    <cffunction name="getDateAdded" access="public" returntype="date" output="false">
		   <cfreturn variables.instance.DateAdded />
		</cffunction>
    <cffunction name="setAddedBy" access="public" returntype="void" output="false">
            <cfargument name="AddedBy" type="string" required="true" />
            <cfset variables.instance.AddedBy = arguments.AddedBy />
	    </cffunction>
    <cffunction name="getAddedBy" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.AddedBy />
		</cffunction>
    <cffunction name="setDateUPdated" access="public" returntype="void" output="false">
            <cfargument name="DateUPdated" type="date" required="true" />
            <cfset variables.instance.DateUPdated = arguments.DateUPdated />
	    </cffunction>
    <cffunction name="getDateUPdated" access="public" returntype="date" output="false">
		   <cfreturn variables.instance.DateUPdated />

		</cffunction>
    <cffunction name="setUpdatedBy" access="public" returntype="void" output="false">
            <cfargument name="UpdatedBy" type="string" required="true" />
            <cfset variables.instance.UpdatedBy = arguments.UpdatedBy />
	    </cffunction>
    <cffunction name="getUpdatedBy" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.UpdatedBy />
		</cffunction>
</cfcomponent>