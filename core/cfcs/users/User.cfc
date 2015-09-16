<cfcomponent displayname="User" output="false" hint="A bean which models the User record.">

<cfsilent>
<!----
================================================================
Filename: User.cfc
Description: A bean which models the User record.
Author:  Michael Kear, AFP Webworks 
Date: 2/Sep/2015
================================================================
This bean was generated with the following template:
Bean Name: User
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	Userid numeric 0
	UserLogin string 
	UserPassword string 
	UserAccessLevel numeric 1
	UserFirstname string 
	UserLastName string 
	Email string 
	UserIp string 
	UserLastLogin any #now()#
	UserTotalLogins numeric 0
	UserActive boolean true
	isVisible boolean true
	Phone string 
	Title string 
	Address1 string 
	Address2 string 
	City string 
	State string NSW
	Postcode string 
	Country String Australia
	DateAdded any #now()#
	AddedBy string 
	DateUpdated any #now()#
	UpdatedBy string 
	Permissions string 10000
	AdminMenus string 0
	UserGroups string 1
	isLoggedIn boolean false
Create getSnapshot method: true
Create setSnapshot method: false
Create setStepInstance method: false
Create validate method: true
Create validate interior: true
Create LTO methods: false
Path to LTO: 
Date Format: DD/MM/YYYY
--->
</cfsilent>
	<!---[	PROPERTIES	]--->
	<cfset variables.instance = StructNew() />

	<!---[ 	INITIALIZATION / CONFIGURATION	]--->
	<cffunction name="init" access="public" returntype="User" output="false">
		<cfargument name="UserID" type="numeric" required="true" default="0" />
    <cfargument name="UserLogin" type="string" required="true" default="" />
    <cfargument name="UserPassword" type="string" required="true" default="" />
    <cfargument name="UserAccessLevel" type="numeric" required="false" default="1" />
    <cfargument name="UserFirstname" type="string" required="false" default="" />
    <cfargument name="UserLastName" type="string" required="false" default="" />
    <cfargument name="Email" type="string" required="false" default="" />
    <cfargument name="UserIp" type="string" required="false" default="" />
    <cfargument name="UserLastLogin" type="date" required="false" default="#now()#" />
    <cfargument name="UserTotalLogins" type="numeric" required="true" default="0" />
    <cfargument name="UserActive" type="boolean" required="true" default="true" />
    <cfargument name="IsVisible" type="boolean" required="true" default="true" />
    <cfargument name="Phone" type="string" required="false" default="" />
    <cfargument name="Mobile" type="string" required="false" default="" />
    <cfargument name="Title" type="string" required="false" default="" />
    <cfargument name="Address1" type="string" required="false" default="" />
    <cfargument name="Address2" type="string" required="false" default="" />
    <cfargument name="City" type="string" required="false" default="" />
    <cfargument name="State" type="string" required="false" default="" />
    <cfargument name="Postcode" type="string" required="false" default="" />
    <cfargument name="Country" type="string" required="false" default="" />
    <cfargument name="DateAdded" type="date" required="true" default="#now()#" />
    <cfargument name="AddedBy" type="string" required="false" default="" />
    <cfargument name="DateUpdated" type="date" required="true" default="#now()#" />
    <cfargument name="UpdatedBy" type="string" required="false" default="" />
    <cfargument name="Permissions" type="string" required="false" default="10000" />
	<cfargument name="AdminMenus" type="string" required="false" default="0" />
	<cfargument name="UserGroups" type="string" required="false" default="1" />
	<cfargument name="isLoggedIn" type="boolean" required="false" default="false" />
		<cfscript>
			// run setters
			setUserid(arguments.Userid);
			setUserLogin(arguments.UserLogin);
			setUserPassword(arguments.UserPassword);
			setUserAccessLevel(arguments.UserAccessLevel);
			setUserFirstname(arguments.UserFirstname);
			setUserLastName(arguments.UserLastName);
			setEmail(arguments.Email);
			setUserIp(arguments.UserIp);
			setUserLastLogin(arguments.UserLastLogin);
			setUserTotalLogins(arguments.UserTotalLogins);
			setUserActive(arguments.UserActive);
			setIsVisible(arguments.isVisible);
			setPhone(arguments.Phone);
			setTitle(arguments.Title);
			setAddress1(arguments.Address1);
			setAddress2(arguments.Address2);
			setCity(arguments.City);
			setState(arguments.State);
			setPostcode(arguments.Postcode);
			setCountry(arguments.Country);
			setDateAdded(arguments.DateAdded);
			setAddedBy(arguments.AddedBy);
			setDateUpdated(arguments.DateUpdated);
			setUpdatedBy(arguments.UpdatedBy);
			setPermissions(arguments.Permissions);
			setAdminMenus(arguments.AdminMenus);
			setUserGroups(arguments.UserGroups);
			setIsLoggedIn(arguments.isLoggedIn);
			return this;
		</cfscript>
 	</cffunction>

	<!---[ 	PUBLIC FUNCTIONS 	]--->
	<cffunction name="getSnapshot" access="public"returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

      <cffunction name="validate" access="public" returntype="any" output="false">
                    <cfargument name="eH" required="true" type="any" />
            <!-----[ validation parameters  (customise to suit) then remove comments     

                  <!----[ UserID ]---->
                <cfif ( getUserID() eq whatever )>
                    <cfset arguments.eH.setError("UserID", "UserID This is the error message") />
                </cfif>
  
                  <!----[ UserLogin ]---->
                <cfif ( getUserLogin() eq whatever )>
                    <cfset arguments.eH.setError("UserLogin", "UserLogin This is the error message") />
                </cfif>
  
                  <!----[ UserPassword ]---->
                <cfif ( getUserPassword() eq whatever )>
                    <cfset arguments.eH.setError("UserPassword", "UserPassword This is the error message") />
                </cfif>
  
                  <!----[ UserAccessLevel ]---->
                <cfif ( getUserAccessLevel() eq whatever )>
                    <cfset arguments.eH.setError("UserAccessLevel", "UserAccessLevel This is the error message") />
                </cfif>
  
                  <!----[ UserFirstname ]---->
                <cfif ( getUserFirstname() eq whatever )>
                    <cfset arguments.eH.setError("UserFirstname", "UserFirstname This is the error message") />
                </cfif>
  
                  <!----[ UserLastName ]---->
                <cfif ( getUserLastName() eq whatever )>
                    <cfset arguments.eH.setError("UserLastName", "UserLastName This is the error message") />
                </cfif>
  
                  <!----[ Email ]---->
                <cfif ( getEmail() eq whatever )>
                    <cfset arguments.eH.setError("Email", "Email This is the error message") />
                </cfif>
  
                  <!----[ UserIp ]---->
                <cfif ( getUserIp() eq whatever )>
                    <cfset arguments.eH.setError("UserIp", "UserIp This is the error message") />
                </cfif>
  
                  <!----[ UserLastLogin ]---->
                <cfif ( getUserLastLogin() eq whatever )>
                    <cfset arguments.eH.setError("UserLastLogin", "UserLastLogin This is the error message") />
                </cfif>
  
                  <!----[ UserTotalLogins ]---->
                <cfif ( getUserTotalLogins() eq whatever )>
                    <cfset arguments.eH.setError("UserTotalLogins", "UserTotalLogins This is the error message") />
                </cfif>
  
                  <!----[ UserActive ]---->
                <cfif ( getUserActive() eq whatever )>
                    <cfset arguments.eH.setError("UserActive", "UserActive This is the error message") />
                </cfif>
  
                  <!----[ IsVisible ]---->
                <cfif ( getIsVisible() eq whatever )>
                    <cfset arguments.eH.setError("IsVisible", "IsVisible This is the error message") />
                </cfif>
  
                  <!----[ Phone ]---->
                <cfif ( getPhone() eq whatever )>
                    <cfset arguments.eH.setError("Phone", "Phone This is the error message") />
                </cfif>
  
                  <!----[ Mobile ]---->
                <cfif ( getMobile() eq whatever )>
                    <cfset arguments.eH.setError("Mobile", "Mobile This is the error message") />
                </cfif>
  
                  <!----[ Title ]---->
                <cfif ( getTitle() eq whatever )>
                    <cfset arguments.eH.setError("Title", "Title This is the error message") />
                </cfif>
  
                  <!----[ Address1 ]---->
                <cfif ( getAddress1() eq whatever )>
                    <cfset arguments.eH.setError("Address1", "Address1 This is the error message") />
                </cfif>
  
                  <!----[ Address2 ]---->
                <cfif ( getAddress2() eq whatever )>
                    <cfset arguments.eH.setError("Address2", "Address2 This is the error message") />
                </cfif>
  
                  <!----[ City ]---->
                <cfif ( getCity() eq whatever )>
                    <cfset arguments.eH.setError("City", "City This is the error message") />
                </cfif>
  
                  <!----[ State ]---->
                <cfif ( getState() eq whatever )>
                    <cfset arguments.eH.setError("State", "State This is the error message") />
                </cfif>
  
                  <!----[ Postcode ]---->
                <cfif ( getPostcode() eq whatever )>
                    <cfset arguments.eH.setError("Postcode", "Postcode This is the error message") />
                </cfif>
  
                  <!----[ Country ]---->
                <cfif ( getCountry() eq whatever )>
                    <cfset arguments.eH.setError("Country", "Country This is the error message") />
                </cfif>
  
                  <!----[ DateAdded ]---->
                <cfif ( getDateAdded() eq whatever )>
                    <cfset arguments.eH.setError("DateAdded", "DateAdded This is the error message") />
                </cfif>
  
                  <!----[ AddedBy ]---->
                <cfif ( getAddedBy() eq whatever )>
                    <cfset arguments.eH.setError("AddedBy", "AddedBy This is the error message") />
                </cfif>
  
                  <!----[ DateUpdated ]---->
                <cfif ( getDateUpdated() eq whatever )>
                    <cfset arguments.eH.setError("DateUpdated", "DateUpdated This is the error message") />
                </cfif>
  
                  <!----[ UpdatedBy ]---->
                <cfif ( getUpdatedBy() eq whatever )>
                    <cfset arguments.eH.setError("UpdatedBy", "UpdatedBy This is the error message") />
                </cfif>
  
   ]---->
		<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS 	]--->
 <cffunction name="setUserID" access="public" returntype="void" output="false">
            <cfargument name="UserID" type="numeric" required="true" />
            <cfset variables.instance.UserID = arguments.UserID />
	    </cffunction>
    <cffunction name="getUserID" access="public" returntype="numeric" output="false">
		   <cfreturn variables.instance.UserID />
		</cffunction>
    <cffunction name="setUserLogin" access="public" returntype="void" output="false">
            <cfargument name="UserLogin" type="string" required="true" />
            <cfset variables.instance.UserLogin = arguments.UserLogin />
	    </cffunction>
    <cffunction name="getUserLogin" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.UserLogin />
		</cffunction>
    <cffunction name="setUserPassword" access="public" returntype="void" output="false">
            <cfargument name="UserPassword" type="string" required="true" />
            <cfset variables.instance.UserPassword = arguments.UserPassword />
	    </cffunction>
    <cffunction name="getUserPassword" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.UserPassword />
		</cffunction>
    <cffunction name="setUserAccessLevel" access="public" returntype="void" output="false">
            <cfargument name="UserAccessLevel" type="numeric" required="true" />
            <cfset variables.instance.UserAccessLevel = arguments.UserAccessLevel />
	    </cffunction>
    <cffunction name="getUserAccessLevel" access="public" returntype="numeric" output="false">
		   <cfreturn variables.instance.UserAccessLevel />
		</cffunction>
    <cffunction name="setUserFirstname" access="public" returntype="void" output="false">
            <cfargument name="UserFirstname" type="string" required="true" />
            <cfset variables.instance.UserFirstname = arguments.UserFirstname />
	    </cffunction>
    <cffunction name="getUserFirstname" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.UserFirstname />
		</cffunction>
    <cffunction name="setUserLastName" access="public" returntype="void" output="false">
            <cfargument name="UserLastName" type="string" required="true" />
            <cfset variables.instance.UserLastName = arguments.UserLastName />
	    </cffunction>
    <cffunction name="getUserLastName" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.UserLastName />
		</cffunction>
    <cffunction name="setEmail" access="public" returntype="void" output="false">
            <cfargument name="Email" type="string" required="true" />
            <cfset variables.instance.Email = arguments.Email />
	    </cffunction>
    <cffunction name="getEmail" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.Email />
		</cffunction>
    <cffunction name="setUserIp" access="public" returntype="void" output="false">
            <cfargument name="UserIp" type="string" required="true" />
            <cfset variables.instance.UserIp = arguments.UserIp />
	    </cffunction>
    <cffunction name="getUserIp" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.UserIp />
		</cffunction>
        
    <cffunction name="setUserLastLogin" access="public" returntype="void" output="false">
            <cfargument name="UserLastLogin" type="date" required="true" />
            <cfset variables.instance.UserLastLogin = arguments.UserLastLogin />
	    </cffunction>
    <cffunction name="getUserLastLogin" access="public" returntype="date" output="false">
		   <cfreturn variables.instance.UserLastLogin />
		</cffunction>
        
    <cffunction name="setUserTotalLogins" access="public" returntype="void" output="false">
            <cfargument name="UserTotalLogins" type="numeric" required="true" />
            <cfset variables.instance.UserTotalLogins = arguments.UserTotalLogins />
	    </cffunction>
    <cffunction name="getUserTotalLogins" access="public" returntype="numeric" output="false">
		   <cfreturn variables.instance.UserTotalLogins />
		</cffunction>
    <cffunction name="setUserActive" access="public" returntype="void" output="false">
            <cfargument name="UserActive" type="boolean" required="true" />
            <cfset variables.instance.UserActive = arguments.UserActive />
	    </cffunction>
    <cffunction name="getUserActive" access="public" returntype="boolean" output="false">
		   <cfreturn variables.instance.UserActive />
		</cffunction>
    <cffunction name="setIsVisible" access="public" returntype="void" output="false">
            <cfargument name="IsVisible" type="boolean" required="true" />
            <cfset variables.instance.IsVisible = arguments.IsVisible />
	    </cffunction>
    <cffunction name="getIsVisible" access="public" returntype="boolean" output="false">
		   <cfreturn variables.instance.IsVisible />
		</cffunction>
    <cffunction name="setPhone" access="public" returntype="void" output="false">
            <cfargument name="Phone" type="string" required="true" />
            <cfset variables.instance.Phone = arguments.Phone />
	    </cffunction>
    <cffunction name="getPhone" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.Phone />
		</cffunction>
    <cffunction name="setMobile" access="public" returntype="void" output="false">
            <cfargument name="Mobile" type="string" required="true" />
            <cfset variables.instance.Mobile = arguments.Mobile />
	    </cffunction>
    <cffunction name="getMobile" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.Mobile />
		</cffunction>
    <cffunction name="setTitle" access="public" returntype="void" output="false">
            <cfargument name="Title" type="string" required="true" />
            <cfset variables.instance.Title = arguments.Title />
	    </cffunction>
    <cffunction name="getTitle" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.Title />
		</cffunction>
    <cffunction name="setAddress1" access="public" returntype="void" output="false">
            <cfargument name="Address1" type="string" required="true" />
            <cfset variables.instance.Address1 = arguments.Address1 />
	    </cffunction>
    <cffunction name="getAddress1" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.Address1 />
		</cffunction>
    <cffunction name="setAddress2" access="public" returntype="void" output="false">
            <cfargument name="Address2" type="string" required="true" />
            <cfset variables.instance.Address2 = arguments.Address2 />
	    </cffunction>
    <cffunction name="getAddress2" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.Address2 />
		</cffunction>
    <cffunction name="setCity" access="public" returntype="void" output="false">
            <cfargument name="City" type="string" required="true" />
            <cfset variables.instance.City = arguments.City />
	    </cffunction>
    <cffunction name="getCity" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.City />
		</cffunction>
    <cffunction name="setState" access="public" returntype="void" output="false">
            <cfargument name="State" type="string" required="true" />
            <cfset variables.instance.State = arguments.State />
	    </cffunction>
    <cffunction name="getState" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.State />
		</cffunction>
    <cffunction name="setPostcode" access="public" returntype="void" output="false">
            <cfargument name="Postcode" type="string" required="true" />
            <cfset variables.instance.Postcode = arguments.Postcode />
	    </cffunction>
    <cffunction name="getPostcode" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.Postcode />
		</cffunction>
    <cffunction name="setCountry" access="public" returntype="void" output="false">
            <cfargument name="Country" type="string" required="true" />
            <cfset variables.instance.Country = arguments.Country />
	    </cffunction>
    <cffunction name="getCountry" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.Country />
		</cffunction>
    <cffunction name="setDateAdded" access="public" returntype="void" output="false">
            <cfargument name="DateAdded" type="date" required="true" />
            <cfset variables.instance.DateAdded = arguments.DateAdded />
	    </cffunction>
    <cffunction name="getDateAdded" access="public" returntype="date" output="false">
		   <cfreturn variables.instance.DateAdded />
		</cffunction>
    <cffunction name="setAddedBy" access="public" returntype="void" output="false">
            <cfargument name="AddedBy" type="string" required="true" />
            <cfset variables.instance.AddedBy = arguments.AddedBy />
	    </cffunction>
    <cffunction name="getAddedBy" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.AddedBy />
		</cffunction>
    <cffunction name="setDateUpdated" access="public" returntype="void" output="false">
            <cfargument name="DateUpdated" type="date" required="true" />
            <cfset variables.instance.DateUpdated = arguments.DateUpdated />
	    </cffunction>
    <cffunction name="getDateUpdated" access="public" returntype="date" output="false">
		   <cfreturn variables.instance.DateUpdated />
		</cffunction>
    <cffunction name="setUpdatedBy" access="public" returntype="void" output="false">
            <cfargument name="UpdatedBy" type="string" required="true" />
            <cfset variables.instance.UpdatedBy = arguments.UpdatedBy />
	    </cffunction>
    <cffunction name="getUpdatedBy" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.UpdatedBy />
		</cffunction>
        
	<cffunction name="setPermissions" access="public" returntype="void" output="false">
		<cfargument name="Permissions" type="string" required="true" />
		<cfset variables.instance.Permissions = arguments.Permissions />
	</cffunction>
	<cffunction name="getPermissions" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Permissions />
	</cffunction>

	<cffunction name="setAdminMenus" access="public" returntype="void" output="false">
		<cfargument name="AdminMenus" type="string" required="true" />
		<cfset variables.instance.AdminMenus = arguments.AdminMenus />
	</cffunction>
	<cffunction name="getAdminMenus" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AdminMenus />
	</cffunction>

	<cffunction name="setUserGroups" access="public" returntype="void" output="false">
		<cfargument name="UserGroups" type="string" required="true" />
		<cfset variables.instance.UserGroups = arguments.UserGroups />
	</cffunction>
	<cffunction name="getUserGroups" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UserGroups />
	</cffunction>

 
        
        <cffunction name="setIsLoggedIn" access="public" returntype="void" output="false">
		<cfargument name="isLoggedIn" type="boolean" required="true" />
		<cfset variables.instance.isLoggedIn = arguments.isLoggedIn />
	</cffunction>
	<cffunction name="getIsLoggedIn" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.isLoggedIn />
	</cffunction>
    

</cfcomponent>