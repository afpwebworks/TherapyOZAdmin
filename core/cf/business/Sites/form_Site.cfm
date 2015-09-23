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
</cfsilent>

<cfoutput>
<div class="content">
<legend>#request.pagename#</legend>
<form name="Sitesform" id="Sitesform" class="form-horizontal" role="form" action="#cgi.SCRIPT_NAME#" method="post" >
	<cfif (isdefined("errorhandler") AND  (errorhandler.haserrors()))>
     <div class="alert alert-danger alert-white rounded">
                <button type="button" class="close" data-dismiss="danger" aria-hidden="true">×</button>
                <div class="icon"><i class="fa fa-warning"></i></div>
                <strong>Error!</strong> #errorhandler.MakeErrorDisplay( errorhandler )#<br>
      </div>
	


	<input type="hidden" name="Addedby" value="#Site.getAddedby()#" />
<div class="form-group">
     <label for="CustomerID" class="col-sm-2 control-label">CustomerID</label>
     <div class="col-sm-10">
       <input type="number" class="form-control" id="CustomerID" placeholder="CustomerID"  value="#Site.getCustomerID()#" >
     </div>
 </div>
<input type="hidden" name="Dateadded" value="#Site.getDateadded()#" /><input type="hidden" name="Dateupdated" value="#Site.getDateupdated()#" /><input type="hidden" name="IsVisible" value="#Site.getIsVisible()#" />
 <div class="radio">
   <label>
     <input type="radio" name="Live" id="Live1" value="1" <cfif #variables.bean.getLive()# eq "1"> Checked</cfif>>
    Yes
   </label>
 </div>
 <div class="radio">
   <label>
     <input type="radio" name="Live" id="Live2" value="0" <cfif #variables.bean.getLive()# eq "0"> Checked</cfif>>
    No
   </label>
 </div>

<div class="form-group">
     <label for="SiteID" class="col-sm-2 control-label">SiteID</label>
     <div class="col-sm-10">
       <input type="number" class="form-control" id="SiteID" placeholder="SiteID" required  value="#Site.getSiteID()#" >
     </div>
 </div>

<div class="form-group">
     <label for="Sitename" class="col-sm-2 control-label">Sitename</label>
     <div class="col-sm-10">
       <input type="text" class="form-control" id="Sitename" placeholder="Sitename"  maxlength="512"  value="#Site.getSitename()#" >
     </div>
 </div>

<div class="form-group">
     <label for="SiteTemplateID" class="col-sm-2 control-label">SiteTemplateID</label>
     <div class="col-sm-10">
       <input type="number" class="form-control" id="SiteTemplateID" placeholder="SiteTemplateID"  value="#Site.getSiteTemplateID()#" >
     </div>
 </div>
<input type="hidden" name="Updatedby" value="#Site.getUpdatedby()#" />
<div class="form-group">
     <label for="Version" class="col-sm-2 control-label">Version</label>
     <div class="col-sm-10">
       <input type="number" class="form-control" id="Version" placeholder="Version" required  value="#Site.getVersion()#" >
     </div>
 </div>
 
<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" name="submit" id="submit" class="btn btn-primary">Submit</button>
    </div>
  </div>
</form>
</div> <!---/end content div ---->
</cfoutput>
