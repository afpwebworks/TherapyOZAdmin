<cfsilent>
<!----
==========================================================================================================
Filename:    DeleteSite.cfm
Description: Deletes a Site from the database and returns the user to the originating page.  Reqires ColdSpring 1.0
Client:       Therapy Oz Admin Site
Date:        23/Sep/2015
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->


<cfparam name="request.pagename" default="Delete Site">
<cfif NOT(isdefined("url.SiteID")) AND NOT(isdefined("form.submit"))>
  <cflocation addtoken="no" url="index.cfm" />
  <cfelseif (isdefined("url.SiteID") and NOT(isDefined("form.submit")))>
  <cfscript>
 	Site =  application.beanfactory.getBean("Site");
	Site.setSiteID(SiteID);
	SitesDAO = application.beanfactory.getBean("SitesDAO");
	SitesDAO.read(Site);
 </cfscript>
</cfif>
<cfif isDefined("form.dontsubmit")>
	 <cflocation addtoken="no" url="#cgi.HTTP_REFERER#" />
	 <abort>
<cfelseif isDefined("form.submit")>
  <cfscript>
	Site =  application.beanfactory.getBean("Site");
	Site.setSiteID(SiteID);
	SitesDAO = application.beanfactory.getBean("SitesDAO");
	SitesDAO.delete(Site);
</cfscript>
  <cflocation addtoken="no" url="#cgi.HTTP_REFERER#" />
</cfif>
</cfsilent>
<cfsetting enablecfoutputonly="yes">
<cfinclude template="/includes/header.cfm">

<cfoutput>
  <p>Delete this Site from the system. <strong>WARNING: This action removes the whole record from the database permanently.  Do you really want to remove this content element?</strong></p>
  <form action="#cgi.SCRIPT_NAME#?#cgi.Query_string#" method="post">
    <input type="hidden" name="SiteID" id="SiteID" value="#url.SiteID#">
    <div id="deletetable">
      <table>
        <tr>
          <th>Site Title</th>
          <td class="lite">#Site.getSiteName()#</td>
        </tr>
        <tr>
          <td align="right"><input type="submit" name="dontsubmit" class="submitbutton" value="No Dont delete"></td>
          <td><input type="submit" name="submit" class="submitbutton"  value="OK Delete it"></td>
        </tr>
      </table>
    </div>
  </form>
</cfoutput>
<cfsetting enablecfoutputonly="no">
<cfinclude template="/includes/footer.cfm">


