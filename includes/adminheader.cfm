<cfsilent>
<!----
==========================================================================================================
Filename:     adminheader.cfm
Description:  Header file for TherapyOZ Admin Area
Date:         1/9/2015
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfparam name="request.pagename" default="">
<!----[  Collect the data for the page  ]----MK ---->
<cfscript>
adminmenudAO = application.beanfactory.getbean("adminmenudAO");
AdminAccessManager =  application.beanfactory.getbean("AdminAccessManager");
adminmenu =application.beanfactory.getbean("adminmenu");
adminmenu.setURL( cgi.SCRIPT_NAME );
adminmenu = adminmenudao.readMenufromCGI( adminmenu );
submenu = adminmenudAO.getChildren( adminmenu );
if (submenu.recordcount eq 0 )
  submenu = adminmenudAO.getSiblings( adminmenu ) ;
request.pagename = adminmenu.getDescription();
</cfscript>

</cfsilent>
<!----[  Set up HTML headers  ]----MK ---->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<cfoutput>
    <title>#application.sitename# <cfif structKeyExists(request, "pagename")> - #request.pagename#</cfif></title>
</cfoutput>
	<!-- Fav and touch icons -->
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="/css/ico/apple-touch-icon-144-precomposed.png">
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="/css/ico/apple-touch-icon-114-precomposed.png">
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="/css/ico/apple-touch-icon-72-precomposed.png">
	<link rel="apple-touch-icon-precomposed" href="/css/ico/apple-touch-icon-57-precomposed.png">
	<link rel="shortcut icon" href="/css/ico/favicon.png">

    <link rel="stylesheet" type="text/css" href="/css/TherapyozCustom.css">
</head>

<body>
<div id="wrapper">
<!----[  Include main side menu  ]----MK ---->
<cfinclude template="/includes/adminmenu.cfm" />
<!----[  Include top page  header  ]----MK ---->
<cfinclude template="/includes/adminheaderbar.cfm" />
