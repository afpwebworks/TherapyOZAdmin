<cfcomponent displayname="AdminMenuDAO" output="false" hint="Manages AdminMenu operations for Heirarchy datatype based setup.">
<cfsilent>
<!----
==========================================================================================================
Filename:     AdminMenuDAO.cfc
Description:  Manages AdminMenu operations for Heirarchy datatype based setup.
Client:       Hawkesbury Radio CMS v5.0
Date:         7/7/2014
Author:       Michael Kear, AFP Webworks

Revision history: 

fields in the adminmenu object: 
	MenuID numeric 0
	Description string 
	lvl numeric 0
	NodeRec string 
	URL string 
	Target string 
	Icon string inbox
	ViewPermission numeric 0
	EditPermission numeric 0
	DeletePermission numeric 0
	CreatePermission numeric 0
	InMenu boolean true
	
==========================================================================================================
--->
</cfsilent>

	<cffunction name="init" access="public" output="no" returntype="AdminMenuDAO" hint="Initialises the values required to use the component.">
   <cfargument name="argsConfiguration" required="true" type="any" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
	<cfset variables.AddNewContentAt = variables.config.getAddNewContentAt() />
	<cfreturn this />
</cffunction>

<cffunction name="setUserService" access="public" output="false" returntype="void" hint="Dependency: User Service">
	<cfargument name="UserService" type="any" required="true"/>
	<cfset variables.UserService = arguments.UserService/>
</cffunction>


<cffunction name="save" access="public" returntype="AdminMenu" output="false" hint="DAO method">
<cfargument name="AdminMenu" type="AdminMenu" required="yes" />
<!-----[  If a MenuID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.AdminMenu.getMenuID() neq "0")>	
		<cfset AdminMenu = update(arguments.AdminMenu)/>
	<cfelse>
		<cfset AdminMenu = create(arguments.AdminMenu)/>
	</cfif>
	<cfreturn AdminMenu />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="AdminMenu" type="AdminMenu" required="true" /> 
	<cfset var qAdminMenuDelete = 0 >
<cfquery name="AdminMenuDelete" datasource="#variables.dsn#" >
		DELETE FROM AdminMenu
		WHERE 
		MenuID = <cfqueryparam value="#AdminMenu.getMenuID()#"  cfsqltype="CF_SQL_VARCHAR"/>
	</cfquery>
	
</cffunction>



<cffunction name="read" access="public" returntype="AdminMenu" output="false" hint="Reads a AdminMenu into the bean">
<cfargument name="argsAdminMenu" type="AdminMenu" required="true" />
	<cfset var AdminMenu  =  arguments.argsAdminMenu />
	<cfset var QAdminMenuselect = "" />
	<cfquery name="QAdminMenuselect" datasource="#variables.dsn#">
		SELECT 
		menuid, NodeRec.ToString() as NodeRec, lvl, URL, Target, Icon, ViewPermission, EditPermission, DeletePermission, CreatePermission, InMenu, Description
		FROM AdminMenu 
		WHERE 
		MenuID = <cfqueryparam value="#AdminMenu.getMenuID()#"  cfsqltype="CF_SQL_integer"/>
	</cfquery>
	<cfif QAdminMenuselect.recordCount >
		<cfscript>
		 AdminMenu.setmenuid(QAdminMenuselect.menuid);
         AdminMenu.setNodeRec(QAdminMenuselect.NodeRec);
         AdminMenu.setlvl(QAdminMenuselect.lvl);
         AdminMenu.setURL(QAdminMenuselect.URL);
         AdminMenu.setTarget(QAdminMenuselect.Target);
         AdminMenu.setIcon(QAdminMenuselect.Icon);
		 if (isnumeric(QAdminMenuselect.ViewPermission)) AdminMenu.setViewPermission(QAdminMenuselect.ViewPermission);
         if (isnumeric(QAdminMenuselect.EditPermission)) AdminMenu.setEditPermission(QAdminMenuselect.EditPermission);
         if (isnumeric(QAdminMenuselect.DeletePermission)) AdminMenu.setDeletePermission(QAdminMenuselect.DeletePermission);
         if (isnumeric(QAdminMenuselect.CreatePermission)) AdminMenu.setCreatePermission(QAdminMenuselect.CreatePermission);
         AdminMenu.setInMenu(QAdminMenuselect.InMenu);
         AdminMenu.setDescription(QAdminMenuselect.Description);         
		</cfscript>
	</cfif>
	<cfreturn AdminMenu />
