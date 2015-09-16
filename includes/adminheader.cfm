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
<cfscript>

</cfscript>
<cfparam name="request.pagename" default="">
</cfsilent>
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


<!----[      <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700,900,400italic' rel='stylesheet' type='text/css'>  ]----MK ---->
<!-- Latest compiled and minified CSS -->
  

    <!----[  <link href="font-awesome/css/font-awesome.css" rel="stylesheet">  ]----MK ---->

 <!----[     <link 
    ="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">  ]----MK ---->
    <link rel="stylesheet" type="text/css" href="/css/TherapyozCustom.css">
</head>

<body>