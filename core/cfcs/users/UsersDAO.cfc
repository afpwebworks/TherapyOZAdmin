<cfcomponent displayname="Users DAO" output="false" hint="DAO Component Handles all Database access for the table Users.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    UsersDAO.cfc
Description: DAO Component Handles all Database access for the table Users.  Requires Coldspring v1.0
Date:        16/Sep/2008
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="UsersDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="any" />
<cfargument name="argsLog" required="true" type="any" />
	<cfset var config  = arguments.argsConfiguration />
	<cfset variables.config = arguments.argsConfiguration />
	<cfset variables.dsn = config.getDSN() />
	<cfset variables.austime = config.getAusTime() />
    <cfset variables.Log = arguments.argsLog/>
	<cfreturn this />
</cffunction>

<cffunction name="setUserService" access="public" output="false" returntype="void" hint="Dependency: User Service">
	<cfargument name="UserService" type="any" required="true"/>
	<cfset variables.UserService = arguments.UserService/>
</cffunction>


<cffunction name="InitLog" access="public" output="false" returntype="any" hint="Initialise the Log Object">

    <cfscript>
	 var Log = 	variables.Log;
	 log.setSiteID(  variables.userservice.getUSer().getSiteID() );
	 Log.setUserID(  variables.userservice.getUser().getUserID() );
	 
	</cfscript>
	<cfset variables.Log = Log/>
    <cfreturn variables.log />
</cffunction>




	<cffunction name="GetSiteContacts" access="public" returntype="query" output="false" hint="Returns a query of teh site's contacts, and email addresses for use throughout the site's contact us forms "> 
		<cfset var sitecontacts = 0 />
		<cfquery name="Sitecontacts" datasource="#variables.dsn#">
			Select s.*, u.Userfirstname + ' ' + u.Userlastname as UserName, u.UserEmail
			FROM SiteContacts s, Users u 
			Where u.IsVisible = '1' AND 
            s.Isvisible = '1' AND
			s.UserID = U.UserId
			ORDER by s.Sortcode, S.UserID		
		</cfquery>
		<cfreturn Sitecontacts />
	</cffunction>


<cffunction name="save" access="public" returntype="User" output="false" hint="DAO method">
<cfargument name="User" type="User" required="yes" />
<!-----[  If a UserID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.User.getUserID() neq "0")>	
		<cfset User = update(arguments.User)/>
	<cfelse>
		<cfset User = create(arguments.User)/>
	</cfif>
	<cfreturn User />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="User" type="User" required="true" /> 
	<cfset var qUserDelete = 0 >
<!-----[  to delete, set 'IsVisible' flag to zero  ]--->
		<cfquery name="qUserDelete" datasource="#variables.dsn#" >
		UPDATE Users
		Set IsVisible = '0'
		WHERE 
		UserID = <cfqueryparam value="#User.getUserID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>	
     <!----[  Add a log entry that the user has logged in  ]----MK ---->
               <cfscript>
                  InitLog( variables.Log);
               	variables.log.setTablename( "Users");
				variables.log.setComment( "Deleted a user");
				variables.log.setActivity( "Delete" );
                variables.log.setDateAdded( now() );
               </cfscript>
               <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
</cffunction>


<cffunction name="UnDelete" returntype="void" output="false" hint="DAO method" >
<cfargument name="User" type="User" required="true" /> 
	<cfset var qUserUnDelete = 0 >
<!-----[  to UnDelete, set 'IsVisible' flag to 1 (true)  ]--->
		<cfquery name="qUserDelete" datasource="#variables.dsn#" >
		UPDATE Users
		Set IsVisible = '1'
		WHERE 
		UserID = <cfqueryparam value="#User.getUserID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>	
     <!----[  Add a log entry that the user has logged in  ]----MK ---->
               <cfscript>
                  InitLog( variables.Log);
               	variables.log.setTablename( "Users");
				variables.log.setComment( "Undeleted a user");
				variables.log.setActivity( "Undelete" );
                variables.log.setDateAdded( now() );
               </cfscript>
               <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
</cffunction>



