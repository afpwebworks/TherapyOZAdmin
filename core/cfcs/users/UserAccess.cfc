<cfcomponent output="no" displayname="User Access" hint="Functions to manage logins and user access for Hawkesbury Radio CMS.">
<cfsilent>
<!---
=================================================================================================================
File:           UserAccess.cfc   
Description:    Functions to manage logins and user access for AFP CMS v4.0
Author:	        Michael Kear
Date:           27/1/2006
Modification:   30/4/2006  Changed to provide only the access/login control items in this CFC.
		2/12/2008 changed for use with v4.0 and Coldspring
		8/9/2015 Modified to run with TherapyOZ Admin module.   MK
=================================================================================================================
--->
</cfsilent>

   <cffunction name="init" access="public" returntype="UserAccess" output="false" hint="This is called by the framework and automatically maps variables in the current event to the instance variables of this bean.">
    <cfargument name="argsConfiguration" required="true" type="any" />
     <cfargument name="argsLog" required="true" type="any" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
    <cfset variables.mailserver = variables.config.getmailserver() />
	<cfset variables.mailuser = variables.config.getmailuser() />
	<cfset variables.mailpassword = variables.config.getmailpassword() />
	<cfset variables.webmasteremail = variables.config.getwebmasteremail() />
	<cfset variables.sitename = variables.config.getsitename() />
	<cfset variables.sitemailindex = variables.config.getsitemailindex() />	
	<cfset variables.austime = variables.config.getAusTime() />
    <cfset variables.Log = arguments.argsLog/>
	<cfreturn this />
</cffunction>

<cffunction name="setUserService" access="public" output="false" returntype="void" hint="Dependency: User Service">
	<cfargument name="UserService" type="any" required="true"/>
	<cfset variables.UserService = arguments.UserService/>
</cffunction>




<cffunction name="GetUser" access="public" returntype="string" output="false" hint="Returns the basic infor for CFLOGIN tag.">
		<cfargument name="UserLogin" type="string" required="true">
		<cfargument name="UserPassword" type="string" required="true">
		<cfset var qGetUser = 0 />
		<cfquery name="qGetUser" datasource="#variables.dsn#">
		SELECT UserID,UserFirstName, UserLastName,UserPassword
		From Users
		WHERE  (UserLogin = <cfqueryparam value = "#arguments.UserLogin#" cfsqltype = "cf_sql_char" maxLength = "50">
			OR
			Email = <cfqueryparam value = "#arguments.UserLogin#" cfsqltype = "cf_sql_char" maxLength = "50">
			)			
			AND
			UserPassword = <cfqueryparam value = "#arguments.UserPassword#" cfsqltype = "cf_sql_char" maxLength = "50">
			AND UserActive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
            AND IsVisible = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
		</cfquery>
			<cfif qGetUser.recordcount eq '1'>
			<cfset myResult = "loggedin">
		<cfelse>		
			<cfset myResult = "NOTloggedin">
		</cfif>
			<cfreturn myResult>
