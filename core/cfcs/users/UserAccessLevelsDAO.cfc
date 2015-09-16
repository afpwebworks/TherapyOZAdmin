<cfcomponent displayname="UserAccesslevels DAO" output="false" hint="DAO Component Handles all Database access for the table UserAccesslevels.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    UserAccessLevelsDAO.cfc
Description: DAO Component Handles all Database access for the table UserAccesslevels.  Requires Coldspring v1.0
Date:        17/Sep/2008
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="UserAccessLevelsDAO" output="false" hint="Initialises the controller">
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


<cffunction name="save" access="public" returntype="UserAccessLevel" output="false" hint="DAO method">
<cfargument name="UserAccessLevel" type="UserAccessLevel" required="yes" />
<!-----[  If a LevelID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.UserAccessLevel.getLevelID() neq "0")>	
		<cfset UserAccessLevel = update(arguments.UserAccessLevel)/>
	<cfelse>
		<cfset UserAccessLevel = create(arguments.UserAccessLevel)/>
	</cfif>
	<cfreturn UserAccessLevel />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="UserAccessLevel" type="UserAccessLevel" required="true" /> 
	<cfset var qUserAccessLevelDelete = 0 >
<cfquery name="UserAccessLevelDelete" datasource="#variables.dsn#" >
		DELETE FROM UserAccesslevels
		WHERE 
		LevelID = <cfqueryparam value="#UserAccessLevel.getLevelID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>
	
</cffunction>



<cffunction name="read" access="public" returntype="UserAccessLevel" output="false" hint="DAO Method. - Reads a UserAccessLevel into the bean">
<cfargument name="argsUserAccessLevel" type="UserAccessLevel" required="true" />
	<cfset var UserAccessLevel  =  arguments.argsUserAccessLevel />
	<cfset var QUserAccesslevelsselect = "" />
	<cfquery name="QUserAccesslevelsselect" datasource="#variables.dsn#">
		SELECT 
		addedby, dateadded, dateupdated, levelid, updatedby, useraccesslevel, useraccessleveldesc
		FROM UserAccesslevels 
		WHERE 
		LevelID = <cfqueryparam value="#UserAccessLevel.getLevelID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>
	<cfif QUserAccesslevelsselect.recordCount >
		<cfscript>
		
                     UserAccessLevel.setaddedby(QUserAccesslevelsselect.addedby);
                     UserAccessLevel.setdateadded(QUserAccesslevelsselect.dateadded);
                     UserAccessLevel.setdateupdated(QUserAccesslevelsselect.dateupdated);
                     UserAccessLevel.setlevelid(QUserAccesslevelsselect.levelid);
                     UserAccessLevel.setupdatedby(QUserAccesslevelsselect.updatedby);
                     UserAccessLevel.setuseraccesslevel(QUserAccesslevelsselect.useraccesslevel);
                     UserAccessLevel.setuseraccessleveldesc(QUserAccesslevelsselect.useraccessleveldesc);
		</cfscript>
	</cfif>
	<cfreturn UserAccessLevel />
</cffunction>
		

<cffunction name="GetAllUserAccessLevels" access="public" output="false" returntype="query" hint="Returns a query of all UserAccessLevels in our Database">
<cfset var QgetallUserAccessLevels = 0 />
	<cfquery name="QgetallUserAccessLevels" datasource="#variables.dsn#">
		SELECT addedby, dateadded, dateupdated, levelid, updatedby, useraccesslevel, useraccessleveldesc
		FROM UserAccesslevels
		
		ORDER BY useraccesslevel,LevelID
	</cfquery>
	<cfreturn QgetallUserAccessLevels />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="UserAccessLevel" output="false" hint="DAO method">
<cfargument name="argsUserAccessLevel" type="UserAccessLevel" required="yes" displayname="create" />
	<cfset var qUserAccessLevelInsert = 0 />
	<cfset var UserAccessLevel = arguments.argsUserAccessLevel />
	
	<cfquery name="qUserAccessLevelInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into UserAccesslevels
		( addedby, dateadded, dateupdated, updatedby, useraccesslevel, useraccessleveldesc ) VALUES
		(
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#UserAccessLevel.getuseraccesslevel()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#UserAccessLevel.getuseraccessleveldesc()#" cfsqltype="cf_sql_varchar"/>
		   ) 
		SELECT Ident_Current('UserAccesslevels') as LevelID
		SET NOCOUNT OFF
	</cfquery>
	<cfset UserAccessLevel.setLevelID(qUserAccessLevelInsert.LevelID)>

	<cfreturn UserAccessLevel />
</cffunction>

<cffunction name="update" access="private" returntype="UserAccessLevel" output="false" hint="DAO method">
<cfargument name="argsUserAccessLevel" type="UserAccessLevel" required="yes" />
	<cfset var UserAccessLevel = arguments.argsUserAccessLevel />
	<cfset var UserAccessLevelUpdate = 0 >
	<cfquery name="UserAccessLevelUpdate" datasource="#variables.dsn#" >
		UPDATE UserAccesslevels SET
		
		 
		 dateupdated  = <cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
		 updatedby  = <cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>,
		 useraccesslevel  = <cfqueryparam value="#UserAccessLevel.getuseraccesslevel()#" cfsqltype="cf_sql_varchar"/>,
		 useraccessleveldesc  = <cfqueryparam value="#UserAccessLevel.getuseraccessleveldesc()#" cfsqltype="cf_sql_varchar"/>
						
		WHERE 
		LevelID = <cfqueryparam value="#UserAccessLevel.getLevelID()#" />
	</cfquery>
	
	<cfreturn UserAccessLevel />
</cffunction>

</cfcomponent>
