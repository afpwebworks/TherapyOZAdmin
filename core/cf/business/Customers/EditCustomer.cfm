<cfsilent>
<!----
==========================================================================================================
Filename:    EditCustomer.cfm
Description: Page for handling the edit and add of data for Customer data.  Requires Coldspring 1.0
Date:        23/Sep/2015
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->

<!----[  Initialise the form for updates:  ]----->
<cfset Customer = application.beanfactory.getBean("Customer") />
<cfset CustomersDAO =   application.beanfactory.getBean("CustomersDAO") />
<cfset Customer.setCustomerID( session.user.getCustomerID() ) />
<!----[  <cfif NOT IsDefined(form.submit)>
	<cfset CustomersDAO.read(Customer) />
<cfelse>  ]----MK ---->

<!----[  Process the form if it is submitted:  ]----->
<cfif isdefined("form.submit")>
	<cfset errorhandler = application.beanfactory.getBean("ErrorHandler") />
   <cfscript>
     //transfer form values to the bean
    Customer.setcustomername(trim(form.customername));
     Customer.setaddress1(trim(form.address1));
     Customer.setaddress2(trim(form.address2));
     Customer.setcity(trim(form.city));
     Customer.setstate(trim(form.state));
     Customer.setpostcode(trim(form.postcode));
     Customer.setcountry(trim(form.country));
     Customer.setphone1(trim(form.phone1));
     Customer.setphone2(trim(form.phone2));
     Customer.setfax(trim(form.fax));
     Customer.setdomainname(trim(form.domainname));
     Customer.setlive(trim(form.live));
     Customer.setisvisible(trim(form.isvisible));
     Customer.setdateadded(trim(form.dateadded));
     Customer.setaddedby(trim(form.addedby));
     Customer.setdateupdated(trim(form.dateupdated));
     Customer.setupdatedby(trim(form.updatedby));
     
     
   </cfscript>
   <cfset Customer.validate(errorhandler) />   
	<cfif NOT(errorhandler.haserrors())>
		<cfset CustomersDAO.save(Customer) />
		<cflocation addtoken="no"  url="/core/cf/business/Customers/editCustomer.cfm" />
		<cfabort> 
	</cfif>
</cfif>	
<!----[  </cfif>  ]----MK ---->
</cfsilent>
<cfinclude template="/Includes/adminheader.cfm" />
<cfset CustomersDAO.read(Customer) />
<cfinclude template="/core/cf/business/customers/form_Customer.cfm" />
<cfinclude template="/Includes/adminfooter.cfm" />
