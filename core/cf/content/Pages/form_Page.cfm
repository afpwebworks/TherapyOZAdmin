<cfsilent>
<!----[
==========================================================================================================
Filename:      form_Page.cfm
Description:   Form for  handling Pages Requires a bean called Page to exist already. 
				Form format is for use with Twitter Bootstrap v2.0
Client:        Therapy OZ Admin                
Date:          17/October/2015 
Author:        Michael Kear,  AFP Webworks

Revision history:

==========================================================================================================
]--->
<cfscript >
    SitePages = application.beanfactory.getbean("Treelibrary").GetPagesForSite( session.user.getSiteID() ) ;
    PageTemplates = application.beanfactory.getbean("PageTemplatesDAO").GetAllPageTemplates();
</cfscript>
</cfsilent>

<cfoutput>
<div class="content">
<legend>#request.pagename#</legend>

<cfdump var="#page.getsnapshot()#" />
<form name="Pagesform" id="Pagesform" class="form-horizontal" role="form" action="#cgi.SCRIPT_NAME#" method="post" >
  <cfif (isdefined("errorhandler") AND  (errorhandler.haserrors()))>
    <div class="alert alert-danger alert-white rounded">
      <button type="button" class="close" data-dismiss="danger" aria-hidden="true">×</button>
      <div class="icon"><i class="fa fa-warning"></i></div>
      <strong>Error!</strong> #errorhandler.MakeErrorDisplay( errorhandler )#<br>
    </div>
  </cfif>
  <input type="hidden" name="DateUpdated" value="#Page.getDateUpdated()#" />
  <input type="hidden" name="AccessLevel" value="#Page.getAccessLevel()#" />
  <input type="hidden" name="ApprovedBy" value="#Page.getApprovedBy()#" />
  <input type="hidden" name="ApprovedDate" value="#Page.getApprovedDate()#" />
  <input type="hidden" name="ApproveLevel" value="#Page.getApproveLevel()#" />
  <input type="hidden" name="EditLevel" value="#Page.getEditLevel()#" />
  <input type="hidden" name="DateAdded" value="#Page.getDateAdded()#" />
  <input type="hidden" name="EditStatus" value="#Page.getEditStatus()#" />
  <input type="hidden" name="IsVisible" value="#Page.getIsVisible()#" />
  <input type="hidden" name="LockedForEdit" value="#Page.getLockedForEdit()#" />
  <input type="hidden" name="NodeRec" value="#Page.getNodeRec()#" />
  <input type="hidden" name="PageID" value="#Page.getPageID()#" />
  <input type="hidden" name="PageName" value="#Page.getPageName()#" />
  <input type="hidden" name="UpdatedBy" value="#Page.getUpdatedBy()#" />
  <input type="hidden" name="Version" value="#Page.getVersion()#" />
  <input type="hidden" name="Siteno" value="#Page.getSiteno()#" />
  <div class="form-group">
    <label for="Template">Page Template</label>
    <select class="form-control" name="Template" id="template">
      <cfloop query="PageTemplates">
      <option value="#PageTemplates.Pagetemplateid#" <cfif PageTemplates.PageTemplateID eq page.getTemplate()>Selected="Selected"</cfif>>#PageTemplates.PAGETEMPLATEDESCRIPTION#</option>
      </cfloop>
    </select>
  </div>
  
 <div class="form-group">
  	<label for="pageowner">Owner of this page</label>
  	<select name="pageowner" id="pageowner" class="form-control">
    	<cfloop query="SitePages">
        	<option value="#sitepages.pageid#" <cfif sitepages.pageid eq page.getowner()>selected="selected" </cfif>>#repeatstring('&nbsp;..&nbsp;', (level-1))##SitePages.PageTitle#</option>
        </cfloop>
    </select>
  </div> 
  
  <div class="form-group">
    <label for="PageTitle">Page Title</label>
    <input type="text" class="form-control" id="PageTitle"  name="PageTitle" placeholder="PageTitle" rquired maxlength="512" placholder="Page Title" value="#Page.getPageTitle()#" >
  </div>
  <div class="form-group">
    <label for="Keywords">Keywords</label>
    <br>
    <textarea name="Keywords" id="Keywords" class="form-control" placeholder="Keywords, for, the, search, engines"  cols="36">#Page.getKeywords()#</textarea>
  </div>
  <div class="form-group">
    <label for="Teaser">Teaser text</label>
    <p>This text will appear in search engine results, and should describe the contents of the page. (Max 1200 characters)</p>
    <textarea name="Teaser" id="Teaser "class="form-control" placeholder="A few sentences about this page.  (Max 1200 characters)"  cols="36">#Page.getTeaser()#</textarea>
  </div>
  <div class="form-group">
    <label for="DateExpires">
    Page Expires
    <p class="small">This page will not appear in the site after the date specified</p>
    <label>
      <input type="radio" name="Expires" id="Expires" value="1" <cfif page.getExpires()>Checked=""</cfif>>
      <i></i> Yes </label>
    <label>
      <input type="radio"  name="Expires"  id="Expires" value="0" checked="0" <cfif NOT page.getExpires()>Checked=""</cfif>>
      <i></i> No </label>
  </div>
  <input type="date" class="form-control" id="DateExpires" name="DateExpires"  placeholder="DateExpires"  value="#Page.getDateExpires()#" >
  <!----[  <div class="input-group date"> <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
    <input id="date_1"  type="text" class="form-control" value="03/04/2014">
  </div>  ]----MK ---->
  </label>
  </div>
  <div class="form-group">
    <label for="EmbargoDate">Page Embargoed</label>
    <p class="small">This page will not appear in the site until the date specified</p>
    <label>
      <input type="radio" name="Embargoed" id="Embargoed" value="1" <cfif page.getEmbargoed()>Checked=""</cfif>>
      <i></i> Yes </label>
    <label>
      <input type="radio"  name="Embargoed"  id="Embargoed" value="0"  <cfif NOT page.getEmbargoed()>Checked=""</cfif>>
      <i></i> No </label>
  </div>
  <div class="form-group"> </div>
  <input type="date" class="form-control" id="EmbargoDate" name="EmbargoDate"  placeholder="EmbargoDate" value="#Page.getEmbargoDate()#" >
  </div>
  
  
  <div class="form-group">
    <label for="Live">Page is Live</label>
    <p class="small">This page will appear in the site when it is set to LIVE=YES</p>
    <label>
      <input type="radio" name="Live" id="Live" value="1" <cfif page.getLive()>Checked=""</cfif>>
      <i></i> Yes </label>
    <label>
      <input type="radio"  name="Live"  id="Live" value="0"  <cfif NOT page.getLive()>Checked=""</cfif>>
      <i></i> No </label>
  </div>
  
  
  
  <div class="form-group">
    <button type="submit" name="submit" id="submit" class="btn btn-primary">Submit</button>
  </div>
</form>
</div>

<!---/end content div ----> 
</cfoutput>
