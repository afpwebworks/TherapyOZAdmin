<cfcomponent displayname="Permissions DAO" output="false" hint="DAO Component Handles all Database access for the table Permissions.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    PermissionsDAO.cfc
Description: DAO Component Handles all Database access for the table Permissions.  Requires Coldspring v1.0
Date:        17/Sep/2008
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="PermissionsDAO" output="false" hint="Initialises the controller">
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


<cffunction name="save" access="public" returntype="PermissionBean" output="false" hint="DAO method">
<cfargument name="PermissionBean" type="PermissionBean" required="yes" />
<!-----[  If a PermissionID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.PermissionBean.getPermissionID() neq "0")>	
		<cfset PermissionBean = update(arguments.PermissionBean)/>
	<cfelse>
		<cfset PermissionBean = create(arguments.PermissionBean)/>
	</cfif>
	<cfreturn PermissionBean />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="PermissionBean" type="PermissionBean" required="true" /> 
	<cfset var qPermissionBeanDelete = 0 >
<!-----[  to delete, set 'IsVisible' flag to zero  ]--->
		<cfquery name="qPermissionBeanDelete" datasource="#variables.dsn#" >
		UPDATE Permissions
		Set IsVisible = '0'
		WHERE 
		PermissionID = <cfqueryparam value="#PermissionBean.getPermissionID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>	
</cffunction>


<cffunction name="UnDelete" returntype="void" output="false" hint="DAO method" >
<cfargument name="PermissionBean" type="PermissionBean" required="true" /> 
	<cfset var qPermissionBeanUnDelete = 0 >
<!-----[  to UnDelete, set 'IsVisible' flag to 1 (true)  ]--->
		<cfquery name="qPermissionBeanDelete" datasource="#variables.dsn#" >
		UPDATE Permissions
		Set IsVisible = '1'
		WHERE 
		PermissionID = <cfqueryparam value="#PermissionBean.getPermissionID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>	
</cffunction>



<cffunction name="read" access="public" returntype="PermissionBean" output="false" hint="DAO Method. - Reads a PermissionBean into the bean">
<cfargument name="argsPermissionBean" type="PermissionBean" required="true" />
	<cfset var PermissionBean  =  arguments.argsPermissionBean />
	<cfset var QPermissionsselect = "" />
	<cfquery name="QPermissionsselect" datasource="#variables.dsn#">
		SELECT 
		addedby, dateadded, dateupdated, isvisible, permission, permissioncategory, permissiondefaultlevel, permissionid, updatedby
		FROM Permissions 
		WHERE 
		IsVisible = '1' AND
		PermissionID = <cfqueryparam value="#PermissionBean.getPermissionID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>
	<cfif QPermissionsselect.recordCount >
		<cfscript>
		
                     PermissionBean.setaddedby(QPermissionsselect.addedby);
                     PermissionBean.setdateadded(QPermissionsselect.dateadded);
                     PermissionBean.setdateupdated(QPermissionsselect.dateupdated);
                     PermissionBean.setisvisible(QPermissionsselect.isvisible);
                     PermissionBean.setpermission(QPermissionsselect.permission);
                     PermissionBean.setpermissioncategory(QPermissionsselect.permissioncategory);
                     PermissionBean.setpermissiondefaultlevel(QPermissionsselect.permissiondefaultlevel);
                     PermissionBean.setpermissionid(QPermissionsselect.permissionid);
                     PermissionBean.setupdatedby(QPermissionsselect.updatedby);
		</cfscript>
	</cfif>
	<cfreturn PermissionBean />
</cffunction>
		

<cffunction name="GetAllPermissionBeans" access="public" output="false" returntype="query" hint="Returns a query of all PermissionBeans in our Database">
<cfset var QgetallPermissionBeans = 0 />
	<cfquery name="QgetallPermissionBeans" datasource="#variables.dsn#">
		SELECT p.addedby, p.dateadded, p.dateupdated, p.isvisible, p.permission, p.permissioncategory, p.permissiondefaultlevel, p.permissionid, p.updatedby, c.PermissionCategory as Category
		FROM Permissions p, permissioncategories c
		
		WHERE IsVisible = '1' AND
		c.permissioncategoryID  = p.permissioncategory
		
		ORDER BY p.permissioncategory, p.Permission, p.permissionid
	</cfquery>
	<cfreturn QgetallPermissionBeans />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="PermissionBean" output="false" hint="DAO method">
<cfargument name="argsPermissionBean" type="PermissionBean" required="yes" displayname="create" />
	<cfset var qPermissionBeanInsert = 0 />
	<cfset var PermissionBean = arguments.argsPermissionBean />
	
	<cfquery name="qPermissionBeanInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into Permissions
		( addedby, dateadded, dateupdated, isvisible, permission, permissioncategory, permissiondefaultlevel, updatedby ) VALUES
		(
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
		<cfqueryparam value="#PermissionBean.getisvisible()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#PermissionBean.getpermission()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#PermissionBean.getpermissioncategory()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#PermissionBean.getpermissiondefaultlevel()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>
		   ) 
		SELECT Ident_Current('Permissions') as PermissionID
		SET NOCOUNT OFF
	</cfquery>
	<cfset PermissionBean.setPermissionID(qPermissionBeanInsert.PermissionID)>

	<cfreturn PermissionBean />
</cffunction>

<cffunction name="update" access="private" returntype="PermissionBean" output="false" hint="DAO method">
<cfargument name="argsPermissionBean" type="PermissionBean" required="yes" />
	<cfset var PermissionBean = arguments.argsPermissionBean />
	<cfset var PermissionBeanUpdate = 0 >
	<cfquery name="PermissionBeanUpdate" datasource="#variables.dsn#" >
		UPDATE Permissions SET
		
		 
		 dateupdated  = <cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
		 isvisible  = <cfqueryparam value="#PermissionBean.getisvisible()#" cfsqltype="cf_sql_varchar"/>,
		 permission  = <cfqueryparam value="#PermissionBean.getpermission()#" cfsqltype="cf_sql_varchar"/>,
		 permissioncategory  = <cfqueryparam value="#PermissionBean.getpermissioncategory()#" cfsqltype="cf_sql_varchar"/>,
		 permissiondefaultlevel  = <cfqueryparam value="#PermissionBean.getpermissiondefaultlevel()#" cfsqltype="cf_sql_varchar"/>,
		 updatedby  = <cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>
						
		WHERE 
		PermissionID = <cfqueryparam value="#PermissionBean.getPermissionID()#" />
	</cfquery>
	
	<cfreturn PermissionBean />
</cffunction>

</cfcomponent>
