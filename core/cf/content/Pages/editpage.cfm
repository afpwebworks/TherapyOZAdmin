<cfsilent>
<!----
==========================================================================================================
Filename:    EditPage.cfm
Description: Page for handling the edit and add of data for Page data.  Requires Coldspring 1.0
Client:      Therapy OZ Admin
Date:        17/Oct/2015
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->

<!----[  Initialise the form for adds:  ]----->
<cfset Page = application.beanfactory.getBean("Page") />
<cfset TreeLibrary =   application.beanfactory.getBean("TreeLibrary") />

<cfif isdefined("url.PageID")>
   <cfset Page.setPageID(PageID) />
   <cfset TreeLibrary.read(Page) />
   <cfset treelibrary.LockPageForEdit( page ) />
   <cfset request.pagename = "Edit Page #page.GetPageName()#"/>
   <cfset action = "editpage" />
<cfelse>
	<cfset action="addpage"/>
    <cfset SitePages = application.beanfactory.getbean("Treelibrary").GetPagesForSite( session.user.getSiteID() ) />   
</cfif>


<!----[  Process the form if it is submitted:  ]----->
<cfif isdefined("form.submit")>
<!----[  <cfdump var="#form#" abort="true" />  ]----MK ---->
    
		<!----[  If the page already exists, set the page object to the correct pageid  ]----MK ---->
		<cfset Page.setPageID(  form.pageid ) />
    <cfif page.getpageid() eq '0'>
    	<!----[  Otherwise it's a new page .. so run the storedproc to create it.   ]----MK ---->    
        <cfquery name="addpage" datasource="#application.dsn#">
         exec usp_AddPage 
         <cfqueryparam value="#form.pageowner#" cfsqltype="cf_sql_integer"/>,
         <cfqueryparam value="#replace(form.pagetitle, ' ', '', "ALL")#" cfsqltype="cf_sql_varchar"/>, 
         <cfqueryparam value="#session.user.getSiteID()#" cfsqltype="cf_sql_integer" />
       </cfquery>
       	<cfset page.setPageID( addpage.pageid   ) />
    </cfif>

	<cfset errorhandler = application.beanfactory.getBean("ErrorHandler") />    
   <cfscript>
     //transfer form values to the bean
	  
		  //Remove any spaces from pagename
         Page.setpagename(trim(  replace(form.pagetitle, ' ', '', "ALL")   ));
         Page.setnoderec(trim(form.noderec));
         Page.setsiteno(trim(form.siteno));
         Page.settemplate(trim(form.template));
         Page.setteaser(trim(form.teaser));
         Page.setkeywords(trim(form.keywords));
         Page.setlive(trim(form.live));
         Page.setembargoed(trim(form.embargoed));
         Page.setexpires(trim(form.expires));
         Page.setaccesslevel(trim(form.accesslevel));
         Page.seteditlevel(trim(form.editlevel));
         Page.setapprovelevel(trim(form.approvelevel));
         Page.seteditstatus(trim( form.editstatus));
         Page.setapprovedby(trim(form.approvedby));
         Page.setapproveddate(trim(form.approveddate));
         Page.setdateupdated(trim(form.dateupdated));
         Page.setupdatedby(trim(form.updatedby));
         Page.setisvisible(trim(form.isvisible));
         Page.setpagetitle(trim(form.pagetitle));
         Page.setversion(trim(form.version));
        // clear the lockekd for edit status
        Treelibrary.UnLockPageForEdit( Page );
   </cfscript>
   <cfif isdate(form.embargodate) ><cfset Page.setembargodate(trim(form.embargodate)) ></cfif>
   <cfif isdate(form.dateexpires) ><cfset Page.setdateexpires(trim(form.dateexpires)) ></cfif>
      
   <cfset Page.validate(errorhandler) />   
	<cfif NOT(errorhandler.haserrors())>
		<cfset TreeLibrary.save(Page) />
		<cflocation addtoken="no"  url="/core/cf/content/pages/pagesindex.cfm" />
		<cfabort> 
	</cfif>
</cfif>	
</cfsilent>
<cfinclude template="/Includes/adminheader.cfm" />

<cfinclude template="/core/cf/content/pages/form_Page.cfm" />
<cfinclude template="/Includes/adminfooter.cfm" />
