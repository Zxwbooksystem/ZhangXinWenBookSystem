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
     String sql = "select * from tushu where 1=1 and delstatus='0' ";
	 String url = "/tushupiaoliusys/admin/tushulist.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String key2 = request.getParameter("key2")==null?"":request.getParameter("key2");
	 if(!key.equals(""))
	 {
		 sql+=" and name like'%"+key+"%'";
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
                <h2>图书管理</h2>
                <div class="block">
                    
                    
                    
                    <table class="data display" id="example">
                    <thead>
						<tr>
							<th colspan="9" align="left">
								<form action="/tushupiaoliusys/admin/tushulist.jsp?f=f" method="post" class="form-inline" style="padding-bottom: 10px;">
									<input class="input-xlarge" placeholder="图书名称..." id="key" name="key" type="text" value="<%=key %>">
									<select id="key1" name="key1" onchange="Change_Select()"  style="width: 150px;height: 21px;">
										<option value="">请选择大类</option>
								    		<%ArrayList<HashMap> fprotypelist = (ArrayList<HashMap>)dao.select("select * from protype where delstatus='0' and fatherid='0' "); 
								    		for(HashMap fprotype:fprotypelist){%>
								    		<option value="<%=fprotype.get("id")%>" <%if(key1.equals(fprotype.get("id").toString())){out.print("selected==selected");} %>><%=fprotype.get("typename")%></option>
								    		<%} %>
										</select>
										<select id="key2" name="key2" style="width: 150px;height: 21px;">
									    		<option value="">请选择小类</option>
									    		<%ArrayList<HashMap> sprotypelist = (ArrayList<HashMap>)dao.select("select * from protype where  fatherid='"+key1+"' "); 
									    		for(HashMap sprotype:sprotypelist){%>
									    		<option value="<%=sprotype.get("id") %>" <%if(key2.equals(sprotype.get("id").toString())){out.print("selected==selected");} %>><%=sprotype.get("typename") %></option>
									    		<%} %>
									    </select>
									<input type="submit"  class="btn btn-small" value="查询">
									<input onclick="newsadd()" type="button"  class="btn btn-small" value="添加">
								</form>
							</th>
						</tr>
					</thead>
					<thead >
						<tr style="margin-top: 20px;">
						  <th>编号</th>
				          <th>名称</th>
				         <th>作者</th>
				         <th>出版社</th>
				          <th>书架号</th>
				          <th>余量</th>
				           <th>定价</th>
				          <th>所属类别</th>
				          <th>创建日期</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					 <%
					   String did = request.getParameter("did");
					   if(did!=null){
						   dao.commOper("update tushu set delstatus=1 where id="+did);
					   }
					   PageManager pageManager = PageManager.getPage(url,10, request);
					   pageManager.doList(sql);
					   PageManager bean= (PageManager)request.getAttribute("page");
					   ArrayList<HashMap> list=(ArrayList<HashMap>)bean.getCollection();
					   	for(HashMap map:list){
					   		HashMap fprotype = (HashMap)dao.select("select * from protype where id="+map.get("fid")).get(0);
					   		HashMap sprotype = (HashMap)dao.select("select * from protype where id="+map.get("sid")).get(0);
						    %>
						<tr  align="center" height="20px;">
						<td>
						<%ArrayList xxlist = (ArrayList)dao.select("select * from tushuxx where delstatus=0 and tsid='"+map.get("id")+"'");
						if(xxlist.size()==0){%>
						<a href="/tushupiaoliusys/admin/tsxxadd.jsp?tsid=<%=map.get("id") %>" style="color: red;" >添加</a>
						<%} else{%>
						<a href="/tushupiaoliusys/admin/tsxxadd.jsp?tsid=<%=map.get("id") %>" style="color: red;">添加</a>
						<a href="/tushupiaoliusys/admin/tsxxlist.jsp?tsid=<%=map.get("id") %>" style="color: blue;">查看</a>
						<%}%>
						
						
						</td>
				          <td><%=map.get("name") %></td>
				          <td><%=map.get("zouzhe") %></td>
				           <td><%=map.get("cbs") %></td>
				            <td><%=map.get("shujia") %></td>
				             <td>
				             <%ArrayList sllist = (ArrayList)dao.select("select * from tushuxx where status='待借' and gsstatus='' and delstatus=0 and tsid='"+map.get("id")+"'");%>
				             <%=sllist.size() %> 本
				             
				             </td>
				              <td><%=map.get("dinjia") %> 元</td>
				          <td><%=fprotype.get("typename") %> （<%=sprotype.get("typename") %>）</td>
							<td><%=map.get("savetime") %> </td>
							<td align="center">
							<a href="/tushupiaoliusys/admin/tushuedit.jsp?id=<%=map.get("id") %>" >编辑</a>
							<a href="/tushupiaoliusys/admin/tushulist.jsp?did=<%=map.get("id") %>" >删除</a>
							</td>
						</tr>
						<%} %>
						<tr class="odd gradeX">
							<td class="right" colspan="10">${page.info }</td>
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