<cffunction name="read" access="public" returntype="User" output="false" hint="DAO Method. - Reads a User into the bean">
<cfargument name="argsUser" type="User" required="true" />
	<cfset var User  =  arguments.argsUser />
	<cfset var QUsersselect = "" />
	<cfquery name="QUsersselect" datasource="#variables.dsn#">
		SELECT 
		u.UserID, u.UserLogin, u.UserPassword, u.UserAccessLevel, u.UserFirstname, u.UserLastName, u.Email, u.UserIp, u.UserLastLogin, u.UserTotalLogins, u.UserActive, u.IsVisible, u.Phone, u.Mobile, u.Title, u.Address1, u.Address2, u.City, u.State, u.Postcode, u.Country, u.DateAdded, u.AddedBy, u.DateUpdated, u.UpdatedBy, u.customerid, s.siteid
		FROM Users u, sites s
		WHERE 
        u.customerid  = s.customerid AND 
		u.IsVisible = <cfqueryparam value="1" cfsqltype="cf_sql_bit" /> AND
		u.UserID = <cfqueryparam value="#User.getUserID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>
	<cfif QUsersselect.recordCount >
		<cfscript>
		
         User.setUserID(QUsersselect.UserID);
         User.setUserLogin(QUsersselect.UserLogin);
         User.setUserPassword(QUsersselect.UserPassword);
         User.setUserAccessLevel(QUsersselect.UserAccessLevel);
         User.setUserFirstname(QUsersselect.UserFirstname);
         User.setUserLastName(QUsersselect.UserLastName);
         User.setEmail(QUsersselect.Email);
         User.setUserIp(QUsersselect.UserIp);
         User.setUserLastLogin(QUsersselect.UserLastLogin);
         User.setUserTotalLogins(QUsersselect.UserTotalLogins);
         User.setUserActive(QUsersselect.UserActive);
         User.setIsVisible(QUsersselect.IsVisible);
         User.setPhone(QUsersselect.Phone);
         User.setMobile(QUsersselect.Mobile);
         User.setTitle(QUsersselect.Title);
         User.setAddress1(QUsersselect.Address1);
         User.setAddress2(QUsersselect.Address2);
         User.setCity(QUsersselect.City);
         User.setState(QUsersselect.State);
         User.setPostcode(QUsersselect.Postcode);
         User.setCountry(QUsersselect.Country);
         User.setDateAdded(QUsersselect.DateAdded);
         User.setAddedBy(QUsersselect.AddedBy);
         User.setDateUpdated(QUsersselect.DateUpdated);
         User.setUpdatedBy(QUsersselect.UpdatedBy);
		 User.setCustomerID(QUsersselect.CustomerID);
		 User.setSiteID( QUsersselect.SiteID );
		</cfscript>
        <cfset ReadPermissions(user) />
        <cfset ReadUserGroups(user) />  
        <cfset ReadAdminMenus(user) />  
        
	</cfif>
	<cfreturn User />
</cffunction>
		

<cffunction name="GetAllUsers" access="public" output="false" returntype="query" hint="Returns a query of all Users in our Database">
<cfset var QgetallUsers = 0 />
	<cfquery name="QgetallUsers" datasource="#variables.dsn#">
		SELECT UserID, UserLogin, UserPassword, UserAccessLevel, UserFirstname, UserLastName, Email, UserIp, UserLastLogin, UserTotalLogins, UserActive, IsVisible, Phone, Mobile, Title, Address1, Address2, City, State, Postcode, Country, DateAdded, AddedBy, DateUpdated, UpdatedBy, customerid 
		Userfirstname + ' ' + Userlastname as UserName
		FROM Users		
		WHERE IsVisible = '1'
		
		ORDER BY userlastname, userfirstname, UserID
	</cfquery>
	<cfreturn QgetallUsers />
</cffunction>


	<cffunction name="getAccessLevels" access="public" returntype="query" output="false" hint="Returns a query containing the available User Access levels in the User Manager">
    <cfargument name="argsMinLevel" required="no" type="numeric" default="99999" />
		<cfset var accesslevels = 0 />
        <cfset var MinLevel = arguments.argsMinLevel />
        
        
		<cfquery name="accesslevels" datasource="#variables.dsn#">
			SELECT UserAccessLevel, UserAccessLevelDesc
			From UserAccesslevels
            <cfif MinLevel neq "99999" >
            WHERE
			UserAccessLevel >= <cfqueryparam value="#MinLevel#" cfsqltype="cf_sql_numeric" />
            </cfif>
			ORDER BY UserAccessLevel
		</cfquery>
		<cfreturn accesslevels />
	</cffunction>
	
