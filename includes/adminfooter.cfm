<cfsilent>
<!----
==========================================================================================================
Filename:     adminfooter.cfm
Description:  Footer file for TherapyOZ Admin Area
Date:         1/9/2015
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
</cfsilent>
<!----[  Close wrapper  ]----MK ---->
</div>
       <cfoutput>
 <!----[         <div class="footer">
            <div class="pull-right">
                Websites optimised for therapists
            </div>
            <div>
                <strong>Copyright</strong> Therapy In Oz &copy; #datepart("yyyy", now() )#
                
                   </div>
        </div>

    </div>
</div>  ]----MK ---->
</cfoutput>

<!-- Mainly scripts -->
<script src="js/jquery-2.1.1.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

<!-- Custom and plugin javascript -->
<script src="js/inspinia.js"></script>
<script src="js/plugins/pace/pace.min.js"></script>
<script src="/js/plugins/iCheck/icheck.min.js"></script>
<!-- Data picker -->
<script src="/js/plugins/datepicker/datepicker.js"></script>


<script>
            $(document).ready(function () {
                $('.i-checks').iCheck({
                    checkboxClass: 'icheckbox_square-green',
                    radioClass: 'iradio_square-green',
                });
				
				$('#date_1 .input-group.date').datepicker({
                startView: 1,
                todayBtn: "linked",
                keyboardNavigation: false,
                forceParse: false,
                autoclose: true,
                format: "dd/mm/yyyy"
            });

				
            });


			
</script>
</body>

</html>