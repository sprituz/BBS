<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="bbs.BbsDAO"%>
<%@page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="title"/>
<jsp:setProperty name="bbs" property="content"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>동국대 컴퓨터공학과 게시판</title>
</head>
<body>
   <%
   String id = null;
	if(session.getAttribute("id") != null) {
		id = (String) session.getAttribute("id");	
	}
	if(id == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	} else {
		if(bbs.getTitle() == null || bbs.getContent() == null){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('제목이나 내용을 입력해주세요')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					BbsDAO bbsDAO= new BbsDAO();
					int result = bbsDAO.write(bbs.getTitle(), id, bbs.getContent());
					if(result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					} else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'bbs.jsp'");
						script.println("</script>");
         }
      }
	}
   %>
</body>
</html>