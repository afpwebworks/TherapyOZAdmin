<cfcomponent displayname="Customers DAO" output="false" hint="DAO Component Handles all Database access for the table Customers.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    CustomersDAO.cfc
Description: DAO Component Handles all Database access for the table Customers.  Requires Coldspring v1.0
Date:        23/Sep/2015
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( Customer.getcustomerid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="CustomersDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="core.config.configbean" />
<cfargument name="argsLog" required="true" type="any" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
    <cfset variables.Log = arguments.argsLog/>
	<cfreturn this />
</cffunction>

<cffunction name="setUserService" access="public" output="false" returntype="void" hint="Dependency: User Service">
	<cfargument name="UserService" type="any" required="true"/>
	<cfset variables.UserService = arguments.UserService/>
</cffunction>

<cffunction name="InitLog" access="public" output="false" returntype="any" hint="Initialise the Log Object">

    <cfscript>
	 var Log = 	variables.Log;
	 log.setSiteID(  variables.userservice.getUSer().getSiteID() );
	 Log.setUserID(  variables.userservice.getUser().getUserID() );
	 
	</cfscript>
	<cfset variables.Log = Log/>
    <cfreturn variables.log />
</cffunction>



<cffunction name="save" access="public" returntype="Customer" output="false" hint="DAO method">
<cfargument name="Customer" type="Customer" required="yes" />
<!-----[  If a CustomerID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.Customer.getCustomerID() neq "0")>	
		<cfset Customer = update(arguments.Customer)/>
	<cfelse>
		<cfset Customer = create(arguments.Customer)/>
	</cfif>
	<cfreturn Customer />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="Customer" type="Customer" required="true" /> 
	<cfset var qCustomerDelete = 0 >
<!-----[  to delete, set 'IsVisible' flag to zero  ]--->
		<cfquery name="qCustomerDelete" datasource="#variables.dsn#" >
		UPDATE Customers
		Set IsVisible = '0'
		WHERE 
		CustomerID = <cfqueryparam value="#Customer.getCustomerID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>	
     <!----[  Add a log entry that the user has logged in  ]----MK ---->
               <cfscript>
                  InitLog( variables.Log);
               	variables.log.setTablename( "Customers");
	variables.log.setComment( "Deleted a customer");
	variables.log.setActivity( "Delete" );
                variables.log.setDateAdded( now() );
               </cfscript>
               <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
</cffunction>


<cffunction name="UnDelete" returntype="void" output="false" hint="DAO method" >
<cfargument name="Customer" type="Customer" required="true" /> 
	<cfset var qCustomerUnDelete = 0 >
<!-----[  to UnDelete, set 'IsVisible' flag to 1 (true)  ]--->
		<cfquery name="qCustomerDelete" datasource="#variables.dsn#" >
		UPDATE Customers
		Set IsVisible = '1'
		WHERE 
		CustomerID = <cfqueryparam value="#Customer.getCustomerID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>	
    <!----[  Add a log entry that the user has logged in  ]----MK ---->
               <cfscript>
                  InitLog( variables.Log);
               	variables.log.setTablename( "Customers");
	variables.log.setComment( "Undeleted a customer");
	variables.log.setActivity( "Undelete" );
                variables.log.setDateAdded( now() );
               </cfscript>
               <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
</cffunction>


<cffunction name="read" access="public" returntype="Customer" output="false" hint="DAO Method. - Reads a Customer into the bean">
<cfargument name="argsCustomer" type="Customer" required="true" />
	<cfset var Customer  =  arguments.argsCustomer />
	<cfset var QCustomersselect = "" />
	<cfquery name="QCustomersselect" datasource="#variables.dsn#">
		SELECT 
		CustomerID, CustomerName, Address1, Address2, City, State, PostCode, Country, Phone1, Phone2, Fax, DomainName, Live, IsVisible, Dateadded, Addedby, Dateupdated, Updatedby
		FROM Customers 
		WHERE 
		IsVisible = '1' AND
        CustomerID = <cfqueryparam value="#Customer.getCustomerID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QCustomersselect.recordCount >
		<cfscript>
		Customer.setCustomerID(QCustomersselect.CustomerID);
         Customer.setCustomerName(QCustomersselect.CustomerName);
         Customer.setAddress1(QCustomersselect.Address1);
         Customer.setAddress2(QCustomersselect.Address2);
         Customer.setCity(QCustomersselect.City);
         Customer.setState(QCustomersselect.State);
         Customer.setPostCode(QCustomersselect.PostCode);
         Customer.setCountry(QCustomersselect.Country);
         Customer.setPhone1(QCustomersselect.Phone1);
         Customer.setPhone2(QCustomersselect.Phone2);
         Customer.setFax(QCustomersselect.Fax);
         Customer.setDomainName(QCustomersselect.DomainName);
         Customer.setLive(QCustomersselect.Live);
         Customer.setIsVisible(QCustomersselect.IsVisible);
         Customer.setDateadded(QCustomersselect.Dateadded);
         Customer.setAddedby(QCustomersselect.Addedby);
         Customer.setDateupdated(QCustomersselect.Dateupdated);
         Customer.setUpdatedby(QCustomersselect.Updatedby);
         
		</cfscript>
	</cfif>
	<cfreturn Customer />
</cffunction>
		

<cffunction name="GetAllCustomers" access="public" output="false" returntype="query" hint="Returns a query of all Customers in our Database">
<cfset var QgetallCustomers = 0 />
	<cfquery name="QgetallCustomers" datasource="#variables.dsn#">
		SELECT CustomerID, CustomerName, Address1, Address2, City, State, PostCode, Country, Phone1, Phone2, Fax, DomainName, Live, IsVisible, Dateadded, Addedby, Dateupdated, Updatedby
		FROM Customers 
		WHERE IsVisible = '1'
        
		ORDER BY CustomerID
	</cfquery>
	<cfreturn QgetallCustomers />
</cffunction>

<cffunction name="getCustomerName" access="public" output="no" returntype="string" hint="Returns the customer name as a string.  REquires a valid customerID">
	<cfargument name="argsCustomerID" type="numeric" required="yes" hint="The customerID to search the name" />
    <cfset var CustomerID = arguments.argsCustomerID />
    <cfset var qCustomername = "" />
    <cfquery name="qCustomername" datasource="#variables.dsn#">
    	SELECT Customername from Customers
        WHERE Customerid = <cfqueryparam value="#customerID#" cfsqltype="cf_sql_integer" />
    </cfquery>
    
    <cfif qCustomername.recordcount>
    	<cfset returnvalue = qCustomername.Customername />
    <cfelse>
    	<cfset returnvalue = "Not Known" />
    </cfif>
    <cfreturn returnvalue />    
</cffunction>

<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="Customer" output="false" hint="DAO method">
<cfargument name="argsCustomer" type="Customer" required="yes" displayname="create" />
	<cfset var qCustomerInsert = 0 />
	<cfset var Customer = arguments.argsCustomer />
	
	<cfquery name="qCustomerInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into Customers
		( CustomerName, Address1, Address2, City, State, PostCode, Country, Phone1, Phone2, Fax, DomainName, Live, IsVisible, Dateadded, Addedby, Dateupdated, Updatedby ) VALUES
		(

		<cfqueryparam value="#Customer.getcustomername()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Customer.getaddress1()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Customer.getaddress2()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Customer.getcity()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Customer.getstate()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Customer.getpostcode()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Customer.getcountry()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Customer.getphone1()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Customer.getphone2()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Customer.getfax()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Customer.getdomainname()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#Customer.getlive()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#Customer.getisvisible()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/> ,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/> 
		   ) 
		SELECT Ident_Current('Customers') as CustomerID
		SET NOCOUNT OFF
	</cfquery>
	<cfset Customer.setCustomerID(qCustomerInsert.CustomerID)>
    
    <!----[  Add a log entry that the user has logged in  ]----MK ---->
               <cfscript>
                  InitLog( variables.Log);
               	variables.log.setTablename( "Customers");
				variables.log.setComment( "Created a customer #Customer.getCustomername()#");
				variables.log.setActivity( "Create" );
                variables.log.setDateAdded( now() );
               </cfscript>
               <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
               

	<cfreturn Customer />
</cffunction>

<cffunction name="update" access="private" returntype="Customer" output="false" hint="DAO method">
<cfargument name="argsCustomer" type="Customer" required="yes" />
	<cfset var Customer = arguments.argsCustomer />
	<cfset var CustomerUpdate = 0 >
	<cfquery name="CustomerUpdate" datasource="#variables.dsn#" >
		UPDATE Customers SET
        customername  = <cfqueryparam value="#Customer.getCustomerName()#" cfsqltype="CF_SQL_VARCHAR"/>,
        address1  = <cfqueryparam value="#Customer.getAddress1()#" cfsqltype="CF_SQL_VARCHAR"/>,
        address2  = <cfqueryparam value="#Customer.getAddress2()#" cfsqltype="CF_SQL_VARCHAR"/>,
        city  = <cfqueryparam value="#Customer.getCity()#" cfsqltype="CF_SQL_VARCHAR"/>,
        state  = <cfqueryparam value="#Customer.getState()#" cfsqltype="CF_SQL_VARCHAR"/>,
        postcode  = <cfqueryparam value="#Customer.getPostCode()#" cfsqltype="CF_SQL_VARCHAR"/>,
        country  = <cfqueryparam value="#Customer.getCountry()#" cfsqltype="CF_SQL_VARCHAR"/>,
        phone1  = <cfqueryparam value="#Customer.getPhone1()#" cfsqltype="CF_SQL_VARCHAR"/>,
        phone2  = <cfqueryparam value="#Customer.getPhone2()#" cfsqltype="CF_SQL_VARCHAR"/>,
        fax  = <cfqueryparam value="#Customer.getFax()#" cfsqltype="CF_SQL_VARCHAR"/>,
        domainname  = <cfqueryparam value="#Customer.getDomainName()#" cfsqltype="CF_SQL_VARCHAR"/>,
        live  = <cfqueryparam value="#Customer.getLive()#" cfsqltype="CF_SQL_BIT"/>,
        isvisible  = <cfqueryparam value="#Customer.getIsVisible()#" cfsqltype="CF_SQL_BIT"/>,
        dateupdated  = <cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
        updatedby  = <cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/>
						
		WHERE 
		CustomerID = <cfqueryparam value="#Customer.getCustomerID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
	<!----[  Add a log entry that the user has logged in  ]----MK ---->
               <cfscript>
                  InitLog( variables.Log);
               	variables.log.setTablename( "Customers");
				variables.log.setComment( "Updated customer details for #Customer.getCustomername()#");
				variables.log.setActivity( "Update" );
                variables.log.setDateAdded( now() );
               </cfscript>
               <cfset application.beanfactory.getbean("LogsDAO").save( variables.log ) />
    
    
	<cfreturn Customer />
</cffunction>

</cfcomponent>
