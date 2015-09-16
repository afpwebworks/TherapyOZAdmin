<cfcomponent output="no" displayname="User Access" hint="Functions to manage logins and user access for DinkyDI Cleaning Supplies CMS.">
<cfsilent>
<!---
=================================================================================================================
File:           UserAccess.cfc   
Description:    Functions to manage logins and user access for AFP CMS v4.0
Author:	        Michael Kear
Date:           27/1/2006
Modification:   30/4/2006  Changed to provide only the access/login control items in this CFC.
		2/12/2008 changed for use with v4.0 and Coldspring
=================================================================================================================
--->
</cfsilent>

   <cffunction name="init" access="public" returntype="AccessManager" output="false" hint="This is called by the framework and automatically maps variables in the current event to the instance variables of this bean.">
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


<cffunction name="setLoggingService" access="public" output="false" returntype="void" hint="Dependency: Logging Service">
	<cfargument name="LoggingService" type="any" required="true"/>
	<cfset variables.LoggingService = arguments.LoggingService/>
</cffunction>

<cffunction name="setUsersDAOService"  access="public" output="false" returntype="void" hint="Dependency: UserAccess Service">
	<cfargument name="UsersDAO" type="any" required="true"/>
	<cfset variables.UsersDAO = arguments.UsersDAO/>
</cffunction>


<!----[  
====================================================================================================    
Logging functions
====================================================================================================
  ]----MK ---->
 <cffunction name="LogEntry" access="public" returntype="any" output="false">
     <cfargument name="argsLogEntry" required="true" type="any" />
          
          
	  <cfreturn arguments.LogEntry />
  </cffunction> 
   
   
   

<cffunction name="loginuser" access="public" returntype="any" hint="checks a user's status and logs him in">
	<cfargument name="argsUserLogin" type="string" required="true">
	<cfargument name="argsUserPassword" type="string" required="true">
	<cfargument name="argsUser" type="any" required="yes" /> 
 		<cfscript>
		var qLoginUser = 0 ;
		var vUser = arguments.argsUser ;
		var login = arguments.argsUserLogin ;
		var password = arguments.argsUserPassword ;
		vuser.setUserLogin ( Login );
		vUser.setUserPassword( password );
        
		variables.UsersDAO.readbyLogin(  vUser );
		</cfscript>
		<cfif vUser.getIsloggedIn()>
		<!---[   Update the logging table (if implemented)  here.   ]---->
        
        <!---[   e.g.  add ip address,  time logged in,  number of logins    ]---->
        </cfif>
        <cfreturn vUser />
</cffunction>

