<cfsilent>
<!----
==========================================================================================================
Filename:     Form_Login.cfm
Description:  Login form for AFP Cms v3.0
Date:         27/1/2006
Author:       Michael Kear

Revision history: 

==========================================================================================================
--->
<cfparam name="session.loginerrormessage" default="" />
<cfparam name="request.pagename" default="Please Log in">
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
    <h4>Enter the email address on your profile and we'll send your login details there. </h4>
    <p><a href="/index.cfm"><< Return to login page.</a></p>
    <cfoutput>
    <form class="m-t" role="form" action="/includes/forcelogin.cfm" method="post"  id="sendlostpassword">
      <div class="form-group">
        <input type="email" class="form-control" name="useremail" id="useremail" placeholder="Email address" required>
      </div>
      <button type="submit" class="btn btn-primary block full-width m-b">Submit</button>
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