<cfcomponent displayname="Pages DAO" output="false" hint="DAO Component Handles all Database access for the table Pages.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    TreeLibrary.cfc
Description: DAO Component Handles all Database access for the table Pages.  Requires Coldspring v1.0
Client:      Therapy OZ Admin
Date:        17/Oct/2015
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( Page.getpageid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="TreeLibrary" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="core.config.configbean" />
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

<cffunction name="setPageArchive" access="public" output="false" returntype="void" hint="Dependency: PageArchive Service">
	<cfargument name="PageArchive" type="any" required="true"/>
	<cfset variables.PageArchive = arguments.PageArchive/>
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


<cffunction name="save" access="public" returntype="Page" output="false" hint="DAO method">
<cfargument name="Page" type="Page" required="yes" />
<!-----[  If a PageID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.Page.getPageID() neq "0")>
		<!----[  Get existing page details and put them into the archive page object for archiving.  ]----MK ---->	
        <cfset variables.PageArchive.setPageID(  arguments.Page.getPageID()   ) />
        <cfset read( variables.PageArchive ) />  
        <!----[  Now insert exising page into the archive table.  ]----MK ---->   
        <cfset archiveOldPage( variables.PageArchive ) />
		<cfset Page = update(arguments.Page)/>
	<cfelse>
		<cfset Page = create(arguments.Page)/>
	</cfif>
	<cfreturn Page />
</cffunction>


<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="Page" type="Page" required="true" /> 
	<cfset var qPageDelete = 0 >
    	<!----[  Archive the old page first.  ]----MK ---->
        <!----[  Get existing page details and put them into the archive page object for archiving.  ]----MK ---->	
        <cfset variables.PageArchive.setPageID(  arguments.Page.getPageID()   ) />
        <cfset read( variables.PageArchive ) />  
        <!----[  Now insert exising page into the archive table.  ]----MK ---->   
        <cfset archiveOldPage( variables.PageArchive ) />
        
<!-----[  to delete, set 'IsVisible' flag to zero  ]--->
		<cfquery name="qPageDelete" datasource="#variables.dsn#" >
		UPDATE Pages
		Set IsVisible = '0', version = version + 1
		WHERE 
		PageID = <cfqueryparam value="#Page.getPageID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery> 
     <!----[  Add a log entry for this function  ]----MK ---->
          <cfscript>
              InitLog( variables.Log);
              variables.log.setTablename( "Pages");
              variables.log.setComment( "Deleted a Page. PageID = #Page.getPageID()#");
              variables.log.setActivity( "Delete" );
              variables.log.setDateAdded( now() );
           </cfscript>
           <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
			
</cffunction>


<cffunction name="UnDelete" returntype="void" output="false" hint="DAO method" >
<cfargument name="Page" type="Page" required="true" /> 
	<cfset var qPageUnDelete = 0 >
    	<!----[  Archive the old page first.  ]----MK ---->
        <!----[  Get existing page details and put them into the archive page object for archiving.  ]----MK ---->	
        <cfset variables.PageArchive.setPageID(  arguments.Page.getPageID()   ) />
        <cfset read( variables.PageArchive ) />  
        <!----[  Now insert exising page into the archive table.  ]----MK ---->   
        <cfset archiveOldPage( variables.PageArchive ) />
    
<!-----[  to UnDelete, set 'IsVisible' flag to 1 (true)  ]--->
		<cfquery name="qPageDelete" datasource="#variables.dsn#" >
		UPDATE Pages
		Set IsVisible = '1', version = version + 1
		WHERE 
		PageID = <cfqueryparam value="#Page.getPageID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
    
     <!----[  Add a log entry for this function  ]----MK ---->
          <cfscript>
              InitLog( variables.Log);
              variables.log.setTablename( "Pages");
              variables.log.setComment( "Restored a page. PageID = #Page.getPageID()#");
              variables.log.setActivity( "Undelete" );
              variables.log.setDateAdded( now() );
           </cfscript>
           <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
    	
</cffunction>


<cffunction name="read" access="public" returntype="Page" output="false" hint="DAO Method. - Reads a Page into the bean">
<cfargument name="argsPage" type="Page" required="true" />
	<cfset var Page  =  arguments.argsPage />
	<cfset var QPagesselect = "" />
	<cfquery name="QPagesselect" datasource="#variables.dsn#">
		SELECT 
		PageID, PageName, noderec.ToString() as Noderec, nodeRec.GetLevel() as Level, Siteno, Template, Teaser, Keywords, Live, Embargoed, EmbargoDate, Expires, DateExpires, AccessLevel, EditLevel, ApproveLevel, EditStatus, LockedForEdit, ApprovedBy, ApprovedDate, DateAdded, DateUpdated, UpdatedBy, IsVisible, PageTitle, Version
		FROM Pages 
		WHERE 
		IsVisible = '1' AND
        PageID = <cfqueryparam value="#Page.getPageID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QPagesselect.recordCount >
		<cfscript>
		Page.setPageID(QPagesselect.PageID);
         Page.setPageName(QPagesselect.PageName);
         Page.setNodeRec(QPagesselect.NodeRec);
         Page.setSiteno(QPagesselect.Siteno);
         Page.setTemplate(QPagesselect.Template);
         Page.setTeaser(QPagesselect.Teaser);
         Page.setKeywords(QPagesselect.Keywords);
         Page.setLive(QPagesselect.Live);
		 Page.setLevel(QPagesselect.Level);
         Page.setEmbargoed(QPagesselect.Embargoed);
         Page.setEmbargoDate(QPagesselect.EmbargoDate);
         Page.setExpires(QPagesselect.Expires);
         Page.setDateExpires(QPagesselect.DateExpires);
         Page.setAccessLevel(QPagesselect.AccessLevel);
         Page.setEditLevel(QPagesselect.EditLevel);
         Page.setApproveLevel(QPagesselect.ApproveLevel);
         Page.setEditStatus(QPagesselect.EditStatus);
         Page.setLockedForEdit(QPagesselect.LockedForEdit);
         Page.setApprovedBy(QPagesselect.ApprovedBy);
         Page.setApprovedDate(QPagesselect.ApprovedDate);
         Page.setDateAdded(QPagesselect.DateAdded);
         Page.setDateUpdated(QPagesselect.DateUpdated);
         Page.setUpdatedBy(QPagesselect.UpdatedBy);
         Page.setIsVisible(QPagesselect.IsVisible);
         Page.setPageTitle(QPagesselect.PageTitle);
         Page.setVersion(QPagesselect.Version);
         
		</cfscript>
	</cfif>
	<cfreturn Page />
</cffunction>
		

<cffunction name="GetAllPages" access="public" output="false" returntype="query" hint="Returns a query of all Pages in our Database">
<cfset var QgetallPages = 0 />
	<cfquery name="QgetallPages" datasource="#variables.dsn#">
		SELECT PageID, PageName, NodeRec.ToString() as Noderec, nodeRec.GetLevel() as Level, Siteno, Template, Teaser, Keywords, Live, Embargoed, EmbargoDate, Expires, DateExpires, AccessLevel, EditLevel, ApproveLevel, EditStatus, LockedForEdit, ApprovedBy, ApprovedDate, DateAdded, DateUpdated, UpdatedBy, IsVisible, PageTitle, Version
		FROM Pages 
		WHERE IsVisible = '1'
        
		ORDER BY PageID
	</cfquery>
	<cfreturn QgetallPages />
</cffunction>


<cffunction name="GetPagesForSite" access="public" output="false" returntype="query" hint="Returns a query of all Pages in our Database for a specific site">
	<cfargument name="argsSiteNO" default="1000" required="yes" type="numeric" />
    
	 <cfset var SiteNO = arguments.argsSiteNO />   
	 <cfset var QgetallPages = 0 />
	<cfquery name="QgetallPages" datasource="#variables.dsn#">
		SELECT PageID, PageName, NodeRec.ToString() as Noderec, nodeRec.GetLevel() as Level, Siteno, Template, Teaser, Keywords, Live, Embargoed, EmbargoDate, Expires, DateExpires, AccessLevel, EditLevel, ApproveLevel, EditStatus, LockedForEdit, ApprovedBy, ApprovedDate, DateAdded, DateUpdated, UpdatedBy, IsVisible, PageTitle, Version
		FROM Pages 
		WHERE IsVisible = '1' AND
        SiteNo = <cfqueryparam value="#SiteNO#" cfsqltype="cf_sql_integer" />
        
		ORDER BY noderec,  PageID
	</cfquery>
	<cfreturn QgetallPages />
</cffunction>


<cffunction name="LockPageForEdit" access="public" output="no" returntype="page" hint="Locks the page for editing,  and updates teh page objcct with teh details.">
	<cfargument name="argsPage" required="yes" hint="Page object of the page being edited.">
    <cfset var page= arguments.argsPage />
    <cfset var q = 0 />
    <cfquery name="q" datasource="#variables.dsn#">
    	Update pages set LockedForEdit = <cfqueryparam value="#variables.userservice.getuser().getUserLastname()#" cfsqltype="cf_sql_varchar" />
        WHERE PageID = <cfqueryparam value="#page.getPageID()#" cfsqltype="cf_sql_integer" />
    </cfquery>
		<cfset page.setLockedForEdit( variables.userservice.getuser().getUserLastname()  ) />
        
        <cfreturn page />
    
</cffunction>


<cffunction name="UnLockPageForEdit" access="public" output="no" returntype="page" hint="UnLocks the page after editing,  and updates teh page objcct with the details.">
	<cfargument name="argsPage" required="yes" hint="Page object of the page being edited.">
    <cfset var page= arguments.argsPage />
    <cfset var q = 0 />
    <cfquery name="q" datasource="#variables.dsn#">
    	Update pages set LockedForEdit = <cfqueryparam value="" cfsqltype="cf_sql_varchar" />
        WHERE PageID = <cfqueryparam value="#page.getPageID()#" cfsqltype="cf_sql_integer" />
    </cfquery>
    <cfset page.setLockedForEdit( "" ) />
        
        <cfreturn page />
</cffunction>

<!-----[  Private 'helper' methods called by other methods only.  ]----->


<cffunction name="InsertPage" access="public" returntype="Page" output="no" hint="Adds a page to the tree, underneath the pageid=ownernodeid">
	<cfargument name="ArgsPage" type="Page" required="yes" hint="Page object to be inserted">
   
        <cfset var PageID = arguments.ArgsPage.getPageID() />
    	<cfset var PageName = arguments.argsPage.getPageName() />
        <cfset var Owner =  arguments.argsPage.getOwner() />
        <cfset var qInsertPage = 0 />

<!----[  
This function requires this Stored Procedure to exist already in the database. 

CREATE PROCEDURE usp_AddPage
@OwnernodeID int,
@PageName nvarchar (50)

AS
BEGIN
DECLARE @Ownernode hierarchyID, @Node hierarchyID
SELECT @Ownernode = NodeRec
FROM Pages
WHERE PageID = @OwnernodeID

SELECT @Node = max(NodeRec)
FROM Pages
WHERE NodeRec.GetAncestor(1) = @Ownernode

INSERT INTO Pages
(PageName, NodeRec)
VALUES
(@PageName, @Ownernode.GetDescendant(@Node, null))
END
GO



DECLARE @NodeRec hierarchyid
set @NodeRec = hierarchyid::GetRoot() INSERT INTO pages
(PageName, NodeRec)
values
('HomePage',  @NodeRec.GetDescendant(null, null))
GO
  ]----MK ---->
  
<cfquery name="qInsertPage" datasource="#variables.dsn#">
	EXEC usp_addpage <cfqueryparam value="#Owner#" cfsqltype="cf_sql_integer" />, <cfqueryparam value="#PageName#" cfsqltype="cf_sql_varchar" />
</cfquery>
<!----[  Returns the pageid, so set the pageid in the page object.  ]----MK ---->

<cfset page.setPageID(  qInsertPage.PageID  ) />

</cffunction>




<cffunction name="create"  access="private" returntype="Page" output="false" hint="DAO method">
<cfargument name="argsPage" type="Page" required="yes" displayname="create" />
	<cfset var qPageInsert = 0 />
	<cfset var Page = arguments.argsPage />
    
    <cfset InsertPage( Page    ) >
   <!----[   Now update the created page with the rest of the varibles  ]----MK ---->
   <cfset update(  Page  ) />
    
    
     <!----[  Add a log entry for this function  ]----MK ---->
        <cfscript>
             InitLog( variables.Log);
             variables.log.setTablename( "Pages");
             variables.log.setComment( "Added a page #page.getPageID()#, #Page.getPageTitle()# version 1") ;
             variables.log.setActivity( "Create" );
             variables.log.setDateAdded( now() );
         </cfscript>
         <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
    
	
	<cfreturn Page />
</cffunction>

<cffunction name="update" access="private" returntype="Page" output="false" hint="DAO method">
<cfargument name="argsPage" type="Page" required="yes" />
	<cfscript>
	 var Page = arguments.argsPage ;
	 var PageUpdate = 0 ;
 	 var newversion = page.getVersion() + 1;
	 page.setversion(  newversion ) ; 
	 </cfscript>
     
	<cfquery name="PageUpdate" datasource="#variables.dsn#" >
		UPDATE Pages SET
            pagename  = <cfqueryparam value="#Page.getPageName()#" cfsqltype="CF_SQL_VARCHAR"/>,
            noderec  = <cfqueryparam value="#Page.getNodeRec()#" cfsqltype="CF_SQL_VARCHAR"/>,
            siteno  = <cfqueryparam value="#Page.getSiteno()#" cfsqltype="CF_SQL_INTEGER"/>,
            template  = <cfqueryparam value="#Page.getTemplate()#" cfsqltype="CF_SQL_VARCHAR"/>,
            teaser  = <cfqueryparam value="#Page.getTeaser()#" cfsqltype="CF_SQL_VARCHAR"/>,
            keywords  = <cfqueryparam value="#Page.getKeywords()#" cfsqltype="CF_SQL_LONGVARCHAR"/>,
            live  = <cfqueryparam value="#Page.getLive()#" cfsqltype="CF_SQL_BIT"/>,
            embargoed  = <cfqueryparam value="#Page.getEmbargoed()#" cfsqltype="CF_SQL_BIT"/>,
            embargodate  = <cfqueryparam value="#Page.getEmbargoDate()#" cfsqltype="CF_SQL_TIMESTAMP"/>,
            expires  = <cfqueryparam value="#Page.getExpires()#" cfsqltype="CF_SQL_BIT"/>,
            dateexpires  = <cfqueryparam value="#Page.getDateExpires()#" cfsqltype="CF_SQL_TIMESTAMP"/>,
            accesslevel  = <cfqueryparam value="#Page.getAccessLevel()#" cfsqltype="CF_SQL_INTEGER"/>,
            editlevel  = <cfqueryparam value="#Page.getEditLevel()#" cfsqltype="CF_SQL_INTEGER"/>,
            approvelevel  = <cfqueryparam value="#Page.getApproveLevel()#" cfsqltype="CF_SQL_INTEGER"/>,
            editstatus  = <cfqueryparam value="#Page.getEditStatus()#" cfsqltype="CF_SQL_VARCHAR"/>,
            lockedforedit  = <cfqueryparam value="#Page.getLockedForEdit()#" cfsqltype="CF_SQL_VARCHAR"/>,
            approvedby  = <cfqueryparam value="#Page.getApprovedBy()#" cfsqltype="CF_SQL_VARCHAR"/>,
            approveddate  = <cfqueryparam value="#Page.getApprovedDate()#" cfsqltype="CF_SQL_TIMESTAMP" null="#(NOT len( Page.getApprovedDate() ))#"/>,
            dateupdated  = <cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
            updatedby  = <cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/>,
            isvisible  = <cfqueryparam value="#Page.getIsVisible()#" cfsqltype="CF_SQL_BIT"/>,
            pagetitle  = <cfqueryparam value="#Page.getPageTitle()#" cfsqltype="CF_SQL_VARCHAR"/>,
            version  = <cfqueryparam value="#Page.getVersion()#" cfsqltype="CF_SQL_INTEGER"/>
						
		WHERE 
		PageID = <cfqueryparam value="#Page.getPageID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
     
     <!----[  Add a log entry for this function  ]----MK ---->
        <cfscript>
             InitLog( variables.Log);
             variables.log.setTablename( "Pages");
             variables.log.setComment( "Updated a page #page.getPageID()#, #Page.getPageTitle()#  to version #page.getVersion()#") ;
             variables.log.setActivity( "Update" );
             variables.log.setDateAdded( now() );
         </cfscript>
         <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
    	
    
	
	<cfreturn Page />
</cffunction>


<cffunction name="archiveOldPage" access="public" returntype="Page" output="no" hint="Archives the old version of a page into the PageArchive table">
   <cfargument name="argsPage" required="yes" type="Page" >
   <cfset var PageAchive = arguments.argsPage />
   <cfset var qPageAchiveInsert = 0 />

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
		SET NOCOUNT OFF
	</cfquery>

</cffunction>

<!----[      
==================================================================================================================
Funtions to alter information about the page tree
==================================================================================================================
  ]----MK ---->
  
 <cffunction name="MovePageToBetween" access="public" output="no" returntype="Page" hint="Moves a page to being a child of another page and between two others (left and right).  Requires a valid page object and a pageid to be the new owner">
  		<cfargument name="argsPage" required="yes" type="Page" >
	 	<cfargument name="ArgsPageID" type="numeric" required="yes" hint="PageID of the page to be the new parent">
        <cfargument name="argsLeftPageID" type="numeric" required="yes" hint="PageID of the page to be to the left of the page">
         <cfargument name="argsRightPageID" type="numeric" required="yes" hint="PageID of the page to be to the right of the page">
        <cfscript>
			var Page = arguments.argsPage; 
			var NewOwnerID = arguments.ArgsPageID;
			var NewLeftID = arguments.argsLeftPageID;
			var newRightID = arguments.argsRightPageID;
			var qPage = 0 ;
        </cfscript>
		
        <cfquery name="qPage" datasource="#variables.dsn#">
        exec usp_MovePageTo <cfqueryparam value="#NewOwnerID#" cfsqltype="cf_sql_integer"/>,<cfqueryparam value="#NewLeftID#" cfsqltype="cf_sql_integer" />,<cfqueryparam value="#newRightID#" cfsqltype="cf_sql_integer" />,<cfqueryparam value="#Page.getPageid()#" cfsqltype="cf_sql_integer" />
\        </cfquery>
        
        <cfset read(page) />
        <cfreturn page />

 <!----[  
 Uses a procedure as follows:      Syntax is:   EXEC usp_MovePageTo #newParentID, #LeftSiblingID, #RightSiblingID, #PageIDToMove
 
 CREATE PROCEDURE usp_MovePageTo

@NewOwnernodeID int,
@LeftPageID int,
@RightPageID int,
@ThisPageID int

AS
BEGIN
DECLARE @NewOwnernode hierarchyID, @LeftNodeRec hierarchyID, @RightNodeRec hierarchyID

Set @newownernode = (select noderec from pages where pageid=@NewOwnernodeID);
Set @LeftNodeRec = (select noderec from pages where pageid=@LeftPageID);
Set @RightNodeRec = (select noderec from pages where pageid=@RightPageID);

update Pages set NodeRec = (@newownernode.GetDescendant( @LeftNodeRec, @RightNodeRec  ))
where PageID = @ThisPageID;
END
GO
 
   ]----MK ---->       
 </cffunction> 
 
 <cffunction name="MovePageToLeftOf" access="public" returntype="Page" output="no" hint="Moves a page to the left of (or the top of) the page given.">
	 <cfargument name="argsPage" required="yes" type="Page" hint="Page object - page to move" >
     <cfargument name="argsNewOwner" required="yes" type="numeric" hint="PageID of the new owner">
     <cfargument name="argsTopChild" required="yes" type="numeric" hint="PageID of the existing left-most child that will be moved to the right">
     <cfscript>
	 	var NewOwner = arguments.argsNewOwner;
		var TopChild = arguments.argsTopChild;
		var thisPage = arguments.argsPage.getPageID();
	 </cfscript>
     
     
     <cfquery name="qmovetoleftof" datasource="#variables.dsn#">
     
     [MovePageToLeftOf] <cfqueryparam value="#NewOwner#" cfsqltype="cf_sql_integer">, 1149, 1177
     	
     </cfquery>
  	
 </cffunction>
 
  
 <cffunction name="moveSubtree" access="public" output="no" returntype="Page" hint="Moves a subtree including all its children from under oldNode to being under NewNode" >	 
	 <cfargument name="ArgsPage" type="Page" required="yes" hint="Page object to be inserted">
 	 <cfargument name="ArgsNewOwner" type="numeric" hint="PageID of the new owner of the subtree.">
     <cfscript>
	 	var ThisPage = arguments.ArgsPage;
		var OldOwner = thispage.getOwner();
		var NewOwner = arguments.ArgsNewOwner;
		var qupdate = 0 ;
	 </cfscript>
     	
       <cfquery name="qupdate" datasource="#variables.dsn#">
       	EXEC MoveSubtree <cfqueryparam value="#oldowner#" cfsqltype="cf_sql_integer">, <cfqueryparam value="#NewOwner#" cfsqltype="cf_sql_integer"> 
       </cfquery> 
 		<cfset read(page) />
        <cfreturn page />
    
 </cffunction> 


<!----[      
==================================================================================================================
Funtions to return information about the page tree
==================================================================================================================
  ]----MK ---->	
  
  <cffunction name="GetChildrenPages" access="public" returntype="query">
		<cfargument name="ArgsPageID" type="numeric" required="yes" hint="PageID of the page to find children of">
        
        <cfset var PageID = arguments.ArgsPageID />
        <cfset var qChildren = 0 />
        <cfquery name="qChildren" datasource="#variables.dsn#">
        SELECT pageid, pagename, NodeRec.ToString() pagepath , NodeRec.GetLevel() Level
        FROM pages 
		WHERE noderec.GetAncestor(1) = ( 
        	SELECT noderec 
            FROM pages 
            WHERE pageid= <cfqueryparam value="#pageID#" cfsqltype="cf_sql_integer" /> 
        )
		</cfquery>
        
        <cfreturn qChildren />

	</cffunction>
    
    <cffunction name="getNodeRec" access="public" output="no" returntype = "any" hint="Returns the NodeRec of a given PageID">
    	<cfargument name="argsPageID" required="yes" type="numeric" />
        <cfscript>
			var PageID = arguments.argsPageID;
			var NodeRec = 0 ;
		</cfscript>
        <cfquery name="qNodeRec" datasource="#variables.dsn#">
        	SELECT NodeRec from Pages where PageID = <cfqueryparam value="#pageID#" cfsqltype="cf_sql_integer" />
        </cfquery>
        <cfreturn qNodeRec.NodeRec />
    </cffunction> 	
    
    	<cffunction name="FindLastChild" access="public" output="no" returntype="any" hint="Finds the PageID of the last child of the given PageID">    	<cfargument name="argsPageID" required="yes" type="numeric" hint="PageID to find last child of">
    	<cfscript>
			var PageID = arguments.argsPageID ; 
			var ChildID = 0;
			var qNoderec = 0;
		</cfscript>
    	
        <cfquery name="qNodeRec" datasource="#variables.dsn#">
            declare @parent hierarchyid , @Child hierarchyid,  @parentID int
			SET  @parent = (SELECT NodeRec from Pages where PageID = <cfqueryparam value="#pageid#" cfsqltype="cf_sql_integer" />)
            SET @Child = (SELECT  max(NodeRec) as NodeRec
            FROM pages 
            WHERE NodeRec.GetAncestor(1) = @parent)
			SELECT PageID from Pages where NodeRec = @Child
        </cfquery>
        
        <cfset ChildID = qNodeRec.PageID />
        <cfreturn ChildID />
	</cffunction>
    
    
    
    <cffunction name="GetBreadcrumb" access="public" output="no" returntype="query" hint="Returns the breadcrumb to get to the top of the tree from the given pageid.">
     	<cfargument name="ArgsPageID" type="numeric" required="no" default="1100" hint="PageID of the page to find breadcrumb for">
            
        <cfset var PageID = arguments.ArgsPageID />
        <cfset var qBreadcrumb = 0 />
    	<cfquery name="qBreadcrumb" datasource="#variables.dsn#">
            SELECT pageid, pagename, NodeRec.ToString() pagepath , NodeRec.GetLevel() Level
            FROM dbo.fn_ReturnBreadcrumb( <cfqueryparam value="#pageiD#" cfsqltype="cf_sql_integer" /> ) 
		</cfquery>
        
        <cfreturn qBreadcrumb />    
        
        <!----[  
		Requires the following function to exist in the database: 
		
		CREATE FUNCTION fn_ReturnBreadcrumb
		(@PageID int)
		RETURNS @Parents TABLE
		(PageID int, NodeRec hierarchyID, Breadcrumb varchar (max),
		PagenAME nvarchar (50))
		AS
		BEGIN
		declare @NodeRec hierarchyID
		DECLARE @Depth int
		select @NodeRec = NodeRec
		from Pages
		WHERE PageID = @PageID
		
		select @Depth = @NodeRec.GetLevel()
		
		while @Depth > 0
		begin
		insert into @Parents
		select PageID, NodeRec, NodeRec.ToString()'Breadcrumb Path',
		PageName
		from Pages
		where NodeRec = @NodeRec.GetAncestor(@Depth)
		
		set @Depth = @Depth - 1
		end
		
		return
		END
		go
		  ]----MK ---->
    </cffunction>
    

    
    <cffunction name="GetSitemap" access="public" output="no" returntype="query" hint="Returns the sitemap below a given pageid. Default pageid is the home page. ">
    	<cfargument name="ArgsPageID" type="numeric" required="no" default="1100" hint="PageID of the page to find children of">
            
        <cfset var PageID = arguments.ArgsPageID />
        <cfset var qSitemap = 0 />
        <cfquery name="qSitemap" datasource="#variables.dsn#">
        SELECT Pageid, pagename, noderec.ToString() as Noderec, noderec.GetLevel() as Level 
        FROM pages 
        ORDER BY Noderec
        </cfquery>
        
        <cfreturn qSitemap />
    </cffunction>
    
    
    
	<cffunction name="getOwner" access="public" returntype="Page" output="no" hint="Returns the ownernode of a specified page.  Requires a valid page object.  Sets the Owner of the supplied page object.">
    	<cfargument name="argsPage" required="yes" type="Page" >
        <cfset var Page = arguments.argsPage />
        <cfset var qOwner = 0 />
        
        <cfquery name="qOwner" datasource="#variables.dsn#">
        SELECT Pageid, pagename, noderec.ToString() as Noderec, noderec.GetLevel() as Level 
        FROM pages 
        WHERE Noderec = (
        
        	SELECT noderec.GetAncestor(1).ToString() 
            FROM pages 
            WHERE Pageid=<cfqueryparam value="#page.getPageID()#" cfsqltype="cf_sql_integer" />
            )
         
          </cfquery>
          
          <cfif qOwner.recordCount GT 0 >
          	<cfset Page.setOwner( qOwner.PageID ) />          
          </cfif>    
          <cfreturn Page />

	    </cffunction>
        
        
        <cffunction name="getSiblings" access="public" returntype="query" output="no" hint="Returns a query of the sibling pages for a specified page.  Requires a valid page object.">
        	<cfargument name="argsPage" required="yes" type="Page" >
        <cfset var Page = arguments.argsPage />
        <cfset var qSiblings = 0 />
        
        <cfquery name="qSiblings" datasource="#variables.dsn#">
            SELECT Pageid, pagename, noderec.ToString() as Noderec, noderec.GetLevel() as Level 
            FROM pages 
            where noderec.GetAncestor(1) = (
           	SELECT noderec.GetAncestor(1)
            FROM pages 
            WHERE Pageid=<cfqueryparam value="#page.getPageID()#" cfsqltype="cf_sql_integer" />
            )
        	
        </cfquery>
        
        <cfreturn qSiblings />
        
        </cffunction>
    
</cfcomponent>