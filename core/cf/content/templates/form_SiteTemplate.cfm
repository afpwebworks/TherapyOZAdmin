<cfsilent>
<!----[
==========================================================================================================
Filename:      form_SiteTemplate.cfm
Description:   Form for  handling SiteTemplates Requires a bean called SiteTemplate to exist already. 
				Form format is for use with Twitter Bootstrap v2.0
Client:        Therapy OZ Admin                
Date:          30/September/2015 
Author:        Michael Kear,  AFP Webworks

Revision history:

==========================================================================================================
]--->
</cfsilent>

<cfoutput>
<div class="content">
<legend>#request.pagename#</legend>
<form name="SiteTemplatesform" id="SiteTemplatesform" class="form-horizontal" role="form" action="#cgi.SCRIPT_NAME#" method="post" >
	<cfif (isdefined("errorhandler") AND  (errorhandler.haserrors()))>
     <div class="alert alert-danger alert-white rounded">
                <button type="button" class="close" data-dismiss="danger" aria-hidden="true">×</button>
                <div class="icon"><i class="fa fa-warning"></i></div>
                <strong>Error!</strong> #errorhandler.MakeErrorDisplay( errorhandler )#<br>
      </div>
	


	<input type="hidden" name="AddedBy" value="#SiteTemplate.getAddedBy()#" /><input type="hidden" name="DateAdded" value="#SiteTemplate.getDateAdded()#" /><input type="hidden" name="DateUpdated" value="#SiteTemplate.getDateUpdated()#" /><input type="hidden" name="IsVisible" value="#SiteTemplate.getIsVisible()#" />
<div class="form-group">
     <label for="SiteTemplateID">SiteTemplateID</label>
       <input type="number" class="form-control" id="SiteTemplateID" name="SiteTemplateID"  placeholder="SiteTemplateID" required  value="#SiteTemplate.getSiteTemplateID()#" >
 </div>

<div class="form-group">
     <label for="TemplateName">TemplateName</label>
         <input type="text" class="form-control" id="TemplateName"  name="TemplateName" placeholder="TemplateName"  maxlength="512"  value="#SiteTemplate.getTemplateName()#" >
 </div>
<input type="hidden" name="UpdatedBy" value="#SiteTemplate.getUpdatedBy()#" /> 
<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" name="submit" id="submit" class="btn btn-primary">Submit</button>
    </div>
  </div>
</form>
</div> <!---/end content div ---->
</cfoutput>