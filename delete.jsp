<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.io.File" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="rebot" content="all">
  <meta name="author" content="Hackyle; Kyle Shawe">
  <meta name="reply-to" content="kyleshawe@outlook.com;1617358182@qq.com">
  <meta name="generator" content="Sublime Text 3; VSCode">
  <meta name="copyright" content="Copy Right: 2022 HACKYLE. All rights reserved">
  <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<title>Delete - Streaming Media Web Server</title>
	<style type="text/css">
    .container {
      width: 100px;
      margin: 0 auto;
    }
  </style>
</head>
<body>

	<!-- 解析请求参数 -->
	<%
			String deleted = request.getParameter("deleted"); //是否删除

	  	String mediaRoot = (String)application.getAttribute("mediaRoot"); //文件根目录
	  	String dir = request.getParameter("dir"); //文件所在目录（仅仅一级）
	  	String name = request.getParameter("name"); //文件名

	  	pageContext.setAttribute("deleted", deleted);
	  	pageContext.setAttribute("dir", dir);
	  	pageContext.setAttribute("name", name);
	%>

	<!-- 删除确认 -->
  <c:if test="${!empty deleted && deleted == 'yes' }">
	  <%
	  	String rootname = mediaRoot+"/"+dir+"/"+name;
	  	// out.println(rootname);
	  	File file = new File(rootname);
	  	boolean del = file.delete();
	  	// out.println(del);
	  	response.sendRedirect("index.jsp?mode=list");
		%>
	</c:if>

  <c:if test="${empty deleted && deleted != 'yes' }">
  	<%=mediaRoot %>
  	<h3><b>${dir}/${name}</b></h3>

		<h2 style="color: red;"><b>是否删除?</b></h2>
  	<div class="container">
    	<h1><a href="delete.jsp?dir=${dir}&name=${name}&deleted=yes">确定</a></h1>
    	<h1><a href="index.jsp?mode=list">返回</a></h1>
  	</div>
	</c:if>
	
</body>
</html>