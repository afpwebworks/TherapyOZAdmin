<cfcomponent displayname="PermissionBean" output="false" hint="A bean which models the PermissionBean record.">

<cfsilent>
<!----
================================================================
Filename: PermissionBean.cfc
Description: A bean which models the PermissionBean record.
Author:  Michael Kear, AFP Webworks 
Date: 16/Sep/2008
================================================================
This bean was generated with the following template:
Bean Name: PermissionBean
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	PermissionID numeric 0
	Permission string 
	IsVisible boolean true
	Permissioncategory numeric 0
	PermissionDefaultLevel numeric 0
	DateAdded any 
	AddedBy string 
	DateUpdated any 
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
	<cffunction name="init" access="public" returntype="PermissionBean" output="false">
		<cfargument name="PermissionID" type="numeric" required="false" default="0" />
		<cfargument name="Permission" type="string" required="false" default="" />
		<cfargument name="IsVisible" type="boolean" required="false" default="true" />
		<cfargument name="Permissioncategory" type="numeric" required="false" default="0" />
		<cfargument name="PermissionDefaultLevel" type="numeric" required="false" default="0" />
		<cfargument name="DateAdded" type="any" required="false" default="" />
		<cfargument name="AddedBy" type="string" required="false" default="" />
		<cfargument name="DateUpdated" type="any" required="false" default="" />
		<cfargument name="UpdatedBy" type="string" required="false" default="" />
		<cfscript>
			// run setters
			setPermissionID(arguments.PermissionID);
			setPermission(arguments.Permission);
			setIsVisible(arguments.IsVisible);
			setPermissioncategory(arguments.Permissioncategory);
			setPermissionDefaultLevel(arguments.PermissionDefaultLevel);
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
			<!----[ PermissionID ]---->
			<cfif ( getPermissionID() eq whatever )>
				<cfset arguments.eH.setError("PermissionID", "PermissionID This is the error message") />
			</cfif>
			
 ]---->
			<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS 	]--->
	<cffunction name="setPermissionID" access="public" returntype="void" output="false">
		<cfargument name="PermissionID" type="numeric" required="true" />
		<cfset variables.instance.PermissionID = arguments.PermissionID />
	</cffunction>
	<cffunction name="getPermissionID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PermissionID />
	</cffunction>

	<cffunction name="setPermission" access="public" returntype="void" output="false">
		<cfargument name="Permission" type="string" required="true" />
		<cfset variables.instance.Permission = arguments.Permission />
	</cffunction>
	<cffunction name="getPermission" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Permission />
	</cffunction>

	<cffunction name="setIsVisible" access="public" returntype="void" output="false">
		<cfargument name="IsVisible" type="boolean" required="true" />
		<cfset variables.instance.IsVisible = arguments.IsVisible />
	</cffunction>
	<cffunction name="getIsVisible" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsVisible />
	</cffunction>

	<cffunction name="setPermissioncategory" access="public" returntype="void" output="false">
		<cfargument name="Permissioncategory" type="numeric" required="true" />
		<cfset variables.instance.Permissioncategory = arguments.Permissioncategory />
	</cffunction>
	<cffunction name="getPermissioncategory" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Permissioncategory />
	</cffunction>

	<cffunction name="setPermissionDefaultLevel" access="public" returntype="void" output="false">
		<cfargument name="PermissionDefaultLevel" type="numeric" required="true" />
		<cfset variables.instance.PermissionDefaultLevel = arguments.PermissionDefaultLevel />
	</cffunction>
	<cffunction name="getPermissionDefaultLevel" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PermissionDefaultLevel />
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