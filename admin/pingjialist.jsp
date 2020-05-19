<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="dao.CommDAO"%>
<%@page import="util.PageManager"%>
<%@page import="util.Info"%>
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
     <script src="/tushupiaoliusys/layer/jquery-2.0.3.min.js"></script>
 <script src="/tushupiaoliusys/layer/layer.js"></script>
 <script src="/tushupiaoliusys/layer/layui.css"></script>
    
    <script src="js/setup.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            setupPrettyPhoto();
            setupLeftMenu();
			setSidebarHeight();


        });
    </script>
  </head>
<%	 CommDAO dao = new CommDAO(); 
     String sql = "select * from pingjia where 1=1 ";
	 String url = "/tushupiaoliusys/admin/pingjialist.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String key2 = request.getParameter("key2")==null?"":request.getParameter("key2");
	 if(!key.equals(""))
	 {
		 sql+=" and mid in (select id from member where tname like'%"+key+"%')";
	 url+="&key="+key;
	 }
	 if(!key1.equals(""))
	 {
	 sql+=" and (fid ='"+key1+"')";
	 url+="&key1="+key1;
	 }
	 if(!key2.equals(""))
	 {
	 sql+=" and (sid ='"+key2+"')";
	 url+="&key2="+key2;
	 }
	 sql+=" order by id desc";
%>
  <body>
<div class="container_12">
        <jsp:include page="/admin/top.jsp"></jsp:include>
        <jsp:include page="/admin/left.jsp"></jsp:include>
        
        <div class="grid_10">
            <div class="box round first grid">
                <h2>图书评价管理</h2>
                <div class="block">
                    
                    
                    
                    <table class="data display" id="example">
                    <thead>
						<tr>
							<th colspan="9" align="left">
								<form action="/tushupiaoliusys/admin/pingjialist.jsp?f=f" method="post" class="form-inline" style="padding-bottom: 10px;">
									<input class="input-xlarge" placeholder="评价人姓名..." id="key" name="key" type="text" value="<%=key %>">
									<input type="submit"  class="btn btn-small" value="查询">
								</form>
							</th>
						</tr>
					</thead>
					<thead >
						<tr style="margin-top: 20px;">
						 <th>评价人</th>
						 <th>评价内容</th>
				         <th>图书名称</th>
				         <th>所属类别</th>
				         <th>评价日期</th>
						<th>操作</th>
						</tr>
					</thead>
					<tbody>
					 <%
					   String did = request.getParameter("did");
					   if(did!=null){
						   dao.commOper("delete from  pingjia  where id="+did);
					   }
					   
					   PageManager pageManager = PageManager.getPage(url,10, request);
					   pageManager.doList(sql);
					   PageManager bean= (PageManager)request.getAttribute("page");
					   ArrayList<HashMap> list=(ArrayList<HashMap>)bean.getCollection();
					   	for(HashMap jymap:list){
					   		HashMap map = dao.select("select * from tushu where id="+jymap.get("tsid")).get(0);
					   		HashMap fprotype = (HashMap)dao.select("select * from protype where id="+map.get("fid")).get(0);
					   		HashMap sprotype = (HashMap)dao.select("select * from protype where id="+map.get("sid")).get(0);
					   		HashMap mmm = dao.select("select * from member where id="+jymap.get("mid")).get(0);
						    %>
						<tr  align="center" height="20px;">
						<td><%=mmm.get("tname") %></td>
				         <td><%=jymap.get("note") %></td>
				          <td><%=map.get("name") %></td>
				          <td><%=fprotype.get("typename") %> （<%=sprotype.get("typename") %>）</td>
							<td><%=jymap.get("savetime") %> </td>
							<td align="center">
							<a href="<%=path %>/admin/pingjialist.jsp?did=<%=jymap.get("id") %>" >删除</a>
							</td>
						</tr>
						<%} %>
						<tr class="odd gradeX">
							<td class="right" colspan="13">${page.info }</td>
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

function show(title,id,type){
    var acontent;
    var hfcontent = $("#hfcontent"+id).val();
    var note = $("#note"+id).val();
    if(type=="jj"){
    	acontent=hfcontent;
    }
    if(type=="bz"){
    	acontent=note;
    }
	layer.open({
		  title: title,
		  area: ['800px', '400px'],
		  offset: 'rb',
		  content: acontent
   }); 
}

  </script>
	<script type="text/javascript">
    	function newsadd(){
			location.href="/tushupiaoliusys/admin/tushuadd.jsp";
        }

        
    	var req;
        function Change_Select(){//当第一个下拉框的选项发生改变时调用该函数
          var fprotype = document.getElementById('key1').value;
          var url = "/tushupiaoliusys/tushupiaoliusys?ac=searchsontype&fprotype="+ escape(fprotype);
          if(window.XMLHttpRequest){
            req = new XMLHttpRequest();
          }else if(window.ActiveXObject){
            req = new ActiveXObject("Microsoft.XMLHTTP");
          }  
          if(req){
            req.open("GET",url,true);
             //指定回调函数为callback
            req.onreadystatechange = callback;
            req.send(null);
          }
        }
        //回调函数
        function callback(){
          if(req.readyState ==4){
            if(req.status ==200){
            //var msg = req.responseText;
    		//		alert(msg);
            
              parseMessage();//解析XML文档
            }else{
              alert("不能得到描述信息:" + req.statusText);
            }
          }
        }
        //解析返回xml的方法
        function parseMessage(){
          var xmlDoc = req.responseXML.documentElement;//获得返回的XML文档
          var xSel = xmlDoc.getElementsByTagName('select');
          //获得XML文档中的所有<select>标记
          var select_root = document.getElementById('key2');
          //获得网页中的第二个下拉框
          select_root.options.length=0;
          //每次获得新的数据的时候先把每二个下拉框架的长度清0
         
          for(var i=0;i<xSel.length;i++){
            var xValue = xSel[i].childNodes[0].firstChild.nodeValue;
            //获得每个<select>标记中的第一个标记的值,也就是<value>标记的值
            var xText = xSel[i].childNodes[1].firstChild.nodeValue;
            //获得每个<select>标记中的第二个标记的值,也就是<text>标记的值
           
            var option = new Option(xText, xValue);
            //根据每组value和text标记的值创建一个option对象
            try{
              select_root.add(option);//将option对象添加到第二个下拉框中
            }catch(e){
            }
          }
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
