<cfcomponent displayname="SiteContact" output="false" hint="A bean which models the SiteContact record.">

<cfsilent>
<!----
================================================================
Filename: SiteContact.cfc
Description: A bean which models the SiteContact record.
Author:  Michael Kear, AFP Webworks 
Date: 23/Sep/2008
================================================================
This bean was generated with the following template:
Bean Name: SiteContact
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	ContactID numeric 0
	Title string 
	SortCode numeric 0
	UserID numeric 0
	IsVisible boolean true
	Addedby string 
	dateadded any #now()#
	dateupdated any #now()#
	Updatedby string 
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
	<cffunction name="init" access="public" returntype="SiteContact" output="false">
		<cfargument name="ContactID" type="numeric" required="false" default="0" />
		<cfargument name="Title" type="string" required="false" default="" />
		<cfargument name="SortCode" type="numeric" required="false" default="0" />
		<cfargument name="UserID" type="numeric" required="false" default="0" />
		<cfargument name="IsVisible" type="boolean" required="false" default="true" />
		<cfargument name="Addedby" type="string" required="false" default="" />
		<cfargument name="dateadded" type="any" required="false" default="#now()#" />
		<cfargument name="dateupdated" type="any" required="false" default="#now()#" />
		<cfargument name="Updatedby" type="string" required="false" default="" />
		<cfscript>
			// run setters
			setContactID(arguments.ContactID);
			setTitle(arguments.Title);
			setSortCode(arguments.SortCode);
			setUserID(arguments.UserID);
			setIsVisible(arguments.IsVisible);
			setAddedby(arguments.Addedby);
			setDateadded(arguments.dateadded);
			setDateupdated(arguments.dateupdated);
			setUpdatedby(arguments.Updatedby);
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
			<!----[ ContactID ]---->
			<cfif ( getContactID() eq whatever )>
				<cfset arguments.eH.setError("ContactID", "ContactID This is the error message") />
			</cfif>
			<!----[ Title ]---->
			<cfif ( getTitle() eq whatever )>
				<cfset arguments.eH.setError("Title", "Title This is the error message") />
			</cfif>
			<!----[ SortCode ]---->
			<cfif ( getSortCode() eq whatever )>
				<cfset arguments.eH.setError("SortCode", "SortCode This is the error message") />
			</cfif>
			<!----[ UserID ]---->
			<cfif ( getUserID() eq whatever )>
				<cfset arguments.eH.setError("UserID", "UserID This is the error message") />
			</cfif>
			<!----[ IsVisible ]---->
			<cfif ( getIsVisible() eq whatever )>
				<cfset arguments.eH.setError("IsVisible", "IsVisible This is the error message") />
			</cfif>
			<!----[ Addedby ]---->
			<cfif ( getAddedby() eq whatever )>
				<cfset arguments.eH.setError("Addedby", "Addedby This is the error message") />
			</cfif>
			<!----[ dateadded ]---->
			<cfif ( getDateadded() eq whatever )>
				<cfset arguments.eH.setError("dateadded", "dateadded This is the error message") />
			</cfif>
			<!----[ dateupdated ]---->
			<cfif ( getDateupdated() eq whatever )>
				<cfset arguments.eH.setError("dateupdated", "dateupdated This is the error message") />
			</cfif>
			<!----[ Updatedby ]---->
			<cfif ( getUpdatedby() eq whatever )>
				<cfset arguments.eH.setError("Updatedby", "Updatedby This is the error message") />
			</cfif>
 ]---->
			<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS 	]--->
	<cffunction name="setContactID" access="public" returntype="void" output="false">
		<cfargument name="ContactID" type="numeric" required="true" />
		<cfset variables.instance.ContactID = arguments.ContactID />
	</cffunction>
	<cffunction name="getContactID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ContactID />
	</cffunction>

	<cffunction name="setTitle" access="public" returntype="void" output="false">
		<cfargument name="Title" type="string" required="true" />
		<cfset variables.instance.Title = arguments.Title />
	</cffunction>
	<cffunction name="getTitle" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Title />
	</cffunction>

	<cffunction name="setSortCode" access="public" returntype="void" output="false">
		<cfargument name="SortCode" type="numeric" required="true" />
		<cfset variables.instance.SortCode = arguments.SortCode />
	</cffunction>
	<cffunction name="getSortCode" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SortCode />
	</cffunction>

	<cffunction name="setUserID" access="public" returntype="void" output="false">
		<cfargument name="UserID" type="numeric" required="true" />
		<cfset variables.instance.UserID = arguments.UserID />
	</cffunction>
	<cffunction name="getUserID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.UserID />
	</cffunction>

	<cffunction name="setIsVisible" access="public" returntype="void" output="false">
		<cfargument name="IsVisible" type="boolean" required="true" />
		<cfset variables.instance.IsVisible = arguments.IsVisible />
	</cffunction>
	<cffunction name="getIsVisible" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsVisible />
	</cffunction>

	<cffunction name="setAddedby" access="public" returntype="void" output="false">
		<cfargument name="Addedby" type="string" required="true" />
		<cfset variables.instance.Addedby = arguments.Addedby />
	</cffunction>
	<cffunction name="getAddedby" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Addedby />
	</cffunction>

	<cffunction name="setDateadded" access="public" returntype="void" output="false">
		<cfargument name="dateadded" type="any" required="true" />
		<cfset variables.instance.dateadded = arguments.dateadded />
	</cffunction>
	<cffunction name="getDateadded" access="public" returntype="any" output="false">
		<cfreturn variables.instance.dateadded />
	</cffunction>

	<cffunction name="setDateupdated" access="public" returntype="void" output="false">
		<cfargument name="dateupdated" type="any" required="true" />
		<cfset variables.instance.dateupdated = arguments.dateupdated />
	</cffunction>
	<cffunction name="getDateupdated" access="public" returntype="any" output="false">
		<cfreturn variables.instance.dateupdated />
	</cffunction>

	<cffunction name="setUpdatedby" access="public" returntype="void" output="false">
		<cfargument name="Updatedby" type="string" required="true" />
		<cfset variables.instance.Updatedby = arguments.Updatedby />
	</cffunction>
	<cffunction name="getUpdatedby" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Updatedby />
	</cffunction>

</cfcomponent>