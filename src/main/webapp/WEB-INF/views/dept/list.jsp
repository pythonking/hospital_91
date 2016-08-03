<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.css">
    <%--<link rel="stylesheet" href="http://cdn.staticfile.org/font-awesome/4.1.0/css/font-awesome.min.css">--%>
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
                    <span class="title"><i class="fa fa-sitemap"></i> 科室列表</span>
                    <%--<ul class="unstyled inline pull-right">--%>
                    <a href="javascript:;" class="pull-right " style="color: white" id="newDept"><i
                            class="fa fa-plus"></i> 新建科室</a>
                    <%--</ul>--%>
                </div>
                <div class="box-body">
                    <table class="table">
                        <thead>
                        <tr>
                            <th width="200">科室名称</th>
                            <th width="200">负责人</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>

                        <c:forEach items="${deptList}" var="dept">
                            <tr>
                                <td>${dept.deptname}</td>
                                <td>${dept.chargeMan}</td>
                                <td><a href="javascript:;" rel="${dept.id}" class="btn btn-primary editLink"
                                       style="margin-right: 10px">修改</a><a href="javascript:;" rel="${dept.id}"
                                                                           class="btn btn-danger delLink">删除</a></td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>


        </div>

    </div>
</div>
<div class="modal fade" id="newDeptModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增科室</h4>
            </div>
            <div class="modal-body">
                <form id="saveForm" method="post">
                    <div class="form-group">
                        <label>科室名称</label>
                        <div>
                            <input type="text" autofocus name="deptname" id="save_name" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>负责人</label>
                        <input type="text" name="chargeMan" id="save_chargeman" class="form-control">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
<div class="modal fade" id="editDeptModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">编辑科室</h4>
            </div>
            <div class="modal-body">
                <form id="editForm" method="post">
                    <input type="hidden" id="edit_id" name="id">
                    <div class="form-group">
                        <label>科室名称</label>
                        <div>
                            <input type="text" name="deptname" autofocus id="edit_name" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>负责人</label>
                        <input type="text" name="chargeMan" id="edit_chargeman" class="form-control">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" id="editBtn">保存</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
<script src="/static/js/jQuery-2.2.0.min.js"></script>
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script>
    $(function () {
        $("#newDept").click(function () {
            $("#saveForm")[0].reset();
            $("#newDeptModal").modal({
                show: true,
                backdrop: "static",
                keyboard: false
            })
            $("#saveBtn").click(function () {
                var $save_name = $("#save_name");
                var $save_chargeMan = $("#save_chargeman");
                if (!$save_name.val()) {
                    $save_name.focus();
                }
                if (!$save_chargeMan.val()) {
                    $save_chargeMan.focus();
                }
//                $("#saveForm").submit();
                $.post("/dept/new", $("#saveForm").serialize()).done(function (data) {
                    if (data == "success") {
                        $("#newDeptModal").modal("hide");
                        alert("新增科室成功.");
                        location.reload();
                    }
                }).fail(function () {
                    alert("服务器异常,新增科室失败");
                })
            })
        })
        $("#saveBtn").click(function () {
            var deptname = $("#save_name").val();
            var chargeMan = $("#save_chargeman").val();
            if (!deptname) {
                $("#save_name").focus;
                return;
            }
            if (!chargeMan) {
                $("#save_chargeman").focus;
                return;
            }
        })
        $(document).delegate(".delLink", "click", function () {
            var id = $(this).attr("rel");
            if (confirm("是否确认删除?")) {
                $.get("/dept/" + id + "/del").done(function (data) {
                    if (data == "success") {
                        alert("删除科室成功.");
                        window.location.href = "/dept";
                    }
                }).fail(function () {
                    alert("服务器异常,删除科室失败");
                })
            }
        })
        $(document).delegate(".editLink", "click", function () {
            var id = $(this).attr("rel");
            $("#editDeptModal").modal({
                show: true,
                backdrop: "static",
                keyboard: false
            })
            $.get("/dept/" + id).done(function (data) {
                var $edit_name = $("#edit_name");
                var $edit_chargeMan = $("#edit_chargeman");

                $("#edit_id").val(data.id);
                $edit_name.val(data.deptname);
                $edit_chargeMan.val(data.chargeMan);
            })
            $("#editBtn").click(function () {
                if (!$("#edit_name").val()) {
                    $("#edit_name").focus();
                } else if (!$("#edit_chargeman").val()) {
                    $("#edit_chargeman").focus();
                } else {
                    $.post("/dept/" + id + "/edit", $("#editForm").serialize()).done(function (result) {
                        if (result == "success") {
                            $("#editDeptModal").modal("hide");
                            alert("修改成功.");
                            location.href = "/dept";
                        }
                    }).fail(function () {
                        alert("服务器出错,修改失败");
                    })
                }
            }).fail(function () {
                alert("服务器出错,找不到该用户信息");
            })
        })
    })
</script>
</body>
</html>