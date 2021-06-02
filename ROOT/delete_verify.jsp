<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="bbs.Bbs"%>
<%@page import="bbs.BbsDAO"%>
<%@page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
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
		Bbs bbs = new BbsDAO().getBbs(PostID);
		if(!id.equals(bbs.getID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		} else {
					BbsDAO bbsDAO= new BbsDAO();
					int result = bbsDAO.delete(PostID);
					if(result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 삭제에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					} else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'bbs.jsp'");
						script.println("</script>");
         }
      }
   %>
</body>
</html>