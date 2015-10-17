<cfcomponent displayname="PageTemplates DAO" output="false" hint="DAO Component Handles all Database access for the table PageTemplates.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    PageTemplatesDAO.cfc
Description: DAO Component Handles all Database access for the table PageTemplates.  Requires Coldspring v1.0
Client:      Therapy OZ Admin
Date:        17/Oct/2015
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( PageTemplate.getpagetemplateid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="PageTemplatesDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="Core.config.configbean" />
<cfargument name="argsLog" required="true" type="any" />
    <cfset variables.Log = arguments.argsLog/>    
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
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


<cffunction name="save" access="public" returntype="PageTemplate" output="false" hint="DAO method">
<cfargument name="PageTemplate" type="PageTemplate" required="yes" />
<!-----[  If a PageTemplateID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.PageTemplate.getPageTemplateID() neq "0")>	
		<cfset PageTemplate = update(arguments.PageTemplate)/>
	<cfelse>
		<cfset PageTemplate = create(arguments.PageTemplate)/>
	</cfif>
	<cfreturn PageTemplate />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="PageTemplate" type="PageTemplate" required="true" /> 
	<cfset var qPageTemplateDelete = 0 >
<!-----[  to delete, set 'IsVisible' flag to zero  ]--->
		<cfquery name="qPageTemplateDelete" datasource="#variables.dsn#" >
		UPDATE PageTemplates
		Set IsVisible = '0'
		WHERE 
		PageTemplateID = <cfqueryparam value="#PageTemplate.getPageTemplateID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery> 
     <!----[  Add a log entry for this function  ]----MK ---->
          <cfscript>
              InitLog( variables.Log);
              variables.log.setTablename( "PageTemplates");
              variables.log.setComment( "Deleted a record");
              variables.log.setActivity( "Delete" );
              variables.log.setDateAdded( now() );
           </cfscript>
           <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
			
</cffunction>


<cffunction name="UnDelete" returntype="void" output="false" hint="DAO method" >
<cfargument name="PageTemplate" type="PageTemplate" required="true" /> 
	<cfset var qPageTemplateUnDelete = 0 >
<!-----[  to UnDelete, set 'IsVisible' flag to 1 (true)  ]--->
		<cfquery name="qPageTemplateDelete" datasource="#variables.dsn#" >
		UPDATE PageTemplates
		Set IsVisible = '1'
		WHERE 
		PageTemplateID = <cfqueryparam value="#PageTemplate.getPageTemplateID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
    
     <!----[  Add a log entry for this function  ]----MK ---->
          <cfscript>
              InitLog( variables.Log);
              variables.log.setTablename( "PageTemplates");
              variables.log.setComment( "Undeleted a record");
              variables.log.setActivity( "Undelete" );
              variables.log.setDateAdded( now() );
           </cfscript>
           <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
    	
</cffunction>


<cffunction name="read" access="public" returntype="PageTemplate" output="false" hint="DAO Method. - Reads a PageTemplate into the bean">
<cfargument name="argsPageTemplate" type="PageTemplate" required="true" />
	<cfset var PageTemplate  =  arguments.argsPageTemplate />
	<cfset var QPageTemplatesselect = "" />
	<cfquery name="QPageTemplatesselect" datasource="#variables.dsn#">
		SELECT 
		PageTemplateID, PageTemplateDescription, PageTemplateExtraDescription, IsVisible, DateAdded, AddedBy, DateUPdated, UpdatedBy
		FROM PageTemplates 
		WHERE 
		IsVisible = '1' AND
        PageTemplateID = <cfqueryparam value="#PageTemplate.getPageTemplateID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QPageTemplatesselect.recordCount >
		<cfscript>
		PageTemplate.setPageTemplateID(QPageTemplatesselect.PageTemplateID);
         PageTemplate.setPageTemplateDescription(QPageTemplatesselect.PageTemplateDescription);
         PageTemplate.setPageTemplateExtraDescription(QPageTemplatesselect.PageTemplateExtraDescription);
         PageTemplate.setIsVisible(QPageTemplatesselect.IsVisible);
         PageTemplate.setDateAdded(QPageTemplatesselect.DateAdded);
         PageTemplate.setAddedBy(QPageTemplatesselect.AddedBy);
         PageTemplate.setDateUPdated(QPageTemplatesselect.DateUPdated);
         PageTemplate.setUpdatedBy(QPageTemplatesselect.UpdatedBy);
         
		</cfscript>
	</cfif>
	<cfreturn PageTemplate />
</cffunction>
		

<cffunction name="GetAllPageTemplates" access="public" output="false" returntype="query" hint="Returns a query of all PageTemplates in our Database">
<cfset var QgetallPageTemplates = 0 />
	<cfquery name="QgetallPageTemplates" datasource="#variables.dsn#">
		SELECT PageTemplateID, PageTemplateDescription, PageTemplateExtraDescription, IsVisible, DateAdded, AddedBy, DateUPdated, UpdatedBy
		FROM PageTemplates 
		WHERE IsVisible = '1'
        
		ORDER BY PageTemplateID
	</cfquery>
	<cfreturn QgetallPageTemplates />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="PageTemplate" output="false" hint="DAO method">
<cfargument name="argsPageTemplate" type="PageTemplate" required="yes" displayname="create" />
	<cfset var qPageTemplateInsert = 0 />
	<cfset var PageTemplate = arguments.argsPageTemplate />
	
	<cfquery name="qPageTemplateInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into PageTemplates
		( PageTemplateDescription, PageTemplateExtraDescription, IsVisible, DateAdded, AddedBy, DateUPdated, UpdatedBy ) VALUES
		(

		<cfqueryparam value="#PageTemplate.getpagetemplatedescription()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PageTemplate.getpagetemplateextradescription()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PageTemplate.getisvisible()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/> ,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/> 
		   ) 
		SELECT Ident_Current('PageTemplates') as PageTemplateID
		SET NOCOUNT OFF
	</cfquery>
	<cfset PageTemplate.setPageTemplateID(qPageTemplateInsert.PageTemplateID)>

     <!----[  Add a log entry for this function  ]----MK ---->
        <cfscript>
             InitLog( variables.Log);
             variables.log.setTablename( "PageTemplates");
             variables.log.setComment( "Created a record");
             variables.log.setActivity( "Create" );
             variables.log.setDateAdded( now() );
         </cfscript>
         <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
    	

	<cfreturn PageTemplate />
</cffunction>

<cffunction name="update" access="private" returntype="PageTemplate" output="false" hint="DAO method">
<cfargument name="argsPageTemplate" type="PageTemplate" required="yes" />
	<cfset var PageTemplate = arguments.argsPageTemplate />
	<cfset var PageTemplateUpdate = 0 >
	<cfquery name="PageTemplateUpdate" datasource="#variables.dsn#" >
		UPDATE PageTemplates SET
pagetemplatedescription  = <cfqueryparam value="#PageTemplate.getPageTemplateDescription()#" cfsqltype="CF_SQL_VARCHAR"/>,
pagetemplateextradescription  = <cfqueryparam value="#PageTemplate.getPageTemplateExtraDescription()#" cfsqltype="CF_SQL_VARCHAR"/>,
isvisible  = <cfqueryparam value="#PageTemplate.getIsVisible()#" cfsqltype="CF_SQL_BIT"/>,
dateupdated  = <cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
updatedby  = <cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/>
						
		WHERE 
		PageTemplateID = <cfqueryparam value="#PageTemplate.getPageTemplateID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
     
     <!----[  Add a log entry for this function  ]----MK ---->
        <cfscript>
             InitLog( variables.Log);
             variables.log.setTablename( "PageTemplates");
             variables.log.setComment( "Updated a record");
             variables.log.setActivity( "Update" );
             variables.log.setDateAdded( now() );
         </cfscript>
         <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
    	
    
	
	<cfreturn PageTemplate />
</cffunction>

</cfcomponent>