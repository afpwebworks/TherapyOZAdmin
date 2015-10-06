<cfcomponent displayname="SiteTemplate" output="false" hint="A bean which models the SiteTemplate record.">
<cfsilent>
<!----
==========================================================================================================
Filename:    SiteTemplate.cfc
Description: A bean which models the SiteTemplate record
Client:      Therapy OZ Admin
Date:        30/Sep/2015
Author:      Michael Kear

Revision history:

==========================================================================================================
This bean was generated by the Beanbuilder Generator with the following template:
Bean Name: SiteTemplate
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
SiteTemplateID numeric 0 
TemplateName string 
IsVisible boolean true 
DateAdded date #now()# 
AddedBy string 
DateUpdated date #now()# 
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
	<cffunction name="init" access="public" returntype="SiteTemplate" output="false">
    
<cfargument name="SiteTemplateID" type="numeric" required="true" default="0" />
    <cfargument name="TemplateName" type="string" required="false" default="" />
    <cfargument name="IsVisible" type="boolean" required="true" default="true" />
    <cfargument name="DateAdded" type="date" required="true" default="#now()#" />
    <cfargument name="AddedBy" type="string" required="false" default="" />
    <cfargument name="DateUpdated" type="date" required="true" default="#now()#" />
    <cfargument name="UpdatedBy" type="string" required="false" default="" />
    
    
    <cfscript>
// run setters

     setSiteTemplateID(arguments.SiteTemplateID);
     setTemplateName(arguments.TemplateName);
     setIsVisible(arguments.IsVisible);
     setDateAdded(arguments.DateAdded);
     setAddedBy(arguments.AddedBy);
     setDateUpdated(arguments.DateUpdated);
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

                  <!----[ SiteTemplateID ]---->
                <cfif ( getSiteTemplateID() eq whatever )>
                    <cfset arguments.eH.setError("SiteTemplateID", "SiteTemplateID This is the error message") />
                </cfif>
  
                  <!----[ TemplateName ]---->
                <cfif ( getTemplateName() eq whatever )>
                    <cfset arguments.eH.setError("TemplateName", "TemplateName This is the error message") />
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
  
                  <!----[ DateUpdated ]---->
                <cfif ( getDateUpdated() eq whatever )>
                    <cfset arguments.eH.setError("DateUpdated", "DateUpdated This is the error message") />
                </cfif>
  
                  <!----[ UpdatedBy ]---->
                <cfif ( getUpdatedBy() eq whatever )>
                    <cfset arguments.eH.setError("UpdatedBy", "UpdatedBy This is the error message") />
                </cfif>
  
   ]---->
		<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS  ]--->
    
    <cffunction name="setSiteTemplateID" access="public" returntype="void" output="false">
            <cfargument name="SiteTemplateID" type="numeric" required="true" />
            <cfset variables.instance.SiteTemplateID = arguments.SiteTemplateID />
	    </cffunction>
    <cffunction name="getSiteTemplateID" access="public" returntype="numeric" output="false">
		   <cfreturn variables.instance.SiteTemplateID />
		</cffunction>
    <cffunction name="setTemplateName" access="public" returntype="void" output="false">
            <cfargument name="TemplateName" type="string" required="true" />
            <cfset variables.instance.TemplateName = arguments.TemplateName />
	    </cffunction>
    <cffunction name="getTemplateName" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.TemplateName />
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
    <cffunction name="setDateUpdated" access="public" returntype="void" output="false">
            <cfargument name="DateUpdated" type="date" required="true" />
            <cfset variables.instance.DateUpdated = arguments.DateUpdated />
	    </cffunction>
    <cffunction name="getDateUpdated" access="public" returntype="date" output="false">
		   <cfreturn variables.instance.DateUpdated />
		</cffunction>
    <cffunction name="setUpdatedBy" access="public" returntype="void" output="false">
            <cfargument name="UpdatedBy" type="string" required="true" />
            <cfset variables.instance.UpdatedBy = arguments.UpdatedBy />
	    </cffunction>
    <cffunction name="getUpdatedBy" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.UpdatedBy />
		</cffunction>
</cfcomponent>