<!---[   	<cffunction name="getAccessLevelsEdit" access="public" returntype="query" output="false" hint="Returns a query containing the available User Access levels in the User Manager">
		<cfset var accesslevels = 0 />
		<cfquery name="accesslevels" datasource="#variables.dsn#">
			SELECT UserAccessLevel, UserAccessLevelDesc
			From UserAccesslevels
			WHERE
			UserAccessLevel >= '#variables.MinEditLevel#'
			ORDER BY UserAccessLevel
		</cfquery>
		<cfreturn accesslevels />
	</cffunction>   ]---->
	
<!---[   	<cffunction name="getAccessLevelsApprove" access="public" returntype="query" output="false" hint="Returns a query containing the available User Access levels in the User Manager">
		<cfset var accesslevels = 0 />
		<cfquery name="accesslevels" datasource="#variables.dsn#">
			SELECT UserAccessLevel, UserAccessLevelDesc
			From UserAccesslevels
			WHERE
			UserAccessLevel >= '#variables.MinApproveLevel#'
			ORDER BY UserAccessLevel
		</cfquery>
		<cfreturn accesslevels />
	</cffunction>   ]---->
	
	<cffunction name="getAllUserGroups" access="public" returntype="query" output="false" hint="Returns a query containing the available User Special Interest Groups levels in the User Manager">
		<cfset var accesslevels = 0 />
		<cfquery name="accesslevels" datasource="#variables.dsn#">
			SELECT UserGroupID, UserGroupName
			From UserGroups
			ORDER BY UserGroupName
		</cfquery>
		<cfreturn accesslevels />
	</cffunction>

<cffunction name="getApprovedUsers" access="public" returntype="query" output="false" hint="Returns a query containing the users details of people who ">
	<cfset var USerList = 0 />
	<cfquery name="UserList" datasource="#variables.dsn#">
	    SELECT UserFirstName + ' ' + UserLastName as Username
		,* 
		from Users 
		WHERE Useraccesslevel > '20'	
	</cfquery>
	<cfreturn USerList />
</cffunction>




<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="User" output="false" hint="DAO method">
<cfargument name="argsUser" type="User" required="yes" displayname="create" />
	<cfset var qUserInsert = 0 />
	<cfset var User = arguments.argsUser />
	
	<cfquery name="qUserInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into Users
		( UserLogin, UserPassword, UserAccessLevel, UserFirstname, UserLastName, Email, UserIp, UserLastLogin, UserTotalLogins, UserActive, IsVisible, Phone, Mobile, Title, Address1, Address2, City, State, Postcode, Country, DateAdded, AddedBy, DateUpdated, UpdatedBy, customerid ) VALUES
		(
		<cfqueryparam value="#User.getuserlogin()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getuserpassword()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getuseraccesslevel()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#User.getuserfirstname()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getuserlastname()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getemail()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getuserip()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getuserlastlogin()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#User.getusertotallogins()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#User.getuseractive()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#User.getisvisible()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#User.getphone()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getmobile()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.gettitle()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getaddress1()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getaddress2()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getcity()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getstate()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getpostcode()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getcountry()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/> ,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/>,
        <cfqueryparam value="#User.getCustomerid()#" cfsqltype="CF_SQL_INTEGER" /> 
		   ) 
		SELECT Ident_Current('Users') as UserID
		SET NOCOUNT OFF
	</cfquery>
	<cfset User.setUserID(qUserInsert.UserID)>
	
		
<!----[  	update the permissions set  ]---->
	<cfset UpdatePermissions( user ) />
	<cfset UpdateUserGroups ( user ) />
    <cfset UpdateAdminMenus ( user ) />		
    
     <!----[  Add a log entry that the user has logged in  ]----MK ---->
               <cfscript>
                  InitLog( variables.Log);
               	variables.log.setTablename( "Users");
				variables.log.setComment( "Created user #user.getUserfirstname()# #user.getUserLastName()#");
				variables.log.setActivity( "Create" );
                variables.log.setDateAdded( now() );
               </cfscript>
               <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />

	<cfreturn User />
</cffunction>

