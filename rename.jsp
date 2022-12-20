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
    <title>Rename - Streaming Media Web Server</title>
</head>
<body>

    <!-- 解析请求参数 -->
    <%
    String renamed = request.getParameter("renamed"); //是否删除

    String mediaRoot = (String)application.getAttribute("mediaRoot"); //文件根目录
    String dir = request.getParameter("dir"); //文件所在目录（仅仅一级）
    String name = request.getParameter("name"); //文件名

    pageContext.setAttribute("renamed", renamed);
    pageContext.setAttribute("dir", dir);
    pageContext.setAttribute("name", name);
    %>

    <!-- 确认重命名 -->
    <c:if test="${!empty renamed && renamed == 'yes' }">
        <%
        String oldDir = request.getParameter("oldDir");
        String newDir = request.getParameter("newDir");

        String oldName = request.getParameter("oldName");
        String newName = request.getParameter("newName");
        
        String oldname = mediaRoot + oldDir +"/"+ oldName;
        String newname = mediaRoot + newDir +"/"+ newName;
        
        if(!oldname.equals(newname)) {
            File oldFile = new File(oldname);
            File newFile = new File(newname);

            if(oldFile.exists()) {
                oldFile.renameTo(newFile);
                response.sendRedirect("index.jsp?mode=list");
            } else {
                out.println("路径不存在: " + oldname);
                out.println("<h1><a href='index.jsp?mode=list'>返回</a></h1>");
            }
        }
        %>
    </c:if>
    
    <c:if test="${empty renamed && renamed != 'yes' }">
        <%=mediaRoot %>
        <h3><b>${dir}/${name}</b></h3>

        <h2 style="color: blue;"><b>是否重命名?</b></h2>

        <form action="rename.jsp" method="get">
            <label hidden>确认标识<input type="text" name="renamed" value="yes"> </label>
            <label hidden>旧文件夹名<input type="text" name="oldDir" value="${dir}"> </label>
            <label hidden>旧文件名<input type="text" name="oldName" value="${name}"> </label>

            <p style="color: green;">旧文件夹名：<input type="text" value="${dir}" size="40"/></p>
            <p style="color: red;">新文件夹名：<input type="text" name="newDir" value="${dir}" size="40" /></p>

            <p style="color: green;">旧文件名：<input type="text" value="${name}" size="40"/></p>
            <p style="color: red;">新文件名：<input type="text" name="newName" value="${name}" size="40" /></p>

            <button type="submit" style="height: 45px;width:70px; background-color: yellow;">提交</button>
        </form>

        <h1><a href="index.jsp">返回</a></h1>
    </c:if>
    
</body>

</html>