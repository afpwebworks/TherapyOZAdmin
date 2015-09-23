<cfsilent>
<!----[
==========================================================================================================
Filename:      form_Customer.cfm
Description:   Form for  handling Customers Requires a bean called Customer to exist already. 
				Form format is for use with Twitter Bootstrap v2.0
Client:        Therapy Oz  Admin Site				
Date:          23/September/2015 
Author:        Michael Kear,  AFP Webworks

Revision history:

==========================================================================================================
]--->
<cfscript>
Countries = util.getcountries();
States = util.getStates();
</cfscript>
</cfsilent>

<cfoutput>
<div class="content">
  <div class="col-sm-6">
  <legend>#request.pagename#</legend>
  <form name="Customersform" id="Customersform"  role="form" action="#cgi.SCRIPT_NAME#" method="post" >
    <cfif (isdefined("errorhandler") AND  (errorhandler.haserrors()))>
      <div class="alert alert-danger alert-white rounded">
        <button type="button" class="close" data-dismiss="danger" aria-hidden="true">×</button>
        <div class="icon"><i class="fa fa-warning"></i></div>
        <strong>Error!</strong> #errorhandler.MakeErrorDisplay( errorhandler )#<br>
      </div>
    </cfif>
    <input type="hidden" name="Addedby" value="#Customer.getAddedby()#" />
    <input type="hidden" id="CustomerID" value="#Customer.getCustomerID()#" >
    <input type="hidden" name="Dateadded" value="#Customer.getDateadded()#" />
    <input type="hidden" name="Dateupdated" value="#now()#" />
    <input type="hidden" name="IsVisible" value="#Customer.getIsVisible()#" />
    <input type="hidden" name="Updatedby" value="#Customer.getUpdatedby()#" />
    <div class="form-group">
      <label for="CustomerName" >CustomerName</label>
      <input type="text" class="form-control" id="CustomerName" name="Customername" placeholder="CustomerName"  maxlength="512"  value="#Customer.getCustomerName()#" >
    </div>
    <div class="form-group">
      <label for="Address1">Address Line 1</label>
      <input type="text" class="form-control" id="Address1" name="Address1" placeholder="Address1"  maxlength="1024"  value="#Customer.getAddress1()#" >
    </div>
    <div class="form-group">
      <label for="Address2">Address Line 2</label>
      <input type="text" class="form-control" id="Address2" name="Address2"  placeholder="Address2"  maxlength="1024"  value="#Customer.getAddress2()#" >
    </div>
    <div class="form-group">
      <label for="City">City</label>
      <input type="text" class="form-control" id="City"  name="City" placeholder="City"  maxlength="50"  value="#Customer.getCity()#" >
    </div>
    <div class="form-group">
      <label for="State">State</label>
      <select name="State" id="State">
        <cfloop query="States">
        <option value="#States.State#" <cfif States.State eq Customer.getState()>selected="selected"</cfif>>#States.State#</option>
        </cfloop>
      </select>
    </div>
    <div class="form-group">
      <label for="PostCode">PostCode</label>
      <input type="text" class="form-control" id="PostCode" name="PostCode"  placeholder="PostCode"  maxlength="50"  value="#Customer.getPostCode()#" >
    </div>
    <div class="form-group">
      <label for="Country">Country</label>
      <select name="Country" id="country">
        <cfloop query="Countries">
        <option value="#countries.country#" <cfif countries.country eq Customer.getCountry()>selected="selected"</cfif>>#countries.country#</option>
        </cfloop>
      </select>
    </div>
    <div class="form-group">
      <label for="DomainName">DomainName</label>
      <input type="text" class="form-control" id="DomainName" name="DomainName"  placeholder="DomainName"  maxlength="512"  value="#Customer.getDomainName()#" >
    </div>
    <div class="form-group">
      <label for="Fax">Fax</label>
      <input type="text" class="form-control" id="Fax"  name="Fax" placeholder="Fax"  maxlength="50"  value="#Customer.getFax()#" >
    </div>
    <div class="form-group">
      <label for="Live">Live</label>
      <label>
        <input type="radio" name="Live" id="Live2" value="1" <cfif #Customer.getLive()# eq "1"> Checked</cfif>>
        Yes </label>
      <label>
        <input type="radio" name="Live" id="Live2" value="0" <cfif #Customer.getLive()# eq "0"> Checked</cfif>>
        No </label>
    </div>
    <div class="form-group">
      <label for="Phone1" >Phone1</label>
      <input type="text" class="form-control" id="Phone1" name="Phone1"  placeholder="Phone1"  maxlength="50"  value="#Customer.getPhone1()#" >
    </div>
    <div class="form-group">
      <label for="Phone2">Phone2</label>
      <input type="text" class="form-control" id="Phone2"  name="Phone2" placeholder="Phone2"  maxlength="50"  value="#Customer.getPhone2()#" >
    </div>
    <div class="form-group">
      <button type="submit" name="submit" id="submit" class="btn btn-primary">Submit</button>
    </div>
    </div>
  </form>
</div>
</div>
<!---/end content div ----> 
</cfoutput>
