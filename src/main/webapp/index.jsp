<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- web 路径问题：
不以/开头的路径 是以当前资源路径为基准，经常容易出错
以/开头的路径，找资源是以服务器路径为准（http://localhost:3306）需要加上项目名才能找到
 -->
<!-- jquery -->
<script src="${APP_PATH}/static/js/jquery-3.3.1.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>
	<!-- 员工修改模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工编辑</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_edit_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static">empName</p>
								<!-- <input type="text" class="form-control" name="empName" id="empName_update_input">
								<span class="help-block"></span> -->
							</div>
						</div>
						<div class="form-group">
							<label for="email_edit_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="email" id="email_update_input">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="deptName_add_input" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-5">
								<!-- 部门提交 只提交did即可 -->
								<select class="form-control" name="dId">
									<!-- <option>1</option>
									<option>2</option>
									<option>3</option>
									<option>4</option>
									<option>5</option> -->
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">
						关 闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">
						 更 新  </button>
				</div>
			</div>
		</div>
	</div>
	<!-- 员工添加 -->
	<!-- =============================================================================== -->
	<!-- 模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="empName" id="empName_add_input">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="email" id="email_add_input" placeholder="liweihai@htm.com">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="deptName_add_input" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-5">
								<!-- 部门提交 只提交did即可 -->
								<select class="form-control" name="dId" id="dept_add_select">
									<!-- <option>1</option>
									<option>2</option>
									<option>3</option>
									<option>4</option>
									<option>5</option> -->
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">
						关 闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">
						保 存</button>
				</div>
			</div>
		</div>
	</div>
	<!--================================================================================  -->


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
				<button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button type="button" class="btn btn-danger" id="emp_delet_all_btn">删除</button>
			</div>
		</div>

		<!--表格  -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover table-bordered table-striped"
					id="emps_table">
					<thead>
						<tr>
							<td>
								<input type="checkbox" id="check_all"/>
							</td>
							<th>员工号</th>
							<th>姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>部门编号</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<%-- <td>${emp.empId}</td>
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
							</td>--%>
						</tr>
					</tbody>

				</table>
			</div>
		</div>

		<!--分页系信息  -->
		<div class="row">
			<!-- 分页信息 -->
			<div class="col-md-6" id="page_info_area"></div>

			<!-- 分页条 -->
			<div class="col-md-6 col-md-offset-7" id="page_nav_area">
				<%-- <nav aria-label="Page navigation">
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
						<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>

					<li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
				</ul>
				</nav> --%>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var totalRecord,currentPage;
	
		$(function() {
			to_page(1);
		});

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					build_emps_table(result);

					build_page_info(result);

					build_page_nav(result)
				}
			});
		};

		/* 员工信息显示 */
		function build_emps_table(result) {
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var checkBoxTd = $("<td></td>").append($("<input type='checkbox' class='check_item'/>"));
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(
						item.gender == 'M' ? '男' : '女');
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>")
						.append(item.department.deptName);
				/**
				<button type="button" class="btn btn-primary btn-sm">
					<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
					编辑
				</button>
					
				<button type="button" class="btn btn-danger btn-sm">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
					删除
				</button>
				
				 **/

			
		var editBtn = $("<button></button>").addClass(
						"btn btn-primary btn-sm edit_btn").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-pencil")).append("编辑");
		editBtn.attr("edit-id",item.empId);
				/* 动态给新创建的按钮绑定单击事件 */
				/* $("body").on("click",".edit_btn",function(){
					
					$("#empUpdateModal").modal({
						backdrop : "static"

					});
				}); */

				var deleteBtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm delete_btn").append(
						$("<span></span>")
								.addClass("glyphicon glyphicon-trash")).append(
						"删除");
				deleteBtn.attr("delete-id",item.empId);

				var operationTd = $("<td></td>").append(editBtn).append("  ")
						.append(deleteBtn);
				$("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(
						genderTd).append(emailTd).append(deptNameTd).append(
						operationTd).appendTo("#emps_table tbody");
			});
		}

		/* 分页信息*/
		function build_page_nav(result) {
			$("#page_nav_area").empty();
			//page_nav_area
			var pageInfo = result.extend.pageInfo;
			var ul = $("<ul></ul>").addClass("pagination");

			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").attr("href", "#").append("&laquo;"));
			if (pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				//为元素添加翻页单击事件
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(pageInfo.pageNum - 1)
				});
			}

			ul.append(firstPageLi).append(prePageLi);

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").attr("href", "#").append("&raquo;"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			if (pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					to_page(pageInfo.pageNum + 1)
				});

				lastPageLi.click(function() {
					to_page(pageInfo.pages)
				});
			}

			var page_nums = pageInfo.navigatepageNums;
			$.each(page_nums, function(index, item) {
				var numli = $("<li></li>").append(
						$("<a></a>").attr("href", "#").append(item));
				if (pageInfo.pageNum == item) {
					numli.addClass("active");
				}
				numli.click(function() {
					to_page(item);
				});

				ul.append(numli);
			});

			ul.append(nextPageLi).append(lastPageLi);

			var nav = $("<nav></nav>").append(ul);

			nav.appendTo("#page_nav_area");

		}

		/*分页条*/
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前是第" + result.extend.pageInfo.pageNum + "页,总共有"
							+ result.extend.pageInfo.pages + "页，总共有"
							+ result.extend.pageInfo.total + "条记录")
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		};

		/* 表单完整重置  包括数据和样式 */
		function reset_form(ele) {
			$(ele)[0].reset();//表单数据重置
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");

		}

		/* 点击新增按钮弹出新增对话框 */
		$("#emp_add_modal_btn").click(function() {
			/* 
			重置表单，解决相同数据在页面跳转不发生校验的问题
			$("#empName_add_input").val("");
			$("#email_add_input").val("");*/

			getDepts("#empAddModal select");

			/* 弹出模态框方法 */
			$("#empAddModal").modal({
				backdrop : "static"

			});
		});

		/*查处所有的部门信息 ，并显示在下拉选中 */
		function getDepts(ele) {
			$(ele).empty();//清空之前的内容
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "GET",
				success : function(result) {
					//$("#dept_add_select")
					var deptDids = result.extend.depts;
					$.each(deptDids, function() {
						var optionEle = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						//optionEle.appendTo("#dept_add_select");
						optionEle.appendTo(ele);

					});
				}

			});

		};

		/*  校验数据 员工姓名和邮箱  可以使用正则表达式校验*/
		function validate_add_form() {

			var empName = $("#empName_add_input").val();

			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,8})/;

			if (!regName.test(empName)) {
				//alert("用户名可以是2到8个中文汉字或6到16个英文字母和数字的组合组成");
				show_validate_msg("#empName_add_input", "error",
						"用户名可以是2到8个中文汉字或6到16个英文字母和数字的组合组成");
				return false;
			} else {
				show_validate_msg("#empName_add_input", "success", "用户名可用");
			}

			var email = $("#email_add_input").val();

			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			;
			if (!regEmail.test(email)) {
				//alert("邮箱地址格式有误，请核对");
				//$("#email_add_input").parent().addClass("has-error");
				//$("#email_add_input").next("span").text("邮箱地址格式有误，请核对");
				show_validate_msg("#email_add_input", "error", "邮箱地址格式有误，请核对");
				return false;
			} else {
				//$("#email_add_input").parent().addClass("has-success");
				//$("#email_add_input").next("span").text("");
				show_validate_msg("#email_add_input", "success", "邮箱格式正确");
			}

			return true;
		}

		//显示校验结果提示信息
		function show_validate_msg(element, status, msg) {
			//在添加类或属性前先保证元素是新的，无状态或无我们关注的属性
			$(element).parent().removeClass("has-success has-error");
			$(element).next("span").text("");

			if ("success" == status) {
				$(element).parent().addClass("has-success");
				$(element).next("span").text(msg);
			} else if ("error" == status) {
				$(element).parent().addClass("has-error");
				$(element).next("span").text(msg);
			}

		};

		/* 新增员工保存 */
	$("#emp_save_btn").click(
			function() {
				if (!validate_add_form()) {
					return false;
				};

				if ($(this).attr("ajax-va") == "error") {
					return false;
				};

				/*1. 将模态框中的数据发送服务器保存 
				//var tt = $("#empAddModal form").serialize();//表格数据序列化 */

				$.ajax({
					url : "${APP_PATH}/emp",
					type : "POST",
					data : $("#empAddModal form")
							.serialize(),
					success : function(result) {
						if (result.code == 100) {
							/*  员工保存成功 1.关闭模态框  2 来的员工信息的最后一页，显示刚添加的员工信息*/
							$('#empAddModal').modal('hide')
							to_page(totalRecord);
						} else {
							//如果后端校验不通过则不能关闭模态框，应该给出异常信息,校验出哪个字段有问题就显示那个字段异常信息
							//console.log(result);
							//console.log(result.extend.erroeField.email);
							//console.log(result.extend.erroeField.empName);//undefined
							if (undefined != result.extend.erroeField.empName) {
								show_validate_msg(
										"#empName_add_input",
										"error",
										result.extend.erroeField.empName);
							}
							//邮箱
							if (undefined != result.extend.erroeField.email) {
								show_validate_msg(
										"#email_add_input",
										"error",
										result.extend.erroeField.email);
							}
						}

					}

				});

			});

		//员工姓名重复校验 当用户输入用户名后，去数据库查是否有同名的用户，若存在，则提示用户已经存在
		$("#empName_add_input").change(
			function() {
				var empName = this.value;
				$.ajax({
					url : "${APP_PATH}/checkemp",
					data : "empName=" + empName,
					type : "POST",
					success : function(result) {
						//alert(result);
						if (result.code == 100) {
							show_validate_msg("#empName_add_input",
									"success", "用户名可用");
							$("#emp_save_btn").attr("ajax-va", "success");
						} else {
							show_validate_msg("#empName_add_input",
									"error", result.extend.vaMsg);
							$("#emp_save_btn").attr("ajax-va", "error");
						}
					}
				});

			});

		$(document).on("click", ".edit_btn", function() {
			/* 1. 查询出员工信息 包括部门信息  */
			//查询员工信息显示在模态框中
			getEmp($(this).attr("edit-id"));

			//查询部门信息显示在模态框中
			getDepts("#empUpdateModal select");

			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#empUpdateModal").modal({
				backdrop : "static"

			});
		});

		function getEmp(id) {
			$.ajax({
				url : "${APP_PATH}/emp/" + id,
				type : "GET",
				success : function(result) {
					//取到员工数据 显示员工数据
					var empData=result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			});
		};

		/* 点击更新 更新员工信息 */
		$("#emp_update_btn").click(function(){
			//需要验证用户输入的邮箱是否合法
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				show_validate_msg("#email_update_input", "error", "邮箱地址格式有误，请核对");
				return false;
			} else {
				show_validate_msg("#email_update_input", "success", "邮箱格式正确");
			}
			
			//获取模态框表单数据 更新数据库数据 
			updateEmp($(this).attr("edit-id"));
			
			//显示被更新的数据
		});

		/*根据员工Id更新员工  */
		function updateEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,

				/*第一种请求方式，  */
