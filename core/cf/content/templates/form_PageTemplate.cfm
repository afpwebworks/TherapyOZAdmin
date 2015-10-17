<cfsilent>
<!----[
==========================================================================================================
Filename:      form_PageTemplate.cfm
Description:   Form for  handling PageTemplates Requires a bean called PageTemplate to exist already. 
				Form format is for use with Twitter Bootstrap v2.0
Client:        Therapy OZ Admin                
Date:          17/October/2015 
Author:        Michael Kear,  AFP Webworks

Revision history:

==========================================================================================================
]--->
</cfsilent>

<cfoutput>
<div class="content">
<legend>#request.pagename#</legend>
<form name="PageTemplatesform" id="PageTemplatesform" class="form-horizontal" role="form" action="#cgi.SCRIPT_NAME#" method="post" >
	<cfif (isdefined("errorhandler") AND  (errorhandler.haserrors()))>
     <div class="alert alert-danger alert-white rounded">
                <button type="button" class="close" data-dismiss="danger" aria-hidden="true">×</button>
                <div class="icon"><i class="fa fa-warning"></i></div>
                <strong>Error!</strong> #errorhandler.MakeErrorDisplay( errorhandler )#<br>
      </div>
	


	<input type="hidden" name="AddedBy" value="#PageTemplate.getAddedBy()#" /><input type="hidden" name="DateAdded" value="#PageTemplate.getDateAdded()#" /><input type="hidden" name="DateUPdated" value="#PageTemplate.getDateUPdated()#" /><input type="hidden" name="IsVisible" value="#PageTemplate.getIsVisible()#" />
<div class="form-group">
     <label for="PageTemplateDescription">PageTemplateDescription</label>
         <input type="text" class="form-control" id="PageTemplateDescription"  name="PageTemplateDescription" placeholder="PageTemplateDescription"  maxlength="256"  value="#PageTemplate.getPageTemplateDescription()#" >
 </div>

<div class="form-group">
     <label for="PageTemplateExtraDescription">PageTemplateExtraDescription</label>
         <input type="text" class="form-control" id="PageTemplateExtraDescription"  name="PageTemplateExtraDescription" placeholder="PageTemplateExtraDescription"  maxlength="1024"  value="#PageTemplate.getPageTemplateExtraDescription()#" >
 </div>

<div class="form-group">
     <label for="PageTemplateID">PageTemplateID</label>
       <input type="number" class="form-control" id="PageTemplateID" name="PageTemplateID"  placeholder="PageTemplateID" required  value="#PageTemplate.getPageTemplateID()#" >
 </div>
<input type="hidden" name="UpdatedBy" value="#PageTemplate.getUpdatedBy()#" /> 
<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" name="submit" id="submit" class="btn btn-primary">Submit</button>
    </div>
  </div>
</form>
</div> <!---/end content div ---->
</cfoutput>
