<cfsilent>
<!----
==========================================================================================================
Filename:    DeletePage.cfm
Description: Deletes a Page from the database and returns the user to the originating page.  Reqires ColdSpring 1.0
Client:      Therapy OZ Admin
Date:        17/Oct/2015
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->


<cfparam name="request.pagename" default="Delete Page">
<cfif NOT(isdefined("url.PageID")) AND NOT(isdefined("form.submit"))>
  <cflocation addtoken="no" url="index.cfm" />
  <cfelseif (isdefined("url.PageID") and NOT(isDefined("form.submit")))>
  <cfscript>
 	Page =  application.beanfactory.getBean("Page");
	Page.setPageID(PageID);
	PagesDAO = application.beanfactory.getBean("PagesDAO");
	PagesDAO.read(Page);
 </cfscript>
</cfif>
<cfif isDefined("form.dontsubmit")>
	 <cflocation addtoken="no" url="#cgi.HTTP_REFERER#" />
	 <abort>
<cfelseif isDefined("form.submit")>
  <cfscript>
	Page =  application.beanfactory.getBean("Page");
	Page.setPageID(PageID);
	PagesDAO = application.beanfactory.getBean("PagesDAO");
	PagesDAO.delete(Page);
</cfscript>
  <cflocation addtoken="no" url="#cgi.HTTP_REFERER#" />
</cfif>
</cfsilent>
<cfinclude template="/includes/adminheader.cfm">

<cfoutput>
  <p>Delete this Page from the page. <strong>WARNING: This action removes the whole record from the database permanently.  Do you really want to remove this content element?</strong></p>
  <form action="#cgi.SCRIPT_NAME#?#cgi.Query_string#" method="post">
    <input type="hidden" name="PageID" id="PageID" value="#url.PageID#">
    <div id="deletetable">
      <table>
        <tr>
          <th>Page Title</th>
          <td class="lite">#Page.getPageName()#</td>
        </tr>
        <tr>
          <td align="right"><input type="submit" name="dontsubmit" class="submitbutton" value="No Dont delete"></td>
          <td><input type="submit" name="submit" class="submitbutton"  value="OK Delete it"></td>
        </tr>
      </table>
    </div>
  </form>
</cfoutput>
<cfinclude template="/includes/adminfooter.cfm">