<cfsilent>
<!----
==========================================================================================================
Filename:     adminmenu.cfm
Description:  Admin area main menu
Date:         11/9/2015
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfset adminmenudAO = application.beanfactory.getbean("adminmenudAO") />
<cfset tempmenu =application.beanfactory.getbean("adminmenu") />
<cfset tempmenu.setURL( cgi.SCRIPT_NAME ) />
<cfset tempmenu = adminmenudao.readMenufromCGI( tempmenu ) />
<cfset submenu = adminmenudAO.getChildren( tempmenu ) />
<cfif submenu.recordcount eq 0 >
  <cfset submenu = adminmenudAO.getSiblings( tempmenu ) />
</cfif>
</cfsilent>
<cfoutput>
<nav class="navbar-default navbar-static-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav metismenu" id="side-menu">
                <li class="nav-header">
                    <div class="dropdown profile-element">
                            <a data-toggle="dropdown" class="dropdown-toggle" href="##">
                            <span class="clear"> <span class="block m-t-xs"> <strong class="font-bold">#session.user.getUserFirstname()# #session.user.getUserLastName()#</strong>
                             </span> <span class="text-muted text-xs block">Last login: #timeformat(session.user.getUserLastLogin(), 'hh:mmtt')# #dateformat(session.user.getUserLastLogin(), 'dd/mmm/yyyy')# <b class="caret"></b></span> </span> </a>
                            <ul class="dropdown-menu animated fadeInRight m-t-xs">
                                <li><a href="/logout.cfm">Logout</a></li>
                            </ul>
                    </div>
                    <div class="logo-element">
                        <img src="/img/TherapyOZLogo.png" />
                    </div>
                </li>
               <li><a href="/index.cfm"><i class="fa fa-dashboard "></i><span>Dashboard</span></a></li> 
                <cfloop query="submenu">
            <li><a href="#submenu.url#"><i class="fa fa-#submenu.icon#"></i><span>#submenu.description#</span></a></li>
          </cfloop>
          
               <!----[   <li class="active">
                    <a href="index.cfm"><i class="fa fa-th-large"></i> <span class="nav-label">Main view</span></a>
                </li>
                <li>
                    <a href="minor.cfm"><i class="fa fa-th-large"></i> <span class="nav-label">Minor view</span> </a>
                </li>  ]----MK ---->
            </ul>

        </div>
    </nav> <!----[  /end cl-sidebar  ]-------->
  </cfoutput>  
  
