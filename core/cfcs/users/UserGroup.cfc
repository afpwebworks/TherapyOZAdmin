<cfcomponent displayname="UserGroup" output="false" hint="A bean which models the UserGroup record.">

<cfsilent>
<!----
================================================================
Filename: UserGroup.cfc
Description: A bean which models the UserGroup record.
Author:  Michael Kear, AFP Webworks 
Date: 23/Sep/2008
================================================================
This bean was generated with the following template:
Bean Name: UserGroup
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	UserGroupID numeric 0
	UserGroupName string 
	IsVisible boolean true
	DateAdded any #now()#
	AddedBy string 
	DateUpdated any #now()#
	UpdatedBy string 
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
	<cffunction name="init" access="public" returntype="UserGroup" output="false">
		<cfargument name="UserGroupID" type="numeric" required="false" default="0" />
		<cfargument name="UserGroupName" type="string" required="false" default="" />
		<cfargument name="IsVisible" type="boolean" required="false" default="true" />
		<cfargument name="DateAdded" type="any" required="false" default="#now()#" />
		<cfargument name="AddedBy" type="string" required="false" default="" />
		<cfargument name="DateUpdated" type="any" required="false" default="#now()#" />
		<cfargument name="UpdatedBy" type="string" required="false" default="" />
		<cfscript>
			// run setters
			setUserGroupID(arguments.UserGroupID);
			setUserGroupName(arguments.UserGroupName);
			setIsVisible(arguments.IsVisible);
			setDateAdded(arguments.DateAdded);
			setAddedBy(arguments.AddedBy);
			setDateUpdated(arguments.DateUpdated);
			setUpdatedBy(arguments.UpdatedBy);
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
			<!----[ UserGroupID ]---->
			<cfif ( getUserGroupID() eq whatever )>
				<cfset arguments.eH.setError("UserGroupID", "UserGroupID This is the error message") />
			</cfif>
			<!----[ UserGroupName ]---->
			<cfif ( getUserGroupName() eq whatever )>
				<cfset arguments.eH.setError("UserGroupName", "UserGroupName This is the error message") />
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

	<!---[ 	ACCESSORS 	]--->
	<cffunction name="setUserGroupID" access="public" returntype="void" output="false">
		<cfargument name="UserGroupID" type="numeric" required="true" />
		<cfset variables.instance.UserGroupID = arguments.UserGroupID />
	</cffunction>
	<cffunction name="getUserGroupID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.UserGroupID />
	</cffunction>

	<cffunction name="setUserGroupName" access="public" returntype="void" output="false">
		<cfargument name="UserGroupName" type="string" required="true" />
		<cfset variables.instance.UserGroupName = arguments.UserGroupName />
	</cffunction>
	<cffunction name="getUserGroupName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UserGroupName />
	</cffunction>

	<cffunction name="setIsVisible" access="public" returntype="void" output="false">
		<cfargument name="IsVisible" type="boolean" required="true" />
		<cfset variables.instance.IsVisible = arguments.IsVisible />
	</cffunction>
	<cffunction name="getIsVisible" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsVisible />
	</cffunction>

	<cffunction name="setDateAdded" access="public" returntype="void" output="false">
		<cfargument name="DateAdded" type="any" required="true" />
		<cfset variables.instance.DateAdded = arguments.DateAdded />
	</cffunction>
	<cffunction name="getDateAdded" access="public" returntype="any" output="false">
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
		<cfargument name="DateUpdated" type="any" required="true" />
		<cfset variables.instance.DateUpdated = arguments.DateUpdated />
	</cffunction>
	<cffunction name="getDateUpdated" access="public" returntype="any" output="false">
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