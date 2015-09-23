<cfcomponent displayname="Site" output="false" hint="A bean which models the Site record.">

<cfsilent>
<!----
================================================================
Filename: Site.cfc
Description: A bean which models the Site record.
Client:   Therapy OZ Admin Site
Author:  Michael Kear, AFP Webworks 
Date: 23/Sep/2015
================================================================
This bean was generated with the following template:
Bean Name: Site
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	SiteID numeric 0
	Sitename string 
	CustomerID numeric 0
	SiteTemplateID numeric 0
	Dateadded date #now()#
	Addedby string 
	Dateupdated date #now()#
	Updatedby string 
	Live boolean true
	IsVisible boolean true
	Version numeric 1
Create getSnapshot method: true
Create setSnapshot method: false
Create setStepInstance method: false
Create validate method: true
Create validate interior: true
Create LTO methods: false
Path to LTO: 
Date Format: DD/MM/YYYY
--->
</cfsilent>
	<!---[	PROPERTIES	]--->
	<cfset variables.instance = StructNew() />

	<!---[ 	INITIALIZATION / CONFIGURATION	]--->
	<cffunction name="init" access="public" returntype="Site" output="false">
		<cfargument name="SiteID" type="numeric" required="false" default="0" />
		<cfargument name="Sitename" type="string" required="false" default="" />
		<cfargument name="CustomerID" type="numeric" required="false" default="0" />
		<cfargument name="SiteTemplateID" type="numeric" required="false" default="0" />
		<cfargument name="Dateadded" type="string" required="false" default="#now()#" />
		<cfargument name="Addedby" type="string" required="false" default="" />
		<cfargument name="Dateupdated" type="string" required="false" default="#now()#" />
		<cfargument name="Updatedby" type="string" required="false" default="" />
		<cfargument name="Live" type="boolean" required="false" default="true" />
		<cfargument name="IsVisible" type="boolean" required="false" default="true" />
		<cfargument name="Version" type="numeric" required="false" default="1" />
		<cfscript>
			// run setters
			setSiteID(arguments.SiteID);
			setSitename(arguments.Sitename);
			setCustomerID(arguments.CustomerID);
			setSiteTemplateID(arguments.SiteTemplateID);
			setDateadded(arguments.Dateadded);
			setAddedby(arguments.Addedby);
			setDateupdated(arguments.Dateupdated);
			setUpdatedby(arguments.Updatedby);
			setLive(arguments.Live);
			setIsVisible(arguments.IsVisible);
			setVersion(arguments.Version);
			return this;
		</cfscript>
 	</cffunction>

	<!---[ 	PUBLIC FUNCTIONS 	]--->
	<cffunction name="getSnapshot" access="public"returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="validate" access="public" returntype="any" output="false">
		<cfargument name="eH" required="true" type="any" />
