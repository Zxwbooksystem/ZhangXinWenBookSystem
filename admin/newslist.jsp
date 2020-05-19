<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="dao.CommDAO"%>
<%@page import="util.Info"%>
<%@page import="util.PageManager"%>
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
    <script src="js/jquery-1.6.4.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/jquery-ui/jquery.ui.core.min.js"></script>
    <script src="js/jquery-ui/jquery.ui.widget.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.accordion.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.core.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.slide.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.mouse.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.sortable.min.js" type="text/javascript"></script>
    <!-- END: load jquery -->
    <script src="js/pretty-photo/jquery.prettyPhoto.js" type="text/javascript"></script>
    <script src="js/setup.js" type="text/javascript"></script>
    <script src="/tushupiaoliusys/layer/jquery-2.0.3.min.js" type="text/javascript"></script>
    <script src="/tushupiaoliusys/layer/layer.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            setupPrettyPhoto();
            setupLeftMenu();
			setSidebarHeight();


        });
    </script>
  </head>
      <%	 
      CommDAO dao = new CommDAO();
	 String sql = "select * from news where 1=1   ";
	 String url = "/tushupiaoliusys/admin/newslist.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 if(!key.equals(""))
	 {
	 sql+=" and (title like'%"+key+"%')";
	 url+="&key="+key;
	 }
	 sql+=" order by id desc";
%>
  <body>
<div class="container_12">
        <jsp:include page="/admin/top.jsp"></jsp:include>
        <jsp:include page="/admin/left.jsp"></jsp:include>
        
        <div class="grid_10">
            <div class="box round first grid">
                <h2>公告管理</h2>
                <div class="block">
                    
                    
                    
                    <table class="data display" id="example">
                    <thead>
						<tr>
							<th colspan="3" align="left">
								<form action="newslist.jsp?f=f" method="post" class="form-inline">
									<input class="input-xlarge" placeholder="标题..." id="key" name="key" type="text" value="<%=key %>">
									<input type="submit"  class="btn btn-small" value="查询">
									<input onclick="newsadd()" type="button"  class="btn btn-small" value="添加">
								</form>
							</th>
						</tr>
					</thead>
					<thead>
						<tr>
							<th>标题</th>
							<th>发布日期</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
					 <%
					   String did = request.getParameter("did");
					   if(did!=null){
						   dao.commOper("delete from news where id="+did);
					   }
					   PageManager pageManager = PageManager.getPage(url,10, request);
					   pageManager.doList(sql);
					   PageManager bean= (PageManager)request.getAttribute("page");
					   ArrayList<HashMap> list=(ArrayList<HashMap>)bean.getCollection();
					   	for(HashMap news:list){
						    %>
						<tr class="odd gradeX" align="center">
							<td><%=news.get("title")%></td>
							<td align="center"><%=news.get("savetime") %></td>
							<td align="center">
							<a href="newsedit.jsp?id=<%=news.get("id") %>">编辑</a>
							|
							<a href="newslist.jsp?did=<%=news.get("id") %>" >删除</a>
							</td>
						</tr>
						<%} %>
						<tr class="odd gradeX">
							<td class="right" colspan="3">${page.info }</td>
						</tr>
						
						
					</tbody>
				</table>
                    
                    
                    
                </div>
            </div>
        </div>
        <div class="clear">
        </div>
    </div>
    <div class="clear">
    </div>
    <jsp:include page="/admin/foot.jsp"></jsp:include>
	</body>
	<script type="text/javascript">
    	function newsadd(){
			location.href="newsadd.jsp";
        }

    </script>
    <script type="text/javascript">
	<%
	String suc = (String)session.getAttribute("suc");
	if(suc!=null){
    session.removeAttribute("suc");
	%>
	layer.msg('<%=suc%>');
	<%}%>
	</script>
    
    
</html>
