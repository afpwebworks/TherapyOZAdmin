<cfcomponent displayname="UserGroups DAO" output="false" hint="DAO Component Handles all Database access for the table UserGroups.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    UserGroupsDAO.cfc
Description: DAO Component Handles all Database access for the table UserGroups.  Requires Coldspring v1.0
Date:        23/Sep/2008
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="UserGroupsDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="any" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
	<cfreturn this />
</cffunction>

<cffunction name="setUserService" access="public" output="false" returntype="void" hint="Dependency: User Service">
	<cfargument name="UserService" type="any" required="true"/>
	<cfset variables.UserService = arguments.UserService/>
</cffunction>


<cffunction name="save" access="public" returntype="UserGroup" output="false" hint="DAO method">
<cfargument name="UserGroup" type="UserGroup" required="yes" />
<!-----[  If a UserGroupID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.UserGroup.getUserGroupID() neq "0")>	
		<cfset UserGroup = update(arguments.UserGroup)/>
	<cfelse>
		<cfset UserGroup = create(arguments.UserGroup)/>
	</cfif>
	<cfreturn UserGroup />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="UserGroup" type="UserGroup" required="true" /> 
	<cfset var qUserGroupDelete = 0 >
<!-----[  to delete, set 'IsVisible' flag to zero  ]--->
		<cfquery name="qUserGroupDelete" datasource="#variables.dsn#" >
		UPDATE UserGroups
		Set IsVisible = '0'
		WHERE 
		UserGroupID = <cfqueryparam value="#UserGroup.getUserGroupID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>	
</cffunction>


<cffunction name="UnDelete" returntype="void" output="false" hint="DAO method" >
<cfargument name="UserGroup" type="UserGroup" required="true" /> 
	<cfset var qUserGroupUnDelete = 0 >
<!-----[  to UnDelete, set 'IsVisible' flag to 1 (true)  ]--->
		<cfquery name="qUserGroupDelete" datasource="#variables.dsn#" >
		UPDATE UserGroups
		Set IsVisible = '1'
		WHERE 
		UserGroupID = <cfqueryparam value="#UserGroup.getUserGroupID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>	
</cffunction>



<cffunction name="read" access="public" returntype="UserGroup" output="false" hint="DAO Method. - Reads a UserGroup into the bean">
<cfargument name="argsUserGroup" type="UserGroup" required="true" />
	<cfset var UserGroup  =  arguments.argsUserGroup />
	<cfset var QUserGroupsselect = "" />
	<cfquery name="QUserGroupsselect" datasource="#variables.dsn#">
		SELECT 
		addedby, dateadded, dateupdated, isvisible, updatedby, usergroupid, usergroupname
		FROM UserGroups 
		WHERE 
		IsVisible = '1' AND
		UserGroupID = <cfqueryparam value="#UserGroup.getUserGroupID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>
	<cfif QUserGroupsselect.recordCount >
		<cfscript>
		
                     UserGroup.setaddedby(QUserGroupsselect.addedby);
                     UserGroup.setdateadded(QUserGroupsselect.dateadded);
                     UserGroup.setdateupdated(QUserGroupsselect.dateupdated);
                     UserGroup.setisvisible(QUserGroupsselect.isvisible);
                     UserGroup.setupdatedby(QUserGroupsselect.updatedby);
                     UserGroup.setusergroupid(QUserGroupsselect.usergroupid);
                     UserGroup.setusergroupname(QUserGroupsselect.usergroupname);
		</cfscript>
	</cfif>
	<cfreturn UserGroup />
</cffunction>
		

<cffunction name="GetAllUserGroups" access="public" output="false" returntype="query" hint="Returns a query of all UserGroups in our Database">
<cfset var QgetallUserGroups = 0 />
	<cfquery name="QgetallUserGroups" datasource="#variables.dsn#">
		SELECT addedby, dateadded, dateupdated, isvisible, updatedby, usergroupid, usergroupname
		FROM UserGroups
		
		WHERE IsVisible = '1'
		
		ORDER BY usergroupname, UserGroupID
	</cfquery>
	<cfreturn QgetallUserGroups />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="UserGroup" output="false" hint="DAO method">
<cfargument name="argsUserGroup" type="UserGroup" required="yes" displayname="create" />
	<cfset var qUserGroupInsert = 0 />
	<cfset var UserGroup = arguments.argsUserGroup />
	
	<cfquery name="qUserGroupInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into UserGroups
		( addedby, dateadded, dateupdated, isvisible, updatedby, usergroupname ) VALUES
		(
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
		<cfqueryparam value="#UserGroup.getisvisible()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#UserGroup.getusergroupname()#" cfsqltype="cf_sql_varchar"/>
		   ) 
		SELECT Ident_Current('UserGroups') as UserGroupID
		SET NOCOUNT OFF
	</cfquery>
	<cfset UserGroup.setUserGroupID(qUserGroupInsert.UserGroupID)>

	<cfreturn UserGroup />
</cffunction>

<cffunction name="update" access="private" returntype="UserGroup" output="false" hint="DAO method">
<cfargument name="argsUserGroup" type="UserGroup" required="yes" />
	<cfset var UserGroup = arguments.argsUserGroup />
	<cfset var UserGroupUpdate = 0 >
	<cfquery name="UserGroupUpdate" datasource="#variables.dsn#" >
		UPDATE UserGroups SET
		
		 
		 dateupdated  = <cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
		 isvisible  = <cfqueryparam value="#UserGroup.getisvisible()#" cfsqltype="cf_sql_varchar"/>,
		 updatedby  = <cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>,
		 usergroupname  = <cfqueryparam value="#UserGroup.getusergroupname()#" cfsqltype="cf_sql_varchar"/>
						
		WHERE 
		UserGroupID = <cfqueryparam value="#UserGroup.getUserGroupID()#" />
	</cfquery>
	
	<cfreturn UserGroup />
</cffunction>

</cfcomponent>