</cffunction>

	

	<cffunction name="loginuser" access="public" returntype="any" hint="checks a user's status and logs him in">
		<cfargument name="argsUserLogin" type="string" required="true">
		<cfargument name="argsUserPassword" type="string" required="true">
		<cfargument name="argsuser" type="any" required="yes" /> 
 		<cfset var qLoginUser = 0 />
		<cfset var vUser = arguments.argsUser />
		<cfset var login = arguments.argsUserLogin />
		<cfset var password = arguments.argsUserPassword />
		<cfset var ThisUsergroups = "" />
		<cfset var ThisUsergroupNames = "" />		
		<cfquery name="qLoginUser" datasource="#variables.DSN#">
    		SELECT u.UserID,u.UserLogin, u.UserPassword
			FROM USERS u
 			WHERE
			(UserLogin = <cfqueryparam value = "#Login#" cfsqltype = "cf_sql_char" maxLength = "50">
			OR
			Email = <cfqueryparam value = "#Login#" cfsqltype = "cf_sql_char" maxLength = "50">
			)			
			AND
			UserPassword = <cfqueryparam value = "#Password#" cfsqltype = "cf_sql_char" maxLength = "50">
			AND
			UserActive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
            AND
            IsVisible = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
		</cfquery>
		<cfif qLoginUser.recordcount>
			<cfscript>
			vUser.setUserID(qLoginUser.UserID);
			application.beanfactory.getbean("UsersDAO").read(vUser);
			vUser.setIsloggedIn(true);
			</cfscript>	
            <cfreturn vUser>
		<!----[  OTherwise it's not a valid user, so just hand back the empty userbean ]---->	
		<cfelse>
		<cfreturn vUser />
		</cfif>
	
	</cffunction>
	
	
<cffunction name="setdefaultlogins" access="public" output="false" hint="sets the default login details and creates the session.auth. struct anew">
		<cfscript>
			session.user = application.beanfactory.getbean("user");
		</cfscript>
	</cffunction>

	
	<cffunction name="checkuserexists"  access="public" output="true" returntype="boolean" hint="Checks to see if a user exists given the UserLogin and UserPassword">
		<cfargument name="UserLogin" type="string" required="true">
		<cfargument name="UserPassword" type="string" required="true">
		<cfquery name="finduser" datasource="#variables.DSN#">
			SELECT Userid from USERS WHERE
			UserLogin = <cfqueryparam value = "#arguments.UserLogin#" cfsqltype = "cf_sql_char" maxLength = "50">
			AND
			UserPassword = <cfqueryparam value = "#arguments.UserPassword#" cfsqltype = "cf_sql_char" maxLength = "50">	
		</cfquery>
		<cfif finduser.recordcount eq "0">
			<cfset userexists = false>
		<cfelse>	
			<cfset userexists = true>		
		</cfif>
		<cfreturn userexists>
	</cffunction>
		
	
	<cffunction name="checkInuse" access="public" output="true" returntype="string" hint="Checks to see if this user/password combination already exists for another user.">
	<cfargument name="UserLogin" type="string" required="true">
	<cfargument name="UserPassword" type="string" required="true">
	<cfset var UserID = 0 />

		<cfquery name="finduser" datasource="#variables.DSN#">
			SELECT Userid from USERS WHERE
			UserLogin = <cfqueryparam value = "#arguments.UserLogin#" cfsqltype = "cf_sql_char" maxLength = "50">
			AND
			UserPassword = <cfqueryparam value = "#arguments.UserPassword#" cfsqltype = "cf_sql_char" maxLength = "50">	
		</cfquery>
		<cfif finduser.recordcount GT "0">
			<cfset Userid = finduser.UserID >
		</cfif>
		<cfreturn Userid>
	</cffunction>
	
	
	<cffunction name="UpdateAfterLogin" access="public" output="true" returntype="user" hint="Returns full details of a user to allow fully logged in status">
	<cfargument name="cgi" type="struct" required="yes" />
	<cfargument name="argsuser" type="user" required="yes" />
	<!----[  //Remove any spaces in the form values   ]---->
	<cfset var updatecount = 0 />
    <cfset var user = arguments.argsUser />
	
	 <cfquery name="updatecount" datasource="#variables.DSN#">
		UPDATE USERS
		SET Usertotallogins    = Usertotallogins + 1,
		UserLastLogin          = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp" />,
		UserIP                 = <cfqueryparam value="#arguments.cgi.REMOTE_ADDR#" cfsqltype="cf_sql_varchar" />
		
		WHERE UserID      = <cfqueryparam value="#user.getUserID()#" />
    </cfquery> 
         <cfset application.beanfactory.getbean("UsersDAO").read( user ) />
	<cfreturn user>
</cffunction>

<cffunction name="LogoutUser" access="public" output="false" returntype="user" hint="Logs the user out and resets all session vars to the defaults">
<cfargument name="argsUser" required="yes" type="user"  />
<cfset var user = arguments.argsUser />

	<!----Kill the cookies and CFID/CFTOKEN ---->
	  <cfcookie name="CFID"  expires="NOW">
	  <cfcookie name="CFTOKEN" expires="NOW">

		<!---- Delete the session vars. ---->
	    <cfscript>
			Newuser = application.beanfactory.getbean("user");
		</cfscript>
		<cfreturn Newuser />
</cffunction>
	
	
<cffunction name="getgroups" access="public" output="true" returntype="query" hint="Returns a Query containing the usergroup details of the called user. Requires a UserLogin from a logged in user">
	<cfargument name="UserID" type="string" required="yes" />
			<!----[  //Remove any spaces in the form values   ]---->
	<cfset var getrights = 0 />
	
	<cfquery name="getrights" datasource="#variables.DSN#">
	  SELECT     UserGroups.UserGroupName, UserGroups.UserGroupID
      FROM     Users INNER JOIN
               UsersGroups ON Users.UserID = UsersGroups.UserID INNER JOIN
               UserGroups ON UsersGroups.UserGroupID = UserGroups.UserGroupID
      WHERE    Users.userid = '#arguments.UserID#' 
	  	</cfquery>
		<cfreturn getrights>
</cffunction> 

<!----[  THis function is not used in the AFP Cms v3.0 system. Instead use the UserAccessLevel field in the USERS table.  ]---->
<cffunction name="GetUserAccessLevel" access="public" output="false" returntype="numeric" hint="Returns the highest access level owned by the user">
    <cfargument name="UserID" type="string" required="true">
	<cfset var QGetUserAccessLevel = 0 />
    <cfquery name="QGetUserAccessLevel" datasource="#variables.dsn#">
		SELECT top 1 UserGroups.Usergroupid from UserGroups, UsersGroups, Users
		WHERE
		Users.UserID = UsersGroups.UserID
		AND
		UsersGroups.UserGroupID = UserGroups.UserGroupID
		AND
		Users.UserID = '#arguments.UserID#'	
		order by UserGroups.Usergroupid desc
	</cfquery>
	<cfreturn #QGetUserAccessLevel.Usergroupid#>	
</cffunction>

<cffunction name="SendPassword" access="public" output="true" returntype="void" hint="Emails the users password to them, based on the email address input">
<cfargument name="Useremail" required="yes" default="">
<cfset var thepasswordreturn = getpassword(Useremail=trim(arguments.useremail))>
<cfset var thepassword  = Listlast(thepasswordreturn) />
<cfset var theUserLogin = Listfirst(thepasswordreturn) />


<cfmail to="#arguments.useremail#" 
		from="#variables.webmasteremail#" 
        subject="#variables.sitemailindex# Your lost password" 
        server="#variables.mailserver#" username="#variables.mailuser#" password="#variables.mailpassword#">
Someone, presumably you, came to the #variables.sitename# web site and asked us to send you the login details to your account. 
		  
Your userid is: #theUserLogin#
Your password is: #thepassword#
		  
Yours faithfully,
Webmaster,
#variables.sitename#		 	 
</cfmail>  
</cffunction>
	
	<cffunction name="getpassword" access="public" output="true" returntype="string" hint="Retrieves password for a given email address to be sent to the user.  Requires either UserEmail, UserLogin or User's first name and last name">
	<cfargument name="Useremail" required="no" default="">
	<cfargument name="UserLogin" required="no" default="">
	<cfargument name="UserFirstName" required="no" default="">
	<cfargument name="UserLastName" required="no" default="">
	<cfset var thepassword = "" />
	<cfset var 	retrievepassword = 0 />	
	<cfquery name="retrievepassword" datasource="#variables.DSN#">
	SELECT UserPassword,Userlogin from USERS where 	0=1
	<cfif len(arguments.UserEmail) GT 1 >
	OR
	(Email = <cfqueryparam value="#trim(arguments.Useremail)#" cfsqltype="cf_sql_varchar" />)
	</cfif>
	<cfif len(arguments.UserLogin) GT 1>
	OR
	(UserLogin = <cfqueryparam value="#trim(arguments.UserLogin)#" cfsqltype="cf_sql_varchar" /> )
	</cfif>
	<cfif len(arguments.UserFirstName) GT 1>	
	OR
	( (UserFirstName= <cfqueryparam value="#trim(arguments.UserFirstName)#" cfsqltype="cf_sql_varchar" /> ) AND (UserLastName= <cfqueryparam value="#trim(arguments.UserLastName)#" cfsqltype="cf_sql_varchar" />) )
	</cfif>
	</cfquery>
	<cfif retrievepassword.recordcount eq '1'>
		<cfset thepassword = "#retrievepassword.Userlogin#,#retrievepassword.Userpassword#">
	<cfelse>	
		<cfset thepassword = "Notknown,NotKnown">
	</cfif>
		<cfreturn thepassword>
	</cffunction>	
 
 <cffunction name="isLoggedIn" access="public" output="false" returntype="boolean" hint="Decides if a user is logged in or not.">
 	<cfargument name="auth" required="yes" type="struct" />
		<cfreturn arguments.auth.Isloggedin neq "No" />
</cffunction>
 
</cfcomponent>