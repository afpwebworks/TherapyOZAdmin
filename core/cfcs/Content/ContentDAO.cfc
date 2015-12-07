<cfcomponent displayname="Content DAO" output="false" hint="DAO Component Handles all Database access for the table Content.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    ContentDAO.cfc
Description: DAO Component Handles all Database access for the table Content.  Requires Coldspring v1.0
Client:      Therapy OZ Admin
Date:        18/Oct/2015
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( Content.getcontentid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="ContentDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="cfcs.config.configbean" />
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


<cffunction name="save" access="public" returntype="Content" output="false" hint="DAO method">
<cfargument name="Content" type="Content" required="yes" />
<!-----[  If a ContentID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.Content.getContentID() neq "0")>	
		<cfset Content = update(arguments.Content)/>
	<cfelse>
		<cfset Content = create(arguments.Content)/>
	</cfif>
	<cfreturn Content />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="Content" type="Content" required="true" /> 
	<cfset var qContentDelete = 0 >
<cfquery name="ContentDelete" datasource="#variables.dsn#" >
		DELETE FROM Content
		WHERE 
		ContentID = <cfqueryparam value="#Content.getContentID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
     
     <!----[  Add a log entry for this function  ]----MK ---->
          <cfscript>
              InitLog( variables.Log);
              variables.log.setTablename( "Content");
              variables.log.setComment( "Deleted a record");
              variables.log.setActivity( "Delete" );
              variables.log.setDateAdded( now() );
           </cfscript>
           <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
			
</cffunction>



<cffunction name="read" access="public" returntype="Content" output="false" hint="DAO Method. - Reads a Content into the bean">
<cfargument name="argsContent" type="Content" required="true" />
	<cfset var Content  =  arguments.argsContent />
	<cfset var QContentselect = "" />
	<cfquery name="QContentselect" datasource="#variables.dsn#">
		SELECT 
		ContentID, Headilne, SiteNo, PageID, SortCode, ContentTemplate, ContentFilename, Accesslevel, EditLevel, ApproveLevel, Live, UserGroupID, Embargoed, EmbargoDate, Expires, DateExpires, Version, DateAdded, AddedBy, DateUpdated, Updatedby
		FROM Content 
		WHERE 
		ContentID = <cfqueryparam value="#Content.getContentID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QContentselect.recordCount >
		<cfscript>
		Content.setContentID(QContentselect.ContentID);
         Content.setHeadilne(QContentselect.Headilne);
         Content.setSiteNo(QContentselect.SiteNo);
         Content.setPageID(QContentselect.PageID);
         Content.setSortCode(QContentselect.SortCode);
         Content.setContentTemplate(QContentselect.ContentTemplate);
         Content.setContentFilename(QContentselect.ContentFilename);
         Content.setAccesslevel(QContentselect.Accesslevel);
         Content.setEditLevel(QContentselect.EditLevel);
         Content.setApproveLevel(QContentselect.ApproveLevel);
         Content.setLive(QContentselect.Live);
         Content.setUserGroupID(QContentselect.UserGroupID);
         Content.setEmbargoed(QContentselect.Embargoed);
         Content.setEmbargoDate(QContentselect.EmbargoDate);
         Content.setExpires(QContentselect.Expires);
         Content.setDateExpires(QContentselect.DateExpires);
         Content.setVersion(QContentselect.Version);
         Content.setDateAdded(QContentselect.DateAdded);
         Content.setAddedBy(QContentselect.AddedBy);
         Content.setDateUpdated(QContentselect.DateUpdated);
         Content.setUpdatedby(QContentselect.Updatedby);
         
		</cfscript>
	</cfif>
	<cfreturn Content />
</cffunction>
		

<cffunction name="GetAllContents" access="public" output="false" returntype="query" hint="Returns a query of all Contents in our Database">
<cfset var QgetallContents = 0 />
	<cfquery name="QgetallContents" datasource="#variables.dsn#">
		SELECT ContentID, Headilne, SiteNo, PageID, SortCode, ContentTemplate, ContentFilename, Accesslevel, EditLevel, ApproveLevel, Live, UserGroupID, Embargoed, EmbargoDate, Expires, DateExpires, Version, DateAdded, AddedBy, DateUpdated, Updatedby
		FROM Content 
		ORDER BY ContentID
	</cfquery>
	<cfreturn QgetallContents />
</cffunction>


<cffunction name="GetContentsForPage" access="public" output="false" returntype="query" hint="Returns a query of all Contents in our Database for a page.  Requires a page object">
	<cfargument name="argsPage" required="yes" type="any" />
    <cfset var page= arguments.argsPage />
    <cfset var QgetContents = 0 />

	<cfquery name="QgetContents" datasource="#variables.dsn#">
		SELECT ContentID, Headilne, SiteNo, PageID, SortCode, ContentTemplate, ContentFilename, Accesslevel, EditLevel, ApproveLevel, Live, UserGroupID, Embargoed, EmbargoDate, Expires, DateExpires, Version, DateAdded, AddedBy, DateUpdated, Updatedby
		FROM Content 
        WHERE
        IsVisible = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
        ORDER BY sortcode, ContentID
	</cfquery>
	<cfreturn QgetContents />
</cffunction>



<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="Content" output="false" hint="DAO method">
<cfargument name="argsContent" type="Content" required="yes" displayname="create" />
	<cfset var qContentInsert = 0 />
	<cfset var Content = arguments.argsContent />
	
	<cfquery name="qContentInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into Content
		( Headilne, SiteNo, PageID, SortCode, ContentTemplate, ContentFilename, Accesslevel, EditLevel, ApproveLevel, Live, UserGroupID, Embargoed, EmbargoDate, Expires, DateExpires, Version, DateAdded, AddedBy, DateUpdated, Updatedby ) VALUES
		(

		<cfqueryparam value="#Content.getheadilne()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Content.getsiteno()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#Content.getpageid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#Content.getsortcode()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#Content.getcontenttemplate()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Content.getcontentfilename()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Content.getaccesslevel()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#Content.geteditlevel()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#Content.getapprovelevel()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#Content.getlive()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#Content.getusergroupid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#Content.getembargoed()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#Content.getembargodate()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#Content.getexpires()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#Content.getdateexpires()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#Content.getversion()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/> ,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/> 
		   ) 
		SELECT Ident_Current('Content') as ContentID
		SET NOCOUNT OFF
	</cfquery>
	<cfset Content.setContentID(qContentInsert.ContentID)>

     <!----[  Add a log entry for this function  ]----MK ---->
        <cfscript>
             InitLog( variables.Log);
             variables.log.setTablename( "Content");
             variables.log.setComment( "Created a record");
             variables.log.setActivity( "Create" );
             variables.log.setDateAdded( now() );
         </cfscript>
         <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
    	

	<cfreturn Content />
</cffunction>

<cffunction name="update" access="private" returntype="Content" output="false" hint="DAO method">
<cfargument name="argsContent" type="Content" required="yes" />
	<cfset var Content = arguments.argsContent />
	<cfset var ContentUpdate = 0 >
	<cfquery name="ContentUpdate" datasource="#variables.dsn#" >
		UPDATE Content SET
headilne  = <cfqueryparam value="#Content.getHeadilne()#" cfsqltype="CF_SQL_VARCHAR"/>,
siteno  = <cfqueryparam value="#Content.getSiteNo()#" cfsqltype="CF_SQL_INTEGER"/>,
pageid  = <cfqueryparam value="#Content.getPageID()#" cfsqltype="CF_SQL_INTEGER"/>,
sortcode  = <cfqueryparam value="#Content.getSortCode()#" cfsqltype="CF_SQL_INTEGER"/>,
contenttemplate  = <cfqueryparam value="#Content.getContentTemplate()#" cfsqltype="CF_SQL_VARCHAR"/>,
contentfilename  = <cfqueryparam value="#Content.getContentFilename()#" cfsqltype="CF_SQL_VARCHAR"/>,
accesslevel  = <cfqueryparam value="#Content.getAccesslevel()#" cfsqltype="CF_SQL_INTEGER"/>,
editlevel  = <cfqueryparam value="#Content.getEditLevel()#" cfsqltype="CF_SQL_INTEGER"/>,
approvelevel  = <cfqueryparam value="#Content.getApproveLevel()#" cfsqltype="CF_SQL_INTEGER"/>,
live  = <cfqueryparam value="#Content.getLive()#" cfsqltype="CF_SQL_BIT"/>,
usergroupid  = <cfqueryparam value="#Content.getUserGroupID()#" cfsqltype="CF_SQL_INTEGER"/>,
embargoed  = <cfqueryparam value="#Content.getEmbargoed()#" cfsqltype="CF_SQL_BIT"/>,
embargodate  = <cfqueryparam value="#Content.getEmbargoDate()#" cfsqltype="CF_SQL_TIMESTAMP"/>,
expires  = <cfqueryparam value="#Content.getExpires()#" cfsqltype="CF_SQL_BIT"/>,
dateexpires  = <cfqueryparam value="#Content.getDateExpires()#" cfsqltype="CF_SQL_TIMESTAMP"/>,
version  = <cfqueryparam value="#Content.getVersion()#" cfsqltype="CF_SQL_INTEGER"/>,
dateupdated  = <cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
updatedby  = <cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/>
						
		WHERE 
		ContentID = <cfqueryparam value="#Content.getContentID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
     
     <!----[  Add a log entry for this function  ]----MK ---->
        <cfscript>
             InitLog( variables.Log);
             variables.log.setTablename( "Content");
             variables.log.setComment( "Updated a record");
             variables.log.setActivity( "Update" );
             variables.log.setDateAdded( now() );
         </cfscript>
         <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
    	
    
	
	<cfreturn Content />
</cffunction>

</cfcomponent>