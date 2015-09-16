<cfcomponent displayname="AdminMenu" output="false" hint="A bean which models the AdminMenu record.">

<cfsilent>
<!----
================================================================
Filename: AdminMenu.cfc
Description: A bean which models the AdminMenu record.
Author:  Michael Kear, AFP Webworks 
Date: 7/Jul/2014
================================================================
This bean was generated with the following template:
Bean Name: AdminMenu
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	MenuID numeric 0
	Description string 
	lvl numeric 0
	NodeRec string 
	URL string 
	Target string 
	Icon string inbox
	ViewPermission numeric 0
	EditPermission numeric 0
	DeletePermission numeric 0
	CreatePermission numeric 0
	InMenu boolean true
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
	<cffunction name="init" access="public" returntype="AdminMenu" output="false">
		<cfargument name="MenuID" type="numeric" required="false" default="0" />
		<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="lvl" type="numeric" required="false" default="0" />
		<cfargument name="NodeRec" type="string" required="false" default="" />
		<cfargument name="URL" type="string" required="false" default="" />
		<cfargument name="Target" type="string" required="false" default="" />
		<cfargument name="Icon" type="string" required="false" default="inbox" />
		<cfargument name="ViewPermission" type="numeric" required="false" default="0" />
		<cfargument name="EditPermission" type="numeric" required="false" default="0" />
		<cfargument name="DeletePermission" type="numeric" required="false" default="0" />
		<cfargument name="CreatePermission" type="numeric" required="false" default="0" />
		<cfargument name="InMenu" type="boolean" required="false" default="true" />
		<cfscript>
			// run setters
			setMenuID(arguments.MenuID);
			setDescription(arguments.Description);
			setLvl(arguments.lvl);
			setNodeRec(arguments.NodeRec);
			setURL(arguments.URL);
			setTarget(arguments.Target);
			setIcon(arguments.Icon);
			setViewPermission(arguments.ViewPermission);
			setEditPermission(arguments.EditPermission);
			setDeletePermission(arguments.DeletePermission);
			setCreatePermission(arguments.CreatePermission);
			setInMenu(arguments.InMenu);
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
			<!----[ MenuID ]---->
			<cfif ( getMenuID() eq whatever )>
				<cfset arguments.eH.setError("MenuID", "MenuID This is the error message") />
			</cfif>
			<!----[ Description ]---->
			<cfif ( getDescription() eq whatever )>
				<cfset arguments.eH.setError("Description", "Description This is the error message") />
			</cfif>
			<!----[ lvl ]---->
			<cfif ( getLvl() eq whatever )>
				<cfset arguments.eH.setError("lvl", "lvl This is the error message") />
			</cfif>
			<!----[ hid ]---->
			<cfif ( getHid() eq whatever )>
				<cfset arguments.eH.setError("hid", "hid This is the error message") />
			</cfif>
			<!----[ URL ]---->
			<cfif ( getURL() eq whatever )>
				<cfset arguments.eH.setError("URL", "URL This is the error message") />
			</cfif>
			<!----[ Target ]---->
			<cfif ( getTarget() eq whatever )>
				<cfset arguments.eH.setError("Target", "Target This is the error message") />
			</cfif>
			<!----[ Icon ]---->
			<cfif ( getIcon() eq whatever )>
				<cfset arguments.eH.setError("Icon", "Icon This is the error message") />
			</cfif>
			<!----[ ViewPermission ]---->
			<cfif ( getViewPermission() eq whatever )>
				<cfset arguments.eH.setError("ViewPermission", "ViewPermission This is the error message") />
			</cfif>
			<!----[ EditPermission ]---->
			<cfif ( getEditPermission() eq whatever )>
				<cfset arguments.eH.setError("EditPermission", "EditPermission This is the error message") />
			</cfif>
			<!----[ DeletePermission ]---->
			<cfif ( getDeletePermission() eq whatever )>
				<cfset arguments.eH.setError("DeletePermission", "DeletePermission This is the error message") />
			</cfif>
			<!----[ CreatePermission ]---->
			<cfif ( getCreatePermission() eq whatever )>
				<cfset arguments.eH.setError("CreatePermission", "CreatePermission This is the error message") />
			</cfif>
			<!----[ InMenu ]---->
			<cfif ( getInMenu() eq whatever )>
				<cfset arguments.eH.setError("InMenu", "InMenu This is the error message") />
			</cfif>
 ]---->
			<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS 	]--->
	<cffunction name="setMenuID" access="public" returntype="void" output="false">
		<cfargument name="MenuID" type="numeric" required="true" />
		<cfset variables.instance.MenuID = arguments.MenuID />
	</cffunction>
	<cffunction name="getMenuID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MenuID />
	</cffunction>

	<cffunction name="setDescription" access="public" returntype="void" output="false">
		<cfargument name="Description" type="string" required="true" />
		<cfset variables.instance.Description = arguments.Description />
	</cffunction>
	<cffunction name="getDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Description />
	</cffunction>

	<cffunction name="setLvl" access="public" returntype="void" output="false">
		<cfargument name="lvl" type="numeric" required="true" />
		<cfset variables.instance.lvl = arguments.lvl />
	</cffunction>
	<cffunction name="getLvl" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.lvl />
	</cffunction>

	<cffunction name="setNodeRec" access="public" returntype="void" output="false">
		<cfargument name="NodeRec" type="string" required="true" />
		<cfset variables.instance.NodeRec = arguments.NodeRec />
	</cffunction>
	<cffunction name="getNodeRec" access="public" returntype="string" output="false">
		<cfreturn variables.instance.NodeRec />
	</cffunction>

	<cffunction name="setURL" access="public" returntype="void" output="false">
		<cfargument name="URL" type="string" required="true" />
		<cfset variables.instance.URL = arguments.URL />
	</cffunction>
	<cffunction name="getURL" access="public" returntype="string" output="false">
		<cfreturn variables.instance.URL />
	</cffunction>

	<cffunction name="setTarget" access="public" returntype="void" output="false">
		<cfargument name="Target" type="string" required="true" />
		<cfset variables.instance.Target = arguments.Target />
	</cffunction>
	<cffunction name="getTarget" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Target />
	</cffunction>

	<cffunction name="setIcon" access="public" returntype="void" output="false">
		<cfargument name="Icon" type="string" required="true" />
		<cfset variables.instance.Icon = arguments.Icon />
	</cffunction>
	<cffunction name="getIcon" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Icon />
	</cffunction>

	<cffunction name="setViewPermission" access="public" returntype="void" output="false">
		<cfargument name="ViewPermission" type="numeric" required="true" />
		<cfset variables.instance.ViewPermission = arguments.ViewPermission />
	</cffunction>
	<cffunction name="getViewPermission" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ViewPermission />
	</cffunction>

	<cffunction name="setEditPermission" access="public" returntype="void" output="false">
		<cfargument name="EditPermission" type="numeric" required="true" />
		<cfset variables.instance.EditPermission = arguments.EditPermission />
	</cffunction>
	<cffunction name="getEditPermission" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.EditPermission />
	</cffunction>

	<cffunction name="setDeletePermission" access="public" returntype="void" output="false">
		<cfargument name="DeletePermission" type="numeric" required="true" />
		<cfset variables.instance.DeletePermission = arguments.DeletePermission />
	</cffunction>
	<cffunction name="getDeletePermission" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.DeletePermission />
	</cffunction>

	<cffunction name="setCreatePermission" access="public" returntype="void" output="false">
		<cfargument name="CreatePermission" type="numeric" required="true" />
		<cfset variables.instance.CreatePermission = arguments.CreatePermission />
	</cffunction>
	<cffunction name="getCreatePermission" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CreatePermission />
	</cffunction>

	<cffunction name="setInMenu" access="public" returntype="void" output="false">
		<cfargument name="InMenu" type="boolean" required="true" />
		<cfset variables.instance.InMenu = arguments.InMenu />
	</cffunction>
	<cffunction name="getInMenu" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.InMenu />
	</cffunction>

</cfcomponent>