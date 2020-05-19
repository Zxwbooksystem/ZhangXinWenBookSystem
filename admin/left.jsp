<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>后台管理系统</title>
    <link rel="stylesheet" type="text/css" href="css/reset.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/text.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/grid.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/layout.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="screen" />
    <!--[if IE 6]><link rel="stylesheet" type="text/css" href="css/ie6.css" media="screen" /><![endif]-->
    <!--[if IE 7]><link rel="stylesheet" type="text/css" href="css/ie.css" media="screen" /><![endif]-->
    <link href="css/table/demo_page.css" rel="stylesheet" type="text/css" />
    <!-- BEGIN: load jquery -->
    <script src="js/jquery-1.6.4.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/jquery-ui/jquery.ui.core.min.js"></script>
    <script src="js/jquery-ui/jquery.ui.widget.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.accordion.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.core.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.slide.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.mouse.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.sortable.min.js" type="text/javascript"></script>
    <script src="js/table/jquery.dataTables.min.js" type="text/javascript"></script>
    <!-- END: load jquery -->
    <script type="text/javascript" src="js/table/table.js"></script>
    <script src="js/setup.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            setupLeftMenu();

            $('.datatable').dataTable();
			setSidebarHeight();


        });
    </script>
  </head>
  
  <body>
<div class="container_12">
        
        <div class="grid_2">
            <div class="box sidemenu">
                <div class="block" id="section-menu">
                    <ul class="section menu">
                        <li><a class="menuitem">基础信息</a>
                            <ul class="submenu">
                             <li><a href="gywmedit.jsp">关于我们</a> </li>
                                <li><a href="newslist.jsp">公告管理</a> </li>
                                <li><a href="memberlist.jsp">用户管理</a> </li>
                                <li><a href="yqlink.jsp">友情链接</a> </li>
                                <li><a href="imgadv.jsp">滚动图片</a> </li>
                            </ul>
                        </li>
                        <li><a class="menuitem">图书信息</a>
                            <ul class="submenu">
                                <li><a href="protype.jsp">图书类别</a></li>
					            <li><a href="tushulist.jsp">图书管理</a></li>
					             <li><a href="tushujieyuelist.jsp">图书借阅</a></li>
					             <li><a href="huansshhlist.jsp">还书审核</a></li>
					             <li><a href="fakuanlist.jsp">逾期罚款</a></li>
					              <li><a href="guasilist.jsp">挂失赔偿</a></li>
					              <li><a href="jieyuejilulist.jsp">图书借阅记录</a></li>
					             <li><a href="pingjialist.jsp">图书评价管理</a></li>
					              <li><a href="tj.jsp">借阅统计</a></li>
					         </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        
	</body>
</html>