</cffunction>
		
        
<cffunction name="readMenufromCGI" access="public" output="no"  returntype="AdminMenu" hint="Populates an Adminmenu object given an adminmenu and the URL">
	<cfargument name="argsAdminmenu" type="adminmenu" required="true">
    <cfset var AdminMenu = arguments.argsAdminMenu />
    <cfset var QAdminMenuselect = 0 />
    <cfset var adminmeuURL = '' />
    

    <cfquery name="QAdminMenuselect" datasource="#variables.dsn#">
    	SELECT top 1
		menuid, NodeRec.ToString() as NodeRec, lvl, URL, Target, Icon, ViewPermission, EditPermission, DeletePermission, CreatePermission, InMenu, Description
		FROM AdminMenu 
		WHERE 
		MenuID in (SELECT Menuid from adminmenu 
        WHERE URL = <cfqueryparam value="#adminmenu.geturl()#" cfsqltype="cf_sql_varchar" />  )  
        order by NodeRec
    </cfquery>
    <cfscript>
		 AdminMenu.setmenuid(QAdminMenuselect.menuid);
         AdminMenu.setNodeRec(QAdminMenuselect.NodeRec);
         AdminMenu.setlvl(QAdminMenuselect.lvl);
         AdminMenu.setURL(QAdminMenuselect.URL);
         AdminMenu.setTarget(QAdminMenuselect.Target);
         AdminMenu.setIcon(QAdminMenuselect.Icon);
		 if (isnumeric(QAdminMenuselect.ViewPermission)) AdminMenu.setViewPermission(QAdminMenuselect.ViewPermission);
         if (isnumeric(QAdminMenuselect.EditPermission)) AdminMenu.setEditPermission(QAdminMenuselect.EditPermission);
         if (isnumeric(QAdminMenuselect.DeletePermission)) AdminMenu.setDeletePermission(QAdminMenuselect.DeletePermission);
         if (isnumeric(QAdminMenuselect.CreatePermission)) AdminMenu.setCreatePermission(QAdminMenuselect.CreatePermission);
         AdminMenu.setInMenu(QAdminMenuselect.InMenu);
         AdminMenu.setDescription(QAdminMenuselect.Description);         
		</cfscript>
       <cfreturn adminMenu />   
    
</cffunction>       


<cffunction name="readFromNodeRec" access="public" output="no" returntype="AdminMenu" hint="REturns an AdminMenu object given an adminmenu where we only know the NodeRec" >
	<cfargument name="argsAdminmenu" type="AdminMenu" required="true">
    <cfset var AdminMenu = arguments.argsAdminMenu />
    <cfset var qAdminMenu = 0 />
    
    <!----[  Find out the menuid related to the NodeRec given  ]----MK ---->
    <cfquery name="qAdminMenu" datasource="#variables.dsn#">
    	SELECT Menuid from AdminMenu where NodeRec= <cfqueryparam value="#adminMenu.getNodeRec()#" />
    </cfquery>
    
    <cfset adminmenu.setMenuid(  qAdminMenu.menuid ) />
    <cfset read( adminmenu ) />
    <cfreturn adminmenu />
    
   </cffunction>     


