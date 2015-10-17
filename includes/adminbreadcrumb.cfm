<cfsilent>
<!----
==========================================================================================================
Filename:     adminbreadcrumb.cfm
Description:  Lays out the breadcrumb for the admin pages
Client: 	   Admin  THerapyoz.com
Date:         119/2015
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfscript>
adminmenuDAO =  application.beanfactory.getbean("adminmenuDAO");
adminmenubc = application.beanfactory.getbean("adminmenu");
adminmenubc.setURL( cgi.SCRIPT_NAME );
adminmenuDAO.readMenufromCGI( adminmenubc  );
qbreadcrumb = AdminAccessManager.getAdminBreadcrumb( adminmenubc );
</cfscript>

</cfsilent>
<cfoutput>
 <h2><i class="fa fa-#adminmenubc.getIcon()# fa-lg"></i> #adminmenubc.getDescription()#</h2>
    <ol class="breadcrumb">
	 <cfif adminmenubc.getDescription() neq "Dashboard">
        <cfloop query="qbreadcrumb">
            <li><a href="#qbreadcrumb.url#">#qbreadcrumb.description#</a></li>
         </cfloop>   
            <li class="active"><a href="#adminmenubc.geturl()#">#adminmenubc.getDescription()#</a></li>
       </cfif>     
    </ol>
    </cfoutput>