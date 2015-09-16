<cfsilent>
<!---
=================================================================================================================
File:          loginform.cfm   
Description:    Log in form for Admin area
Client:   		Therapy OZ
Author:	        Michael Kear
Date:           1/9/2015
Modification:  


=================================================================================================================
--->

<cfparam name="session.loginerrormessage" default="" />
<cfparam name="request.pagename" default="Log In" />
<script>

</script>
</cfsilent>
<cfinclude template="/includes/adminheader.cfm" />
<div class="gray-bg">
<div class="middle-box text-center loginscreen animated fadeInDown">
  <div>
    <div class="logo_title">
      <picture>
        <source srcset="/img/TherapyOZLogo.png, /img/TherapyOZLogo_retina.png 2x">
        <img class="logo" srcset="/img/TherapyOZLogo.png, /img/TherapyOZLogo_retina.png 2x" alt="Therapy Oz Logo"/> </picture>
      <h1 class="title">THERAPY <span>Oz</span></h1>
    </div>
    <h3>Welcome to the Therapy Oz Administration Suite</h3>
    <h4>To manage your web site and add/edit content to the sites.  If you wish to see the public web site for Therapy Oz, please <a href="http://therapyoz.com" >Click Here >>></a> </h4>
    <p>Please Log in</p>
    <cfoutput>
    <cfif len(session.loginerrormessage) GT '1'>
    <div class="alert alert-danger">
    <ul>#session.loginerrormessage#</ul>
	</div>
    </cfif>
    <form class="m-t" role="form" action="/includes/forcelogin.cfm" method="post" >
      <div class="form-group">
        <input type="text" class="form-control" name="username" id="username" placeholder="Username" required>
      </div>
      <div class="form-group">
        <input type="password" class="form-control" name="password" id="password" placeholder="Password" required>
      </div>
      <button type="submit" class="btn btn-primary block full-width m-b">Login</button>
      <a href="/includes/LostPasswordForm.cfm"><small>Forgot password?</small></a>
      <p class="text-muted text-center"><small>Do not have an account?</small></p>
      <a class="btn btn-sm btn-white btn-block" href="http://therapyoz.com">Create an account</a>
    </form>
   
    <p class="m-t"> <small>&copy; #datepart("yyyy", now())#  Therapy Oz</small> </p>
    </cfoutput>
  </div>
</div>
</div>
<!-- Mainly scripts --> 
<script src="/js/jquery-2.1.1.js"></script> 
<script src="/js/bootstrap.min.js"></script>
</body>
</html>