<cffunction name="getChildren" access="public" output="no" returntype="query" hint="Returns a query of the children of an adminmenu object.">
	<cfargument name="argsAdminMenu" type="adminmenu" required="yes" />
    <cfset var Menuid = arguments.argsAdminMenu.getMenuID() />
    <cfset var qChildren = 0 />
    <cfquery name="qChildren" datasource="#variables.dsn#">
        select url,icon,description, target, lvl, NodeRec.ToString() Path, createpermission,viewpermission,deletepermission,viewpermission
        from AdminMenu
        where  NodeRec.GetAncestor(1) = (
            select NodeRec 
            from AdminMenu 
            where menuid=<cfqueryparam value="#menuid#" cfsqltype="cf_sql_integer" />
        )
   		order by path
	</cfquery>
	<cfreturn qChildren />
</cffunction>


<cffunction name="getSiblings" access="public" output="no" returntype="query" hint="Returns a query of the siblings of an adminmenu object.">
	<cfargument name="argsAdminMenu" type="adminmenu" required="yes" />
    <cfset var thismenu = arguments.argsAdminmenu />
    <cfset var Menuid = arguments.argsAdminMenu.getMenuID() />
    <cfset var qSiblings = 0 />
    
    <!----[    ]----MK ---->
    <cfscript>
	//Find parent of this adminmenu.
     parent = getParent( thismenu );
	 // get the children of the parent (i.e. this menu's siblings) 
	 qSiblings = getChildren( parent );
     </cfscript>
    
	<cfreturn qSiblings />
</cffunction>

<cffunction name="getRoot" access="public" output="no" returntype="adminmenu" hint="returns a adminmenu object of the root item.">
	<cfset var rootMenu = application.beanfactory.getbean("adminmenu") />
    <cfset var qRoot = 0 />
    <cfquery name="qRoot" datasource="#variables.dsn#">
        SELECT menuid
        FROM AdminMenu
        WHERE NodeRec = hierarchyid::GetRoot();
	</cfquery>
	<cfset rootMenu.setMenuID( qRoot.menuid ) />
    <cfset read( rootMenu ) />
    <cfreturn rootMenu />
</cffunction>

<cffunction name="getMainHeadings" access="public" output="no" returntype="query" hint="Returns a query of the immediate children of the root object.">
	<cfset var qmainheads = 0 />
    <cfset qMainheads = getChildren(  getRoot() ) />
	<cfreturn qMainHeads />
</cffunction>

<cffunction name="getqSitemap" access="public" output="yes" returntype="query" hint="Returns a query in NodeRec order of the sitemap">
<cfargument name="argsTopPage" type="string" default="/" />
	<cfset var qsitemap = 0 />
    <cfset var TopPage = arguments.argsTopPage />
    
    <cfquery name="qsitemap" datasource="#variables.dsn#">
    	SELECT NodeRec.ToString() Path, url, icon, description, target, lvl, createpermission, viewpermission, deletepermission, viewpermission
		FROM AdminMenu
		WHERE NodeRec.IsDescendantOf('#TopPage#')='1' AND
        inmenu='1'
		ORDER BY NodeRec
    </cfquery>
    <cfreturn qsitemap />
</cffunction>


<cffunction name="getBreadcrumb" access="public" returntype="query">
	<cfargument name="argsadminmenu" type="any" required="yes">
    <cfset var 	adminmenu = arguments.argsadminmenu />
    <cfset var qbreadcrumb =0 />
    
    <cfquery name="qbreadcrumb" datasource="#variables.dsn#" >
    SELECT parent.menuid, parent.url, parent.icon, parent.description, parent.lvl 
    FROM AdminMenu as parent 
      INNER JOIN AdminMenu as child 
       ON  
		 <cfif adminmenu.getmenuid() neq '0'> 
	       child.menuid = <cfqueryparam value="#adminmenu.getmenuid()#" />
         <cfelse>
       		child.NodeRec = <cfqueryparam value="#adminmenu.getNodeRec()#" />
       </cfif> 
        AND
       child.NodeRec.IsDescendantOf(parent.NodeRec) = 1
    
    </cfquery>   
      <cfreturn qbreadcrumb>
	</cffunction>
    
    
     <cffunction name="getAncestor" access="public" output="no" returntype="AdminMenu" hint="Returns the immediate ancestor of a submitted node hierarchyID">
     <cfargument name="argsadminmenu" type="any" required="yes">
     <cfset var adminmenu = arguments.argsadminmenu />
     <cfset var qgetAncestor = ''/>
  
    <cfquery name="qgetAncestor" datasource="#variables.dsn#">
    	select NodeRec.GetAncestor('1').ToString() as ancestor from adminmenu 
        where NodeRec =  <cfqueryparam value="#adminmenu.getNodeRec()#" />
     </cfquery>
  <!----[    set our adminmenu object to this new menuid  ]----MK ---->
  <cfset adminmenu.setNodeRec(  qgetAncestor.ancestor ) />
   <cfset readFromNodeRec(adminmenu) />
   <cfreturn adminmenu />
       
 </cffunction> 
    
 
