<cfsilent>
<!----
==========================================================================================================
Filename:       logout.cfm
Description:    Logout page 
Date:          22/7/2005
Author:       Michael Kear

Revision history: 

==========================================================================================================
--->
<cfscript>
	session.user = application.beanfactory.getbean("UserAccess").LogoutUser(session.user);
</cfscript>
<cflocation url="/index.cfm" addtoken="no">
<cfabort>
</cfsilent>