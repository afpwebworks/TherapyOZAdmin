<cfsilent>
<!----
==========================================================================================================
Filename:     index.cfm
Description:  Main Dashboard File for TherapyOZ Admin Area
Date:         1/9/2015
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfscript>
</cfscript>
<cfparam name="request.pagename" default="Main Dashboard">
</cfsilent>
<cfinclude template="/includes/adminheader.cfm" />
<cfoutput>

      <div class="text-center m-t-lg">
        <h1>Welcome to THERAPY OZ Admin Dashboard</h1>
        <small>This is an application skeleton for a typical web app. Content, news, forms will go in this area, depending on the user's level of access and needs.</small>
        <h1>Logged In? : #session.user.getIsLoggedIn()#</h1>
        <cfif application.siteversion eq "development">
            <cfdump var="#session.user.getsnapshot()#" label="session.user">
            <cfdump var="#application#" label="application" >
            <cfset TreeLibrary = application.beanfactory.getbean("TreeLibrary") />
            <cfset page  = application.beanfactory.getbean("Page") />
            <cfdump var="#page.getsnapshot()#" />
            <h1>Sending password ....</h1>
            <cfdump var="#application.beanfactory.getbean('Useraccess').getpassword('mkear@afpwebworks.com')#" />
            <hr />
            <cfset thepasswordreturn = application.beanfactory.getbean('Useraccess').getpassword('mkear@afpwebworks.com')>
            <cfset  thepassword  = Listlast(thepasswordreturn) />
            <cfset  theUserLogin = Listfirst(thepasswordreturn) />
            
            <!----[  <cfmail ]----MK ----> to="mkear@afpwebworks.com" <br />
            from="#application.webmasteremail#" 
            subject="#application.sitemailindex# Your lost password" <br />
            server="#application.mailserver#" <br />
            username="#application.mailuser#" <br />
            password="#application.mailpassword#"> <br />
            Someone, presumably you, came to the #application.sitename# web site and asked us to send you the login details to your account. 
            
            Your userid is: #theUserLogin#<br />
            Your password is: #thepassword#<br />
            Yours faithfully,<br />
            Webmaster,<br />
            #application.sitename# 
            <!----[  </cfmail>   ]----MK ---->
            
            <h4>Sent. </h4>
           </cfif> 
      </div>
    </div>
  </div>
</div>
</cfoutput>
<cfinclude template="/includes/adminfooter.cfm" />