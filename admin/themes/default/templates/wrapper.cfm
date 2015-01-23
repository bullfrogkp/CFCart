<cfoutput>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>AdminLTE | Dashboard</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <!-- bootstrap 3.0.2 -->
        <link href="#SESSION.absolute_url_theme_admin#css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- font Awesome -->
        <link href="#SESSION.absolute_url_theme_admin#css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons -->
        <link href="#SESSION.absolute_url_theme_admin#css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <!-- Morris chart -->
        <link href="#SESSION.absolute_url_theme_admin#css/morris/morris.css" rel="stylesheet" type="text/css" />
        <!-- jvectormap -->
        <link href="#SESSION.absolute_url_theme_admin#css/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
        <!-- Date Picker -->
        <link href="#SESSION.absolute_url_theme_admin#css/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
        <!-- Daterange picker -->
        <link href="#SESSION.absolute_url_theme_admin#css/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
        <!-- bootstrap wysihtml5 - text editor -->
        <link href="#SESSION.absolute_url_theme_admin#css/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
        <!-- Theme style -->
        <link href="#SESSION.absolute_url_theme_admin#css/AdminLTE.css" rel="stylesheet" type="text/css" />

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
    </head>
    <body class="skin-blue">
        <!-- header logo: style can be found in header.less -->
        <header class="header">
            <a href="index.html" class="logo">
                <!-- Add the class icon to your logo image or logo icon to add the margining -->
                Admin Panel
            </a>
            <!-- Header Navbar: style can be found in header.less -->
            <nav class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a href="##" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <div class="navbar-right">
                    <ul class="nav navbar-nav">
                        <!-- Messages: style can be found in dropdown.less-->
                        
                        <!-- User Account: style can be found in dropdown.less -->
                        <li class="dropdown user user-menu">
                            <a href="##" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="glyphicon glyphicon-user"></i>
                                <span>Rona<i class="caret"></i></span>
                            </a>
                            <ul class="dropdown-menu">
                                <!-- User image -->
                                <li class="user-header bg-light-blue">
                                    <img src="#SESSION.absolute_url_theme_admin#img/avatar3.png" class="img-circle" alt="User Image" />
                                    <p>
                                        Rona - Administrator
                                    </p>
                                </li>
                                <!-- Menu Footer-->
                                <li class="user-footer">
                                    <div class="pull-left">
                                        <a href="change_password.cfm" class="btn btn-default btn-flat">Profile</a>
                                    </div>
                                    <div class="pull-right">
                                        <a href="login.cfm?logout=1" class="btn btn-default btn-flat">Sign out</a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        <div class="wrapper row-offcanvas row-offcanvas-left">
            <!-- Left side column. contains the logo and sidebar -->
            <aside class="left-side sidebar-offcanvas">
                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">
                    <!-- Sidebar user panel -->
                    <div class="user-panel">
                        <div class="pull-left image">
                            <img src="#SESSION.absolute_url_theme_admin#img/avatar3.png" class="img-circle" alt="User Image" />
                        </div>
                        <div class="pull-left info">
                            <p>Hello, Rona</p>

                            <a href="##"><i class="fa fa-circle text-success"></i> Online</a>
                        </div>
                    </div>
                    <!-- search form -->
                    <form action="##" method="get" class="sidebar-form">
                        <div class="input-group">
                            <input type="text" name="q" class="form-control" placeholder="Search..."/>
                            <span class="input-group-btn">
                                <button type='submit' name='seach' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button>
                            </span>
                        </div>
                    </form>
                    <!-- /.search form -->
                    <!-- sidebar menu: : style can be found in sidebar.less -->
                     <ul class="sidebar-menu">
                        <li>
                            <a href="#APPLICATION.absolute_url_web#admin/index.cfm">
                                <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                            </a>
                        </li>
						 <li>
                            <a href="#APPLICATION.absolute_url_web#admin/categories.cfm">
                                <i class="fa fa-bars"></i> <span>Categories</span>
                            </a>
                        </li>
						 <li>
                            <a href="#APPLICATION.absolute_url_web#admin/products.cfm">
                                <i class="fa fa-shopping-cart"></i> <span>Products</span>
                            </a>
                        </li>
						 <li>
                            <a href="#APPLICATION.absolute_url_web#admin/customers.cfm">
                                <i class="fa fa-users"></i> <span>Customers</span>
                            </a>
                        </li>
						 <li>
                            <a href="#APPLICATION.absolute_url_web#admin/orders.cfm">
                                <i class="fa fa-file-text"></i> <span>Orders</span>
                            </a>
                        </li>
                        <li class="treeview">
                            <a href="##">
                                <i class="fa fa-gear"></i>
                                <span>Settings</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <li><a href="#APPLICATION.absolute_url_web#admin/emails.cfm"><i class="fa fa-angle-double-right"></i> Emails</a></li>
                                <li><a href="#APPLICATION.absolute_url_web#admin/taxes.cfm"><i class="fa fa-angle-double-right"></i> Taxes</a></li>
                                <li><a href="#APPLICATION.absolute_url_web#admin/location.cfm"><i class="fa fa-angle-double-right"></i> Location</a></li>
                            </ul>
                        </li>
						 <li>
                            <a href="#CGI.SCRIPT_NAME#?logout">
                                <i class="fa fa-user"></i> <span>Logout</span>
                            </a>
                        </li>
                    </ul>
                
                </section>
                <!-- /.sidebar -->
            </aside>

            <!-- Right side column. Contains the navbar and content of the page -->
            <aside class="right-side">
                <cfinclude template="#REQUEST.page_data.template_path#" />
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->


        <!-- jQuery 2.0.2 -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
        <!-- jQuery UI 1.10.3 -->
        <script src="#SESSION.absolute_url_theme_admin#js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
        <!-- Bootstrap -->
        <script src="#SESSION.absolute_url_theme_admin#js/bootstrap.min.js" type="text/javascript"></script>
        <!-- Morris.js charts -->
        <script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
        <script src="#SESSION.absolute_url_theme_admin#js/plugins/morris/morris.min.js" type="text/javascript"></script>
        <!-- Sparkline -->
        <script src="#SESSION.absolute_url_theme_admin#js/plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
        <!-- jvectormap -->
        <script src="#SESSION.absolute_url_theme_admin#js/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
        <script src="#SESSION.absolute_url_theme_admin#js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>
        <!-- jQuery Knob Chart -->
        <script src="#SESSION.absolute_url_theme_admin#js/plugins/jqueryKnob/jquery.knob.js" type="text/javascript"></script>
        <!-- daterangepicker -->
        <script src="#SESSION.absolute_url_theme_admin#js/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
        <!-- datepicker -->
        <script src="#SESSION.absolute_url_theme_admin#js/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
        <!-- Bootstrap WYSIHTML5 -->
        <script src="#SESSION.absolute_url_theme_admin#js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
        <!-- iCheck -->
        <script src="#SESSION.absolute_url_theme_admin#js/plugins/iCheck/icheck.min.js" type="text/javascript"></script>

        <!-- AdminLTE App -->
        <script src="#SESSION.absolute_url_theme_admin#js/AdminLTE/app.js" type="text/javascript"></script>

        <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
        <script src="#SESSION.absolute_url_theme_admin#js/AdminLTE/dashboard.js" type="text/javascript"></script>

        <!-- AdminLTE for demo purposes -->
        <script src="#SESSION.absolute_url_theme_admin#js/AdminLTE/demo.js" type="text/javascript"></script>
    </body>
</html>
</cfoutput>
<cfset SESSION.temp = {} />