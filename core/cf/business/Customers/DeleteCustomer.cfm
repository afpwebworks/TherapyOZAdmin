<cfsilent>
<!----
==========================================================================================================
Filename:    DeleteCustomer.cfm
Description: Deletes a Customer from the database and returns the user to the originating page.  Reqires ColdSpring 1.0
Date:        23/Sep/2015
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->


<cfparam name="request.pagename" default="Delete Customer">
<cfif NOT(isdefined("url.CustomerID")) AND NOT(isdefined("form.submit"))>
  <cflocation addtoken="no" url="index.cfm" />
  <cfelseif (isdefined("url.CustomerID") and NOT(isDefined("form.submit")))>
  <cfscript>
 	Customer =  application.beanfactory.getBean("Customer");
	Customer.setCustomerID(CustomerID);
	CustomersDAO = application.beanfactory.getBean("CustomersDAO");
	CustomersDAO.read(Customer);
 </cfscript>
</cfif>
<cfif isDefined("form.dontsubmit")>
	 <cflocation addtoken="no" url="#cgi.HTTP_REFERER#" />
	 <abort>
<cfelseif isDefined("form.submit")>
  <cfscript>
	Customer =  application.beanfactory.getBean("Customer");
	Customer.setCustomerID(CustomerID);
	CustomersDAO = application.beanfactory.getBean("CustomersDAO");
	CustomersDAO.delete(Customer);
</cfscript>
  <cflocation addtoken="no" url="#cgi.HTTP_REFERER#" />
</cfif>
</cfsilent>
<cfsetting enablecfoutputonly="yes">
<cfinclude template="/includes/adminheader.cfm">

<cfoutput>
  <p>Delete this Customer from the page. <strong>WARNING: This action removes the whole record from the database permanently.  Do you really want to remove this content element?</strong></p>
  <form action="#cgi.SCRIPT_NAME#?#cgi.Query_string#" method="post">
    <input type="hidden" name="CustomerID" id="CustomerID" value="#url.CustomerID#">
    <div id="deletetable">
      <table>
        <tr>
          <th>Customer Title</th>
          <td class="lite">#Customer.getCustomerName()#</td>
        </tr>
        <tr>
          <td align="right"><input type="submit" name="dontsubmit" class="submitbutton" value="No Dont delete"></td>
          <td><input type="submit" name="submit" class="submitbutton"  value="OK Delete it"></td>
        </tr>
      </table>
    </div>
  </form>
</cfoutput>
<cfsetting enablecfoutputonly="no">
<cfinclude template="/includes/adminfooter.cfm">
