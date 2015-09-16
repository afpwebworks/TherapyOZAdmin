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
session.user.setUserid('1');
session.user = application.beanfactory.getbean("UsersDAO").read(session.user) ;
</cfscript>
<cfparam name="request.pagename" default="Main Dashboard">
</cfsilent>
<cfinclude template="/includes/adminheader.cfm" />
<cfoutput>
<div id="wrapper">
<!----[  Include main menu  ]----MK ---->
<cfinclude template="/includes/adminmenu.cfm" />
<div id="page-wrapper" class="gray-bg">
<div class="row border-bottom"> <nav class="navbar navbar-static-top white-bg" role="navigation" style="margin-bottom: 0">
  <div class="navbar-header"> <a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="##"><i class="fa fa-bars"></i> </a>
    <form role="search" class="navbar-form-custom" method="post" action="##">
      <div class="form-group">
        <input type="text" placeholder="Search for something..." class="form-control" name="top-search" id="top-search">
      </div>
    </form>
  </div>
  <ul class="nav navbar-top-links navbar-right">
    <li> <a href="/logout.cfm"> <i class="fa fa-sign-out"></i> Log out </a> </li>
  </ul>
  </nav> </div>
<div class="wrapper wrapper-content animated fadeInRight">
  <div class="row">
    <div class="col-lg-12">
      <cfinclude template="/includes/adminbreadcrumb.cfm" />
      <div class="text-center m-t-lg">
        <h1>Welcome to THERAPY OZ Admin Dashboard</h1>
        <small>This is an application skeleton for a typical web app. Content, news, forms will go in this area, depending on the user's level of access and needs.</small>
        <h1>Logged In? : #session.user.getIsLoggedIn()#</h1>
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
      </div>
    </div>
  </div>
</div>
</cfoutput>
<cfinclude template="/includes/adminfooter.cfm" />