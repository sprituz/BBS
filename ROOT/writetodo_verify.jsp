<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="todo.Todo" %>
<%@ page import="todo.TodoDAO" %>
<%@page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="todo" class="todo.Todo" scope="page" />
<jsp:setProperty name="todo" property="title"/>
<jsp:setProperty name="todo" property="description"/>
<jsp:setProperty name="todo" property="isDone"/>
<jsp:setProperty name="todo" property="targetDate"/>
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
	if(todo.getTitle()==null || todo.getDescription()==null|| todo.getIsDone()==null
            || todo.getTargetDate()==null){
         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('모든 항목에 입력해 주세요')");
         script.println("history.back()");
         script.println("</script>");
	}
	else{
					TodoDAO todoDAO = new TodoDAO();
					int result = todoDAO.insertTodo(todo.getTitle(), todo.getDescription(), todo.getIsDone(),todo.getTargetDate(),id);
					if(result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 수정에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					} else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'todo.jsp'");
						script.println("</script>");
     
	}
	}
   %>
</body>
</html>