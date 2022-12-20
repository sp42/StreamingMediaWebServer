<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.util.Properties" %>

<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.stream.Collectors" %>


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
  <title>Home - Streaming Media Web Server</title>
</head>
<body>

  <%
    String projectPath = request.getSession().getServletContext().getRealPath("");
    String path = projectPath + "/WEB-INF/config.properties";

    //从配置文件中读取媒体文件的所在目录
    FileInputStream is = new FileInputStream(path);
    Properties pro = new Properties();
    pro.load(is);
    String mediaPath = pro.getProperty("media-path");

    File mediaPathFile = new File(mediaPath);
    if(!mediaPathFile.exists()) {
      out.println("<h1 style='background-color: red'> Warning: The Media Path is not Exists! </h1>");
      return;
    }

    //收集所有视频文件：K-文件夹名，V-该文件夹下的所有文件
    HashMap<String, List<String>> mp4FilesMap = new HashMap<>();
    collectFile(mediaPath, mediaPathFile, mp4FilesMap);
    if(mp4FilesMap ==null || mp4FilesMap.size()<1) {
      out.println("<h1 style='background-color: red'>Warning: The Media Path is not Exists Files! </h1>");
      return;
    }

    int mp4FileCount = 0;
    for (List<String> ff : mp4FilesMap.values()) {
        mp4FileCount += ff.size();
    }
 
    //根目录
    application.setAttribute("mediaRoot", mediaPath);
    //视频总数
    application.setAttribute("mp4FileCount", mp4FileCount);
    //将视频文件放入域对象
    application.setAttribute("mp4FilesMap", mp4FilesMap);
  %>

  <%!
    //递归收集路径（mediaPath）下的所有文件存于fileMap中
    public void collectFile(String mediaPath, File file, Map<String, List<String>> fileMap) {
        if(!file.exists()) {
            return;
        }

        //收集文件
        File[] files = file.listFiles(File::isFile);
        if(files != null && files.length > 0) {
            String name = file.getAbsolutePath().replace(File.separator, "/");
            List<String> collect = Arrays.stream(files).map(ff -> ff.getName()).collect(Collectors.toList());
            fileMap.put(name.replace(mediaPath, ""), collect);
        }

        //收集文件夹
        File[] dirs = file.listFiles(File::isDirectory);
        if(dirs == null || dirs.length < 1) {
            return;
        }
        //递归收集文件夹下的子文件、文件夹
        for (File dir : dirs) {
            collectFile(mediaPath, dir, fileMap);
        }
    }
  %>

  <%
    //入参检查
    String mode = request.getParameter("mode"); //文件预览模式

    pageContext.setAttribute("mode", mode);
  %>

  <div>
    Total：${mp4FileCount} 
    &emsp;&emsp; <a href="index.jsp?mode=list"> 列表模式 </a>
    &emsp;&emsp; <a href="index.jsp?mode=view"> 宫格模式 </a>
  </div>

  <%-- Map的遍历 --%>
  <c:forEach items="${mp4FilesMap}" var="entry">
    <h3>${entry.key}</h3>
    <%-- List的遍历 --%>
    <c:forEach items="${entry.value}" var="name" varStatus="varSta">
      <c:choose>
        <c:when test="${!empty mode && mode == 'list' }"> <%-- else if 的意思 --%>
          <p>No.${varSta.count}
            <a href="delete.jsp?dir=${entry.key}&name=${name}"><b>删除</b></a>
            <a href="rename.jsp?dir=${entry.key}&name=${name}"><b>重命名</b></a>
            <a target="_blank" href="/media/${entry.key}/${name}">${name}</a>
          </p>
        </c:when>
    
        <c:otherwise> <%-- else的意思 --%>
          <!-- 视频的高度、宽度是按照1920*1080同比例缩小 -->
          <video src="/media/${entry.key}/${name}" width="384px" height="216px" controls preload="auto"></video>
        </c:otherwise>
      </c:choose>

    </c:forEach>
  </c:forEach>

</body>
</html>