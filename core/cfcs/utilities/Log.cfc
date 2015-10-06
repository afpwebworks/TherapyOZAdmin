<cfcomponent displayname="Log" output="false" hint="A bean which models the Log record.">

<cfsilent>
<!----
================================================================
Filename: Log.cfc
Description: A bean which models the Log record.
Client:   Therapy OZ Admin site
Author:  Michael Kear, AFP Webworks 
Date: 29/Sep/2015
================================================================
This bean was generated with the following template:
Bean Name: Log
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	LogID numeric 0
	SiteID numeric 0
	UserID numeric 0
	TableName string 
	Activity string 
	Comment string 
	DateAdded date #now()#
	IsVisible boolean true
	Seen boolean false
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
	<cffunction name="init" access="public" returntype="Log" output="false">
		<cfargument name="LogID" type="numeric" required="false" default="0" />
		<cfargument name="SiteID" type="numeric" required="false" default="0" />
		<cfargument name="UserID" type="numeric" required="false" default="0" />
		<cfargument name="TableName" type="string" required="false" default="" />
		<cfargument name="Activity" type="string" required="false" default="" />
		<cfargument name="Comment" type="string" required="false" default="" />
		<cfargument name="DateAdded" type="string" required="false" default="#now()#" />
		<cfargument name="IsVisible" type="boolean" required="false" default="true" />
		<cfargument name="Seen" type="boolean" required="false" default="false" />
		<cfscript>
			// run setters
			setLogID(arguments.LogID);
			setSiteID(arguments.SiteID);
			setUserID(arguments.UserID);
			setTableName(arguments.TableName);
			setActivity(arguments.Activity);
			setComment(arguments.Comment);
			setDateAdded(arguments.DateAdded);
			setIsVisible(arguments.IsVisible);
			setSeen(arguments.Seen);
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
			<!----[ LogID ]---->
			<cfif ( getLogID() eq whatever )>
				<cfset arguments.eH.setError("LogID", "LogID This is the error message") />
			</cfif>
			<!----[ SiteID ]---->
			<cfif ( getSiteID() eq whatever )>
				<cfset arguments.eH.setError("SiteID", "SiteID This is the error message") />
			</cfif>
			<!----[ UserID ]---->
			<cfif ( getUserID() eq whatever )>
				<cfset arguments.eH.setError("UserID", "UserID This is the error message") />
			</cfif>
			<!----[ TableName ]---->
			<cfif ( getTableName() eq whatever )>
				<cfset arguments.eH.setError("TableName", "TableName This is the error message") />
			</cfif>
			<!----[ Activity ]---->
			<cfif ( getActivity() eq whatever )>
				<cfset arguments.eH.setError("Activity", "Activity This is the error message") />
			</cfif>
			<!----[ Comment ]---->
			<cfif ( getComment() eq whatever )>
				<cfset arguments.eH.setError("Comment", "Comment This is the error message") />
			</cfif>
			<!----[ DateAdded ]---->
			<cfif ( getDateAdded() eq whatever )>
				<cfset arguments.eH.setError("DateAdded", "DateAdded This is the error message") />
			</cfif>
			<!----[ IsVisible ]---->
			<cfif ( getIsVisible() eq whatever )>
				<cfset arguments.eH.setError("IsVisible", "IsVisible This is the error message") />
			</cfif>
			<!----[ Seen ]---->
			<cfif ( getSeen() eq whatever )>
				<cfset arguments.eH.setError("Seen", "Seen This is the error message") />
			</cfif>

 ]---->
			<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS 	]--->
	<cffunction name="setLogID" access="public" returntype="void" output="false">
		<cfargument name="LogID" type="numeric" required="true" />
		<cfset variables.instance.LogID = arguments.LogID />
	</cffunction>
	<cffunction name="getLogID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.LogID />
	</cffunction>

	<cffunction name="setSiteID" access="public" returntype="void" output="false">
		<cfargument name="SiteID" type="numeric" required="true" />
		<cfset variables.instance.SiteID = arguments.SiteID />
	</cffunction>
	<cffunction name="getSiteID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SiteID />
	</cffunction>

	<cffunction name="setUserID" access="public" returntype="void" output="false">
		<cfargument name="UserID" type="numeric" required="true" />
		<cfset variables.instance.UserID = arguments.UserID />
	</cffunction>
	<cffunction name="getUserID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.UserID />
	</cffunction>

	<cffunction name="setTableName" access="public" returntype="void" output="false">
		<cfargument name="TableName" type="string" required="true" />
		<cfset variables.instance.TableName = arguments.TableName />
	</cffunction>
	<cffunction name="getTableName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.TableName />
	</cffunction>

	<cffunction name="setActivity" access="public" returntype="void" output="false">
		<cfargument name="Activity" type="string" required="true" />
		<cfset variables.instance.Activity = arguments.Activity />
	</cffunction>
	<cffunction name="getActivity" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Activity />
	</cffunction>

	<cffunction name="setComment" access="public" returntype="void" output="false">
		<cfargument name="Comment" type="string" required="true" />
		<cfset variables.instance.Comment = arguments.Comment />
	</cffunction>
	<cffunction name="getComment" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Comment />
	</cffunction>

	<cffunction name="setDateAdded" access="public" returntype="void" output="false">
		<cfargument name="DateAdded" type="string" required="true" />
		<cfif isDate(arguments.DateAdded)>
			<cfset arguments.DateAdded = dateformat(arguments.DateAdded,"DD/MM/YYYY") />
		</cfif>
		<cfset variables.instance.DateAdded = arguments.DateAdded />
	</cffunction>
	<cffunction name="getDateAdded" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateAdded />
	</cffunction>

	<cffunction name="setIsVisible" access="public" returntype="void" output="false">
		<cfargument name="IsVisible" type="boolean" required="true" />
		<cfset variables.instance.IsVisible = arguments.IsVisible />
	</cffunction>
	<cffunction name="getIsVisible" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsVisible />
	</cffunction>

	<cffunction name="setSeen" access="public" returntype="void" output="false">
		<cfargument name="Seen" type="boolean" required="true" />
		<cfset variables.instance.Seen = arguments.Seen />
	</cffunction>
	<cffunction name="getSeen" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.Seen />
	</cffunction>


<cffunction name="SaveLog" access="public" output="no" returntype="Log" hint="Persists a log object to the database.">
	<cfargument name="argsLOG" required="yes" type="Log" hint="A valid Log Object to be persisted." />
    <cfset var Log = arguments.argsLOG />
    <cfset application.beanfactory.getbean("LogsDAO").save(log) />
    <cfreturn Log />
	
</cffunction>

</cfcomponent>