<cfcomponent displayname="PermissionCategories DAO" output="false" hint="DAO Component Handles all Database access for the table PermissionCategories.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    PermissionCategoriesDAO.cfc
Description: DAO Component Handles all Database access for the table PermissionCategories.  Requires Coldspring v1.0
Date:        17/Sep/2008
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="PermissionCategoriesDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="any" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
	<cfreturn this />
</cffunction>

<cffunction name="setUserService" access="public" output="false" returntype="void" hint="Dependency: User Service">
	<cfargument name="UserService" type="any" required="true"/>
	<cfset variables.UserService = arguments.UserService/>
</cffunction>


<cffunction name="save" access="public" returntype="PermissionCategory" output="false" hint="DAO method">
<cfargument name="PermissionCategory" type="PermissionCategory" required="yes" />
<!-----[  If a PermissionCategoryID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.PermissionCategory.getPermissionCategoryID() neq "0")>	
		<cfset PermissionCategory = update(arguments.PermissionCategory)/>
	<cfelse>
		<cfset PermissionCategory = create(arguments.PermissionCategory)/>
	</cfif>
	<cfreturn PermissionCategory />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="PermissionCategory" type="PermissionCategory" required="true" /> 
	<cfset var qPermissionCategoryDelete = 0 >
<cfquery name="PermissionCategoryDelete" datasource="#variables.dsn#" >
		DELETE FROM PermissionCategories
		WHERE 
		PermissionCategoryID = <cfqueryparam value="#PermissionCategory.getPermissionCategoryID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>
	
</cffunction>



<cffunction name="read" access="public" returntype="PermissionCategory" output="false" hint="DAO Method. - Reads a PermissionCategory into the bean">
<cfargument name="argsPermissionCategory" type="PermissionCategory" required="true" />
	<cfset var PermissionCategory  =  arguments.argsPermissionCategory />
	<cfset var QPermissionCategoriesselect = "" />
	<cfquery name="QPermissionCategoriesselect" datasource="#variables.dsn#">
		SELECT 
		permissioncategory, permissioncategoryid
		FROM PermissionCategories 
		WHERE 
		PermissionCategoryID = <cfqueryparam value="#PermissionCategory.getPermissionCategoryID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>
	<cfif QPermissionCategoriesselect.recordCount >
		<cfscript>
		
                     PermissionCategory.setpermissioncategory(QPermissionCategoriesselect.permissioncategory);
                     PermissionCategory.setpermissioncategoryid(QPermissionCategoriesselect.permissioncategoryid);
		</cfscript>
	</cfif>
	<cfreturn PermissionCategory />
</cffunction>
		

<cffunction name="GetAllPermissionCategories" access="public" output="false" returntype="query" hint="Returns a query of all PermissionCategories in our Database">
<cfset var QgetallPermissionCategorys = 0 />
	<cfquery name="QgetallPermissionCategorys" datasource="#variables.dsn#">
		SELECT permissioncategory, permissioncategoryid
		FROM PermissionCategories
		
		ORDER BY PermissionCategoryID
	</cfquery>
	<cfreturn QgetallPermissionCategorys />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="PermissionCategory" output="false" hint="DAO method">
<cfargument name="argsPermissionCategory" type="PermissionCategory" required="yes" displayname="create" />
	<cfset var qPermissionCategoryInsert = 0 />
	<cfset var PermissionCategory = arguments.argsPermissionCategory />
	
	<cfquery name="qPermissionCategoryInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into PermissionCategories
		( permissioncategory ) VALUES
		(
		<cfqueryparam value="#PermissionCategory.getpermissioncategory()#" cfsqltype="cf_sql_varchar"/>
		   ) 
		SELECT Ident_Current('PermissionCategories') as PermissionCategoryID
		SET NOCOUNT OFF
	</cfquery>
	<cfset PermissionCategory.setPermissionCategoryID(qPermissionCategoryInsert.PermissionCategoryID)>

	<cfreturn PermissionCategory />
</cffunction>

<cffunction name="update" access="private" returntype="PermissionCategory" output="false" hint="DAO method">
<cfargument name="argsPermissionCategory" type="PermissionCategory" required="yes" />
	<cfset var PermissionCategory = arguments.argsPermissionCategory />
	<cfset var PermissionCategoryUpdate = 0 >
	<cfquery name="PermissionCategoryUpdate" datasource="#variables.dsn#" >
		UPDATE PermissionCategories SET
		
		 
		 permissioncategory  = <cfqueryparam value="#PermissionCategory.getpermissioncategory()#" cfsqltype="cf_sql_varchar"/>
						
		WHERE 
		PermissionCategoryID = <cfqueryparam value="#PermissionCategory.getPermissionCategoryID()#" />
	</cfquery>
	
	<cfreturn PermissionCategory />
</cffunction>

</cfcomponent>