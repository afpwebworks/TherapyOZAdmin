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
RecentActivity = application.beanfactory.getbean("LogsDAO").GetMyLogs( session.user, false );
</cfscript>
<cfparam name="request.pagename" default="Main Dashboard">
</cfsilent>
<cfinclude template="/includes/adminheader.cfm" />
<cfoutput>
<div class="text-center m-t-lg">
  <h1>Welcome to THERAPY OZ Admin Dashboard</h1>
  <small>This is the main dashboard for the admin area.  Most commonly needed basic information is on this page.  Menus provide access to the areas you have access to.</small>
  <div class="row">
    <div class="col-lg-6">
      <div class="ibox float-e-margins">
        <div class="ibox-title">
          <h5>Recent Activity on your site</h5>
          <div class="ibox-tools"> <a class="collapse-link"> <i class="fa fa-chevron-up"></i> </a> <a class="close-link"> <i class="fa fa-times"></i> </a> </div>
        </div>
        <cfdump var="#session.user.getsnapshot()#" />
<!----[          Recent activity box  ]----MK ---->
        <div class="ibox-content">
          <table class="table table-hover no-margins">
            <thead>
              <tr>
                <th>Sitename</th>
                <th>Date</th>
                <th>User</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <cfloop query="RecentActivity">
              <tr>
                <td>#Recentactivity.sitename#</td>
                <td>#dateformat( Recentactivity.dateadded, 'dd/mmm/yyyy')# <i class="fa fa-clock-o"></i> #lcase(  timeformat( Recentactivity.dateadded, 'hh:mmtt' ))#</td>
                <td>#username#</td>
                <td><strong>#Recentactivity.activity#</strong>: #Recentactivity.comment#</td>
              </tr>
              </cfloop>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
  
<!----[    /End Recent Activity  ]----MK ---->

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
    <cfdump var="#RecentActivity#" label="dashboard line 37" />
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