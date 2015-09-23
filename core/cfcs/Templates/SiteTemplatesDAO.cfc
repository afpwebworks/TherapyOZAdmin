<cfcomponent displayname="SiteTemplates DAO" output="false" hint="DAO Component Handles all Database access for the table SiteTemplates.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    SiteTemplatesDAO.cfc
Description: DAO Component Handles all Database access for the table SiteTemplates.  Requires Coldspring v1.0
Date:        23/Sep/2015
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( SiteTemplate.getsitetemplateid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="SiteTemplatesDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="core.config.configbean" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
	<cfreturn this />
</cffunction>

<cffunction name="setUserService" access="public" output="false" returntype="void" hint="Dependency: User Service">
	<cfargument name="UserService" type="any" required="true"/>
	<cfset variables.UserService = arguments.UserService/>
</cffunction>


<cffunction name="save" access="public" returntype="SiteTemplate" output="false" hint="DAO method">
<cfargument name="SiteTemplate" type="SiteTemplate" required="yes" />
<!-----[  If a SiteTemplateID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.SiteTemplate.getSiteTemplateID() neq "0")>	
		<cfset SiteTemplate = update(arguments.SiteTemplate)/>
	<cfelse>
		<cfset SiteTemplate = create(arguments.SiteTemplate)/>
	</cfif>
	<cfreturn SiteTemplate />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="SiteTemplate" type="SiteTemplate" required="true" /> 
	<cfset var qSiteTemplateDelete = 0 >
<!-----[  to delete, set 'IsVisible' flag to zero  ]--->
		<cfquery name="qSiteTemplateDelete" datasource="#variables.dsn#" >
		UPDATE SiteTemplates
		Set IsVisible = '0'
		WHERE 
		SiteTemplateID = <cfqueryparam value="#SiteTemplate.getSiteTemplateID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>	
</cffunction>


<cffunction name="UnDelete" returntype="void" output="false" hint="DAO method" >
<cfargument name="SiteTemplate" type="SiteTemplate" required="true" /> 
	<cfset var qSiteTemplateUnDelete = 0 >
<!-----[  to UnDelete, set 'IsVisible' flag to 1 (true)  ]--->
		<cfquery name="qSiteTemplateDelete" datasource="#variables.dsn#" >
		UPDATE SiteTemplates
		Set IsVisible = '1'
		WHERE 
		SiteTemplateID = <cfqueryparam value="#SiteTemplate.getSiteTemplateID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>	
</cffunction>


<cffunction name="read" access="public" returntype="SiteTemplate" output="false" hint="DAO Method. - Reads a SiteTemplate into the bean">
<cfargument name="argsSiteTemplate" type="SiteTemplate" required="true" />
	<cfset var SiteTemplate  =  arguments.argsSiteTemplate />
	<cfset var QSiteTemplatesselect = "" />
	<cfquery name="QSiteTemplatesselect" datasource="#variables.dsn#">
		SELECT 
		SiteTemplateID, TemplateName, IsVisible, DateAdded, AddedBy, DateUpdated, UpdatedBy
		FROM SiteTemplates 
		WHERE 
		IsVisible = '1' ANDSiteTemplateID = <cfqueryparam value="#SiteTemplate.getSiteTemplateID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QSiteTemplatesselect.recordCount >
		<cfscript>
		SiteTemplate.setSiteTemplateID(QSiteTemplatesselect.SiteTemplateID);
         SiteTemplate.setTemplateName(QSiteTemplatesselect.TemplateName);
         SiteTemplate.setIsVisible(QSiteTemplatesselect.IsVisible);
         SiteTemplate.setDateAdded(QSiteTemplatesselect.DateAdded);
         SiteTemplate.setAddedBy(QSiteTemplatesselect.AddedBy);
         SiteTemplate.setDateUpdated(QSiteTemplatesselect.DateUpdated);
         SiteTemplate.setUpdatedBy(QSiteTemplatesselect.UpdatedBy);
         
		</cfscript>
	</cfif>
	<cfreturn SiteTemplate />
</cffunction>
		

<cffunction name="GetAllSiteTemplates" access="public" output="false" returntype="query" hint="Returns a query of all SiteTemplates in our Database">
<cfset var QgetallSiteTemplates = 0 />
	<cfquery name="QgetallSiteTemplates" datasource="#variables.dsn#">
		SELECT SiteTemplateID, TemplateName, IsVisible, DateAdded, AddedBy, DateUpdated, UpdatedBy
		FROM SiteTemplates 
		WHERE IsVisible = '1'
        
		ORDER BY SiteTemplateID
	</cfquery>
	<cfreturn QgetallSiteTemplates />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="SiteTemplate" output="false" hint="DAO method">
<cfargument name="argsSiteTemplate" type="SiteTemplate" required="yes" displayname="create" />
	<cfset var qSiteTemplateInsert = 0 />
	<cfset var SiteTemplate = arguments.argsSiteTemplate />
	
	<cfquery name="qSiteTemplateInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into SiteTemplates
		( TemplateName, IsVisible, DateAdded, AddedBy, DateUpdated, UpdatedBy ) VALUES
		(

		<cfqueryparam value="#SiteTemplate.gettemplatename()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#SiteTemplate.getisvisible()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/> ,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/> 
		   ) 
		SELECT Ident_Current('SiteTemplates') as SiteTemplateID
		SET NOCOUNT OFF
	</cfquery>
	<cfset SiteTemplate.setSiteTemplateID(qSiteTemplateInsert.SiteTemplateID)>

	<cfreturn SiteTemplate />
</cffunction>

<cffunction name="update" access="private" returntype="SiteTemplate" output="false" hint="DAO method">
<cfargument name="argsSiteTemplate" type="SiteTemplate" required="yes" />
	<cfset var SiteTemplate = arguments.argsSiteTemplate />
	<cfset var SiteTemplateUpdate = 0 >
	<cfquery name="SiteTemplateUpdate" datasource="#variables.dsn#" >
		UPDATE SiteTemplates SET
templatename  = <cfqueryparam value="#SiteTemplate.getTemplateName()#" cfsqltype="CF_SQL_VARCHAR"/>,
isvisible  = <cfqueryparam value="#SiteTemplate.getIsVisible()#" cfsqltype="CF_SQL_BIT"/>,
dateupdated  = <cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
updatedby  = <cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/>
						
		WHERE 
		SiteTemplateID = <cfqueryparam value="#SiteTemplate.getSiteTemplateID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
	
	<cfreturn SiteTemplate />
</cffunction>

</cfcomponent>