<cffunction name="UpdateAfterLogin" access="public" output="true" returntype="any" hint="Returns full details of a user to allow fully logged in status">
	<cfargument name="cgi" type="struct" required="yes" />
	<cfargument name="argsuser" type="any" required="yes" />
	<!----[  //Remove any spaces in the form values   ]---->
	<cfset var updatecount = 0 />
    <cfset var user = arguments.argsUser />
	
	 <cfquery name="updatecount" datasource="#variables.DSN#">
		UPDATE USERS
		SET Usertotallogins    = Usertotallogins + 1,
		UserLastLogin          = #createodbcdatetime(variables.austime)#,
		UserIP                 = '#arguments.cgi.REMOTE_ADDR#'
		
		WHERE UserID      = <cfqueryparam value="#user.getUserID()#" />
    </cfquery> 
    
    
		
	<cfreturn arguments.argsuser>
</cffunction>



<cffunction name="LogoutUser" access="public" output="false" returntype="any" hint="Logs the user out and resets all session vars to the defaults">
<cfargument name="argsUser" required="yes" type="any"  />
<cfset var user = arguments.argsUser />

	<!----Kill the cookies and CFID/CFTOKEN ---->
	  <cfcookie name="CFID"  expires="NOW">
	  <cfcookie name="CFTOKEN" expires="NOW">

		<!---- Delete the session vars. ---->
	    <cfscript>
			Newuser = createobject("component","core.cfcs.users.user").init();
		</cfscript>
		<cfreturn Newuser />
</cffunction>



<cffunction name="getTopMenu" access="public" output="no" returntype="query" hint="Returns a query of the top menu  items for a user.">
<cfset var qTopMenu = 0 />
    <cfquery name="qTopmenu" datasource="#variables.dsn#">
        SELECT m.MenuID, m.Description, m.URL,  m.SuperMenuID, m.SortOrder, m.Target, m.DisplayLevel, m.CreatePermission, m.DeletePermission, m.EditPermission, m.ViewPermission, m.InMenu 
        FROM dbo.AdminMenu m, usersMenus u
        WHERE 
        m.menuid = u.menuid AND
        u.userID = <cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_integer" /> AND
        m.Displaylevel = '1'
        ORDER BY m.sortorder
    </cfquery>
    <cfreturn qTopMenu />    
</cffunction>

<cffunction name="getSubmenu" access="public" output="no" returntype="query" hint="Returns a query of the top menu  items for a user.">
<cfargument name="argsTopMenuID" required="yes" />
<cfset var TopmenuID = arguments.argsTopMenuID />
<cfset var qSubMenu = 0 />

    <cfquery name="qSubMenu" datasource="#variables.dsn#">
        SELECT m.MenuID, m.Description, m.URL,  m.SuperMenuID, m.SortOrder,  m.Target, m.DisplayLevel, m.CreatePermission, m.DeletePermission, m.EditPermission, m.ViewPermission, m.InMenu 
        FROM dbo.AdminMenu m, usersMenus u
        WHERE 
        m.menuid = u.menuid AND
         m.Displaylevel = '2' AND
        m.SuperMenuID = <cfqueryparam value="#topmenuid#" cfsqltype="cf_sql_integer" /> AND
        u.userID = <cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_integer" />        
        ORDER BY m.sortorder
    </cfquery>
    <cfreturn qSubMenu />    
</cffunction>


<cffunction name="getAllMenus" access="public" output="no" returntype="query" hint="Returns a list of all admin menus with access for the specified user">
<cfset var qMenus = querynew("menuid,description,url,supermenuid,sortorder,displaylevel","integer,varchar,varchar,integer,integer,integer") />
<cfset var qMenusDB = 0 />
<cfset var menuAccessList = "0" />



<!---[   Get all menus in a query to be processed   ]---->
<cfquery name="qMenusDB" datasource="#variables.dsn#">
SELECT m.MenuID, m.Description, m.URL, m.target, m.SuperMenuID, m.SortOrder, m.DisplayLevel, m.CreatePermission, m.DeletePermission, m.EditPermission, m.ViewPermission, m.InMenu 
    FROM dbo.AdminMenu m
    Order by sortorder
</cfquery>
<!---[   First get the top level menus out of qMenusDB   ]---->
<cfquery name="qtemp01" dbtype="query">
SELECT menuid,description,url,supermenuid,sortorder,displaylevel FROM qMenusDB
WHERE
SuperMenuID = <cfqueryparam value='0' cfsqltype="cf_sql_integer" />
</cfquery>

<cfloop query="qtemp01">
	<cfscript>
	Queryaddrow(qMenus, "1");
	QuerysetCell(qMenus,"MenuID",qtemp01.MenuID);
	QuerysetCell(qMenus,"description",qtemp01.description);
	QuerysetCell(qMenus,"url",qtemp01.url);
	QuerysetCell(qMenus,"supermenuid",qtemp01.supermenuid);
	QuerysetCell(qMenus,"sortorder",qtemp01.sortorder);
	QuerysetCell(qMenus,"displaylevel",qtemp01.displaylevel);
	</cfscript>
    
  <!---[     Now get the submenus under that menu   ]---->
  <cfquery name="qtemp02" dbtype="query">
SELECT menuid,description,url,supermenuid,sortorder,displaylevel FROM qMenusDB
WHERE
SuperMenuID = <cfqueryparam value='#qtemp01.MenuID#' cfsqltype="cf_sql_integer" />
</cfquery>
    <cfloop query="qtemp02">
		<cfscript>
			Queryaddrow(qMenus, "1");
			QuerysetCell(qMenus,"MenuID",qtemp02.MenuID);
			QuerysetCell(qMenus,"description",qtemp02.description);
			QuerysetCell(qMenus,"url",qtemp02.url);
			QuerysetCell(qMenus,"supermenuid",qtemp02.supermenuid);
			QuerysetCell(qMenus,"sortorder",qtemp02.sortorder);
			QuerysetCell(qMenus,"displaylevel",qtemp02.displaylevel);
        </cfscript>
      
    </cfloop>
    
    
</cfloop>

<cfreturn qMenus />
</cffunction>



<cffunction name="save" access="public" returntype="AdminMenu" output="false" hint="DAO method">
<cfargument name="AdminMenu" type="AdminMenu" required="yes" />
<!-----[  If a MenuID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.AdminMenu.getMenuID() neq "0")>	
		<cfset AdminMenu = update(arguments.AdminMenu)/>
	<cfelse>
		<cfset AdminMenu = create(arguments.AdminMenu)/>
	</cfif>
	<cfreturn AdminMenu />
</cffunction>


<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="AdminMenu" type="AdminMenu" required="true" /> 
	<cfset var qAdminMenuDelete = 0 >
<cfquery name="AdminMenuDelete" datasource="#variables.dsn#" >
		DELETE FROM AdminMenu
		WHERE 
		MenuID = <cfqueryparam value="#AdminMenu.getMenuID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
    <!---[      Also delete the user references  from the link table ]---->
	<cfquery name="AdminMenuDelete" datasource="#variables.dsn#" >
    	DELETE FROM UsersMenus
		WHERE 
		MenuID = <cfqueryparam value="#AdminMenu.getMenuID()#"  cfsqltype="CF_SQL_INTEGER"/>
    </cfquery>
</cffunction>


<cffunction name="read" access="public" returntype="AdminMenu" output="false" hint="DAO Method. - Reads a AdminMenu into the bean">
<cfargument name="argsAdminMenu" type="AdminMenu" required="true" />
	<cfset var AdminMenu  =  arguments.argsAdminMenu />
	<cfset var QAdminMenuselect = "" />
	<cfquery name="QAdminMenuselect" datasource="#variables.dsn#">
		SELECT 
		MenuID, Description, URL, Target, DisplayLevel, SuperMenuID, SortOrder, ViewPermission, EditPermission, DeletePermission, CreatePermission, InMenu
		FROM AdminMenu 
		WHERE 
		MenuID = <cfqueryparam value="#AdminMenu.getMenuID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QAdminMenuselect.recordCount >
		<cfscript>
		AdminMenu.setMenuID(QAdminMenuselect.MenuID);
         AdminMenu.setDescription(QAdminMenuselect.Description);
         AdminMenu.setURL(QAdminMenuselect.URL);
         AdminMenu.setTarget(QAdminMenuselect.Target);
         AdminMenu.setDisplayLevel(QAdminMenuselect.DisplayLevel);
         AdminMenu.setSuperMenuID(QAdminMenuselect.SuperMenuID);
         AdminMenu.setSortOrder(QAdminMenuselect.SortOrder);
         AdminMenu.setViewPermission(QAdminMenuselect.ViewPermission);
         AdminMenu.setEditPermission(QAdminMenuselect.EditPermission);
         AdminMenu.setDeletePermission(QAdminMenuselect.DeletePermission);
         AdminMenu.setCreatePermission(QAdminMenuselect.CreatePermission);
         AdminMenu.setInMenu(QAdminMenuselect.InMenu);
         
		</cfscript>
	</cfif>
	<cfreturn AdminMenu />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="AdminMenu" output="false" hint="DAO method">
<cfargument name="argsAdminMenu" type="AdminMenu" required="yes" displayname="create" />
	<cfset var qAdminMenuInsert = 0 />
	<cfset var AdminMenu = arguments.argsAdminMenu />
    <cfset Adminmenu.setSortOrder( FindNewSortCode( AdminMenu.getSuperMenuID()  )) />
  	
	<cfquery name="qAdminMenuInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into AdminMenu
		( Description, URL, Target, DisplayLevel, SuperMenuID, SortOrder, ViewPermission, EditPermission, DeletePermission, CreatePermission, InMenu ) VALUES
		(

		<cfqueryparam value="#AdminMenu.getdescription()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#AdminMenu.geturl()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#AdminMenu.gettarget()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#AdminMenu.getdisplaylevel()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#AdminMenu.getsupermenuid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#AdminMenu.getsortorder()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#AdminMenu.getviewpermission()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#AdminMenu.geteditpermission()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#AdminMenu.getdeletepermission()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#AdminMenu.getcreatepermission()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#AdminMenu.getinmenu()#" cfsqltype="CF_SQL_BIT" />
		   ) 
		SELECT Ident_Current('AdminMenu') as MenuID
		SET NOCOUNT OFF
	</cfquery>
	<cfset AdminMenu.setMenuID(qAdminMenuInsert.MenuID)>

	<cfreturn AdminMenu />
</cffunction>


<cffunction name="update" access="private" returntype="AdminMenu" output="false" hint="DAO method">
<cfargument name="argsAdminMenu" type="AdminMenu" required="yes" />
	<cfset var AdminMenu = arguments.argsAdminMenu />
	<cfset var AdminMenuUpdate = 0 >
	<cfquery name="AdminMenuUpdate" datasource="#variables.dsn#" >
		UPDATE AdminMenu SET
        description  = <cfqueryparam value="#AdminMenu.getDescription()#" cfsqltype="CF_SQL_VARCHAR"/>,
        url  = <cfqueryparam value="#AdminMenu.getURL()#" cfsqltype="CF_SQL_VARCHAR"/>,
        target  = <cfqueryparam value="#AdminMenu.getTarget()#" cfsqltype="CF_SQL_VARCHAR"/>,
        displaylevel  = <cfqueryparam value="#AdminMenu.getDisplayLevel()#" cfsqltype="CF_SQL_INTEGER"/>,
        supermenuid  = <cfqueryparam value="#AdminMenu.getSuperMenuID()#" cfsqltype="CF_SQL_INTEGER"/>,
        sortorder  = <cfqueryparam value="#AdminMenu.getSortOrder()#" cfsqltype="CF_SQL_INTEGER"/>,
        viewpermission  = <cfqueryparam value="#AdminMenu.getViewPermission()#" cfsqltype="CF_SQL_VARCHAR"/>,
        editpermission  = <cfqueryparam value="#AdminMenu.getEditPermission()#" cfsqltype="CF_SQL_VARCHAR"/>,
        deletepermission  = <cfqueryparam value="#AdminMenu.getDeletePermission()#" cfsqltype="CF_SQL_VARCHAR"/>,
        createpermission  = <cfqueryparam value="#AdminMenu.getCreatePermission()#" cfsqltype="CF_SQL_VARCHAR"/>,
        inmenu  = <cfqueryparam value="#AdminMenu.getInMenu()#" cfsqltype="CF_SQL_BIT"/>
						
		WHERE 
		MenuID = <cfqueryparam value="#AdminMenu.getMenuID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
	
	<cfreturn AdminMenu />
</cffunction>


<cffunction name="FindNewSortCode" access="public" output="true" returntype="numeric" hint="Finds the new sort code for an added or moved menu" >
<cfargument name="supermenuid" type="numeric" required="yes" />
<cfset var MenuInsert = 0 />
	
	<!----[  Find sort order to add content at the end of the page  ]---->
		<cfquery name="findsortorder" datasource="#variables.dsn#">
			SELECT max(sortorder) as maxsortcode from adminmenu 
			where supermenuid = <cfqueryparam value="#arguments.supermenuid#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfif findsortorder.maxsortcode GT "0">
			<cfset 	newsortcode = #findsortorder.maxsortcode# + 1 />		
		<cfelse>
		    <cfset newsortcode = "1" />
		</cfif>		
	
    
	<cfreturn newsortcode />
</cffunction></cfcomponent>