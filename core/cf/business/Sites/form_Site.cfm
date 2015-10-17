<cfsilent>
<!----[
==========================================================================================================
Filename:      form_Site.cfm
Description:   Form for  handling Sites Requires a bean called Site to exist already. 
				Form format is for use with Twitter Bootstrap v2.0
Client:       Therapy Oz Admin Site				
Date:          23/September/2015 
Author:        Michael Kear,  AFP Webworks

Revision history:

==========================================================================================================
]--->
<cfscript>
SiteTemplates = application.beanfactory.getbean("SiteTemplatesDAO").GetAllSiteTemplates();
</cfscript>

</cfsilent>

<cfoutput>
<div class="content">
<div class="col-sm-6">
  <legend>#request.pagename# Site ID: #Site.getSiteID()#</legend>
  <form name="Sitesform" id="Sitesform" role="form" action="#cgi.SCRIPT_NAME#" method="post" >
    <cfif (isdefined("errorhandler") AND  (errorhandler.haserrors()))>
      <div class="alert alert-danger alert-white rounded">
        <button type="button" class="close" data-dismiss="danger" aria-hidden="true">×</button>
        <div class="icon"><i class="fa fa-warning"></i></div>
        <strong>Error!</strong> #errorhandler.MakeErrorDisplay( errorhandler )#<br>
      </div>
    </cfif>
    <input type="hidden" name="Addedby" value="#Site.getAddedby()#" />
    <input type="hidden" name="Dateadded" value="#Site.getDateadded()#" />
    <input type="hidden" name="Dateupdated" value="#Site.getDateupdated()#" />
    <input type="hidden" name="IsVisible" value="#Site.getIsVisible()#" />
    <input type="hidden" name="SiteID" value="#Site.getSiteID()#" >
    <input type="hidden" name="Updatedby" value="#Site.getUpdatedby()#" />
    <input type="hidden" name="CustomerID"  value="#Site.getCustomerID()#" >
    <input type="hidden" name="Version"  value="#Site.getVersion()#" >
    <input type="hidden" name="Live"  value="#Site.getLive()#" >
    <div class="form-group">
      <label for="Sitename" >Sitename</label>
      <input type="text" class="form-control" id="Sitename" name="Sitename" placeholder="Sitename"  maxlength="512"  value="#Site.getSitename()#" >
    </div>
    <div class="form-group">
    <label for="SiteTemplateID">Site&nbsp;Template </label>
    <select name="SiteTemplateID" id="SiteTemplateID" >
    <cfloop query="SiteTemplates">
    	<option value="#SiteTemplates.SiteTemplateID#" <cfif SiteTemplates.SiteTemplateID eq Site.getSiteTemplateID()>selected="selected"</cfif>>#SiteTemplates.TemplateName#</option>
    </cfloop>
    </select>
   </div>
  
    <div class="form-group">
      <button type="submit" name="submit" id="submit" class="btn btn-primary">Submit</button>
    </div>
  </form>
</div>
<!---/end content div ---->
</cfoutput>
