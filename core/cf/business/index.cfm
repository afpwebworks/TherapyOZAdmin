<cfsilent>
<!----
==========================================================================================================
Filename:     index.cfm
Description:  Profile dashboard site
Date:         23/9/2015 
Client:       Therapy Oz Admin Site	   
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfscript>

</cfscript>

</cfsilent>
<cfinclude template="/includes/adminheader.cfm" />
<p>On this page you can set up the basic profile of your site,  and maintain your own personal details. </p>

<p><a href="/core/cf/business/Customers/editCustomer.cfm"><button type="button" class="btn btn-primary btn-lg"> <i class="fa fa-briefcase"></i> Customer Details</button></a></p>
<p><a href="/core/cf/business/sites/editsite.cfm"><button type="button" class="btn btn-primary btn-lg"> <i class="fa fa-briefcase"></i> Site Profile</button></a></p>
<p><a href="/core/cf/business/users/EditUserProfile.cfm"><button type="button" class="btn btn-primary btn-lg"><i class="fa fa-user"></i> Your personal profile</button></a></p>



</div>
</div>

<cfinclude template="/includes/adminfooter.cfm" />