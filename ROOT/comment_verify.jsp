<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="reply.Reply" %>
<%@ page import="reply.ReplyDAO" %>
<%@page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="reply" class="reply.Reply" scope="page" />
<jsp:setProperty name="reply" property="replyText"/>
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
  	}
  	int ReplyID=0;
  	if (request.getParameter("ReplyID") != null) {
  		ReplyID = Integer.parseInt(request.getParameter("ReplyID"));
  	}
  	int PostID=0;
  	if (request.getParameter("PostID") != null) {
  		PostID = Integer.parseInt(request.getParameter("PostID"));
  	}
  		if(PostID == 0) {
  			PrintWriter script = response.getWriter();
  			script.println("<script>");
  			script.println("alert('유효하지 않은 글입니다.')");
  			script.println("location.href = 'bbs.jsp'");
  			script.println("</script>");
  	}
	if(reply.getReplyText()==null){
         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('댓글을 입력해 주세요')");
         script.println("history.back()");
         script.println("</script>");
	}
	else{
					ReplyDAO replyDAO = new ReplyDAO();
					int result = replyDAO.insertReply(reply.getReplyText(),id ,PostID);
					
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'view.jsp?PostID="+PostID+"'");
						script.println("</script>");
     
	
	}
   %>
</body>
</html>