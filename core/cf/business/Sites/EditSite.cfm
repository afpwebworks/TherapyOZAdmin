<cfsilent>
<!----
==========================================================================================================
Filename:    EditSite.cfm
Description: Page for handling the edit and add of data for Site data.  Requires Coldspring 1.0
Client:      Therapy Oz Admin Site
Date:        23/Sep/2015
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->

<!----[  Initialise the form for adds:  ]----->
<cfscript>
Site = application.beanfactory.getBean("Site");
SitesDAO =   application.beanfactory.getBean("SitesDAO") ;
Site.setSiteID( session.user.getSiteID() ) ;

</cfscript>



<!----[  Process the form if it is submitted:  ]----->
<cfif isdefined("form.submit")>
	<cfset errorhandler = application.beanfactory.getBean("ErrorHandler") />
   <cfscript>
     //transfer form values to the bean
    Site.setsitename(trim(form.sitename));
     Site.setcustomerid(trim(form.customerid));
     Site.setsitetemplateid(trim(form.sitetemplateid));
     Site.setdateadded(trim(form.dateadded));
     Site.setaddedby(trim(form.addedby));
     Site.setdateupdated(trim(form.dateupdated));
     Site.setupdatedby(trim(form.updatedby));
     Site.setlive(trim(form.live));
     Site.setisvisible(trim(form.isvisible));
     Site.setversion(trim(form.version));
     
     
   </cfscript>
   <cfset Site.validate(errorhandler) />   
	<cfif NOT(errorhandler.haserrors())>
		<cfset SitesDAO.save(Site) />
		<cflocation addtoken="no"  url="/core/cf/business/admin/index.cfm" />
		<cfabort> 
	</cfif>
</cfif>	
</cfsilent>
<cfinclude template="/Includes/adminheader.cfm" />
 <cfset SitesDAO.read(Site) />
        
<p>On this page you maintain the base settings of your site. </p>


<cfinclude template="/core/cf/business/sites/form_Site.cfm" />
<cfinclude template="/Includes/adminfooter.cfm" />
