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
    
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="screen" />
    <!--[if IE 6]><link rel="stylesheet" type="text/css" href="css/ie6.css" media="screen" /><![endif]-->
    <!--[if IE 7]><link rel="stylesheet" type="text/css" href="css/ie.css" media="screen" /><![endif]-->
    <link href="css/table/demo_page.css" rel="stylesheet" type="text/css" />
    <!-- BEGIN: load jquery -->
    <script src="<%=path %>/layer/jquery-2.0.3.min.js"></script>
    <script src="<%=path %>/layer/layer.js"></script>
    <script src="js/jquery-1.6.4.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/jquery-ui/jquery.ui.core.min.js"></script>
    <script src="js/jquery-ui/jquery.ui.widget.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.accordion.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.core.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.slide.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.mouse.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.sortable.min.js" type="text/javascript"></script>
    <!-- END: load jquery -->
  </head>
   
  <body>
<div class="container_12">
        <jsp:include page="/admin/top.jsp"></jsp:include>
        <jsp:include page="/admin/left.jsp"></jsp:include>
        
        <div class="grid_10">
            <div class="box round first fullpage">
                <h2>添加</h2>
                <div class="block ">
                    <form id="form" action="<%=path %><%=path %>?ac=imgadvadd" method="post" >
                    <table class="form">
                        <tr>
                            <td class="col1">
                                <label>图片</label>
                            </td>
                            <td class="col2">
                                <input name="filename" type='text' class="form-control" placeholder="点击按钮上传图片"  required    id='url'  size='15'  />&nbsp;
                                <input type='button' value='上传'  class="layui-input" onClick="up('url')" style="width: 80px;height: 25px;border:1px solid #cccccc;background: white;border-radius:20px 20px;outline:none;"/>
                            
                            </td>
                        </tr>
                        <tr>
                            <td class="col1" colspan="2">
                                <button class="btn btn-primary"><i class="icon-save"></i> Save</button>
                            </td>
                        </tr>
                        
                        
                    </table>
                    </form>
                </div>
            </div>
        </div>
        <div class="clear">
        </div>
        </div>
        <div class="clear">
        </div>
    <div class="clear">
    </div>
    <jsp:include page="/admin/foot.jsp"></jsp:include>
	</body>
	<script type="text/javascript">
    	function newsadd(){
			location.href="newsadd.jsp";
        }

    	function up(tt)
    	{
        layer.open({
          type: 2,
          title: '上传文件',
          shadeClose: true,
          shade: false,
          maxmin: true, //开启最大化最小化按钮
          area: ['450px', '200px'],
          content: 'upload.jsp?Result='+tt
        });
    	}
    </script>
</html>