<!-----[ validation parameters  (customise to suit) then remove comments 
			<!----[ SiteID ]---->
			<cfif ( getSiteID() eq whatever )>
				<cfset arguments.eH.setError("SiteID", "SiteID This is the error message") />
			</cfif>
			<!----[ Sitename ]---->
			<cfif ( getSitename() eq whatever )>
				<cfset arguments.eH.setError("Sitename", "Sitename This is the error message") />
			</cfif>
			<!----[ CustomerID ]---->
			<cfif ( getCustomerID() eq whatever )>
				<cfset arguments.eH.setError("CustomerID", "CustomerID This is the error message") />
			</cfif>
			<!----[ SiteTemplateID ]---->
			<cfif ( getSiteTemplateID() eq whatever )>
				<cfset arguments.eH.setError("SiteTemplateID", "SiteTemplateID This is the error message") />
			</cfif>
			<!----[ Dateadded ]---->
			<cfif ( getDateadded() eq whatever )>
				<cfset arguments.eH.setError("Dateadded", "Dateadded This is the error message") />
			</cfif>
			<!----[ Addedby ]---->
			<cfif ( getAddedby() eq whatever )>
				<cfset arguments.eH.setError("Addedby", "Addedby This is the error message") />
			</cfif>
			<!----[ Dateupdated ]---->
			<cfif ( getDateupdated() eq whatever )>
				<cfset arguments.eH.setError("Dateupdated", "Dateupdated This is the error message") />
			</cfif>
			<!----[ Updatedby ]---->
			<cfif ( getUpdatedby() eq whatever )>
				<cfset arguments.eH.setError("Updatedby", "Updatedby This is the error message") />
			</cfif>
			<!----[ Live ]---->
			<cfif ( getLive() eq whatever )>
				<cfset arguments.eH.setError("Live", "Live This is the error message") />
			</cfif>
			<!----[ IsVisible ]---->
			<cfif ( getIsVisible() eq whatever )>
				<cfset arguments.eH.setError("IsVisible", "IsVisible This is the error message") />
			</cfif>
			<!----[ Version ]---->
			<cfif ( getVersion() eq whatever )>
				<cfset arguments.eH.setError("Version", "Version This is the error message") />
			</cfif>
 ]---->
			<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS 	]--->
	<cffunction name="setSiteID" access="public" returntype="void" output="false">
		<cfargument name="SiteID" type="numeric" required="true" />
		<cfset variables.instance.SiteID = arguments.SiteID />
	</cffunction>
	<cffunction name="getSiteID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SiteID />
	</cffunction>

	<cffunction name="setSitename" access="public" returntype="void" output="false">
		<cfargument name="Sitename" type="string" required="true" />
		<cfset variables.instance.Sitename = arguments.Sitename />
	</cffunction>
	<cffunction name="getSitename" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Sitename />
	</cffunction>

	<cffunction name="setCustomerID" access="public" returntype="void" output="false">
		<cfargument name="CustomerID" type="numeric" required="true" />
		<cfset variables.instance.CustomerID = arguments.CustomerID />
	</cffunction>
	<cffunction name="getCustomerID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CustomerID />
	</cffunction>

	<cffunction name="setSiteTemplateID" access="public" returntype="void" output="false">
		<cfargument name="SiteTemplateID" type="numeric" required="true" />
		<cfset variables.instance.SiteTemplateID = arguments.SiteTemplateID />
	</cffunction>
	<cffunction name="getSiteTemplateID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SiteTemplateID />
	</cffunction>

	<cffunction name="setDateadded" access="public" returntype="void" output="false">
		<cfargument name="Dateadded" type="string" required="true" />
		<cfif isDate(arguments.Dateadded)>
			<cfset arguments.Dateadded = dateformat(arguments.Dateadded,"DD/MM/YYYY") />
		</cfif>
		<cfset variables.instance.Dateadded = arguments.Dateadded />
	</cffunction>
	<cffunction name="getDateadded" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Dateadded />
	</cffunction>

	<cffunction name="setAddedby" access="public" returntype="void" output="false">
		<cfargument name="Addedby" type="string" required="true" />
		<cfset variables.instance.Addedby = arguments.Addedby />
	</cffunction>
	<cffunction name="getAddedby" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Addedby />
	</cffunction>

	<cffunction name="setDateupdated" access="public" returntype="void" output="false">
		<cfargument name="Dateupdated" type="string" required="true" />
		<cfif isDate(arguments.Dateupdated)>
			<cfset arguments.Dateupdated = dateformat(arguments.Dateupdated,"DD/MM/YYYY") />
		</cfif>
		<cfset variables.instance.Dateupdated = arguments.Dateupdated />
	</cffunction>
	<cffunction name="getDateupdated" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Dateupdated />
	</cffunction>

	<cffunction name="setUpdatedby" access="public" returntype="void" output="false">
		<cfargument name="Updatedby" type="string" required="true" />
		<cfset variables.instance.Updatedby = arguments.Updatedby />
	</cffunction>
	<cffunction name="getUpdatedby" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Updatedby />
	</cffunction>

	<cffunction name="setLive" access="public" returntype="void" output="false">
		<cfargument name="Live" type="boolean" required="true" />
		<cfset variables.instance.Live = arguments.Live />
	</cffunction>
	<cffunction name="getLive" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.Live />
	</cffunction>

	<cffunction name="setIsVisible" access="public" returntype="void" output="false">
		<cfargument name="IsVisible" type="boolean" required="true" />
		<cfset variables.instance.IsVisible = arguments.IsVisible />
	</cffunction>
	<cffunction name="getIsVisible" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsVisible />
	</cffunction>

	<cffunction name="setVersion" access="public" returntype="void" output="false">
		<cfargument name="Version" type="numeric" required="true" />
		<cfset variables.instance.Version = arguments.Version />
	</cffunction>
	<cffunction name="getVersion" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Version />
	</cffunction>

</cfcomponent>