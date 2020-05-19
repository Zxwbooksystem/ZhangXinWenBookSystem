<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="dao.CommDAO"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
HashMap mm = (HashMap)session.getAttribute("admin");
CommDAO dao = new CommDAO();
HashMap map = (HashMap)dao.select("select * from sysuser where id="+mm.get("id")).get(0);
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>后台管理系统</title>
  </head>
  <body>
<div class="container_12">
        <div class="grid_12 header-repeat">
            <div id="branding">
                <div class="floatleft">
                    	<h3 style="color: white;">后台管理系统</h3></div>
                <div class="floatright">
                    <div class="floatleft">
                    <div class="floatleft marginleft10">
                        <ul class="inline-ul floatleft">
                            <li>( <%=map.get("usertype") %> ) <%=map.get("realname") %></li>
                            <li><a href="myaccount.jsp">密码修改</a></li>
                            <li><a href="/tushupiaoliusys/tushupiaoliusys?ac=adminExit">安全退出</a></li>
                        </ul>
                        
                    </div>
                </div>
                <div class="clear">
                </div>
            </div>
        </div>
        <div class="clear">
        </div>
        </div>
	</body>
</html>
