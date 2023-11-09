<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="robots" content="all">
  <meta name="author" content="Hackyle; Kyle Shawe">
  <meta name="reply-to" content="kyleshawe@outlook.com;1617358182@qq.com">
  <meta name="generator" content="Sublime Text 3; VSCode">
  <meta name="copyright" content="Copy Right: 2022 HACKYLE. All rights reserved">
  <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <title>Shutdown - Streaming Media Web Server</title>
</head>
<body>
<%
  // String control = request.getParameter("control"); //control=yes关机，control=cancel取消关机
  // pageContext.setAttribute("control", control);
%>

<%
  String osName = System.getProperty("os.name").toLowerCase();
  if(osName.contains("win")) {
    // Runtime.getRuntime().exec("cmd.exe /c ipconfig /all > C:\\\\users\\\\kyle\\\\desktop\\\\ip-out.txt");
    Runtime.getRuntime().exec("shutdown -s -t 1");
  } else if(osName.contains("linux")) {
    //TODO 暂不支持
  } else if(osName.contains("mac")) {
    //TODO 暂不支持
  } else {
    //TODO 暂不支持
  }

%>

<div style="text-align: center;">
  <h2>请等待2s后返回主页，主页打不开则说明关机成功!</h2>
  <h3>再稍等几秒后可关闭电源！</h3>
  
  <br/><br/>
  <h1><a href="index.jsp">返回</a></h1>
</div>

</body>
