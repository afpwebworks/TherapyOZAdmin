<cfsilent>
<!----
==========================================================================================================
Filename:     adminsidemenu.cfm
Description:  Side sub menu for CMS
Client:       TherapyOZ Admin Site
Date:         11/9/2015
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfset adminmenudAO = application.getbean("adminmenudAO") />
<cfset tempmenu =application.getbean("adminmenu") />
<cfset submenu = adminmenudAO.getChildren( tempmenu ) />
<cfif submenu.recordcount eq 0 >
  <cfset submenu = adminmenudAO.getSiblings( tempmenu ) />
</cfif>
</cfsilent>
<cfoutput>
<div class="cl-sidebar" data-position="right" data-step="1" data-intro="<strong>Fixed Sidebar</strong> <br/> It adjust to your needs." >
  <div class="cl-toggle"><i class="fa fa-bars"></i></div>
  <div class="cl-navblock">
    <div class="menu-space">
      <div class="content">
        <div class="side-user">
          <div class="info"> <a href="##">#session.user.getUserFirstname()# #session.user.getuserlastname()#</a> <img src="images/state_online.png" alt="Status" /> <span>Online</span> </div>
        </div>
        <ul class="cl-vnavigation">
          <cfloop query="submenu">
            <li><a href="#submenu.url#"><i class="fa fa-#submenu.icon#"></i><span>#submenu.description#</span></a></li>
          </cfloop>
        </ul>
      </div>
    </div>
  </div>
</div> <!----[  /end cl-sidebar  ]-------->
</cfoutput>
