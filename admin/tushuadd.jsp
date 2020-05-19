<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="dao.CommDAO"%>
<%@page import="util.Info"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
CommDAO dao = new CommDAO();  %>
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
      <script src="<%=path %>/layer/jquery-2.0.3.min.js"></script>
    <script src="<%=path %>/layer/layer.js"></script>
    
    <!-- END: load jquery -->
    <script charset="utf-8" src="/tushupiaoliusys/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="/tushupiaoliusys/kindeditor/lang/zh-CN.js"></script>
	<script>
	        KindEditor.ready(function(K) {
	                window.editor = K.create('#editor_id');
	        });
	</script>
		<script>

KindEditor.ready(function(K) {

K.create('textarea[name="note"]', {

uploadJson : '/tushupiaoliusys/kindeditor/jsp/upload_json.jsp',

                fileManagerJson : '/tushupiaoliusys/kindeditor/jsp/file_manager_json.jsp',

                allowFileManager : true,

                allowImageUpload : true, 

autoHeightMode : true,

afterCreate : function() {this.loadPlugin('autoheight');},

afterBlur : function(){ this.sync(); }  //Kindeditor下获取文本框信息

});

});

</script>
  </head>
   
  <body>
  
<div class="container_12">
        <jsp:include page="/admin/top.jsp"></jsp:include>
        <jsp:include page="/admin/left.jsp"></jsp:include>
        
        <div class="grid_10">
            <div class="box round first fullpage">
                <h2>添加图书</h2>
                <div class="block ">
                    <form id="form" action="<%=path %><%=path %>?ac=tushuadd" method="post">
                    <table class="form" style="margin-left: 10px;">
                    <tr>
                            <td class="col1">
                                <label>图片</label>
                            </td>
                            <td class="col2">
                               <img alt="" src="/tushupiaoliusys/upfile/no.jpg" id="imgfilename" style="width: 100px;height: 100px;">
							<input  name="filename"  type='hidden' class="form-control" placeholder="点击按钮上传图片"  required    id='url'  size='40'  /><br>
								<input type='button' value='上传图片'  class="layui-input" onClick="up('url')" style="width: 80px;height: 30px;border:1px solid #cccccc;background: white;border-radius:20px 20px;outline:none;"/>
                            </td>
                        </tr><%--
                    
                        <tr>
                            <td class="col1">
                                <label>编号</label>
                            </td>
                            <td class="col2">
                                <input type="text" id="bianhao" name="bianhao" value="<%=Info.getAutoNo() %>" readonly="readonly" class="input-xlarge span12" required>
                            </td>
                        </tr>
                        
                        --%><tr>
                            <td class="col1">
                                <label>名称</label>
                            </td>
                            <td class="col2">
                                <input type="text" id="name" name="name" class="input-xlarge span12" required>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="col1">
                                <label>作者</label>
                            </td>
                            <td class="col2">
                                <input type="text" id="zouzhe" name="zouzhe" class="input-xlarge span12" required>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="col1">
                                <label>出版社</label>
                            </td>
                            <td class="col2">
                                <input type="text" id="cbs" name="cbs" class="input-xlarge span12" required>
                            </td>
                        </tr>
                        
                          <tr>
                            <td class="col1">
                                <label>书架号</label>
                            </td>
                            <td class="col2">
                                <input type="text" id="shujia" name="shujia" class="input-xlarge span12" required>
                            </td>
                        </tr>
                        
                        
                        <tr>
                            <td class="col1">
                                <label>定价</label>
                            </td>
                            <td class="col2">
                                <input type="text" id="dinjia" name="dinjia" class="input-xlarge span12" required>
                            </td>
                        </tr>
                        
                        
                        <tr>
                            <td class="col1">
                                <label>所属类别</label>
                            </td>
                            <td class="col2">
                                <select id="fid" name="fid" onChange="Change_Select()" style="width: 179px;height: 30px;"  required>
								<option value="">请选择大类</option>
					    		<%ArrayList<HashMap> fprotypelist = (ArrayList<HashMap>)dao.select("select * from protype where delstatus='0' and fatherid='0'"); 
					    		for(HashMap fprotype:fprotypelist){%>
					    		<option value="<%=fprotype.get("id") %>"><%=fprotype.get("typename") %></option>
					    		<%} %>
					    		</select>
                            </td>
                        </tr>
                             <tr>
                            <td class="col1">
                                <label></label>
                            </td>
                            <td class="col2">
								<select style="width: 179px;height: 30px;" id="sid" name="sid" required>
							    <option value="">请选择小类</option>
							</select>
                            </td>
                        </tr>
                        
                        
                        <tr>
                            <td class="col1">
                                <label>简要描述</label>
                            </td>
                            <td class="col2">
                                <textarea id="editor_id" id="note" name="note" style="width:700px;height:200px;" ></textarea>
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
    <script type="text/javascript">
    	
	
    var req;
    function Change_Select(){//当第一个下拉框的选项发生改变时调用该函数
      var fprotype = document.getElementById('fid').value;
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
      var select_root = document.getElementById('sid');
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
</html>
