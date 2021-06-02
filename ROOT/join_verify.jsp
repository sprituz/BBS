<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserDAO"%>
<%@page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="id"/>
<jsp:setProperty name="user" property="password"/>
<jsp:setProperty name="user" property="name"/>
<jsp:setProperty name="user" property="gender"/>
<jsp:setProperty name="user" property="email"/>
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
	if(id != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 되어있습니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
      if(user.getId()==null || user.getPassword()==null|| user.getName()==null
            || user.getGender()==null|| user.getEmail()==null){
         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('모든 항목에 입력해 주세요')");
         script.println("history.back()");
         script.println("</script>");
      }else{
         UserDAO userDAO = new UserDAO();
         int result = userDAO.join(user); 
         if(result == -1){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 존재하는 아이디입니다.')");
            script.println("history.back()");
            script.println("</script>");
         }
         else {
        	 session.setAttribute("id", user.getId());
 			PrintWriter script = response.getWriter();
 			script.println("<script>");
 			script.println("location.href = 'main.jsp'");
 			script.println("</script>");
         }
      }
   %>
</body>
</html>