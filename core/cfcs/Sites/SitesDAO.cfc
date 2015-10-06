<cfcomponent displayname="Sites DAO" output="false" hint="DAO Component Handles all Database access for the table Sites.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    SitesDAO.cfc
Description: DAO Component Handles all Database access for the table Sites.  Requires Coldspring v1.0
Client:       Therapy Oz Admin Site
Date:        23/Sep/2015
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( Site.getsiteid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="SitesDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="core.config.configbean" />
<cfargument name="argsLog" required="true" type="any" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
    <cfset variables.Log = arguments.argsLog/>
	<cfreturn this />
</cffunction>

<cffunction name="setUserService" access="public" output="false" returntype="void" hint="Dependency: User Service">
	<cfargument name="UserService" type="any" required="true"/>
	<cfset variables.UserService = arguments.UserService/>
</cffunction>

<cffunction name="InitLog" access="public" output="false" returntype="any" hint="Initialise the Log Object">

    <cfscript>
	 var Log = 	variables.Log;
	 log.setSiteID(  variables.userservice.getUSer().getSiteID() );
	 Log.setUserID(  variables.userservice.getUser().getUserID() );
	 
	</cfscript>
	<cfset variables.Log = Log/>
    <cfreturn variables.log />
</cffunction>



<cffunction name="save" access="public" returntype="Site" output="false" hint="DAO method">
<cfargument name="Site" type="Site" required="yes" />
<!-----[  If a SiteID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.Site.getSiteID() neq "0")>	
		<cfset Site = update(arguments.Site)/>
	<cfelse>
		<cfset Site = create(arguments.Site)/>
	</cfif>
	<cfreturn Site />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="Site" type="Site" required="true" /> 
	<cfset var qSiteDelete = 0 >
<!-----[  to delete, set 'IsVisible' flag to zero  ]--->
		<cfquery name="qSiteDelete" datasource="#variables.dsn#" >
		UPDATE Sites
		Set IsVisible = '0'
		WHERE 
		SiteID = <cfqueryparam value="#Site.getSiteID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>	
     <!----[  Add a log entry that the user has logged in  ]----MK ---->
               <cfscript>
                  InitLog( variables.Log);
               	variables.log.setTablename( "Sites");
	variables.log.setComment( "Deleted the site");
	variables.log.setActivity( "Delete Site" );
                variables.log.setDateAdded( now() );
               </cfscript>
               <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
</cffunction>


<cffunction name="UnDelete" returntype="void" output="false" hint="DAO method" >
<cfargument name="Site" type="Site" required="true" /> 
	<cfset var qSiteUnDelete = 0 >
<!-----[  to UnDelete, set 'IsVisible' flag to 1 (true)  ]--->
		<cfquery name="qSiteDelete" datasource="#variables.dsn#" >
		UPDATE Sites
		Set IsVisible = '1'
		WHERE 
		SiteID = <cfqueryparam value="#Site.getSiteID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>	
     <!----[  Add a log entry that the user has logged in  ]----MK ---->
               <cfscript>
                  InitLog( variables.Log);
               	variables.log.setTablename( "Sites");
	variables.log.setComment( "Undeleted the site");
	variables.log.setActivity( "Undelete Site" );
                variables.log.setDateAdded( now() );
               </cfscript>
               <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
</cffunction>


<cffunction name="read" access="public" returntype="Site" output="false" hint="DAO Method. - Reads a Site into the bean">
<cfargument name="argsSite" type="Site" required="true" />
	<cfset var Site  =  arguments.argsSite />
	<cfset var QSitesselect = "" />
	<cfquery name="QSitesselect" datasource="#variables.dsn#">
		SELECT 
		SiteID, Sitename, CustomerID, SiteTemplateID, Dateadded, Addedby, Dateupdated, Updatedby, Live, IsVisible, Version
		FROM Sites 
		WHERE 
		IsVisible = '1' AND
        SiteID = <cfqueryparam value="#Site.getSiteID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QSitesselect.recordCount >
		<cfscript>
		Site.setSiteID(QSitesselect.SiteID);
         Site.setSitename(QSitesselect.Sitename);
         Site.setCustomerID(QSitesselect.CustomerID);
         Site.setSiteTemplateID(QSitesselect.SiteTemplateID);
         Site.setDateadded(QSitesselect.Dateadded);
         Site.setAddedby(QSitesselect.Addedby);
         Site.setDateupdated(QSitesselect.Dateupdated);
         Site.setUpdatedby(QSitesselect.Updatedby);
         Site.setLive(QSitesselect.Live);
         Site.setIsVisible(QSitesselect.IsVisible);
         Site.setVersion(QSitesselect.Version);
         
		</cfscript>
	</cfif>
	<cfreturn Site />
</cffunction>
		

<cffunction name="GetAllSites" access="public" output="false" returntype="query" hint="Returns a query of all Sites in our Database">
<cfset var QgetallSites = 0 />
	<cfquery name="QgetallSites" datasource="#variables.dsn#">
		SELECT SiteID, Sitename, CustomerID, SiteTemplateID, Dateadded, Addedby, Dateupdated, Updatedby, Live, IsVisible, Version
		FROM Sites 
		WHERE IsVisible = '1'
        
		ORDER BY SiteID
	</cfquery>
	<cfreturn QgetallSites />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="Site" output="false" hint="DAO method">
<cfargument name="argsSite" type="Site" required="yes" displayname="create" />
	<cfset var qSiteInsert = 0 />
	<cfset var Site = arguments.argsSite />
	
	<cfquery name="qSiteInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into Sites
		( Sitename, CustomerID, SiteTemplateID, Dateadded, Addedby, Dateupdated, Updatedby, Live, IsVisible, Version ) VALUES
		(

		<cfqueryparam value="#Site.getsitename()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Site.getcustomerid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#Site.getsitetemplateid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/> ,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/> ,
		<cfqueryparam value="#Site.getlive()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#Site.getisvisible()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#Site.getversion()#" cfsqltype="CF_SQL_INTEGER" />
		   ) 
		SELECT Ident_Current('Sites') as SiteID
		SET NOCOUNT OFF
	</cfquery>
	<cfset Site.setSiteID(qSiteInsert.SiteID)>
     <!----[  Add a log entry that the user has logged in  ]----MK ---->
               <cfscript>
                  InitLog( variables.Log);
               	variables.log.setTablename( "Sites");
				variables.log.setComment( "Created the site #site.getSitename()#");
				variables.log.setActivity( "Create" );
                variables.log.setDateAdded( now() );
               </cfscript>
               <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />

	<cfreturn Site />
</cffunction>

<cffunction name="update" access="private" returntype="Site" output="false" hint="DAO method">
<cfargument name="argsSite" type="Site" required="yes" />
	<cfset var Site = arguments.argsSite />
	<cfset var SiteUpdate = 0 >
	<cfquery name="SiteUpdate" datasource="#variables.dsn#" >
		UPDATE Sites SET
        sitename  = <cfqueryparam value="#Site.getSitename()#" cfsqltype="CF_SQL_VARCHAR"/>,
        customerid  = <cfqueryparam value="#Site.getCustomerID()#" cfsqltype="CF_SQL_INTEGER"/>,
        sitetemplateid  = <cfqueryparam value="#Site.getSiteTemplateID()#" cfsqltype="CF_SQL_INTEGER"/>,
        dateupdated  = <cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
        updatedby  = <cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/>,
        live  = <cfqueryparam value="#Site.getLive()#" cfsqltype="CF_SQL_BIT"/>,
        isvisible  = <cfqueryparam value="#Site.getIsVisible()#" cfsqltype="CF_SQL_BIT"/>,
        version  = <cfqueryparam value="#Site.getVersion()#" cfsqltype="CF_SQL_INTEGER"/>
						
		WHERE 
		SiteID = <cfqueryparam value="#Site.getSiteID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
	<!----[  Add a log entry that the user has logged in  ]----MK ---->
               <cfscript>
					InitLog( variables.Log);
					variables.log.setTablename( "Sites");
					variables.log.setComment( "Updated the details of the site #site.getSitename()#");
					variables.log.setActivity( "Update" );
					variables.log.setDateAdded( now() );
               </cfscript>
               <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
    
	<cfreturn Site />
</cffunction>

</cfcomponent>