<cffunction name="update" access="private" returntype="User" output="false" hint="DAO method">
<cfargument name="argsUser" type="User" required="yes" />
	<cfset var User = arguments.argsUser />
	<cfset var UserUpdate = 0 >
	<cfquery name="UserUpdate" datasource="#variables.dsn#" >
		UPDATE Users SET
		 
		 userlogin  = <cfqueryparam value="#User.getUserLogin()#" cfsqltype="CF_SQL_VARCHAR"/>,
        userpassword  = <cfqueryparam value="#User.getUserPassword()#" cfsqltype="CF_SQL_VARCHAR"/>,
        useraccesslevel  = <cfqueryparam value="#User.getUserAccessLevel()#" cfsqltype="CF_SQL_INTEGER"/>,
        userfirstname  = <cfqueryparam value="#User.getUserFirstname()#" cfsqltype="CF_SQL_VARCHAR"/>,
        userlastname  = <cfqueryparam value="#User.getUserLastName()#" cfsqltype="CF_SQL_VARCHAR"/>,
        email  = <cfqueryparam value="#User.getEmail()#" cfsqltype="CF_SQL_VARCHAR"/>,
        userip  = <cfqueryparam value="#User.getUserIp()#" cfsqltype="CF_SQL_VARCHAR"/>,
        userlastlogin  = <cfqueryparam value="#User.getUserLastLogin()#" cfsqltype="CF_SQL_TIMESTAMP"/>,
        usertotallogins  = <cfqueryparam value="#User.getUserTotalLogins()#" cfsqltype="CF_SQL_INTEGER"/>,
        useractive  = <cfqueryparam value="#User.getUserActive()#" cfsqltype="CF_SQL_BIT"/>,
        isvisible  = <cfqueryparam value="#User.getIsVisible()#" cfsqltype="CF_SQL_BIT"/>,
        phone  = <cfqueryparam value="#User.getPhone()#" cfsqltype="CF_SQL_VARCHAR"/>,
        mobile  = <cfqueryparam value="#User.getMobile()#" cfsqltype="CF_SQL_VARCHAR"/>,
        title  = <cfqueryparam value="#User.getTitle()#" cfsqltype="CF_SQL_VARCHAR"/>,
        address1  = <cfqueryparam value="#User.getAddress1()#" cfsqltype="CF_SQL_VARCHAR"/>,
        address2  = <cfqueryparam value="#User.getAddress2()#" cfsqltype="CF_SQL_VARCHAR"/>,
        city  = <cfqueryparam value="#User.getCity()#" cfsqltype="CF_SQL_VARCHAR"/>,
        state  = <cfqueryparam value="#User.getState()#" cfsqltype="CF_SQL_VARCHAR"/>,
        postcode  = <cfqueryparam value="#User.getPostcode()#" cfsqltype="CF_SQL_VARCHAR"/>,
        country  = <cfqueryparam value="#User.getCountry()#" cfsqltype="CF_SQL_VARCHAR"/>,
        dateupdated  = <cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
        updatedby  = <cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/>,
        customerid = <cfqueryparam value="#User.getCustomerid()#" cfsqltype="CF_SQL_INTEGER" /> 
						
		WHERE 
		UserID = <cfqueryparam value="#User.getUserID()#" />
	</cfquery>
		
<!----[  update the permissions set  ]---->
	<cfset UpdatePermissions( user ) />
	<cfset UpdateUserGroups ( user ) />
    <cfset UpdateAdminMenus ( user ) />
    
    <!----[  Add a log entry that the user has logged in  ]----MK ---->
               <cfscript>
                InitLog( variables.Log);
               	variables.log.setTablename( "Users");
				variables.log.setComment( "Updated user #user.getUserfirstname()# #user.getUserLastName()#");
				variables.log.setActivity( "Update" );
                variables.log.setDateAdded( now() );
               </cfscript>
               <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
               

	<cfreturn User />
</cffunction>

<cffunction name="ReadPermissions" access="private" returntype="user" output="false" hint="Gets and sets the permission set for a user">
<cfargument name="argsuser" required="yes" type="user" />
<cfset var user = arguments.argsuser />
<!----[  Get permissions  ]---->
	<cfquery name="qGetPermissions" datasource="#variables.dsn#">
		SELECT PermissionID from  userspermissions   		
		WHERE
		UserID = <cfqueryparam value="#user.getUserID()#" cfsqltype="cf_sql_varchar"/>
		ORDER BY  permissionID
	</cfquery>
	<cfset user.setPermissions(valuelist(qGetPermissions.PermissionID, ",")) />

<cfreturn user />

</cffunction>

<cffunction name="UpdatePermissions" access="private" returntype="user" output="false" hint="persists the permission set for a user">
<cfargument name="argsuser" required="yes" type="user" />
<cfset var user = arguments.argsuser />

