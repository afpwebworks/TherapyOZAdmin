<cfsilent>
<!----
==========================================================================================================
Filename:     adminheaderbar.cfm
Description:  Header bar for admin page - contains search field and logout button.
Date:         23/9/2015
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfscript>

</cfscript>
</cfsilent>

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