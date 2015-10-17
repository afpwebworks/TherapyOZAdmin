<cfsilent>
<!----
==========================================================================================================
Filename:     headerview.cfm
Description:  View element for site template
Client:       Therapy Oz Admin site
Date:         4/10/2015
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfscript>

</cfscript>
<cfparam name="request.pagename" default="">
</cfsilent>
<!doctype html>
<html>
<head>
<meta charset="utf-8">

<cfoutput>
<title>#application.sitename#<cfif len(request.pagename)>-#request.pagename#</cfif></title>
</cfoutput>
</head>

