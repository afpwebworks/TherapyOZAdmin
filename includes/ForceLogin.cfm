<cfsilent>
<!---
=============================================================================================================================
File:         forcelogin.cfm
Description:  Requires the user to be logged in before granting access.  Normally included by Application.cfm
Author:	      Michael Kear
Date:        27/1/2006
Revision history: 
			8/9/2015 Modified to run with TherapyOZ Admin module.   MK
=============================================================================================================================
--->
<cfset UserAccess = application.beanfactory.getbean("UserAccess") />	

</cfsilent>

<cfif (session.user.getIsLoggedIn() is false)>

<cfif IsDefined("Form.sendlostpassword")> 
	 <cfscript>
        application.beanfactory.getbean("UserAccess").SendPassword(Useremail="#form.useremail#");
     </cfscript>
<!--- If the user has submitted login form process it --->
<cfelseif (IsDefined("FORM.UserName") AND IsDefined("FORM.Password"))>

	<cflock scope="session" type="exclusive" timeout="10">
		<cfset session.loginerrormessage = "">
	</cflock>	
	
	<cfscript>
		//Remove any spaces in the form values 
		rUserName = #Replace(form.UserName, " ", "")#;
		rPassword = #Replace(form.Password, " ", "")#;
		session.user = UserAccess.loginUser( rUserName, rPassword, session.user );
	</cfscript>
    		
		<cfif session.user.getIsloggedin()>
		<!--- If the user is populated with data, consider the user 'logged in' and update the count and stats --->
			<cfscript>
				session.user = UserAccess.UpdateAfterLogin(cgi, session.user);
			</cfscript>
            
				<cflocation addtoken="no" url="/index.cfm" /> 
			<!--- Othewise re-prompt for a valid username and password --->	
		<cfelse>
			<cflock scope="session" type="exclusive" timeout="10">
				<cfset session.loginerrormessage = "<li>Sorry that username and password are not recognised.  Please try again.</li>">
			</cflock>
		</cfif>
        
</cfif>
	<cfinclude template="/includes/LoginForm.cfm">
	<cfabort>


</cfif>

<!----[  
======================================================================================================================================


<cfsilent>
	
</cfsilent>

<cfif NOT(session.user.getIsLoggedIn())>

<!--- If the user has submitted login form process it --->
<cfif (IsDefined("FORM.UserLogin") AND IsDefined("FORM.UserPassword"))>

		<cfset session.loginerrormessage = "">

	<cfscript>
		//Remove any spaces in the form values 
		rUserLogin = #Replace(form.UserLogin, " ", "")#;
		rUserPassword = #Replace(form.UserPassword, " ", "")#;
		session.user = UserAccess.loginuser( rUserLogin, rUserPassword, session.user );
	</cfscript>
		<cfif session.user.getIsloggedin()>
      
            
			<cflocation url="/index.cfm" addtoken="no" />
			<!--- Othewise re-prompt for a valid username and password --->	
		<cfelse>
			<cflock scope="session" type="exclusive" timeout="10">
				<cfset session.loginerrormessage = "<li>Sorry that username and password aren't recognised.  Please try again.</li>">
			</cflock>
		</cfif>

</cfif>
	<cfinclude template="/core/cf/includes/Form_Login.cfm">
	<cfabort>
</cfif>
  ]----MK ---->