<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap -->

<title>员工列表页面</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<!-- 搭建页面 -->
	<div class="container">
		<!--标题  -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>

		<!--按钮  -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button type="button" class="btn btn-primary">新增</button>
				<button type="button" class="btn btn-danger">删除</button>
			</div>
		</div>

		<!--表格  -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover table-bordered table-striped">
					<tr>
						<th>员工号</th>
						<th>姓名</th>
						<th>性别</th>
						<th>邮箱</th>
						<th>部门编号</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<td>${emp.empId}</td>
							<td>${emp.empName}</td>
							<td>${emp.gender=="M"?"男":"女"}</td>
							<td>${emp.email}</td>
							<td>${emp.department.deptName}</td>
							<td>
								<button type="button" class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
								<button type="button" class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</td>
						</tr>
					</c:forEach>

				</table>
			</div>
		</div>

		<!--分页系信息  -->
		<div class="row">
			<!-- 分页信息 -->
			<div class="col-md-6">当前是第${pageInfo.pageNum}页,总共有${pageInfo.pages}页，总共有${pageInfo.total}条记录</div>

			<!-- 分页条 -->
			<div class="col-md-6 col-md-offset-7">
				<nav aria-label="Page navigation">
				<ul class="pagination pagination-lg">
					<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
					<c:if test="${pageInfo.hasPreviousPage }">
						<li><a href="${APP_PATH}/emps?pn=${pagnInfo.pageNum-1}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>

					<c:forEach items="${pageInfo.navigatepageNums }" var="page_num">
						<c:if test="${page_num==pageInfo.pageNum}">
							<li class="active"><a href="#">${page_num}</a></li>
						</c:if>
						<c:if test="${page_num!=pageInfo.pageNum}">
							<li><a href="${APP_PATH}/emps?pn=${page_num}">${page_num}</a></li>
						</c:if>
					</c:forEach>
					<c:if test="${pageInfo.hasNextPage }">
						<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next"> <span
							aria-hidden="true">&raquo;</span>
					</a></li>
					</c:if>
					
					<li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
				</ul>
				</nav>
			</div>
		</div>
	</div>

	<!-- web 路径问题：
不以/开头的路径 是以当前资源路径为基准，经常容易出错
以/开头的路径，找资源是以服务器路径为准（http://localhost:3306）需要加上项目名才能找到
 -->
	<!-- jquery -->
	<script src="${APP_PATH}/static/js/jquery-3.3.1.js"></script>
	<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
	<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</body>
</html>