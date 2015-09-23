<cfsilent>
<!----
==========================================================================================================
Filename:    EditUser.cfm
Description: Page for handling the edit and add of data for User data.  Requires Coldspring 1.0
Date:        23/Sep/2015
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->
<cfscript>
UsersDAO = application.beanfactory.getBean("UsersDAO");

</cfscript>
<!----[  Initialise the form for adds:  ]----->


<!----[  Process the form if it is submitted:  ]----->
<cfif isdefined("form.submit")>
	<cfset user = application.beanfactory.getBean("user") />
	<cfset errorhandler = application.beanfactory.getBean("ErrorHandler") />
   <cfscript>
     //transfer form values to the bean
     User.setuserlogin(trim(form.userlogin));
	 if ( form.userpassword eq form.userpassword2 )  User.setuserpassword(trim(form.userpassword));
     User.setuseraccesslevel(trim(form.useraccesslevel));
	 User.setuserID(trim(form.userID));
     User.setuserfirstname(trim(form.userfirstname));
     User.setuserlastname(trim(form.userlastname));
     User.setemail(trim(form.email));
     User.setuserip(trim(form.userip));
     User.setuserlastlogin(trim(form.userlastlogin));
     User.setusertotallogins(trim(form.usertotallogins));
     User.setuseractive(trim(form.useractive));
     User.setisvisible(trim(form.isvisible));
     User.setphone(trim(form.phone));
     User.setmobile(trim(form.mobile));
     User.settitle(trim(form.title));
     User.setaddress1(trim(form.address1));
     User.setaddress2(trim(form.address2));
     User.setcity(trim(form.city));
     User.setstate(trim(form.state));
     User.setpostcode(trim(form.postcode));
     User.setcountry(trim(form.country));
     User.setdateadded(trim(form.dateadded));
     User.setaddedby(trim(form.addedby));
     User.setdateupdated(trim(form.dateupdated));
     User.setupdatedby(trim(form.updatedby));
     User.setcustomerid(trim(form.customerid));
	 User.setUserActive(trim(form.UserActive));
	 User.setPermissions(form.permissions);
     User.setAdminMenus(form.AdminMenus);
	 User.setUserGroups(form.UserGroups);
	 User.setIsLoggedIn(form.IsLoggedIn);
     
   </cfscript>
   <cfset User.validate(errorhandler) />   
	<cfif NOT(errorhandler.haserrors())>
		<cfset UsersDAO.save(User) />
        <cfif user.getUserID() eq session.user.getUserID()>
			<cfset session.user = user />
		</cfif>
		<cflocation addtoken="no"  url="/core/cf/business/index.cfm" />
		<cfabort> 
	</cfif>
</cfif>	
</cfsilent>
<cfinclude template="/Includes/adminheader.cfm" />
<cfinclude template="/core/cf/business/users/form_User.cfm" />
<cfinclude template="/Includes/adminfooter.cfm" />