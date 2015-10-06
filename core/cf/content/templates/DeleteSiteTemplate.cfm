<cfsilent>
<!----
==========================================================================================================
Filename:    DeleteSiteTemplate.cfm
Description: Deletes a SiteTemplate from the database and returns the user to the originating page.  Reqires ColdSpring 1.0
Client:      Therapy OZ Admin
Date:        30/Sep/2015
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->


<cfparam name="request.pagename" default="Delete SiteTemplate">
<cfif NOT(isdefined("url.SiteTemplateID")) AND NOT(isdefined("form.submit"))>
  <cflocation addtoken="no" url="index.cfm" />
  <cfelseif (isdefined("url.SiteTemplateID") and NOT(isDefined("form.submit")))>
  <cfscript>
 	SiteTemplate =  application.beanfactory.getBean("SiteTemplate");
	SiteTemplate.setSiteTemplateID(SiteTemplateID);
	SiteTemplatesDAO = application.beanfactory.getBean("SiteTemplatesDAO");
	SiteTemplatesDAO.read(SiteTemplate);
 </cfscript>
</cfif>
<cfif isDefined("form.dontsubmit")>
	 <cflocation addtoken="no" url="#cgi.HTTP_REFERER#" />
	 <abort>
<cfelseif isDefined("form.submit")>
  <cfscript>
	SiteTemplate =  application.beanfactory.getBean("SiteTemplate");
	SiteTemplate.setSiteTemplateID(SiteTemplateID);
	SiteTemplatesDAO = application.beanfactory.getBean("SiteTemplatesDAO");
	SiteTemplatesDAO.delete(SiteTemplate);
</cfscript>
  <cflocation addtoken="no" url="#cgi.HTTP_REFERER#" />
</cfif>
</cfsilent>
<cfinclude template="/includes/adminheader.cfm">

<cfoutput>
  <p>Delete this SiteTemplate from the page. <strong>WARNING: This action removes the whole record from the database permanently.  Do you really want to remove this content element?</strong></p>
  <form action="#cgi.SCRIPT_NAME#?#cgi.Query_string#" method="post">
    <input type="hidden" name="SiteTemplateID" id="SiteTemplateID" value="#url.SiteTemplateID#">
    <div id="deletetable">
      <table>
        <tr>
          <th>SiteTemplate Title</th>
          <td class="lite">#SiteTemplate.getSiteTemplateName()#</td>
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
