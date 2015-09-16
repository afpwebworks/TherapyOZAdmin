<cfcomponent displayname="SiteContacts DAO" output="false" hint="DAO Component Handles all Database access for the table SiteContacts.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    SiteContactsDAO.cfc
Description: DAO Component Handles all Database access for the table SiteContacts.  Requires Coldspring v1.0
Date:        23/Sep/2008
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="SiteContactsDAO" output="false" hint="Initialises the controller">
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


<cffunction name="save" access="public" returntype="SiteContact" output="false" hint="DAO method">
<cfargument name="SiteContact" type="SiteContact" required="yes" />
<!-----[  If a ContactID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.SiteContact.getContactID() neq "0")>	
		<cfset SiteContact = update(arguments.SiteContact)/>
	<cfelse>
		<cfset SiteContact = create(arguments.SiteContact)/>
	</cfif>
	<cfreturn SiteContact />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="SiteContact" type="SiteContact" required="true" /> 
	<cfset var qSiteContactDelete = 0 >
<!-----[  to delete, set 'IsVisible' flag to zero  ]--->
		<cfquery name="qSiteContactDelete" datasource="#variables.dsn#" >
		UPDATE SiteContacts
		Set IsVisible = '0'
		WHERE 
		ContactID = <cfqueryparam value="#SiteContact.getContactID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>	
</cffunction>


<cffunction name="UnDelete" returntype="void" output="false" hint="DAO method" >
<cfargument name="SiteContact" type="SiteContact" required="true" /> 
	<cfset var qSiteContactUnDelete = 0 >
<!-----[  to UnDelete, set 'IsVisible' flag to 1 (true)  ]--->
		<cfquery name="qSiteContactDelete" datasource="#variables.dsn#" >
		UPDATE SiteContacts
		Set IsVisible = '1'
		WHERE 
		ContactID = <cfqueryparam value="#SiteContact.getContactID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>	
</cffunction>



<cffunction name="read" access="public" returntype="SiteContact" output="false" hint="DAO Method. - Reads a SiteContact into the bean">
<cfargument name="argsSiteContact" type="SiteContact" required="true" />
	<cfset var SiteContact  =  arguments.argsSiteContact />
	<cfset var QSiteContactsselect = "" />
	<cfquery name="QSiteContactsselect" datasource="#variables.dsn#">
		SELECT 
		addedby, contactid, dateadded, dateupdated, isvisible, sortcode, title, updatedby, userid
		FROM SiteContacts 
		WHERE 
		IsVisible = '1' AND
		ContactID = <cfqueryparam value="#SiteContact.getContactID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>
	<cfif QSiteContactsselect.recordCount >
		<cfscript>
		
                     SiteContact.setaddedby(QSiteContactsselect.addedby);
                     SiteContact.setcontactid(QSiteContactsselect.contactid);
                     SiteContact.setdateadded(QSiteContactsselect.dateadded);
                     SiteContact.setdateupdated(QSiteContactsselect.dateupdated);
                     SiteContact.setisvisible(QSiteContactsselect.isvisible);
                     SiteContact.setsortcode(QSiteContactsselect.sortcode);
                     SiteContact.settitle(QSiteContactsselect.title);
                     SiteContact.setupdatedby(QSiteContactsselect.updatedby);
                     SiteContact.setuserid(QSiteContactsselect.userid);
		</cfscript>
	</cfif>
	<cfreturn SiteContact />
</cffunction>
		

<cffunction name="GetAllSiteContacts" access="public" output="false" returntype="query" hint="Returns a query of all SiteContacts in our Database">
<cfset var QgetallSiteContacts = 0 />
	<cfquery name="QgetallSiteContacts" datasource="#variables.dsn#">
		SELECT c.addedby, c.contactid, c.dateadded, c.dateupdated, c.isvisible, c.sortcode, c.title, c.updatedby, c.userid,
		u.UserFirstname + ' ' + u.UserLastname as Username
		FROM SiteContacts c, users u
		
		WHERE c.IsVisible = '1' AND
		u.userid = c.userid
		
		ORDER BY c.sortcode,c.ContactID
	</cfquery>
	<cfreturn QgetallSiteContacts />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="SiteContact" output="false" hint="DAO method">
<cfargument name="argsSiteContact" type="SiteContact" required="yes" displayname="create" />
	<cfset var qSiteContactInsert = 0 />
	<cfset var SiteContact = arguments.argsSiteContact />
	 <cfset SiteContact.setSortCode(FindNewSortCode())>
	<cfquery name="qSiteContactInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into SiteContacts
		( addedby, dateadded, dateupdated, isvisible, sortcode, title, updatedby, userid ) VALUES
		(
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
		<cfqueryparam value="#SiteContact.getisvisible()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#SiteContact.getsortcode()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#SiteContact.gettitle()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#SiteContact.getuserid()#" cfsqltype="cf_sql_varchar"/>
		   ) 
		SELECT Ident_Current('SiteContacts') as ContactID
		SET NOCOUNT OFF
	</cfquery>
	<cfset SiteContact.setContactID(qSiteContactInsert.ContactID)>

	<cfreturn SiteContact />