/* 				type:"POST",
				data:$("#empUpdateModal form").serialize()+"&_method=PUT",//如果不配置HttpPutFormContentFilter，则必须这样请求，因为tomcat服务器不支持put请求的解析
 */
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//关闭模态框
					$("#empUpdateModal").modal('hide');
					//回到被修改数据的那一页
					to_page(currentPage);
				}
			});
		};

		/* 单个删除 */
		$(document).on("click",".delete_btn",function(){
			/*点击删除按钮后 弹出对话框 确认是否删除当前选定的员工 根据id删除后端数据  */
			var empName=$(this).parents("tr").find("td:eq(2)").text();
			//alert(empName);
			if(confirm("确认删除【"+empName+"】吗？")){
				$.ajax({
					url:"${APP_PATH}/emp/"+$(this).attr("delete-id"),
					type:"DELETE",
					success:function(result){
						if(result.code == 100){
							to_page(currentPage);
						}
					}
				});
			};
			
			
		});

		/* 全选 全不选按钮功能实现  */
		$("#check_all").click(function(){
			//attr 获取dom元素的自定属性的值
			//prop 获取dom元素原生属性的值（读取或修改）
			//$(this).prop("checked");
			$(".check_item").prop("checked",$(this).prop("checked"));//点击全选  下面的每一行都被选中

		});

		/* 为每一check-item绑定事件  */
		$(document).on("click",".check_item",function(){
			var flag = $(".check_item:checked").length == $(".check_item").length;
			if(flag){
				$("#check_all").prop("checked",true);
			}else{
				$("#check_all").prop("checked",false);	
			}
		});

		/* 批量删除 */
		$("#emp_delet_all_btn").click(function(){
			//$(".check_item:checked");
			var emp_names="";
			var del_idstr="";
			$.each($(".check_item:checked"),function(){
				emp_names += $(this).parents("tr").find("td:eq(2)").text()+",";
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			//去除末尾多余的逗号
			emp_names = emp_names.substring(0, emp_names.length-1);
			del_idstr = del_idstr.substring(0, emp_names.length-1);
			//确认是否删除
			if(confirm("确认要删除【"+emp_names+"】吗？")){
				//发送ajax请求批量删除员工信息
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						if(result.code==100){
							alert(result.msg);
							to_page(currentPage);
						}
					}
				});
			}
		});
		
	</script>

</body>
</html>