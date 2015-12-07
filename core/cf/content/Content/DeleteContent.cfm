<cfsilent>
<!----
==========================================================================================================
Filename:    DeleteContent.cfm
Description: Deletes a Content from the database and returns the user to the originating page.  Reqires ColdSpring 1.0
Client:      Therapy OZ Admin
Date:        18/Oct/2015
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->


<cfparam name="request.pagename" default="Delete Content">
<cfif NOT(isdefined("url.ContentID")) AND NOT(isdefined("form.submit"))>
  <cflocation addtoken="no" url="index.cfm" />
  <cfelseif (isdefined("url.ContentID") and NOT(isDefined("form.submit")))>
  <cfscript>
 	Content =  application.beanfactory.getBean("Content");
	Content.setContentID(ContentID);
	ContentDAO = application.beanfactory.getBean("ContentDAO");
	ContentDAO.read(Content);
 </cfscript>
</cfif>
<cfif isDefined("form.dontsubmit")>
	 <cflocation addtoken="no" url="#cgi.HTTP_REFERER#" />
	 <abort>
<cfelseif isDefined("form.submit")>
  <cfscript>
	Content =  application.beanfactory.getBean("Content");
	Content.setContentID(ContentID);
	ContentDAO = application.beanfactory.getBean("ContentDAO");
	ContentDAO.delete(Content);
</cfscript>
  <cflocation addtoken="no" url="#cgi.HTTP_REFERER#" />
</cfif>
</cfsilent>
<cfinclude template="/includes/adminheader.cfm">

<cfoutput>
  <p>Delete this Content from the page. <strong>WARNING: This action removes the whole record from the database permanently.  Do you really want to remove this content element?</strong></p>
  <form action="#cgi.SCRIPT_NAME#?#cgi.Query_string#" method="post">
    <input type="hidden" name="ContentID" id="ContentID" value="#url.ContentID#">
    <div id="deletetable">
      <table>
        <tr>
          <th>Content Title</th>
          <td class="lite">#Content.getContentName()#</td>
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
