
<cfscript>
/**
 * Creates the RegEx to test a string for possible SQL injection.
 * 
 * @return Returns string. 
 * @author Luis Melo (luism@grouptraveltech.com)
 * @version 1, July 25, 2008
 * @version 2, July 28, 2008
 * @version 3, August 20, 2008
 */ 
function checkSQLInject() {
	// list of db objects/functions to protect 
	var insSql = 'insert|delete|select|update|create|alter|drop|truncate|grant|revoke|declare|' &
				 'exec|backup|restore|sp_|xp_|set|execute|dbcc|deny|union|Cast|Char|Varchar|nChar|nVarchar';
 
	 // Build the regex 
	 var regEx='((or)+[[:space:]]*\(*''?[[:print:]]+''?' &
		  '([[:space:]]*[\+\-\/\*][[:space:]]*''?' &
		  '[[:print:]]+''?)*\)*[[:space:]]*' &
		  '(([=><!]{1,2}|(like))[[:space:]]*\(*''?' &
		  '[[:print:]]+''?([[:space:]]*[\+\-\/\*]' &
		  '[[:space:]]*''?[[:print:]]+''?)*\)*)|((in)' &
		  '[[:space:]]*\(+[[:space:]]*''?[[:print:]]+''?' &
		  '(\,[[:space:]]*''?[[:print:]]+''?)*\)+)|' &
		  '((between)[[:space:]]*\(*[[:space:]]*''?' &
		  '[[:print:]]+''?(\,[[:space:]]*''?[[:print:]]+''?)' &
		  '*\)*(and)[[:space:]]+\(*[[:space:]]*''?[[:print:]]+''?' &
		  '(\,[[:space:]]*''?[[:print:]]+''?)*\)*)|((;)([^a-z>]*)' &
		  '(#insSql#)([^a-z]+|$))|(union[^a-z]+(all|select))|(\/\*)|(--$))';
		  
	return regEx;
}

function loadPattern() {
/**
 * Build the java pattern matcher
 * 
 * @return Returns object. 
 * @author Gabriel Read from CF-Talk (gabe@evolution7.com)
 * @version 1, July 28, 2008
 * @version 2, August 15, 2008
 */ 
	// Build the java pattern matcher 	
	var reMatcher = '';
	var blacklist = checkSQLInject();
	var rePattern = createObject('java', 'java.util.regex.Pattern'); 
	rePattern = rePattern.compile(blackList); 
	return rePattern;
}


/**
 * This function checks the URL, form, and cookie scopes, and selected CGI variables for SQL Injection
 * 
 * @return Returns boolean. 
 * @author Mary Jo Sminkey
 * @version 1, July 25, 2008
 * @version 2, July 28, 2008
 * @version 3, August 15, 2008
 * @version 4, August 20, 2008
 */ 
function checkforattack() {
	
	var hackattempt = 'no';
	var testvar = '';
	var reMatcher = '';
	var CGIvars = 'script_name,remote_addr,query_string,path_info,http_referer,http_user_agent,server_name';
	var i = 1;
	
	//Make sure the Matcher is available in Application Scope
	if (NOT StructKeyExists(Application, 'regExChecker')) {
		Application.regExChecker = loadPattern();
	}
	
	//load matcher
	reMatcher = Application.regExChecker.matcher('');
	
	//Check URL scope for SQL Injection attacks
	for (testvar in URL) {
		if (reMatcher.reset(lcase(URL[testvar])).find()) {
			hackattempt="yes";
		}
	}
	
	//check form scope
	for (testvar in FORM) {
		if (testvar IS NOT "fieldnames" AND reMatcher.reset(lcase(FORM[testvar])).find()) {
			hackattempt="yes";
		}
	}
	
	//Check cookie scope
	for (testvar in COOKIE) {
		if (reMatcher.reset(lcase(COOKIE[testvar])).find()) {
			hackattempt="yes";
		}
	}
	
	//Check CGI scope 
	for (i=1; i LTE ListLen(CGIvars); i=i+1) {
		testvar = ListGetAt(CGIvars, i);
		if (StructKeyExists(CGI, testvar) AND reMatcher.reset(lcase(CGI[testvar])).find()) {
			hackattempt="yes";
		}
	}

	return hackattempt;
}
</cfscript>


<cfset hackattempt = checkforattack()>
<cfif hackattempt>
	<cfoutput><br/>Sorry, your page request appears to be a hack attempt and processing has been halted.<br/><br/> If you believe this message was received in error, return to the previous page and change the text you entered. <br/><br/>If you continue to receive this message, please contact the Webmaster. </cfoutput>
	<cfabort>
</cfif> 


