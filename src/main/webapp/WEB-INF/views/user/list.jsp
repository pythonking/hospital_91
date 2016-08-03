<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="/static/font/awesome/css/font-awesome.min.css">
    <%--<link href="//cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.css" rel="stylesheet">--%>
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>

<jsp:include page="../include/topbar.jsp">
    <jsp:param name="menu" value="setting"/>
</jsp:include>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">

            <div class="box">
                <div class="box-header">
                    <span class="title"><i class="fa fa-sitemap"></i> 员工列表</span>
                    <a href="javascript:;" class="pull-right " style="color: white" id="newUser"><i
                            class="fa fa-plus"></i> 新增员工</a>
                </div>
                <div class="box-body">
                    <table class="table">
                        <thead>
                        <tr>
                            <th width="100">员工姓名</th>
                            <th width="100">账号</th>
                            <th width="200">联系电话</th>
                            <th width="80">角色</th>
                            <th width="70">状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>

                        <c:forEach items="${userList}" var="user">
                            <tr>
                                <td>${user.realname}</td>
                                <td>${user.username}</td>
                                <td>${user.telphone}</td>
                                <td>${user.role.rolename}</td>
                                <td>

                                    <c:choose>
                                        <c:when test="${user.enable==true}">
                                            <span>可用</span>
                                        </c:when>
                                        <c:when test="${user.enable==false}">
                                            <span class="text-warning">禁用</span>
                                        </c:when>
                                    </c:choose>

                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.role.rolename != '管理员' && user.enable==true }">
                                            <a href="/admin/user/${user.id}">修改</a>
                                            <a href="javascript:;" rel="${user.id}"
                                               style="margin-right: 5px;margin-left: 10px"
                                               class="btn btn-danger forbidLink">禁用</a>
                                            <a href="javascript:;" rel="${user.id}"
                                               class="btn btn-danger resetPwdLink">重置密码</a>
                                        </c:when>
                                        <c:when test="${user.role.rolename != '管理员' && user.enable==false }">
                                            <a href="/admin/user/${user.id}">修改</a>
                                            <a href="javascript:;" rel="${user.id}"
                                               style="margin-right: 5px;margin-left: 10px"
                                               class="btn btn-primary forbidLink">启用</a>
                                            <a href="javascript:;" rel="${user.id}"
                                               class="btn btn-danger resetPwdLink">重置密码</a>
                                        </c:when>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>


        </div>

    </div>
</div>

<div class="modal fade" id="newUserModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增员工</h4>
            </div>
            <div class="modal-body">
                <form id="saveUserForm" method="post">
                    <div class="form-group">
                        <label>员工姓名</label>
                        <div>
                            <input type="text" autofocus name="realname" id="save_realname" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>账户(用于登录系统)</label>
                        <div>
                            <input type="text" name="username" id="save_username" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>密码(默认密码000000)</label>
                        <input type="password" name="password" id="save_password" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>科室</label>
                        <select name="dept.id" class="form-control">
                            <c:forEach items="${deptList}" var="dept">
                                <option value="${dept.id}">${dept.deptname}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>联系电话</label>
                        <div>
                            <input type="text" id="save_telphone" name="telphone" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>请选择角色</label>
                        <select name="role.id" class="form-control">
                            <option value="3">员工</option>
                            <option value="2">主任</option>
                            <option value="1">管理员</option>
                        </select>
                    </div>


                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="/static/js/jQuery-2.2.0.min.js"></script>
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script>
    $(function () {
        $("#newUser").click(function () {
            $("#saveUserForm")[0].reset();
            $("#newUserModal").modal({
                show: true,
                backdrop: "static",
                keyboard: false
            })
        });
        $("#saveBtn").click(function () {
            $("#saveUserForm").submit();
            $("#newUserModal").modal("hide");
        });
        $(document).delegate(".forbidLink", "click", function () {
            var id = $(this).attr("rel");
            $.get("/admin/forbid/"+id).done(function(data){
                if(confirm("是否重新设置用户状态")){
                    if(data=="disable"){
                        alert("禁用用户成功");
                    }else if(data=="enable"){
                        alert("启用用户成功");
                    }
                    location.reload();
                }
            }).fail(function(){
                alert("操作失败,请稍候再试");
            })
        });

        $(document).delegate(".resetPwdLink", "click", function () {
            var id = $(this).attr("rel");
            $.get("/admin/resetpwd/"+id).done(function(data){
                if(confirm("是否重置密码")){
                    if(data=="success"){
                        alert("重置密码成功");
                    }
                }
            }).fail(function(){
                alert("重置密码失败");
            })
        });
    })
</script>
</body>
</html>