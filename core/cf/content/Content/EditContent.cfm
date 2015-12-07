<cfsilent>
<!----
==========================================================================================================
Filename:    EditContent.cfm
Description: Page for handling the edit and add of data for Content data.  Requires Coldspring 1.0
Client:      Therapy OZ Admin
Date:        18/Oct/2015
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->

<!----[  Initialise the form for adds:  ]----->
<cfset Content = application.beanfactory.getBean("Content") />
<cfset ContentDAO =   application.beanfactory.getBean("ContentDAO") />

<cfif isdefined("url.ContentID")>
   <cfset Content.setContentID(ContentID) />
   <cfset ContentDAO.read(Content) />
</cfif>


<!----[  Process the form if it is submitted:  ]----->
<cfif isdefined("form.submit")>
	<cfset errorhandler = application.beanfactory.getBean("ErrorHandler") />
   <cfscript>
     //transfer form values to the bean
    Content.setheadilne(trim(form.headilne));
     Content.setsiteno(trim(form.siteno));
     Content.setpageid(trim(form.pageid));
     Content.setsortcode(trim(form.sortcode));
     Content.setcontenttemplate(trim(form.contenttemplate));
     Content.setcontentfilename(trim(form.contentfilename));
     Content.setaccesslevel(trim(form.accesslevel));
     Content.seteditlevel(trim(form.editlevel));
     Content.setapprovelevel(trim(form.approvelevel));
     Content.setlive(trim(form.live));
     Content.setusergroupid(trim(form.usergroupid));
     Content.setembargoed(trim(form.embargoed));
     Content.setembargodate(trim(form.embargodate));
     Content.setexpires(trim(form.expires));
     Content.setdateexpires(trim(form.dateexpires));
     Content.setversion(trim(form.version));
     Content.setdateadded(trim(form.dateadded));
     Content.setaddedby(trim(form.addedby));
     Content.setdateupdated(trim(form.dateupdated));
     Content.setupdatedby(trim(form.updatedby));
     
     
   </cfscript>
   <cfset Content.validate(errorhandler) />   
	<cfif NOT(errorhandler.haserrors())>
		<cfset ContentDAO.save(Content) />
		<cflocation addtoken="no"  url="/index.cfm" />
		<cfabort> 
	</cfif>
</cfif>	
</cfsilent>
<cfinclude template="/Includes/adminheader.cfm" />
<cfinclude template="/Includes/form_Content.cfm" />
<cfinclude template="/Includes/adminfooter.cfm" />