<cffunction name="getParent" access="public" output="no" returntype="adminmenu" hint="Returns an adminmenu object, the parent of the adminmenu submitted.">
	<cfargument name="argsAdminMenu" type="adminmenu" required="yes" />
    <cfset var thisAdminMenu = arguments.argsAdminMenu />
    <cfset var Menuid = arguments.argsAdminMenu.getMenuID() />
    <cfset var qParent = 0 />
    <cfquery name="qParent" datasource="#variables.dsn#">
        DECLARE @parent hierarchyid, @thismenu hierarchyid;
        SELECT @thismenu = NodeRec FROM AdminMenu
        WHERE menuid = <cfqueryparam value="#menuid#" cfsqltype="cf_sql_integer" /> ;
        select menuid
        from AdminMenu 
        where NodeRec=@thismenu.GetAncestor(1) ;
    </cfquery>
	<cfset thisAdminMenu.setMenuID(  qParent.menuid ) />
	<cfset read(thisAdminMenu) />
    <cfreturn thisAdminMenu />
</cffunction>



<cffunction name="GetAllAdminMenus" access="public" output="false" returntype="query" hint="Returns a query of all AdminMenus in our Database">
<cfset var QgetallAdminMenus = 0 />
	<cfquery name="QgetallAdminMenus" datasource="#variables.dsn#">
        SELECT menuid, NodeRec.ToString() path, lvl, URL, Target, Icon, ViewPermission, EditPermission, DeletePermission, CreatePermission, InMenu, Description, 
        left( replicate('..', lvl) + right(' ', lvl) + description, 256) as MENUDesc  
		FROM AdminMenu 
		ORDER BY path, MenuID
	</cfquery>
	<cfreturn QgetallAdminMenus />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="AdminMenu" output="false" hint="DAO method - creates a new menuid underneath 'ownermenuid' ">
<cfargument name="argsAdminMenu" type="AdminMenu" required="yes" displayname="adminMenuObj" />
<cfargument name="argsOwnerMenuID" type="numeric" required="yes" displayname="ownernodeID"/>
	<cfset var qAdminMenuInsert = 0 />
	<cfset var AdminMenu = arguments.argsAdminMenu />
    <cfset var ownermenuid = 0 />
	<!----[  Note:  Lvl is a computed field, so does not need to be inserted in the 'create' method.  ]----MK ---->
    
    <cfstoredproc procedure="usp_AddAdminMenu" datasource="#variables.dsn#"> 
          <cfprocparam value="#ownermenuid#" cfsqltype="CF_SQL_INTEGER">
          <cfprocparam value="#AdminMenu.geturl()#" cfsqltype="cf_sql_varchar"> 
          <cfprocparam value="#AdminMenu.gettarget()#" cfsqltype="cf_sql_varchar"> 
          <cfprocparam value="#AdminMenu.geticon()#" cfsqltype="cf_sql_varchar">
          <cfprocparam value="#AdminMenu.getdescription()#" cfsqltype="CF_SQL_VARCHAR" /> 
          <cfprocparam value="#AdminMenu.getviewpermission()#" cfsqltype="CF_SQL_INTEGER"> 
          <cfprocparam value="#AdminMenu.geteditpermission()#" cfsqltype="CF_SQL_INTEGER" > 
          <cfprocparam value="#AdminMenu.getcreatepermission()#" cfsqltype="CF_SQL_INTEGER"> 
          <cfprocparam value="#AdminMenu.getdeletepermission()#" cfsqltype="CF_SQL_INTEGER">
          <cfprocparam value="#AdminMenu.getinmenu()#" cfsqltype="CF_SQL_BIT" /> 
          <cfprocparam type="out" variable="menuid" cfsqltype="CF_SQL_INTEGER"  >
     </cfstoredproc>
     
     
  <cfset adminmenu.setMenuid( usp_AddAdminMenu.menuid )  />
  <cfset read(adminmenu) />
  
  <cfreturn adminmenu />





