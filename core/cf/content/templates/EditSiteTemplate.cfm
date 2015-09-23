<cfsilent>
<!----
==========================================================================================================
Filename:    EditSiteTemplate.cfm
Description: Page for handling the edit and add of data for SiteTemplate data.  Requires Coldspring 1.0
Date:        23/Sep/2015
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->

<!----[  Initialise the form for adds:  ]----->
<cfset SiteTemplate = application.beanfactory.getBean("SiteTemplate") />
<cfset SiteTemplatesDAO =   application.beanfactory.getBean("SiteTemplatesDAO") />

<cfif isdefined("url.SiteTemplateID")>
   <cfset SiteTemplate.setSiteTemplateID(SiteTemplateID) />
   <cfset SiteTemplatesDAO.read(SiteTemplate) />
</cfif>


<!----[  Process the form if it is submitted:  ]----->
<cfif isdefined("form.submit")>
	<cfset errorhandler = application.beanfactory.getBean("ErrorHandler") />
   <cfscript>
     //transfer form values to the bean
    SiteTemplate.settemplatename(trim(form.templatename));
     SiteTemplate.setisvisible(trim(form.isvisible));
     SiteTemplate.setdateadded(trim(form.dateadded));
     SiteTemplate.setaddedby(trim(form.addedby));
     SiteTemplate.setdateupdated(trim(form.dateupdated));
     SiteTemplate.setupdatedby(trim(form.updatedby));
     
     
   </cfscript>
   <cfset SiteTemplate.validate(errorhandler) />   
	<cfif NOT(errorhandler.haserrors())>
		<cfset SiteTemplatesDAO.save(SiteTemplate) />
		<cflocation addtoken="no"  url="/core/cf/content/templates/index.cfm" />
		<cfabort> 
	</cfif>
</cfif>	
</cfsilent>
<cfinclude template="/Includes/adminheader.cfm" />
<cfinclude template="/cf/content/templates/form_SiteTemplate.cfm" />
<cfinclude template="/Includes/adminfooter.cfm" />