<cfcomponent displayname="PagesArchive DAO" output="false" hint="DAO Component Handles all Database access for the table PagesArchive."  >
<cfsilent>
<!----
==========================================================================================================
Filename:    PageArchiveDAO.cfc
Description: DAO Component Handles all Database access for the table PagesArchive.  Requires Coldspring v1.0
Client:      TherapyOz_Admin
Date:        8/Dec/2015
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( PageAchive.getpagearchiveid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="PageArchiveDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="cfcs.config.configbean" />
   
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
	<cfreturn this />
</cffunction>

<cffunction name="setUserService" access="public" output="false" returntype="void" hint="Dependency: User Service">
	<cfargument name="UserService" type="any" required="true"/>
	<cfset variables.UserService = arguments.UserService/>
</cffunction>


<cffunction name="save" access="public" returntype="PageAchive" output="false" hint="DAO method">
<cfargument name="PageAchive" type="PageAchive" required="yes" />
<!-----[  If a PageArchiveID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.PageAchive.getPageArchiveID() neq "0")>	
		<cfset PageAchive = update(arguments.PageAchive)/>
	<cfelse>
		<cfset PageAchive = create(arguments.PageAchive)/>
	</cfif>
	<cfreturn PageAchive />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="PageAchive" type="PageAchive" required="true" /> 
	<cfset var qPageAchiveDelete = 0 >
<!-----[  to delete, set 'IsVisible' flag to zero  ]--->
		<cfquery name="qPageAchiveDelete" datasource="#variables.dsn#" >
		UPDATE PagesArchive
		Set IsVisible = '0'
		WHERE 
		PageArchiveID = <cfqueryparam value="#PageAchive.getPageArchiveID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery> 	
</cffunction>


<cffunction name="UnDelete" returntype="void" output="false" hint="DAO method" >
<cfargument name="PageAchive" type="PageAchive" required="true" /> 
	<cfset var qPageAchiveUnDelete = 0 >
<!-----[  to UnDelete, set 'IsVisible' flag to 1 (true)  ]--->
		<cfquery name="qPageAchiveDelete" datasource="#variables.dsn#" >
		UPDATE PagesArchive
		Set IsVisible = '1'
		WHERE 
		PageArchiveID = <cfqueryparam value="#PageAchive.getPageArchiveID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
    	
</cffunction>


<cffunction name="read" access="public" returntype="PageAchive" output="false" hint="DAO Method. - Reads a PageAchive into the bean">
<cfargument name="argsPageAchive" type="PageAchive" required="true" />
	<cfset var PageAchive  =  arguments.argsPageAchive />
	<cfset var QPagesArchiveselect = "" />
	<cfquery name="QPagesArchiveselect" datasource="#variables.dsn#">
		SELECT 
		PageArchiveID, PageID, PageName, NodeRec, Siteno, Template, Teaser, Keywords, Live, Embargoed, EmbargoDate, Expires, DateExpires, AccessLevel, EditLevel, ApproveLevel, EditStatus, LockedForEdit, ApprovedBy, ApprovedDate, DateAdded, DateUpdated, UpdatedBy, IsVisible, PageTitle, Version
		FROM PagesArchive 
		WHERE 
		IsVisible = '1' ANDPageArchiveID = <cfqueryparam value="#PageAchive.getPageArchiveID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QPagesArchiveselect.recordCount >
		<cfscript>
		PageAchive.setPageArchiveID(QPagesArchiveselect.PageArchiveID);
         PageAchive.setPageID(QPagesArchiveselect.PageID);
         PageAchive.setPageName(QPagesArchiveselect.PageName);
         PageAchive.setNodeRec(QPagesArchiveselect.NodeRec);
         PageAchive.setSiteno(QPagesArchiveselect.Siteno);
         PageAchive.setTemplate(QPagesArchiveselect.Template);
         PageAchive.setTeaser(QPagesArchiveselect.Teaser);
         PageAchive.setKeywords(QPagesArchiveselect.Keywords);
         PageAchive.setLive(QPagesArchiveselect.Live);
         PageAchive.setEmbargoed(QPagesArchiveselect.Embargoed);
         PageAchive.setEmbargoDate(QPagesArchiveselect.EmbargoDate);
         PageAchive.setExpires(QPagesArchiveselect.Expires);
         PageAchive.setDateExpires(QPagesArchiveselect.DateExpires);
         PageAchive.setAccessLevel(QPagesArchiveselect.AccessLevel);
         PageAchive.setEditLevel(QPagesArchiveselect.EditLevel);
         PageAchive.setApproveLevel(QPagesArchiveselect.ApproveLevel);
         PageAchive.setEditStatus(QPagesArchiveselect.EditStatus);
         PageAchive.setLockedForEdit(QPagesArchiveselect.LockedForEdit);
         PageAchive.setApprovedBy(QPagesArchiveselect.ApprovedBy);
         PageAchive.setApprovedDate(QPagesArchiveselect.ApprovedDate);
         PageAchive.setDateAdded(QPagesArchiveselect.DateAdded);
         PageAchive.setDateUpdated(QPagesArchiveselect.DateUpdated);
         PageAchive.setUpdatedBy(QPagesArchiveselect.UpdatedBy);
         PageAchive.setIsVisible(QPagesArchiveselect.IsVisible);
         PageAchive.setPageTitle(QPagesArchiveselect.PageTitle);
         PageAchive.setVersion(QPagesArchiveselect.Version);
         
		</cfscript>
	</cfif>
	<cfreturn PageAchive />
</cffunction>
		

<cffunction name="GetAllPageAchives" access="public" output="false" returntype="query" hint="Returns a query of all PageAchives in our Database">
<cfset var QgetallPageAchives = 0 />
	<cfquery name="QgetallPageAchives" datasource="#variables.dsn#">
		SELECT PageArchiveID, PageID, PageName, NodeRec, Siteno, Template, Teaser, Keywords, Live, Embargoed, EmbargoDate, Expires, DateExpires, AccessLevel, EditLevel, ApproveLevel, EditStatus, LockedForEdit, ApprovedBy, ApprovedDate, DateAdded, DateUpdated, UpdatedBy, IsVisible, PageTitle, Version
		FROM PagesArchive 
		WHERE IsVisible = '1'
        
		ORDER BY PageArchiveID
	</cfquery>
	<cfreturn QgetallPageAchives />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="PageAchive" output="false" hint="DAO method">
<cfargument name="argsPageAchive" type="PageAchive" required="yes" displayname="create" />
	<cfset var qPageAchiveInsert = 0 />
	<cfset var PageAchive = arguments.argsPageAchive />
	
	<cfquery name="qPageAchiveInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into PagesArchive
		( PageID, PageName, NodeRec, Siteno, Template, Teaser, Keywords, Live, Embargoed, EmbargoDate, Expires, DateExpires, AccessLevel, EditLevel, ApproveLevel, EditStatus, LockedForEdit, ApprovedBy, ApprovedDate, DateAdded, DateUpdated, UpdatedBy, AddedBy, IsVisible, PageTitle, Version ) VALUES
		(

		<cfqueryparam value="#PageAchive.getpageid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PageAchive.getpagename()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PageAchive.getnoderec()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PageAchive.getsiteno()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PageAchive.gettemplate()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PageAchive.getteaser()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PageAchive.getkeywords()#" cfsqltype="CF_SQL_LONGVARCHAR" />,
		<cfqueryparam value="#PageAchive.getlive()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#PageAchive.getembargoed()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#PageAchive.getembargodate()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#PageAchive.getexpires()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#PageAchive.getdateexpires()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#PageAchive.getaccesslevel()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PageAchive.geteditlevel()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PageAchive.getapprovelevel()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PageAchive.geteditstatus()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PageAchive.getlockedforedit()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PageAchive.getapprovedby()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PageAchive.getapproveddate()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#PageAchive.getDateAdded()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#PageAchive.getDateUpdated()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#PageAchive.getUpdatedby()#" cfsqltype="CF_SQL_VARCHAR"/> ,
        <cfqueryparam value="#PageAchive.getAddedby()#" cfsqltype="CF_SQL_VARCHAR"/> ,
		<cfqueryparam value="#PageAchive.getisvisible()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#PageAchive.getpagetitle()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PageAchive.getversion()#" cfsqltype="CF_SQL_INTEGER" />
		   ) 
		SELECT Ident_Current('PagesArchive') as PageArchiveID
		SET NOCOUNT OFF
	</cfquery>
	<cfset PageAchive.setPageArchiveID(qPageAchiveInsert.PageArchiveID)>
	

	<cfreturn PageAchive />
</cffunction>

<cffunction name="update" access="private" returntype="PageAchive" output="false" hint="DAO method">
<cfargument name="argsPageAchive" type="PageAchive" required="yes" />
	<cfset var PageAchive = arguments.argsPageAchive />
	<cfset var PageAchiveUpdate = 0 >
	<cfquery name="PageAchiveUpdate" datasource="#variables.dsn#" >
		UPDATE PagesArchive SET
            pageid  = <cfqueryparam value="#PageAchive.getPageID()#" cfsqltype="CF_SQL_INTEGER"/>,
            pagename  = <cfqueryparam value="#PageAchive.getPageName()#" cfsqltype="CF_SQL_VARCHAR"/>,
            noderec  = <cfqueryparam value="#PageAchive.getNodeRec()#" cfsqltype="CF_SQL_VARCHAR"/>,
            siteno  = <cfqueryparam value="#PageAchive.getSiteno()#" cfsqltype="CF_SQL_INTEGER"/>,
            template  = <cfqueryparam value="#PageAchive.getTemplate()#" cfsqltype="CF_SQL_VARCHAR"/>,
            teaser  = <cfqueryparam value="#PageAchive.getTeaser()#" cfsqltype="CF_SQL_VARCHAR"/>,
            keywords  = <cfqueryparam value="#PageAchive.getKeywords()#" cfsqltype="CF_SQL_LONGVARCHAR"/>,
            live  = <cfqueryparam value="#PageAchive.getLive()#" cfsqltype="CF_SQL_BIT"/>,
            embargoed  = <cfqueryparam value="#PageAchive.getEmbargoed()#" cfsqltype="CF_SQL_BIT"/>,
            embargodate  = <cfqueryparam value="#PageAchive.getEmbargoDate()#" cfsqltype="CF_SQL_TIMESTAMP"/>,
            expires  = <cfqueryparam value="#PageAchive.getExpires()#" cfsqltype="CF_SQL_BIT"/>,
            dateexpires  = <cfqueryparam value="#PageAchive.getDateExpires()#" cfsqltype="CF_SQL_TIMESTAMP"/>,
            accesslevel  = <cfqueryparam value="#PageAchive.getAccessLevel()#" cfsqltype="CF_SQL_INTEGER"/>,
            editlevel  = <cfqueryparam value="#PageAchive.getEditLevel()#" cfsqltype="CF_SQL_INTEGER"/>,
            approvelevel  = <cfqueryparam value="#PageAchive.getApproveLevel()#" cfsqltype="CF_SQL_INTEGER"/>,
            editstatus  = <cfqueryparam value="#PageAchive.getEditStatus()#" cfsqltype="CF_SQL_VARCHAR"/>,
            lockedforedit  = <cfqueryparam value="#PageAchive.getLockedForEdit()#" cfsqltype="CF_SQL_VARCHAR"/>,
            approvedby  = <cfqueryparam value="#PageAchive.getApprovedBy()#" cfsqltype="CF_SQL_VARCHAR"/>,
            approveddate  = <cfqueryparam value="#PageAchive.getApprovedDate()#" cfsqltype="CF_SQL_TIMESTAMP"/>,
            dateupdated  = <cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
            updatedby  = <cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/>,
            isvisible  = <cfqueryparam value="#PageAchive.getIsVisible()#" cfsqltype="CF_SQL_BIT"/>,
            pagetitle  = <cfqueryparam value="#PageAchive.getPageTitle()#" cfsqltype="CF_SQL_VARCHAR"/>,
            version  = <cfqueryparam value="#PageAchive.getVersion()#" cfsqltype="CF_SQL_INTEGER"/>
						
		WHERE 
		PageArchiveID = <cfqueryparam value="#PageAchive.getPageArchiveID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
     	
    
	
	<cfreturn PageAchive />
</cffunction>

</cfcomponent>
i
