<cfsilent>
<!----[
==========================================================================================================
Filename:      form_Content.cfm
Description:   Form for  handling Content Requires a bean called Content to exist already. 
				Form format is for use with Twitter Bootstrap v2.0
Client:        Therapy OZ Admin                
Date:          18/October/2015 
Author:        Michael Kear,  AFP Webworks

Revision history:

==========================================================================================================
]--->
</cfsilent>

<cfoutput>
<div class="content">
<legend>#request.pagename#</legend>
<form name="Contentform" id="Contentform" class="form-horizontal" role="form" action="#cgi.SCRIPT_NAME#" method="post" >
	<cfif (isdefined("errorhandler") AND  (errorhandler.haserrors()))>
     <div class="alert alert-danger alert-white rounded">
                <button type="button" class="close" data-dismiss="danger" aria-hidden="true">×</button>
                <div class="icon"><i class="fa fa-warning"></i></div>
                <strong>Error!</strong> #errorhandler.MakeErrorDisplay( errorhandler )#<br>
      </div>
	


	
<div class="form-group">
     <label for="Accesslevel">Accesslevel</label>
       <input type="number" class="form-control" id="Accesslevel" name="Accesslevel"  placeholder="Accesslevel"  value="#Content.getAccesslevel()#" >
 </div>
<input type="hidden" name="AddedBy" value="#Content.getAddedBy()#" />
<div class="form-group">
     <label for="ApproveLevel">ApproveLevel</label>
       <input type="number" class="form-control" id="ApproveLevel" name="ApproveLevel"  placeholder="ApproveLevel"  value="#Content.getApproveLevel()#" >
 </div>

<div class="form-group">
     <label for="ContentFilename">ContentFilename</label>
         <input type="text" class="form-control" id="ContentFilename"  name="ContentFilename" placeholder="ContentFilename"  maxlength="256"  value="#Content.getContentFilename()#" >
 </div>

<div class="form-group">
     <label for="ContentID">ContentID</label>
       <input type="number" class="form-control" id="ContentID" name="ContentID"  placeholder="ContentID" required  value="#Content.getContentID()#" >
 </div>

<div class="form-group">
     <label for="ContentTemplate">ContentTemplate</label>
         <input type="text" class="form-control" id="ContentTemplate"  name="ContentTemplate" placeholder="ContentTemplate"  maxlength="50"  value="#Content.getContentTemplate()#" >
 </div>
<input type="hidden" name="DateAdded" value="#Content.getDateAdded()#" />
<div class="form-group">
     <label for="DateExpires">DateExpires</label>
       <input type="date" class="form-control" id="DateExpires" name="DateExpires"  placeholder="DateExpires"  value="#Content.getDateExpires()#" >
     </div>
 </div>
<input type="hidden" name="DateUpdated" value="#Content.getDateUpdated()#" />
<div class="form-group">
     <label for="EditLevel">EditLevel</label>
       <input type="number" class="form-control" id="EditLevel" name="EditLevel"  placeholder="EditLevel"  value="#Content.getEditLevel()#" >
 </div>
<div class="form-group">
     <label for="EmbargoDate">EmbargoDate</label>
       <input type="date" class="form-control" id="EmbargoDate" name="EmbargoDate"  placeholder="EmbargoDate"  value="#Content.getEmbargoDate()#" >
     </div>
 </div>

 <div class="radio">
   <label>
     <input type="radio" name="Embargoed" id="Embargoed1" value="1" <cfif #variables.bean.getEmbargoed()# eq "1"> Checked</cfif>>
    Yes
   </label>
 </div>
 <div class="radio">
   <label>
     <input type="radio" name="Embargoed" id="Embargoed2" value="0" <cfif #variables.bean.getEmbargoed()# eq "0"> Checked</cfif>>
    No
   </label>
 </div>

 <div class="radio">
   <label>
     <input type="radio" name="Expires" id="Expires1" value="1" <cfif #variables.bean.getExpires()# eq "1"> Checked</cfif>>
    Yes
   </label>
 </div>
 <div class="radio">
   <label>
     <input type="radio" name="Expires" id="Expires2" value="0" <cfif #variables.bean.getExpires()# eq "0"> Checked</cfif>>
    No
   </label>
 </div>

<div class="form-group">
     <label for="Headilne">Headilne</label>
         <input type="text" class="form-control" id="Headilne"  name="Headilne" placeholder="Headilne"  maxlength="256"  value="#Content.getHeadilne()#" >
 </div>

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
     <label for="PageID">PageID</label>
       <input type="number" class="form-control" id="PageID" name="PageID"  placeholder="PageID"  value="#Content.getPageID()#" >
 </div>

<div class="form-group">
     <label for="SiteNo">SiteNo</label>
       <input type="number" class="form-control" id="SiteNo" name="SiteNo"  placeholder="SiteNo"  value="#Content.getSiteNo()#" >
 </div>

<div class="form-group">
     <label for="SortCode">SortCode</label>
       <input type="number" class="form-control" id="SortCode" name="SortCode"  placeholder="SortCode"  value="#Content.getSortCode()#" >
 </div>
<input type="hidden" name="Updatedby" value="#Content.getUpdatedby()#" />
<div class="form-group">
     <label for="UserGroupID">UserGroupID</label>
       <input type="number" class="form-control" id="UserGroupID" name="UserGroupID"  placeholder="UserGroupID"  value="#Content.getUserGroupID()#" >
 </div>

<div class="form-group">
     <label for="Version">Version</label>
       <input type="number" class="form-control" id="Version" name="Version"  placeholder="Version" required  value="#Content.getVersion()#" >
 </div>
 
<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" name="submit" id="submit" class="btn btn-primary">Submit</button>
    </div>
  </div>
</form>
</div> <!---/end content div ---->
</cfoutput>
