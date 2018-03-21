<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<div id="wrapper">
		<jsp:include page="/WEB-INF/view/template/menu.jsp" />
		<table>
			<tr>
				<th>ID</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<!-- items에는 컨트롤러가 준 것 쓰기 -->
			<c:forEach items="${communityList}" var="community">
					<tr>
						<td>${community.id}</td>
						<td>
							<a href="<c:url value="/read/${community.id}" />">
								${community.title}
							</a>
							<c:if test="${not empty community.displayFilename}">
								<img src="<c:url value="/static/img/file.png" />"
									 alt="${community.displayFilename}" 
									 style="width: 20px;" />
							</c:if>
						</td>
						<td>
						<!-- NICKNAME(EMAIL) -->
							(${community.memberVO.nickname})(${community.memberVO.email})
						</td>
						<td>${community.writeDate}</td>
						<td>${community.viewCount}</td>
					</tr>
			</c:forEach>
			<!-- 비어있으면 empty, 안비어있으면 notempty -->
			<c:if test="${empty communityList }">
				<tr>
					<td colspan="5">등록된 게시글이 없습니다.</td>
				</tr>
			</c:if>
		</table>
		<div>
			<a href="<c:url value= "/write"/>">글쓰기</a>
		</div>
		<div>
			<a href="<c:url value="/delete/process1"/>">탈퇴하기</a>
		</div>
		
	</div>
</body>
</html>