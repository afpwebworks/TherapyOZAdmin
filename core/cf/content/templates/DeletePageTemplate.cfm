<cfsilent>
<!----
==========================================================================================================
Filename:    DeletePageTemplate.cfm
Description: Deletes a PageTemplate from the database and returns the user to the originating page. Works with ColdSpring 1.0
Client:      Therapy OZ Admin
Date:        17/Oct/2015
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->


<cfif NOT(isdefined("url.PageTemplateID")) AND NOT(isdefined("form.submitpage"))>
	<cflocation addtoken="no" url="index.cfm" />
</cfif>
<cfset PageTemplate =  application.beanfactory.getBean("PageTemplate") />
<cfset PageTemplate.setPageTemplateID(PageTemplateID) />
<cfset PageTemplatesDAO = application.beanfactory.getBean("PageTemplatesDAO") />
<cfset PageTemplatesDAO.delete(PageTemplate) />
<cflocation addtoken="no" url="#cgi.HTTP_REFERER#" />
</cfsilent>
