<cfsilent>
<!----
==========================================================================================================
Filename:     Pagesindex.cfm
Description:  Main switchboard for page management area
Client:       Therapy Oz Admin site
Date:         20/9/2015
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfscript>
SitePages = application.beanfactory.getbean("Treelibrary").GetPagesForSite( session.user.getSiteID() ) ;
</cfscript>
<cfparam name="request.pagename" default="">
</cfsilent>
<cfinclude template="/includes/adminheader.cfm" />

<p>Select the page to edit. </p>

<p>This function is to change the structural part of the page, or its location in the site, or its display parameters and dates. If you want to change the content of the page, go to the content maintenance section. </p>

<div class="section"><a href="/core/cf/content/pages/editpage.cfm"><button class="btn btn-primary " type="button"><i class="fa fa-plus"></i>&nbsp;Add a new page.</button></a></div>

<div class="table-responsive">
<cfoutput>
<table class="table table-striped table-bordered table-hover dataTables-example">
<thead>
<tr>
<th>PageID / Version</th>
<th>PageName</th>
<th>Action to take</th>
<th>Delete</th>
</tr>
</thead>
<tbody>
<cfloop query="sitepages">
<tr>
<td>#SitePages.PageID# / #sitepages.version#</td>
<td>#repeatstring('&nbsp;..&nbsp;', (level-1))##SitePages.PageTitle#</td>
<td>
<cfif len(sitepages.LockedForEdit) GT '2'>
<button class="btn btn-warning disabled" type="button"><i class="fa fa-ban"></i>&nbsp;Locked for Edit</button>
<cfelse>
<a href="/core/cf/content/pages/editpage.cfm?pageid=#SitePages.PageID#"><button class="btn btn-primary " type="button"><i class="fa fa-edit"></i>&nbsp;Edit Page</button></a>&nbsp;&nbsp;<a href="/core/cf/content/pages/editpage.cfm?pageid=#SitePages.PageID#"><button class="btn btn-primary " type="button"><i class="fa fa-edit"></i>&nbsp;Edit Content</button></a>
</cfif>
</td>
<td>
<cfif len(sitepages.LockedForEdit) GT '2'>
<button class="btn btn-warning disabled" type="button"><i class="fa fa-ban"></i>&nbsp;Locked for Edit</button>
<cfelse>
<cfif SitePages.level eq '1'><button class="btn btn-warning disabled " type="button"><i class="fa fa-minus"></i>&nbsp;&nbsp;Delete</button>
<cfelse>
<a href="/core/cf/content/pages/deletepage.cfm?pageid=#SitePages.PageID#"><button class="btn btn-danger " type="button"><i class="fa fa-minus"></i>&nbsp;&nbsp;Delete</button></a></cfif>
</cfif>
</td>
</tr>
</cfloop>
</tbody>
<tfoot>
<tr>
<th>PageID</th>
<th>PageName</th>
<th>Action to take</th>
<th>Delete</th>
</tr>
</tfoot>
</table>
</div>
</cfoutput>
<cfinclude template="/includes/adminfooter.cfm" />