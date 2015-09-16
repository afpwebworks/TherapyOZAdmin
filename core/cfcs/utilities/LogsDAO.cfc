<cfcomponent displayname="Log DAO" output="false" hint="DAO Component Handles all Database access for the table Log.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    LogsDAO.cfc
Description: DAO Component Handles all Database access for the table Log.  Requires Coldspring v1.0
Date:        7/Sep/2015
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( Log.getlogid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="LogsDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="configbean" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
	<cfreturn this />
</cffunction>

<cffunction name="setUserService" access="public" output="false" returntype="void" hint="Dependency: User Service">
	<cfargument name="UserService" type="any" required="true"/>
	<cfset variables.UserService = arguments.UserService/>
</cffunction>


<cffunction name="save" access="public" returntype="Log" output="false" hint="DAO method">
<cfargument name="Log" type="Log" required="yes" />
<!-----[  If a LogID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.Log.getLogID() neq "0")>	
		<cfset Log = update(arguments.Log)/>
	<cfelse>
		<cfset Log = create(arguments.Log)/>
	</cfif>
	<cfreturn Log />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="Log" type="Log" required="true" /> 
	<cfset var qLogDelete = 0 >
<!-----[  to delete, set 'IsVisible' flag to zero  ]--->
		<cfquery name="qLogDelete" datasource="#variables.dsn#" >
		UPDATE Log
		Set IsVisible = '0'
		WHERE 
		LogID = <cfqueryparam value="#Log.getLogID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>	
</cffunction>


<cffunction name="UnDelete" returntype="void" output="false" hint="DAO method" >
<cfargument name="Log" type="Log" required="true" /> 
	<cfset var qLogUnDelete = 0 >
<!-----[  to UnDelete, set 'IsVisible' flag to 1 (true)  ]--->
		<cfquery name="qLogDelete" datasource="#variables.dsn#" >
		UPDATE Log
		Set IsVisible = '1'
		WHERE 
		LogID = <cfqueryparam value="#Log.getLogID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>	
</cffunction>


<cffunction name="read" access="public" returntype="Log" output="false" hint="DAO Method. - Reads a Log into the bean">
<cfargument name="argsLog" type="Log" required="true" />
	<cfset var Log  =  arguments.argsLog />
	<cfset var QLogselect = "" />
	<cfquery name="QLogselect" datasource="#variables.dsn#">
		SELECT 
		LogID, SiteID, UserID, TableName, Activity, Comment, DateAdded, IsVisible
		FROM Log 
		WHERE 
		IsVisible = '1' ANDLogID = <cfqueryparam value="#Log.getLogID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QLogselect.recordCount >
		<cfscript>
		Log.setLogID(QLogselect.LogID);
         Log.setSiteID(QLogselect.SiteID);
         Log.setUserID(QLogselect.UserID);
         Log.setTableName(QLogselect.TableName);
         Log.setActivity(QLogselect.Activity);
         Log.setComment(QLogselect.Comment);
         Log.setDateAdded(QLogselect.DateAdded);
         Log.setIsVisible(QLogselect.IsVisible);
         
		</cfscript>
	</cfif>
	<cfreturn Log />
</cffunction>
		

<cffunction name="GetAllLogs" access="public" output="false" returntype="query" hint="Returns a query of all Logs in our Database">
<cfset var QgetallLogs = 0 />
	<cfquery name="QgetallLogs" datasource="#variables.dsn#">
		SELECT LogID, SiteID, UserID, TableName, Activity, Comment, DateAdded, IsVisible
		FROM Log 
		WHERE IsVisible = '1'
        
		ORDER BY LogID
	</cfquery>
	<cfreturn QgetallLogs />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="Log" output="false" hint="DAO method">
<cfargument name="argsLog" type="Log" required="yes" displayname="create" />
	<cfset var qLogInsert = 0 />
	<cfset var Log = arguments.argsLog />
	
	<cfquery name="qLogInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into Log
		( SiteID, UserID, TableName, Activity, Comment, DateAdded, IsVisible ) VALUES
		(

		<cfqueryparam value="#Log.getsiteid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#Log.getuserid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#Log.gettablename()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Log.getactivity()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Log.getcomment()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_BINARY" />,
		<cfqueryparam value="#Log.getisvisible()#" cfsqltype="CF_SQL_BIT" />
		   ) 
		SELECT Ident_Current('Log') as LogID
		SET NOCOUNT OFF
	</cfquery>
	<cfset Log.setLogID(qLogInsert.LogID)>

	<cfreturn Log />
</cffunction>

<cffunction name="update" access="private" returntype="Log" output="false" hint="DAO method">
<cfargument name="argsLog" type="Log" required="yes" />
	<cfset var Log = arguments.argsLog />
	<cfset var LogUpdate = 0 >
	<cfquery name="LogUpdate" datasource="#variables.dsn#" >
		UPDATE Log SET
        siteid  = <cfqueryparam value="#Log.getSiteID()#" cfsqltype="CF_SQL_INTEGER"/>,
        userid  = <cfqueryparam value="#Log.getUserID()#" cfsqltype="CF_SQL_INTEGER"/>,
        tablename  = <cfqueryparam value="#Log.getTableName()#" cfsqltype="CF_SQL_VARCHAR"/>,
        activity  = <cfqueryparam value="#Log.getActivity()#" cfsqltype="CF_SQL_VARCHAR"/>,
        comment  = <cfqueryparam value="#Log.getComment()#" cfsqltype="CF_SQL_VARCHAR"/>,
        isvisible  = <cfqueryparam value="#Log.getIsVisible()#" cfsqltype="CF_SQL_BIT"/>
						
		WHERE 
		LogID = <cfqueryparam value="#Log.getLogID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
	
	<cfreturn Log />
</cffunction>

</cfcomponent>
