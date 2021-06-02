<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.sql.*"  %>
<%@ page import="java.util.*" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="reply.Reply" %>
<%@ page import="reply.ReplyDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>동국대 컴퓨터공학과 게시판</title>
</head>
<body>
	<%
		String id = null;
		if(session.getAttribute("id") != null){
			id = (String)session.getAttribute("id");
		}
		int PostID = 0;
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
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">동국대 컴퓨터공학과 게시판</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="bbs.jsp">게시판</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
				<li><a href="todo.jsp">할 일</a></li>
			</ul>
			<%
				if(id == null){	
			%>
			<ul class="nav navbar-nav navbar-right">
						<li><a href="login.jsp">로그인</a></li>
					</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
						<li><a href="logout_verify.jsp">로그아웃</a></li>
					</ul>
			<%
				}
			%>
		</div>
	</nav>
		<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= bbs.getTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= bbs.getID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= bbs.getPostDate().substring(0, 11) + bbs.getPostDate().substring(11, 13) + "시 " + bbs.getPostDate().substring(14, 16) + "분"%></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="height: 200px; text-align: left;"><%= bbs.getContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if(id != null && id.equals(bbs.getID())) {
			%>
				<a href="update.jsp?PostID=<%= PostID %>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="delete_verify.jsp?PostID=<%= PostID %>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
			     <form action="comment_verify.jsp?PostID=<%= PostID %>&ID=<%= id%>" method="post">
                    <div id="comment_box">
                        <br><textarea name="replyText" class="form-control" placeholder="댓글을 입력해주세요" style="height:100px; margin-bottom:5px" maxlength="300"  ></textarea>
                        <%
                            //로그인 세션이 있을때만 덧글 작성 가능.
                            if(id != null){
                            	   %>   
                                	<input type="submit" class="btn btn-primary pull-right" value="작성" >
                                	  <%                       
                            }
                            else{
                            	  %>   
                              	<input type="submit" class="btn btn-primary pull-right" value="작성"  disabled="disabled" style="width:50px;float:right">
                              	  <%     
                            }
                        %>   
                        <div class="container">
		<div class="row">
			<table class="table" style="text-align: center; border: 1px solid #dddddd">
				<thead>
				</thead>
				<tbody>
						<%
						
						ReplyDAO replyDAO = new ReplyDAO();
						ArrayList<Reply> list = replyDAO.getList(PostID);
						if(list != null){
						for(int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%= list.get(i).getID()%></a></td>
						<td><%=list.get(i).getReplyText() %></td>
						<td><%=list.get(i).getReplyDate().substring(0,11) %></td>
						<td><a href="delete_comment.jsp?PostID=<%= PostID %>&ReplyID=<%=list.get(i).getReplyID()%>">삭제</td>
					</tr>
					<%
						}
						}
					%>
				</tbody>
			</table>
		</div>
	</div>

                    </div>
                </form> 
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>