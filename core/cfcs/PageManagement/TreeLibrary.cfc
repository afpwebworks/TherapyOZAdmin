<cfcomponent displayname="TreeLibrary" output="false" hint="Manipulates pages in the tree.">

<cfsilent>
<!----
==========================================================================================================
Filename:     TreeLibrary.cfc
Description:  Manipulates pages in the tree.
Date:         20/8/2015
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
</cfsilent>

<cffunction name="init" access="public" output="no" returntype="TreeLibrary" hint="Initialises the values required to use the component.">
   <cfargument name="argsConfiguration" required="true" type="any" />
	<cfset var config  = arguments.argsConfiguration />
	<cfset variables.config = arguments.argsConfiguration />
	<cfset variables.dsn = config.getDSN() />
	<cfreturn this />
</cffunction>

<cffunction name="setUserService" access="public" output="false" returntype="void" hint="Dependency: User Service">
	<cfargument name="UserService" type="any" required="true"/>
	<cfset variables.UserService = arguments.UserService/>
</cffunction>

<!----[      
==================================================================================================================
Basic reporting functions
==================================================================================================================
  ]----MK ---->
 <cffunction name="Read" access="public" output="false" returntype="Page" hint="Reads the content of the page from the database.">
 	<cfargument name="argsPage" required="true" type="Page" />
    	<cfset var Page = arguments.argsPage />
        <cfset var qPage = 0 />
        
        <cfquery name="qPage" datasource="#variables.dsn#">
        	SELECT Pageid, pagename, noderec.ToString() as Noderec, nodeRec.GetLevel() as Level 
            FROM Pages
            WHERE  PageID = <cfqueryparam value="#page.getPageID()#" cfsqltype="cf_sql_integer" />
            AND IsVisible = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
        </cfquery>
        
        <cfif qPage.recordCount >
		<cfscript>
		
                     Page.setPageID(qPage.Pageid);
                     Page.setPageName(qPage.pagename);
                     Page.setNodeRec(qPage.Noderec);
					 Page.setLevel(qPage.Level);
                     
		</cfscript>
        <cfset getOwner(Page) />
	</cfif>
	<cfreturn Page />
 </cffunction> 
  
<!----[      
==================================================================================================================
Funtions to insert, update and move pages around the tree.
==================================================================================================================
  ]----MK ---->	
  
<cffunction name="save" access="public" returntype="Page" output="false" hint="DAO method">
  <cfargument name="Page" type="Page" required="yes" />
	<!-----[  If a PageID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
    <cfif (arguments.Page.getPageID() neq "0")>	
		<cfset Page = update(arguments.Page)/>
	<cfelse>
		<cfset Page = InsertPage(arguments.Page)/>
	</cfif>
	<cfreturn Page />
</cffunction>


<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="Page" type="Page" required="true" /> 
	<cfset var qPageDelete = 0 >
<!-----[  to delete, set 'IsVisible' flag to zero  ]--->
		<cfquery name="qPageDelete" datasource="#variables.dsn#" >
		UPDATE Pages
		Set IsVisible = '0'
		WHERE 
		PageID = <cfqueryparam value="#Page.getPageID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>	
</cffunction>





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