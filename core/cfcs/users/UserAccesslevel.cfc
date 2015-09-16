<cfcomponent displayname="UserAccessLevel" output="false" hint="A bean which models the UserAccessLevel record.">

<cfsilent>
<!----
================================================================
Filename: UserAccessLevel.cfc
Description: A bean which models the UserAccessLevel record.
Author:  Michael Kear, AFP Webworks 
Date: 17/Sep/2008
================================================================
This bean was generated with the following template:
Bean Name: UserAccessLevel
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	LevelID numeric 0
	UserAccessLevel numeric 0
	UserAccessLevelDesc string 
	AddedBy string 
	DateAdded any 
	Updatedby string 
	DateUpdated any 
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
	<cffunction name="init" access="public" returntype="UserAccessLevel" output="false">
		<cfargument name="LevelID" type="numeric" required="false" default="0" />
		<cfargument name="UserAccessLevel" type="numeric" required="false" default="0" />
		<cfargument name="UserAccessLevelDesc" type="string" required="false" default="" />
		<cfargument name="AddedBy" type="string" required="false" default="" />
		<cfargument name="DateAdded" type="any" required="false" default="" />
		<cfargument name="Updatedby" type="string" required="false" default="" />
		<cfargument name="DateUpdated" type="any" required="false" default="" />
		<cfscript>
			// run setters
			setLevelID(arguments.LevelID);
			setUserAccessLevel(arguments.UserAccessLevel);
			setUserAccessLevelDesc(arguments.UserAccessLevelDesc);
			setAddedBy(arguments.AddedBy);
			setDateAdded(arguments.DateAdded);
			setUpdatedby(arguments.Updatedby);
			setDateUpdated(arguments.DateUpdated);
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
			<!----[ LevelID ]---->
			<cfif ( getLevelID() eq whatever )>
				<cfset arguments.eH.setError("LevelID", "LevelID This is the error message") />
			</cfif>
			<!----[ UserAccessLevel ]---->
			<cfif ( getUserAccessLevel() eq whatever )>
				<cfset arguments.eH.setError("UserAccessLevel", "UserAccessLevel This is the error message") />
			</cfif>
			<!----[ UserAccessLevelDesc ]---->
			<cfif ( getUserAccessLevelDesc() eq whatever )>
				<cfset arguments.eH.setError("UserAccessLevelDesc", "UserAccessLevelDesc This is the error message") />
			</cfif>
			<!----[ AddedBy ]---->
			<cfif ( getAddedBy() eq whatever )>
				<cfset arguments.eH.setError("AddedBy", "AddedBy This is the error message") />
			</cfif>
			<!----[ DateAdded ]---->
			<cfif ( getDateAdded() eq whatever )>
				<cfset arguments.eH.setError("DateAdded", "DateAdded This is the error message") />
			</cfif>
			<!----[ Updatedby ]---->
			<cfif ( getUpdatedby() eq whatever )>
				<cfset arguments.eH.setError("Updatedby", "Updatedby This is the error message") />
			</cfif>
			<!----[ DateUpdated ]---->
			<cfif ( getDateUpdated() eq whatever )>
				<cfset arguments.eH.setError("DateUpdated", "DateUpdated This is the error message") />
			</cfif>
 ]---->
			<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS 	]--->
	<cffunction name="setLevelID" access="public" returntype="void" output="false">
		<cfargument name="LevelID" type="numeric" required="true" />
		<cfset variables.instance.LevelID = arguments.LevelID />
	</cffunction>
	<cffunction name="getLevelID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.LevelID />
	</cffunction>

	<cffunction name="setUserAccessLevel" access="public" returntype="void" output="false">
		<cfargument name="UserAccessLevel" type="numeric" required="true" />
		<cfset variables.instance.UserAccessLevel = arguments.UserAccessLevel />
	</cffunction>
	<cffunction name="getUserAccessLevel" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.UserAccessLevel />
	</cffunction>

	<cffunction name="setUserAccessLevelDesc" access="public" returntype="void" output="false">
		<cfargument name="UserAccessLevelDesc" type="string" required="true" />
		<cfset variables.instance.UserAccessLevelDesc = arguments.UserAccessLevelDesc />
	</cffunction>
	<cffunction name="getUserAccessLevelDesc" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UserAccessLevelDesc />
	</cffunction>

	<cffunction name="setAddedBy" access="public" returntype="void" output="false">
		<cfargument name="AddedBy" type="string" required="true" />
		<cfset variables.instance.AddedBy = arguments.AddedBy />
	</cffunction>
	<cffunction name="getAddedBy" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AddedBy />
	</cffunction>

	<cffunction name="setDateAdded" access="public" returntype="void" output="false">
		<cfargument name="DateAdded" type="any" required="true" />
		<cfset variables.instance.DateAdded = arguments.DateAdded />
	</cffunction>
	<cffunction name="getDateAdded" access="public" returntype="any" output="false">
		<cfreturn variables.instance.DateAdded />
	</cffunction>

	<cffunction name="setUpdatedby" access="public" returntype="void" output="false">
		<cfargument name="Updatedby" type="string" required="true" />
		<cfset variables.instance.Updatedby = arguments.Updatedby />
	</cffunction>
	<cffunction name="getUpdatedby" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Updatedby />
	</cffunction>

	<cffunction name="setDateUpdated" access="public" returntype="void" output="false">
		<cfargument name="DateUpdated" type="any" required="true" />
		<cfset variables.instance.DateUpdated = arguments.DateUpdated />
	</cffunction>
	<cffunction name="getDateUpdated" access="public" returntype="any" output="false">
		<cfreturn variables.instance.DateUpdated />
	</cffunction>

</cfcomponent>