</cffunction>

<cffunction name="update" access="private" returntype="SiteContact" output="false" hint="DAO method">
<cfargument name="argsSiteContact" type="SiteContact" required="yes" />
	<cfset var SiteContact = arguments.argsSiteContact />
	<cfset var SiteContactUpdate = 0 >
	<cfquery name="SiteContactUpdate" datasource="#variables.dsn#" >
		UPDATE SiteContacts SET
		
		 
		 dateupdated  = <cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
		 isvisible  = <cfqueryparam value="#SiteContact.getisvisible()#" cfsqltype="cf_sql_varchar"/>,
		 sortcode  = <cfqueryparam value="#SiteContact.getsortcode()#" cfsqltype="cf_sql_varchar"/>,
		 title  = <cfqueryparam value="#SiteContact.gettitle()#" cfsqltype="cf_sql_varchar"/>,
		 updatedby  = <cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>,
		 userid  = <cfqueryparam value="#SiteContact.getuserid()#" cfsqltype="cf_sql_varchar"/>
						
		WHERE 
		ContactID = <cfqueryparam value="#SiteContact.getContactID()#" />
	</cfquery>
	
	<cfreturn SiteContact />
</cffunction>


<cffunction name="moveUP" access="public" output="false" returntype="SiteContact" hint="Moves a contact up in the sort order.  If the contact is already at the top, does nothing." >
<cfargument name="SiteContact" required="yes" type="SiteContact" />
<cfset var thissortcode = arguments.SiteContact.getSortcode() />
<cfif arguments.SiteContact.getsortcode() GT "1">
	<cfquery name="movenextonedown" datasource="#variables.dsn#">
		UPDATE SiteContacts SET sortcode = sortcode + 1
		WHERE sortcode = (#thissortcode# - 1)
		</cfquery>
	<cfquery name="movethisoneup" datasource="#variables.dsn#">	
		UPDATE SiteContacts SET sortcode = sortcode - 1
		WHERE contactid = '#arguments.SiteContact.getcontactid()#'
	</cfquery>
	<cfset arguments.SiteContact.setSortcode(thissortcode-1) />
</cfif>
<cfreturn arguments.SiteContact />

</cffunction>

<cffunction name="moveDown" access="public" output="false" returntype="SiteContact" hint="Moves a contact down in the sort order. If it is already at the bottom of the list, nothing happens." >

<cfargument name="SiteContact" required="yes" type="SiteContact" />
<cfset var thissortcode = arguments.SiteContact.getSortcode() />
	<!----[  Find the sort code of the bottom item  ]---->
	<cfquery name="getbottomcode" datasource="#variables.dsn#">
		SELECT max(sortcode) as bottom
		FROM SiteContacts
	</cfquery>
<cfif arguments.SiteContact.getsortcode() LT  getbottomcode.bottom>
	<cfquery name="movenextonedown" datasource="#variables.dsn#">
		UPDATE SiteContacts SET sortcode = sortcode - 1
		WHERE sortcode = (#thissortcode# + 1)
	</cfquery>
	<cfquery name="movethisoneup" datasource="#variables.dsn#">	
		UPDATE SiteContacts SET sortcode = sortcode + 1
		WHERE contactid = '#arguments.SiteContact.getcontactid()#'
	</cfquery>
	<cfset arguments.SiteContact.setSortcode(thissortcode+1) />
</cfif>
<cfreturn arguments.SiteContact />
</cffunction>

<cffunction name="FindNewSortCode" access="public" output="true" returntype="numeric" hint="Finds the new sort code for an added Site Contact" >
	<cfif variables.AddNewContentAt eq "end">
	<!----[  Find sort order to add content at the end of the page  ]---->
		<cfquery name="findsortorder" datasource="#variables.dsn#">
			SELECT max(sortcode) as maxsortcode from SiteContacts 
		</cfquery>
		<cfif findsortorder.maxsortcode GT "0">
			<cfset 	newsortcode = #findsortorder.maxsortcode# + 1 />		
		<cfelse>
		    <cfset newsortcode = "1" />
		</cfif>		
	<cfelse> 
	<!----[  Move all the other items down one position then set sortorder = '1'  ]---->	
		<cfquery name="MoveAllDown" datasource="#variables.dsn#">
			Update SiteContacts set sortcode = sortcode + 1 
		</cfquery>
		<cfset newsortcode = "1" />	
	</cfif>
	<cfreturn newsortcode />
</cffunction>



</cfcomponent>