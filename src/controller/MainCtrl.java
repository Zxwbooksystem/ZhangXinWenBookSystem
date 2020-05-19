package controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.SocketException;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.main.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.RequestContext;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.servlet.ServletRequestContext;




import util.Info;
import util.StrUtil;

import dao.CommDAO;

public class MainCtrl extends HttpServlet {
	
	public MainCtrl() {
		super();
	}

	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
	this.doPost(request, response);
	}
	MainMethod responses = new MainMethod();
		public void go(String url,HttpServletRequest request, HttpServletResponse response)
		{
		try {
			request.getRequestDispatcher(url).forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		}
		
		public void gor(String url,HttpServletRequest request, HttpServletResponse response)
		{
			try {
				response.sendRedirect(url);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
        response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		HashMap admin = (HashMap)session.getAttribute("admin");
		HashMap member = (HashMap)session.getAttribute("member");
		String ac = request.getParameter("ac");
		if(ac==null)ac="";
		CommDAO dao = new CommDAO();
		String date = Info.getDateStr();
		String today = date.substring(0,10);
		String tomonth = date.substring(0,7);
		
		//登录
		if(ac.equals("adminLogin"))
		{
			    String username = request.getParameter("username");
			    String userpwd = request.getParameter("userpwd");
			    	String sql = "select * from sysuser where username='"+username+"' and userpwd='"+userpwd+"' and usertype='管理员'";
			    	List<HashMap> list = dao.select(sql);
			    	if(list.size()==1)
			    	{
			    		session.setAttribute("admin", list.get(0));
			    	gor("/tushupiaoliusys/admin/memberlist.jsp", request, response);
			    	}else{
			    		request.setAttribute("suc", "用户名或密码错误");
				    	gor("/tushupiaoliusys/admin/login.jsp", request, response);
			    	}
		}
		//后台退出
		if(ac.equals("adminExit")){
			session.removeAttribute("admin");
			gor("/tushupiaoliusys/admin/login.jsp", request, response);
		}
		//密码修改
		if (ac.equals("adminPwdEdit")) {
			String id = request.getParameter("id");
			String newpwd1 = request.getParameter("newpwd1");
			dao.commOper("update sysuser set userpwd='"+newpwd1+"' where id="+id);
			session.setAttribute("suc", "修改成功");
			gor("/tushupiaoliusys/admin/myaccount.jsp", request, response);
			
		}
		//关于我们
		if (ac.equals("gywmedit")) {
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String note = request.getParameter("note");
			dao.commOper("update gywm set name='"+name+"',note='"+note+"' where id="+id);
			session.setAttribute("suc", "操作成功");
			gor("/tushupiaoliusys/admin/gywmedit.jsp", request, response);
			
		}
		//公告新增
		if (ac.equals("newsadd")) {
			String title = request.getParameter("title");
			String bstime = "";
			String note = request.getParameter("note");
			String savetime = Info.getDateStr();
			dao.commOper("insert into news values(null,'"+title+"','"+bstime+"','"+note+"','"+savetime+"')");
			session.setAttribute("suc", "操作成功");
			gor("/tushupiaoliusys/admin/newslist.jsp", request, response);
		}
		
		//编辑公告
		if (ac.equals("newsedit")) {
			String id = request.getParameter("id");
			String title = request.getParameter("title");
			String note = request.getParameter("note");
			dao.commOper("update news set title='"+title+"',note='"+note+"' where id="+id);
			session.setAttribute("suc", "操作成功");
			gor("/tushupiaoliusys/admin/newslist.jsp", request, response);
		}
		
		//读者新增
		if (ac.equals("memberadd")) {
			String uname = request.getParameter("uname");
			String upass = request.getParameter("upass");
			String tname = request.getParameter("tname");
			String sex = request.getParameter("sex");
			String tel = request.getParameter("tel");
			String delstatus = "0";
			String savetime = Info.getDateStr();
			dao.commOper("insert into member values(null,'"+uname+"','"+upass+"','"+tname+"','"+sex+"','"+tel+"','"+delstatus+"','"+savetime+"')");
			session.setAttribute("suc", "操作成功");
			gor("/tushupiaoliusys/admin/memberlist.jsp", request, response);
		}
		
		//读者信息编辑
		if (ac.equals("membereditgly")) {
			String id = request.getParameter("id");
			String tname = request.getParameter("tname");
			String sex = request.getParameter("sex");
			String tel = request.getParameter("tel");
			dao.commOper("update member set tname='"+tname+"',sex='"+sex+"',tel='"+tel+"' where id="+id);
			session.setAttribute("suc", "操作成功");
			gor("/tushupiaoliusys/admin/memberlist.jsp", request, response);
		}
		
		
		//检查用户名唯一性AJAX 系统用户
		if(ac.equals("useradminnamecheck")){
			String username = request.getParameter("username");
			ArrayList cklist = (ArrayList)dao.select("select * from sysuser where username='"+username+"' and delstatus='0' ");
			if(cklist.size()==0){
				out.print("0");
			}else{
				out.print("1");
			}
		}
		
		//友情链接新增
		if (ac.equals("yqlinkadd")) {
			String linkname = request.getParameter("linkname");
			String linkurl = request.getParameter("linkurl");
			dao.commOper("insert into yqlink values(null,'"+linkname+"','"+linkurl+"')");
			session.setAttribute("suc", "操作成功");
			gor("/tushupiaoliusys/admin/yqlink.jsp", request, response);
		}
		
		//友情链接编辑
		if (ac.equals("yqlinkedit")) {
			String id = request.getParameter("id");
			String linkname = request.getParameter("linkname");
			String linkurl = request.getParameter("linkurl");
			dao.commOper("update yqlink set linkname='"+linkname+"',linkurl='"+linkurl+"' where id="+id);
			session.setAttribute("suc", "操作成功");
			gor("/tushupiaoliusys/admin/yqlink.jsp", request, response);
		}
		
		//滚动图片新增
		if (ac.equals("imgadvadd")) {
			String filename = request.getParameter("filename");
			dao.commOper("insert into imgadv values(null,'"+filename+"')");
			session.setAttribute("suc", "操作成功");
			gor("/tushupiaoliusys/admin/imgadv.jsp", request, response);
			
		}
		
		//类别新增
		if(ac.equals("protypeAdd")){
			String typename = request.getParameter("typename");
			String fatherid = request.getParameter("fatherid");
			dao.commOper("insert into protype (typename,fatherid,delstatus) values ('"+typename+"','"+fatherid+"','0') ");
			session.setAttribute("suc", "操作成功!");
			gor("/tushupiaoliusys/admin/protype.jsp", request, response);
		}
		//类别编辑
		if(ac.equals("protypeEdit")){
			String id = request.getParameter("id");
			String typename = request.getParameter("typename");
			dao.commOper("update protype set typename='"+typename+"' where id="+id);
			session.setAttribute("suc", "操作成功!");
			gor("/tushupiaoliusys/admin/protype.jsp", request, response);
		}
		
		//图书新增
		if (ac.equals("tushuadd")) {
			String filename = request.getParameter("filename");
			//String bianhao = request.getParameter("bianhao");
			String name = request.getParameter("name");
			String zouzhe = request.getParameter("zouzhe");
			String cbs = request.getParameter("cbs");
			String shujia = request.getParameter("shujia");
			//String num = request.getParameter("num");
			String fid = request.getParameter("fid");
			String sid = request.getParameter("sid");
			String note = request.getParameter("note");
			String delstatus = "0";
			String savetime = Info.getDateStr();
			String dinjia = request.getParameter("dinjia");
			dao.commOper("insert into tushu values(null,'"+filename+"','','"+name+"','"+zouzhe+"','"+cbs+"','"+shujia+"','','"+fid+"','"+sid+"','"+note+"','"+delstatus+"','"+savetime+"','0','"+dinjia+"')");
			session.setAttribute("suc", "操作成功!");
			gor("/tushupiaoliusys/admin/tushulist.jsp", request, response);
		}
		
		//图书编辑
		if (ac.equals("tushuedit")) {
			String id = request.getParameter("id");
			String filename = request.getParameter("filename");
			//String bianhao = request.getParameter("bianhao");
			String name = request.getParameter("name");
			String zouzhe = request.getParameter("zouzhe");
			String cbs = request.getParameter("cbs");
			String shujia = request.getParameter("shujia");
			//String num = request.getParameter("num");
			String fid = request.getParameter("fid");
			String sid = request.getParameter("sid");
			String note = request.getParameter("note");
			String savetime = Info.getDateStr();
			String dinjia = request.getParameter("dinjia");
			dao.commOper("update tushu set filename='"+filename+"',name='"+name+"',zouzhe='"+zouzhe+"',cbs='"+cbs+"'," +
					"shujia='"+shujia+"',fid='"+fid+"',sid='"+sid+"',note='"+note+"',savetime='"+savetime+"',dinjia='"+dinjia+"' where id="+id);
			session.setAttribute("suc", "操作成功!");
			gor("/tushupiaoliusys/admin/tushulist.jsp", request, response);
		}
		//&图书编号新增
		if (ac.equals("tsxxadd")) {
			String tsid = request.getParameter("tsid");
			String bianhao = request.getParameter("bianhao");
			String status = "待借";
			String delstatus = "0";
			dao.commOper("insert into tushuxx values(null,'"+tsid+"','"+bianhao+"','"+status+"','"+delstatus+"','')");
			session.setAttribute("suc", "操作成功!");
			gor("/tushupiaoliusys/admin/tushulist.jsp", request, response);
		}
		
		//图书信息删除
		if (ac.equals("tsxx")) {
			String id = request.getParameter("id");
			String tsid = request.getParameter("tsid");
			 dao.commOper("update tushuxx set delstatus=1 where id="+id);
			 session.setAttribute("suc", "操作成功!");
				gor("/tushupiaoliusys/admin/tsxxlist.jsp?tsid="+tsid, request, response);
		}
		
		//借阅新增
		if (ac.equals("jieyueadd")) {
			String tsxxid = request.getParameter("tsxxid");
			HashMap map = dao.select("select * from tushuxx where id="+tsxxid).get(0);
			String tsid = map.get("tsid").toString();
			String mid = member.get("id").toString();
			String jystatus = "借阅成功";
			String hsstatus = "待还书";
			String shstatus = "";
			String savetime = Info.getDateStr();
			String delstatus = "0";
			String yjhstime = request.getParameter("yjhstime");
			String hstime = "";
			String gsstatus = "";
			ArrayList jylist = (ArrayList)dao.select("select * from tushujy where tsid='"+tsid+"' and mid='"+mid+"' and hsstatus='待还书'");
			if (jylist.size()==0) {
			dao.commOper("insert into tushujy values(null,'"+tsxxid+"','"+tsid+"','"+mid+"','"+jystatus+"','"+hsstatus+"','"+shstatus+"','"+savetime+"','"+delstatus+"','"+yjhstime+"','"+hstime+"','"+gsstatus+"')");
			dao.commOper("update tushu set jy=jy+1 where id="+tsid);
			dao.commOper("update tushuxx set status='已借' where id="+tsxxid);
			request.setAttribute("suc", "借阅成功");
			go("/wodejieyuelist.jsp", request, response);
			}else {
				request.setAttribute("suc", "你已借阅该图书");
				go("/wodejieyuelist.jsp", request, response);
			}
		}
		
		//bijiadd笔记新增
		if (ac.equals("bijiadd")) {
			String tsid = request.getParameter("tsid");
			String mid = member.get("id").toString();
			String content = request.getParameter("content");
			String savetime = Info.getDateStr();
			dao.commOper("insert into biji values(null,'"+tsid+"','"+mid+"','"+content+"','"+savetime+"')");
			request.setAttribute("suc", "操作成功");
			go("/bijilist.jsp", request, response);
		}
		
		
	/*	//预定借阅
		if (ac.equals("ydjy")) {
			String tsxxid = request.getParameter("tsxxid");
			String id = request.getParameter("id");
			HashMap map = dao.select("select * from tushuxx where id="+tsxxid).get(0);
			String tsid = map.get("tsid").toString();
			String mid = member.get("id").toString();
			String jystatus = "借阅成功";
			String hsstatus = "待还书";
			String shstatus = "";
			String savetime = Info.getDateStr();
			String delstatus = "0";
			String yjhstime = request.getParameter("yjhstime");
			String hstime = "";
			String gsstatus = "";
			dao.commOper("insert into tushujy values(null,'"+tsxxid+"','"+tsid+"','"+mid+"','"+jystatus+"','"+hsstatus+"','"+shstatus+"','"+savetime+"','"+delstatus+"','"+yjhstime+"','"+hstime+"','"+gsstatus+"')");
			dao.commOper("update tushu set jy=jy+1 where id="+tsid);
			dao.commOper("update tushuxx set status='已借' where id="+tsxxid);
			dao.commOper("delete from yuyue where id="+id);
			request.setAttribute("suc", "借阅成功");
			go("/wodejieyuelist.jsp", request, response);
		}
		*/
		//续借新增
		if (ac.equals("xujieadd")) {
			String jyid = request.getParameter("id");
			HashMap map = dao.select("select * from tushujy where id="+jyid).get(0);
			String mid = member.get("id").toString();
			String xjtime = request.getParameter("xjtime");
			String savetime = Info.getDateStr();
			dao.commOper("insert into xujie values(null,'"+jyid+"','"+mid+"','"+xjtime+"','"+savetime+"')");
			dao.commOper("update tushujy set yjhstime='"+xjtime+"' where id="+jyid);
			request.setAttribute("suc", "操作成功");
			go("/wodejieyuelist.jsp", request, response);
		}
		
		
		
		//还书审核
		if (ac.equals("hstg")) {
			String id = request.getParameter("id");
			String tsxxid = request.getParameter("tsxxid");
			dao.commOper("update tushujy set shstatus='通过',hsstatus='已还',hstime='"+Info.getDateStr()+"' where id="+id);
			dao.commOper("update tushuxx set status='待借' where id="+tsxxid);
			session.setAttribute("suc", "操作成功!");
			gor("/tushupiaoliusys/admin/jieyuejilulist.jsp", request, response);
		}
		
		//&罚款新增
		if (ac.equals("fakuanadd")) {
			String jieyueid = request.getParameter("jieyueid");
			HashMap map = dao.select("select * from tushujy where id="+jieyueid).get(0);
			String tsxxid = map.get("tsxxid").toString();
			String mid = map.get("mid").toString();
			String fkje = request.getParameter("fkje");
			String fkzt = "待付款";
			String fkfs = "";
			String note = request.getParameter("note");
			String savetime = Info.getDateStr();
			dao.commOper("insert into fakuan values(null,'"+jieyueid+"','"+tsxxid+"','"+mid+"','"+fkje+"','"+fkzt+"','"+fkfs+"','"+note+"','"+savetime+"')");
			session.setAttribute("suc", "操作成功!");
			gor("/tushupiaoliusys/admin/tushujieyuelist.jsp", request, response);
			
		}
		//罚款缴纳
		if (ac.equals("fkfkadd")) {
			String id = request.getParameter("id");
			String fkfs = request.getParameter("fkfs");
			dao.commOper("update fakuan set fkfs='"+fkfs+"',fkzt='已付款' where id="+id);
			request.setAttribute("suc", "操作成功");
			go("/fakuanwdlist.jsp", request, response);
		}
		
		//&挂失新增
		if (ac.equals("guasi")) {
			String jieyueid = request.getParameter("jieyueid");
			HashMap map = dao.select("select * from tushujy where id="+jieyueid).get(0);
			String tsxxid = map.get("tsxxid").toString();
			String mid = member.get("id").toString();
			String fkzt = "待付款";
			String fkfs = "";
			String savetime = Info.getDateStr();
			dao.commOper("insert into guasi values(null,'"+jieyueid+"','"+tsxxid+"','"+mid+"','"+fkzt+"','"+fkfs+"','"+savetime+"')");
			dao.commOper("update tushujy set gsstatus='已挂失' where id="+jieyueid);
			dao.commOper("update tushuxx set gsstatus='丢失' where id="+tsxxid);
			request.setAttribute("suc", "操作成功");
			go("/guaswdlist.jsp", request, response);
			
		}
		//赔偿缴纳
		if (ac.equals("gsadd")) {
			String id = request.getParameter("id");
			String fkfs = request.getParameter("fkfs");
			dao.commOper("update guasi set fkfs='"+fkfs+"',fkzt='已付款' where id="+id);
			request.setAttribute("suc", "操作成功");
			go("/guaswdlist.jsp", request, response);
		}
		
		
		
		//评价新增
		if (ac.equals("pjadd")) {
			String tsid = request.getParameter("tsid");
			String mid = member.get("id").toString();
			String note = request.getParameter("note");
			String savetime = Info.getDateStr();
			dao.commOper("insert into pingjia values(null,'"+tsid+"','"+mid+"','"+note+"','"+savetime+"')");
			request.setAttribute("suc", "操作成功");
			go("/wodejieyuejilu.jsp?id="+tsid, request, response);
		}
		
		//预定新增
		if (ac.equals("tuyud")) {
			String mid = member.get("id").toString();
			String tsxxid = request.getParameter("tsxxid");
			String savetime = Info.getDateStr();
			ArrayList list = (ArrayList)dao.select("select * from yuyue where mid='"+mid+"'and tsxxid='"+tsxxid+"'");
			if (list.size()==0) {
				ArrayList jylist = (ArrayList)dao.select("select * from tushujy where mid='"+mid+"'and tsxxid='"+tsxxid+"' and hsstatus='待还书'");
				if (jylist.size()==0) {
					dao.commOper("insert into yuyue values(null,'"+mid+"','"+tsxxid+"','"+savetime+"')");
					request.setAttribute("suc", "操作成功");
					go("/wodeyudinglist.jsp", request, response);
				}else {
					request.setAttribute("suc", "你已借阅该图书");
					go("/wodejieyuelist.jsp", request, response);
				}
				
			}else {
				request.setAttribute("suc", "你已预定该图书");
				go("/wodeyudinglist.jsp", request, response);
			}
			
		}
		
		
		
	
		
		
		
		//前台用户登录
		if (ac.equals("memberLogin")) {
			String uname = request.getParameter("uname");
			String upass = request.getParameter("upass");
			ArrayList cklist = (ArrayList)dao.select("select * from member where uname='"+uname+"' and upass='"+upass+"' and delstatus='0'");
			if(cklist.size()>0){
				session.setAttribute("member", cklist.get(0));
				gor("/tushupiaoliusys/index.jsp", request, response);
			}else{
				request.setAttribute("suc", "用户名或密码错误!");
				go("/login.jsp", request, response);
			}
		}
		
		//用户退出
		if (ac.equals("memberExit")) {
		session.removeAttribute("member");
		go("/login.jsp", request, response);
		}
		
		//用户注册
		if (ac.equals("memberReg")) {
			String uname = request.getParameter("uname");
			String upass = request.getParameter("upass");
			String tname = request.getParameter("tname");
			String sex = request.getParameter("sex");
			String idcard = request.getParameter("idcard");
			String tel = request.getParameter("tel");
			String delstatus = "0";
			String savetime = Info.getDateStr();
			dao.commOper("insert into member values(null,'"+uname+"','"+upass+"','"+tname+"','"+sex+"','"+idcard+"','"+tel+"','"+delstatus+"','"+savetime+"')");
			request.setAttribute("suc", "操作成功");
			go("/login.jsp", request, response);
		}
		

		//个人信息编辑
		if (ac.equals("memberEdit")) {
			String id = request.getParameter("id");
			String tname = request.getParameter("tname");
			String sex = request.getParameter("sex");
			String tel = request.getParameter("tel");
			String idcard = request.getParameter("idcard");
			String savetime = Info.getDateStr();
			dao.commOper("update member set tname='"+tname+"',sex='"+sex+"',tel='"+tel+"',idcard='"+idcard+"',savetime='"+savetime+"'  where id="+id);
			request.setAttribute("suc", "操作成功");
			go("/memberinfo.jsp", request, response);
		}
		
		//密码修改
		if (ac.equals("pswddit")) {
			String id = request.getParameter("id");
			String newpwd1 = request.getParameter("newpwd1");
			dao.commOper("update member set upass='"+newpwd1+"' where id="+id);
			session.removeAttribute("member");
			request.setAttribute("info", "操作成功，请重新登录");
			go("/login.jsp", request, response);
		}
		
		

		//检查用户名唯一性AJAX
		if(ac.equals("usernamecheck")){
			String uname = request.getParameter("uname");
			ArrayList cklist = (ArrayList)dao.select("select * from member where uname='"+uname+"' and delstatus='0' ");
			if(cklist.size()>0){
				out.write("1");  
			}else{
				out.write("0");  
			}
		}
	
		//AJAX根据父类查子类
		if(ac.equals("searchsontype")){
			String xml_start = "<selects>";
	        String xml_end = "</selects>";
	        String xml = "";
	        String fprotype = request.getParameter("fprotype");
	        ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select("select * from protype where fatherid='"+fprotype+"' and delstatus='0' ");
			if(list.size()>0){
		        for(HashMap map:list){
					xml += "<select><value>"+map.get("id")+"</value><text>"+map.get("typename")+"</text><value>"+map.get("id")+"</value><text>"+map.get("typename")+"</text></select>";
				}
			}
			String last_xml = xml_start + xml + xml_end;
			response.setContentType("text/xml;charset=GB2312"); 
			response.setCharacterEncoding("utf-8");
			response.getWriter().write(last_xml);
			response.getWriter().flush();
			
		}
		
		
		
		
		//检查用户名唯一性AJAX 注册
		if(ac.equals("memberunamecheck")){
			String uname = request.getParameter("username");
			ArrayList cklist = (ArrayList)dao.select("select * from member where uname='"+uname+"' and delstatus='0' ");
			if(cklist.size()>0){
				out.print("false");
				
			}else{
				out.print("true");
			}
		}
		
		//登录
		if(ac.equals("frontlogin")){
			String uname = request.getParameter("uname");
			String upass = request.getParameter("upass");
			ArrayList cklist = (ArrayList)dao.select("select * from member where uname='"+uname+"' and upass='"+upass+"' and delstatus='0'");
			if(cklist.size()>0){
				session.setAttribute("member", cklist.get(0));
				go("/index.jsp", request, response);
			}else{
				request.setAttribute("info", "用户名或密码错误!");
				go("/login.jsp", request, response);
			}
			
		}
		
		//前台退出
		if(ac.equals("frontexit")){
			Cookie cookie = new Cookie("key", null);
			cookie.setMaxAge(0);
			session.removeAttribute("member");
			go("/index.jsp", request, response);
		}
		
		
		if(ac.equals("delfav")){
			String favid = request.getParameter("favid");
			dao.commOper("delete from fav where id='"+favid+"'");
			out.print("true");
		}
		
	
		
		
		if(ac.equals("pwdedit")){
			String oldpwd = request.getParameter("oldpwd");
			String newpwd = request.getParameter("newpwd");
			HashMap oldmap = dao.select("select * from sysuser where id="+admin.get("id")).get(0);
			if(oldpwd.equals(oldmap.get("userpwd"))){
				dao.commOper("update sysuser set userpwd = '"+newpwd+"' where id="+admin.get("id"));
				out.print("true");
			}else{
				out.print("false");
			}
		}
		
		if(ac.equals("aboutedit")){
			String lxr = request.getParameter("lxr");
			String tel = request.getParameter("tel");
			String addr = request.getParameter("addr");
			String note = request.getParameter("note");
			dao.commOper("update about set lxr='"+lxr+"',tel='"+tel+"',addr='"+addr+"',note='"+note+"' where id=1");
			request.setAttribute("suc", "操作成功!");
			gor("/tushupiaoliusys/admin/aboutedit.jsp", request, response);
		}
		
		
		//验证用户名是否正确
		if(ac.equals("checkname")){
			String uname = request.getParameter("uname");
			ArrayList cklist = (ArrayList)dao.select("select * from member where uname='"+uname+"' and delstatus='0' ");
			if(cklist.size()>0){
				out.print("true");
				
			}else{
				out.print("false");
			}
		}
		
		if(ac.equals("tj")){
			ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select("SELECT tsid, count(*) as num from tushujy where 1=1 and delstatus=0  group by tsid");
			String xdata = "[";
			String ydata = "[";
			int i =0;
			for(HashMap map:list){
				//i++;
				HashMap mm = dao.select("select * from tushu where id="+map.get("tsid")).get(0);
				//['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
				xdata += "'"+mm.get("name")+"'";
				ydata += map.get("num");
				if(i<list.size()-1){
					xdata+=",";
					ydata+=",";
				}
			}
			xdata += "]";
			ydata += "]";
			String rtn = xdata+"$"+ydata;
			Gson gson = new Gson();
			rtn = gson.toJson(rtn);
			//System.out.println(rtn);
			out.write(rtn);
		}
		
		
	dao.close();
	out.flush();
	out.close();
}

	public static void main(String[] args) {
		System.out.println(new CommDAO().select("select * from mixinfo"));
	}
	

}
