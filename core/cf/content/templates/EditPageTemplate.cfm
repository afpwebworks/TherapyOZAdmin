<cfsilent>
<!----
==========================================================================================================
Filename:    EditPageTemplate.cfm
Description: Page for handling the edit and add of data for PageTemplate data.  Requires Coldspring 1.0
Client:      Therapy OZ Admin
Date:        17/Oct/2015
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->

<!----[  Initialise the form for adds:  ]----->
<cfset PageTemplate = application.beanfactory.getBean("PageTemplate") />
<cfset PageTemplatesDAO =   application.beanfactory.getBean("PageTemplatesDAO") />

<cfif isdefined("url.PageTemplateID")>
   <cfset PageTemplate.setPageTemplateID(PageTemplateID) />
   <cfset PageTemplatesDAO.read(PageTemplate) />
</cfif>


<!----[  Process the form if it is submitted:  ]----->
<cfif isdefined("form.submit")>
	<cfset errorhandler = application.beanfactory.getBean("ErrorHandler") />
   <cfscript>
     //transfer form values to the bean
    PageTemplate.setpagetemplatedescription(trim(form.pagetemplatedescription));
     PageTemplate.setpagetemplateextradescription(trim(form.pagetemplateextradescription));
     PageTemplate.setisvisible(trim(form.isvisible));
     PageTemplate.setdateadded(trim(form.dateadded));
     PageTemplate.setaddedby(trim(form.addedby));
     PageTemplate.setdateupdated(trim(form.dateupdated));
     PageTemplate.setupdatedby(trim(form.updatedby));
     
     
   </cfscript>
   <cfset PageTemplate.validate(errorhandler) />   
	<cfif NOT(errorhandler.haserrors())>
		<cfset PageTemplatesDAO.save(PageTemplate) />
		<cflocation addtoken="no"  url="/index.cfm" />
		<cfabort> 
	</cfif>
</cfif>	
</cfsilent>
<cfinclude template="/Includes/Content/header.cfm" />
<cfinclude template="/Includes/form_PageTemplate.cfm" />
<cfinclude template="/Includes/Content/footer.cfm" />