<!----[  Remove the existing permissions from the permissions mapping table  ]---->
	<cfquery name="RemovePermissions" datasource="#variables.dsn#">
		DELETE from userspermissions 
		WHERE 
		UserID = <cfqueryparam value="#user.getUserID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>
	<!----[  Set the permissions into the permissions mapping table  ]---->
	<cfloop list="#user.getPermissions()#" index="i">
		<cfquery name="InsertPermission" datasource="#variables.dsn#">
			INSERT into userspermissions (PermissionID, UserID) values (
			<cfqueryparam value="#i#" />,
			<cfqueryparam value="#user.getUserID()#" />
			)
		</cfquery>
	</cfloop>
                   
<cfreturn user />
</cffunction>


<cffunction name="ReadUserGroups" access="private" returntype="user" output="false" hint="Gets and sets the permission set for a user">
<cfargument name="argsuser" required="yes" type="user" />
<cfset var user = arguments.argsuser />
<!----[  Get permissions  ]---->
	<cfquery name="qGetGroups" datasource="#variables.dsn#">
		SELECT UserGroupID from  usersgroups  		
		WHERE
		UserID = <cfqueryparam value="#user.getUserID()#" cfsqltype="cf_sql_varchar"/>
		ORDER BY  UserGroupID
	</cfquery>
	<cfset user.setUserGroups(valuelist(qGetGroups.UserGroupID, ",")) />
<cfreturn user />

</cffunction>


<cffunction name="UpdateUserGroups" access="private" returntype="user" output="false" hint="persists the permission set for a user">
<cfargument name="argsuser" required="yes" type="user" />
<cfset var user = arguments.argsuser />

<!----[  Remove the existing permissions from the permissions mapping table  ]---->
	<cfquery name="RemovePermissions" datasource="#variables.dsn#">
		DELETE from UsersGroups 
		WHERE 
		UserID = <cfqueryparam value="#user.getUserID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>
	<!----[  Set the permissions into the permissions mapping table  ]---->
	<cfloop list="#user.getUserGroups()#" index="i">
		<cfquery name="InsertGroup" datasource="#variables.dsn#">
			INSERT into UsersGroups (UserGroupID, UserID,dateUpdated,dateadded,UpdatedBy) values (
			<cfqueryparam value="#i#" />,
			<cfqueryparam value="#user.getUserID()#" />,
			<cfqueryparam value="#createodbcdatetime(variables.austime)#" cfsqltype="cf_sql_timestamp" />,
            <cfqueryparam value="#createodbcdatetime(variables.austime)#" cfsqltype="cf_sql_timestamp" />,
			<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>			
			)
		</cfquery>
	</cfloop>
<cfreturn user />
</cffunction>

<cffunction name="ReadAdminMenus" access="private" returntype="user" output="false" hint="Gets and sets the adminmenus visible to this user">
<cfargument name="argsuser" required="yes" type="user" />
<cfset var user = arguments.argsuser />
<!----[  Get permissions  ]---->
	<cfquery name="qGetMenus" datasource="#variables.dsn#">
		SELECT menuID from  usersmenus  		
		WHERE
		UserID = <cfqueryparam value="#user.getUserID()#" cfsqltype="cf_sql_varchar"/>
		ORDER BY  menuID
	</cfquery>
	<cfset user.setAdminMenus(valuelist(qGetMenus.menuID, ",")) />
<cfreturn user />

</cffunction>


<cffunction name="UpdateAdminMenus" access="private" returntype="user" output="false" hint="persists the AdminMenus set for a user">
<cfargument name="argsuser" required="yes" type="user" />
<cfset var user = arguments.argsuser />

<!----[  Remove the existing permissions from the permissions mapping table  ]---->
	<cfquery name="RemovePermissions" datasource="#variables.dsn#">
		DELETE from usersmenus
		WHERE 
		UserID = <cfqueryparam value="#user.getUserID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>
	<!----[  Set the permissions into the permissions mapping table  ]---->
	<cfloop list="#user.getAdminMenus()#" index="i">
		<cfquery name="InsertAdminMenu" datasource="#variables.dsn#">
			INSERT into usersmenus (menuid, UserID) values (
			<cfqueryparam value="#i#" />,
			<cfqueryparam value="#user.getUserID()#" />
			)
		</cfquery>
	</cfloop>
                  
<cfreturn user />
</cffunction>


</cfcomponent>