<!----[  	<cfquery name="qAdminMenuInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into AdminMenu
		( NodeRec, URL, Target, Icon, ViewPermission, EditPermission, DeletePermission, CreatePermission, InMenu, Description ) VALUES
		(

		<cfqueryparam value="#AdminMenu.getNodeRec()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#AdminMenu.geturl()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#AdminMenu.gettarget()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#AdminMenu.geticon()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#AdminMenu.getviewpermission()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#AdminMenu.geteditpermission()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#AdminMenu.getdeletepermission()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#AdminMenu.getcreatepermission()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#AdminMenu.getinmenu()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#AdminMenu.getdescription()#" cfsqltype="CF_SQL_VARCHAR" />
		   ) 
		SELECT Ident_Current('AdminMenu') as MenuID
		SET NOCOUNT OFF
	</cfquery>
	<cfset AdminMenu.setMenuID(qAdminMenuInsert.MenuID)>
    <cfset AdminMenu.setLvl( qAdminMenuInsert.NodeRec.GetLevel()  ) />

	<cfreturn AdminMenu />  ]----MK ---->
</cffunction>

<cffunction name="update" access="private" returntype="AdminMenu" output="false" hint="DAO method">
<cfargument name="argsAdminMenu" type="AdminMenu" required="yes" />
	<cfset var AdminMenu = arguments.argsAdminMenu />
	<cfset var AdminMenuUpdate = 0 >
	<!----[  Note:  Lvl is a computed field, so does not need to be touched in the 'updated' method.  ]----MK ---->
    
    <cfquery name="AdminMenuUpdate" datasource="#variables.dsn#" >
		UPDATE AdminMenu SET
        NodeRec  = <cfqueryparam value="#AdminMenu.getNodeRec()#" cfsqltype="CF_SQL_VARCHAR"/>,
        url  = <cfqueryparam value="#AdminMenu.getURL()#" cfsqltype="CF_SQL_VARCHAR"/>,
        target  = <cfqueryparam value="#AdminMenu.getTarget()#" cfsqltype="CF_SQL_VARCHAR"/>,
        icon  = <cfqueryparam value="#AdminMenu.getIcon()#" cfsqltype="CF_SQL_VARCHAR"/>,
        viewpermission  = <cfqueryparam value="#AdminMenu.getViewPermission()#" cfsqltype="CF_SQL_INTEGER"/>,
        editpermission  = <cfqueryparam value="#AdminMenu.getEditPermission()#" cfsqltype="CF_SQL_INTEGER"/>,
        deletepermission  = <cfqueryparam value="#AdminMenu.getDeletePermission()#" cfsqltype="CF_SQL_INTEGER"/>,
        createpermission  = <cfqueryparam value="#AdminMenu.getCreatePermission()#" cfsqltype="CF_SQL_INTEGER"/>,
        inmenu  = <cfqueryparam value="#AdminMenu.getInMenu()#" cfsqltype="CF_SQL_BIT"/>,
        description  = <cfqueryparam value="#AdminMenu.getDescription()#" cfsqltype="CF_SQL_VARCHAR"/>
						
		WHERE 
		MenuID = <cfqueryparam value="#AdminMenu.getMenuID()#"   cfsqltype="CF_SQL_VARCHAR" />
	</cfquery>
	
	<cfreturn AdminMenu />
</cffunction>

</cfcomponent>
