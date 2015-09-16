<cfcomponent displayname="ConfigBean" output="false" hint="A configuration bean that reads XML config file and sets the Application scope.">
<cfsilent>
<!----
=======================================================================
Filename:       ConfigBean.cfc
Description:    A configuration bean that reads XML config file and sets the Application scope.
Client:            Therapy Oz Sales Site
Author:          Michael Kear, AFP Webworks 
Date:             7/Jul/2015
=======================================================================
This bean was generated with the following template:
Bean Name: ConfigBean
Extends: 
Call super.init(): false
Global variables:
	pageincrement numeric 7
	AddNewContentAt string bottom
	AddNewPageAt string top
	minaccesslevelEdit numeric 20
	minaccesslevelApprove numeric 90
	hometimezone string Australia/Sydney
Bean Template:
	sitename string TherapyOz
	dsn string therapyoz
	bansdsn string HawkesburyRadioCMS
	mailserver string mail.therapyoz.com
	mailuser string webmaster@therapyoz.com
	mailpassword string 407$)&fhgFHG
	sitemailindex string [TherapyOzSales]
	webmasteremail string mkear@therapyoz.com
	siteURL string http://therapyoz.com
Create getSnapshot method: true
Create validate method: false
Create validate interior: false
Date Format: DD/MM/YYYY
--->
</cfsilent>
	<!---[	PROPERTIES	]--->
	<cfset variables.instance = StructNew() />

	<!---[ 	INITIALIZATION / CONFIGURATION	]--->
	<cffunction name="init" access="public" returntype="ConfigBean" output="false">
	       <cfargument name="argsConfigXMLname" type="string" required="yes" />
		   <cfargument name="TimezoneCFC" type="any" required="yes" />
   <!---[ Global variable arguments  ]---> 
		<cfargument name="pageincrement" type="numeric" required="false" default="7" />
		<cfargument name="AddNewContentAt" type="string" required="false" default="bottom" />
		<cfargument name="AddNewPageAt" type="string" required="false" default="top" />
		<cfargument name="minaccesslevelEdit" type="numeric" required="false" default="20" />
		<cfargument name="minaccesslevelApprove" type="numeric" required="false" default="90" />
		<cfargument name="hometimezone" type="string" required="false" default="Australia/Sydney" />
   <!---[ Siteversion-specific variable arguments  ]---> 
		<cfargument name="sitename" type="string" required="false" default="TherapyOz" />
		<cfargument name="dsn" type="string" required="false" default="therapyoz" />
		<cfargument name="bansdsn" type="string" required="false" default="HawkesburyRadioCMS" />
		<cfargument name="mailserver" type="string" required="false" default="mail.therapyoz.com" />
		<cfargument name="mailuser" type="string" required="false" default="webmaster@therapyoz.com" />
		<cfargument name="mailpassword" type="string" required="false" default="407$)&fhgFHG" />
		<cfargument name="sitemailindex" type="string" required="false" default="[TherapyOzSales]" />
		<cfargument name="webmasteremail" type="string" required="false" default="mkear@therapyoz.com" />
		<cfargument name="siteURL" type="string" required="false" default="http://therapyoz.com" />
		<cfargument name="timezone" type="any" required="false" default="cfcs.utilities.TimeZone" />
		<cfset var siteversion = application.siteversion />
			<cffile action="read" 
					file="#expandPath(arguments.argsConfigXMLname)#"	
					variable="rawconfigXML"/>
			<cfset configXML = xmlparse(rawconfigXML) />	
		<cfscript>
          	    // set the base paths and ABS paths 
                  thisapprootABS = "#ExpandPath( "/" )#"; 
	            // Remove the trailing slash from the ABS paths   
                  thisapprootABS = left(thisapprootABS, (len(thisapprootABS)-1) );
          		// set base paths
          		setApprootURL("http://" &  cgi.http_host  );
          		setApprootABS(thisapprootABS);
          		setCMSABS( thisapprootABS & "cms"    ) ;	
          		setCMSURL( "http://" & cgi.http_host & "/cms"   );	

               // run globals setters
			setPageincrement(configXML.settings.globals.pageincrement.xmltext);
			setAddNewContentAt(configXML.settings.globals.AddNewContentAt.xmltext);
			setAddNewPageAt(configXML.settings.globals.AddNewPageAt.xmltext);
			setMinaccesslevelEdit(configXML.settings.globals.minaccesslevelEdit.xmltext);
			setMinaccesslevelApprove(configXML.settings.globals.minaccesslevelApprove.xmltext);
			setHometimezone(configXML.settings.globals.hometimezone.xmltext);

               // run other setters
			setSitename(configXML.settings[#siteversion#].sitename.xmltext);
			setDsn(configXML.settings[#siteversion#].dsn.xmltext);
			setBansdsn(configXML.settings[#siteversion#].bansdsn.xmltext);
			setMailserver(configXML.settings[#siteversion#].mailserver.xmltext);
			setMailuser(configXML.settings[#siteversion#].mailuser.xmltext);
			setMailpassword(configXML.settings[#siteversion#].mailpassword.xmltext);
			setSitemailindex(configXML.settings[#siteversion#].sitemailindex.xmltext);
			setWebmasteremail(configXML.settings[#siteversion#].webmasteremail.xmltext);
			setSiteURL(configXML.settings[#siteversion#].siteURL.xmltext);
			setTimezone(arguments.TimezoneCFC);
			return this;
		</cfscript>
 	</cffunction>

	<!---[ 	PUBLIC FUNCTIONS 	]--->
	<cffunction name="getSnapshot" access="public"returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<!---[ 	ACCESSORS 	  ]--->

   <!-----[   Global accessors   ] ---->  

	<cffunction name="setPageincrement" access="public" returntype="void" output="false">
		<cfargument name="pageincrement" type="numeric" required="true" />
		<cfset variables.instance.pageincrement = arguments.pageincrement />
		<cfset application.pageincrement = arguments.pageincrement />
	</cffunction>
	<cffunction name="getPageincrement" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.pageincrement />
	</cffunction>

	<cffunction name="setAddNewContentAt" access="public" returntype="void" output="false">
		<cfargument name="AddNewContentAt" type="string" required="true" />
		<cfset variables.instance.AddNewContentAt = arguments.AddNewContentAt />
		<cfset application.AddNewContentAt = arguments.AddNewContentAt />
	</cffunction>
	<cffunction name="getAddNewContentAt" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AddNewContentAt />
	</cffunction>

	<cffunction name="setAddNewPageAt" access="public" returntype="void" output="false">
		<cfargument name="AddNewPageAt" type="string" required="true" />
		<cfset variables.instance.AddNewPageAt = arguments.AddNewPageAt />
		<cfset application.AddNewPageAt = arguments.AddNewPageAt />
	</cffunction>
	<cffunction name="getAddNewPageAt" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AddNewPageAt />
	</cffunction>

	<cffunction name="setMinaccesslevelEdit" access="public" returntype="void" output="false">
		<cfargument name="minaccesslevelEdit" type="numeric" required="true" />
		<cfset variables.instance.minaccesslevelEdit = arguments.minaccesslevelEdit />
		<cfset application.minaccesslevelEdit = arguments.minaccesslevelEdit />
	</cffunction>
	<cffunction name="getMinaccesslevelEdit" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.minaccesslevelEdit />
	</cffunction>

	<cffunction name="setMinaccesslevelApprove" access="public" returntype="void" output="false">
		<cfargument name="minaccesslevelApprove" type="numeric" required="true" />
		<cfset variables.instance.minaccesslevelApprove = arguments.minaccesslevelApprove />
		<cfset application.minaccesslevelApprove = arguments.minaccesslevelApprove />
	</cffunction>
	<cffunction name="getMinaccesslevelApprove" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.minaccesslevelApprove />
	</cffunction>

	<cffunction name="setHometimezone" access="public" returntype="void" output="false">
		<cfargument name="hometimezone" type="string" required="true" />
		<cfset variables.instance.hometimezone = arguments.hometimezone />
		<cfset application.hometimezone = arguments.hometimezone />
	</cffunction>
	<cffunction name="getHometimezone" access="public" returntype="string" output="false">
		<cfreturn variables.instance.hometimezone />
	</cffunction>


   <!-----[   Siteversion specific accessors   ] ---->  

	<cffunction name="setSitename" access="public" returntype="void" output="false">
		<cfargument name="sitename" type="string" required="true" />
		<cfset variables.instance.sitename = arguments.sitename />
		<cfset application.sitename = arguments.sitename />
	</cffunction>
	<cffunction name="getSitename" access="public" returntype="string" output="false">
		<cfreturn variables.instance.sitename />
	</cffunction>

	<cffunction name="setDsn" access="public" returntype="void" output="false">
		<cfargument name="dsn" type="string" required="true" />
		<cfset variables.instance.dsn = arguments.dsn />
		<cfset application.dsn = arguments.dsn />
	</cffunction>
	<cffunction name="getDsn" access="public" returntype="string" output="false">
		<cfreturn variables.instance.dsn />
	</cffunction>

	<cffunction name="setBansdsn" access="public" returntype="void" output="false">
		<cfargument name="bansdsn" type="string" required="true" />
		<cfset variables.instance.bansdsn = arguments.bansdsn />
		<cfset application.bansdsn = arguments.bansdsn />
	</cffunction>
	<cffunction name="getBansdsn" access="public" returntype="string" output="false">
		<cfreturn variables.instance.bansdsn />
	</cffunction>

	<cffunction name="setMailserver" access="public" returntype="void" output="false">
		<cfargument name="mailserver" type="string" required="true" />
		<cfset variables.instance.mailserver = arguments.mailserver />
		<cfset application.mailserver = arguments.mailserver />
	</cffunction>
	<cffunction name="getMailserver" access="public" returntype="string" output="false">
		<cfreturn variables.instance.mailserver />
	</cffunction>

	<cffunction name="setMailuser" access="public" returntype="void" output="false">
		<cfargument name="mailuser" type="string" required="true" />
		<cfset variables.instance.mailuser = arguments.mailuser />
		<cfset application.mailuser = arguments.mailuser />
	</cffunction>
	<cffunction name="getMailuser" access="public" returntype="string" output="false">
		<cfreturn variables.instance.mailuser />
	</cffunction>

	<cffunction name="setMailpassword" access="public" returntype="void" output="false">
		<cfargument name="mailpassword" type="string" required="true" />
		<cfset variables.instance.mailpassword = arguments.mailpassword />
		<cfset application.mailpassword = arguments.mailpassword />
	</cffunction>
	<cffunction name="getMailpassword" access="public" returntype="string" output="false">
		<cfreturn variables.instance.mailpassword />
	</cffunction>

	<cffunction name="setSitemailindex" access="public" returntype="void" output="false">
		<cfargument name="sitemailindex" type="string" required="true" />
		<cfset variables.instance.sitemailindex = arguments.sitemailindex />
		<cfset application.sitemailindex = arguments.sitemailindex />
	</cffunction>
	<cffunction name="getSitemailindex" access="public" returntype="string" output="false">
		<cfreturn variables.instance.sitemailindex />
	</cffunction>

	<cffunction name="setWebmasteremail" access="public" returntype="void" output="false">
		<cfargument name="webmasteremail" type="string" required="true" />
		<cfset variables.instance.webmasteremail = arguments.webmasteremail />
		<cfset application.webmasteremail = arguments.webmasteremail />
	</cffunction>
	<cffunction name="getWebmasteremail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.webmasteremail />
	</cffunction>

	<cffunction name="setSiteURL" access="public" returntype="void" output="false">
		<cfargument name="siteURL" type="string" required="true" />
		<cfset variables.instance.siteURL = arguments.siteURL />
		<cfset application.siteURL = arguments.siteURL />
	</cffunction>
	<cffunction name="getSiteURL" access="public" returntype="string" output="false">
		<cfreturn variables.instance.siteURL />
	</cffunction>

	<cffunction name="setApprootURL" access="public" returntype="void" output="false">
		<cfargument name="ApprootURL" type="any" required="true" />
		<cfset variables.instance.ApprootURL = arguments.ApprootURL />
		<cfset application.ApprootURL = arguments.ApprootURL />
	</cffunction>
	<cffunction name="getApprootURL" access="public" returntype="any" output="false">
		<cfreturn variables.instance.ApprootURL />
	</cffunction> 

	<cffunction name="setApprootABS" access="public" returntype="void" output="false">
		<cfargument name="ApprootABS" type="any" required="true" />
		<cfset variables.instance.ApprootABS = arguments.ApprootABS />
		<cfset application.ApprootABS = arguments.ApprootABS />
	</cffunction>
	<cffunction name="getApprootABS" access="public" returntype="any" output="false">
		<cfreturn variables.instance.ApprootABS />
	</cffunction> 

	<cffunction name="setCMSABS" access="public" returntype="void" output="false">
		<cfargument name="CMSABS" type="any" required="true" />
		<cfset variables.instance.CMSABS = arguments.CMSABS />
		<cfset application.CMSABS = arguments.CMSABS />
	</cffunction>
	<cffunction name="getCMSABS" access="public" returntype="any" output="false">
		<cfreturn variables.instance.CMSABS />
	</cffunction> 

	<cffunction name="setCMSURL" access="public" returntype="void" output="false">
		<cfargument name="CMSURL" type="any" required="true" />
		<cfset variables.instance.CMSURL = arguments.CMSURL />
		<cfset application.CMSURL = arguments.CMSURL />
	</cffunction>
	<cffunction name="getCMSURL" access="public" returntype="any" output="false">
		<cfreturn variables.instance.CMSURL />
	</cffunction> 


	<cffunction name="setTimezone" access="public" returntype="void" output="false">
		<cfargument name="timezone" type="any" required="true" />
		<cfset variables.instance.timezone = arguments.timezone />
	</cffunction>
	<cffunction name="getTimezone" access="public" returntype="any" output="false">
		<cfreturn variables.instance.timezone />
	</cffunction> 

	<cffunction name="getAustime" access="public" returntype="any" output="no" hint="returns the current time (i.e. Australian time) in the local time zone">
		<cfreturn	getTimezone().castFromServer(now(),gethometimezone() ) />
	</cffunction>

</cfcomponent>