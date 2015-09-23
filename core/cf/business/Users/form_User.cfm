<cfsilent>
<!----[
==========================================================================================================
Filename:      form_User.cfm
Description:   Form for  handling Users Requires a bean called User to exist already. 
				Form format is for use with Twitter Bootstrap v2.0
Date:          23/September/2015 
Author:        Michael Kear,  AFP Webworks

Revision history:

==========================================================================================================
]--->
<cfscript>
	user = session.user ;
	customersDAO = application.beanfactory.getbean("customersDAO");
	SitesDAO = application.beanfactory.getbean("SitesDAO");
	countries = util.getCOuntries();
	states = util.getStates();
</cfscript>
</cfsilent>

<cfoutput>
<div class="content">
  <legend>#request.pagename#</legend>
  
  <form name="Usersform" id="Usersform" class="form-horizontal" role="form" action="#cgi.SCRIPT_NAME#" method="post" >
    <cfif (isdefined("errorhandler") AND  (errorhandler.haserrors()))>
      <div class="alert alert-danger alert-white rounded">
        <button type="button" class="close" data-dismiss="danger" aria-hidden="true">×</button>
        <div class="icon"><i class="fa fa-warning"></i></div>
        <strong>Error!</strong> #errorhandler.MakeErrorDisplay( errorhandler )#<br>
      </div>
    </cfif>
    <input type="hidden" name="UserID" value="#User.getUserID()#" />
    <input type="hidden" name="AddedBy" value="#User.getAddedBy()#" />
    <input type="hidden" name="DateAdded" value="#User.getDateAdded()#" />
    <input type="hidden" name="DateUpdated" value="#User.getDateUpdated()#" />
    <input type="hidden" name="IsVisible" value="#User.getIsVisible()#" />
    <input type="hidden" name="UpdatedBy" value="#User.getUpdatedBy()#" />
    <input type="hidden" name="Permissions" value="#User.getPermissions()#" />
    <input type="hidden" name="adminmenus" value="#User.getadminmenus()#" />
    <input type="hidden" name="UserGroups" value="#User.getUserGroups()#" />
    <input type="hidden" name="IsLoggedIn" value="#User.getIsLoggedIn()#" />
    
    
    <label for="CustomerID">Customer</label>
    #customersdao.getCustomerName( User.getCustomerID() )#<br />
    <input type="hidden" id="CustomerID" name="CustomerID"  value="#User.getCustomerID()#" >
    <label for="Title" >Title</label>
    <input type="text" class="form-control" id="Title"  name="Title"  placeholder="Title"  maxlength="150"  value="#User.getTitle()#" >
    <label for="UserFirstname">First name</label>
    <input type="text" class="form-control" id="UserFirstname"  name="UserFirstname"  placeholder="UserFirstname"  maxlength="150"  value="#User.getUserFirstname()#" >
    <label for="UserLastName">Last Name</label>
    <input type="text" class="form-control" id="UserLastName"  name="UserLastName"  placeholder="UserLastName"  maxlength="150"  value="#User.getUserLastName()#" >
    <label for="UserLogin">Login</label>
    <input type="text" class="form-control" id="UserLogin"  name="UserLogin"  placeholder="UserLogin" required  maxlength="50"  value="#User.getUserLogin()#" >
    <label for="UserPassword">Password</label>
    <input type="password" class="form-control" id="UserPassword"  name="UserPassword"  placeholder="UserPassword" required  maxlength="50"  value="#User.getUserPassword()#" >
       <label for="UserPassword">Password Again</label>
    <input type="password" class="form-control" id="UserPassword2"  name="UserPassword2"  placeholder="UserPassword" required  maxlength="50"  value="#User.getUserPassword()#" >
    <label for="Address1">Address Line 1</label>
    <input type="text" class="form-control" id="Address1"  name="Address1"  placeholder="Address1"  maxlength="350"  value="#User.getAddress1()#" >
    <label for="Address2">Address Line 2</label>
    <input type="text" class="form-control" id="Address2"  name="Address2"  placeholder="Address2"  maxlength="350"  value="#User.getAddress2()#" >
    <label for="Email" >Email</label>
    <input type="email" class="form-control" id="Email"  name="Email"  placeholder="Email"  maxlength="150"  value="#User.getEmail()#" >
    <label for="Mobile">Mobile</label>
    <input type="text" class="form-control" id="Mobile"  name="Mobile"  placeholder="Mobile"  maxlength="20"  value="#User.getMobile()#" >
    <label for="Phone" >Phone</label>
    <input type="text" class="form-control" id="Phone"  name="Phone"  placeholder="Phone"  maxlength="20"  value="#User.getPhone()#" >
    <label for="City">City</label>
    <input type="text" class="form-control" id="City"  name="City"  placeholder="City"  maxlength="150"  value="#User.getCity()#" >
    <label for="State" >State</label>
    <br>
    <select name="State" id="State">
      <cfloop query="States">
      <option value="#States.state#" <cfif states.state eq User.getState()>Selected="selected"</cfif>>#states.state#</option>
      </cfloop>
    </select>
    <br>
    <label for="Postcode" >Postcode</label>
    <input type="text" class="form-control" id="Postcode"  name="Postcode"  placeholder="Postcode"  maxlength="30"   value="#User.getPostcode()#" >
    <label for="Country" >Country</label>
    <br>
    <select name="Country" id="Country">
      <cfloop query="Countries">
      <option value="#Countries.Country#" <cfif Countries.Country eq User.getCountry()>Selected="selected"</cfif>>#Countries.Country#</option>
      </cfloop>
    </select>
    <br>
   <cfif session.user.getuserAccessLevel() GT 90 > 
    <label for="UserAccessLevel" >UserAccessLevel</label>
    <input type="number" class="form-control" id="UserAccessLevel" name="UserAccessLevel"  placeholder="UserAccessLevel"  value="#User.getUserAccessLevel()#" >
       <label for="UserActive"><input type="radio" id="UserActive"  name="UserActive" value="1" <cfif user.getUserActive() eq 1>checked="checked"</cfif> > Active</label>
        <label for="UserActive"><input type="radio" id="UserActive"  name="UserActive"  value="2"  <cfif user.getUserActive() eq 2>checked="checked"</cfif> > Inactive</label>
        
    <cfelse>
 	<input type="hidden" name="UserAccessLevel" id="UserAccessLevel" value="#User.getUserAccessLevel()#" />  
    <input type="hidden" name="UserActive" id="UserActive" value="#User.getUserActive()#" />    
    </cfif>

      
      <h2>Information: </h2>
     Your last IP:   #User.getUserIp()#<input type="hidden" name="UserIp" id="UserIp" value="#User.getUserIp()#" /><br>  
	Your Last Login: #dateformat(User.getUserLastLogin(), "dd/mmm/yyyy")#<input type="hidden" name="UserLastLogin" id="UserLastLogin" value="#User.getUserLastLogin()#" /><br>  
    You have logged in #User.getUserTotalLogins()# times.<br>  <br>  
<input type="hidden" name="UserTotalLogins" id="UserTotalLogins" value="#User.getUserTotalLogins()#" />
    <button type="submit" name="submit" id="submit" class="btn btn-primary">Submit</button>
  </form>
</div>
<!---/end content div ----> 
</cfoutput>
