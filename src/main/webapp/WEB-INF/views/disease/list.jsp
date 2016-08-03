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
    <link rel="stylesheet" href="/static/plugins/datatable/css/dataTables.bootstrap.min.css">
</head>
<body>

<jsp:include page="../include/topbar.jsp">
    <jsp:param name="menu" value="home"/>
</jsp:include>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">
            <c:if test="${not empty message}">
                <c:choose>
                    <c:when test="${message.state=='success'}">
                        <div class="alert alert-success">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                            </button>
                                ${message.message}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info alert-dismissable">
                            <button type="button" class="close" data-dismiss="alert"
                                    aria-hidden="true">
                                &times;
                            </button>
                                ${message.message}
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:if>

            <div class="box">
                <div class="box-header">
                    <span class="title"><i class="fa fa-search"></i> 搜索</span>
                </div>
                <div class="box-body search-box">
                    <form method="get" class="form-search">
                        <input type="text" name="keyWord" placeholder="疾病名称或所属科室">
                        <select id="ks" name="dept.id">
                            <option value="">所属科室</option>
                            <c:forEach items="${deptList}" var="dept">
                                <option value="${dept.id}">${dept.deptname}</option>
                            </c:forEach>
                        </select>
                        <button class="button button-pill button-flat-primary"><i class="fa fa-search"></i> 搜索</button>
                    </form>

                </div>
            </div>

            <div class="box">
                <div class="box-header">
                    <span class="title"><i class="fa fa-medkit"></i> 病种列表</span>
                    <a href="javascript:;" style="color: white" class="pull-right" id="newDisease"><i
                            class="fa fa-plus"></i> 新建</a>
                </div>
                <div class="box-body">
                    <table class="table" id="diseaseTable">
                        <thead>
                        <tr>
                            <th width="200">疾病名称</th>
                            <th width="200">所属科室</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>
<div class="modal fade" id="newDiseaseModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增病种</h4>
            </div>
            <div class="modal-body">
                <form id="saveForm" method="post">
                    <div class="form-group">
                        <label>病种名称</label>
                        <div>
                            <input type="text" autofocus name="illness" id="save_illness" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>所属科室</label>
                        <select name="dept.id" class="form-control">
                            <c:forEach items="${deptList}" var="dept">
                                <option class="${dept.deptname=='外科'?'selected':''}" value="${dept.id}">${dept.deptname}</option>
                            </c:forEach>
                        </select>
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
<div class="modal fade" id="editDiseaseModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">编辑病种</h4>
            </div>
            <div class="modal-body">
                <form id="editForm" method="post">
                    <input name="id" id="edit_id" type="hidden">
                    <div class="form-group">
                        <label>病种名称</label>
                        <div>
                            <input type="text" autofocus name="illness" id="edit_illness" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>所属科室</label>
                        <select name="dept.id" id="edit_deptid" class="form-control">
                            <c:forEach items="${deptList}" var="dept">
                                <option class="${dept.deptname=='外科'?'selected':''}" value="${dept.id}">${dept.deptname}</option>
                            </c:forEach>
                        </select>
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
<script src="/static/plugins/datatable/js/jquery.dataTables.min.js"></script>
<script src="/static/plugins/datatable/js/dataTables.bootstrap.js"></script>
<script>
    $(function () {
        $("#diseaseTable").DataTable({
            "lengthMenu": [5, 10, 15, 20], //定义每页显示的数量列表
            "ordering": false,//指定默认排序方式
            "serverSide": true, //表示所有的操作都在服务端进行
            "ajax": "/disease/list.json",
            "searching": false,
            "columns": [
                {"data": "illness"},
                {"data": "dept.deptname"},
                {
                    "data": function (row) {
                        return "<button class='btn btn-info editLink' rel='" + row.id + "'>编辑</button><button class='btn btn-danger delLink' style='margin-left:10px' rel='" + row.id + "'>删除</button>";
                    }
                }
            ],
            "language": { //定义中文
                "zeroRecords": "没有匹配的数据",
                "lengthMenu": "显示 _MENU_ 条数据",
                "info": "显示从 _START_ 到 _END_ 条数据 共 _TOTAL_ 条数据",
                "infoFiltered": "(从 _MAX_ 条数据中过滤得来)",
                "loadingRecords": "加载中...",
                "processing": "处理中...",
                "paginate": {
                    "first": "首页",
                    "last": "末页",
                    "next": "下一页",
                    "previous": "上一页"
                },
                "infoEmpty": "没有获取到数据"
            }
        })
        $("#newDisease").click(function(){
            $("#newDiseaseModal").modal({
                show:true,
                backdrop:"static",
                keyboard:false
            })
        })
        $("#saveBtn").click(function(){
            if (!$("#save_illness").val()){
                $("#save_illness").focus();
                return;
            }
            $("#saveForm").submit();
        })
        $(document).delegate(".delLink","click",function(){
            var id = $(this).attr("rel");
            alert(id);
            if (confirm("是否确认删除?")){
                $.get("/disease/"+id+"/del").done(function(data){
                    if(data=="success"){
                        alert("删除成功.");
                        window.location.reload();
                    }
                }).fail(function(){
                    alert("删除失败.");
                })
            }
        })
        $(document).delegate(".editLink","click",function(){
            $("#editDiseaseModal").modal({
                show:true,
                backdrop:"static",
                keyboard:true
            })
            var id = $(this).attr("rel");
            $.get("/disease/"+id).done(function(result){
                $("#edit_id").val(result.data.id);
                $("#edit_deptid").val(result.data.dept.id);
                $("#edit_illness").val(result.data.illness);
            }).fail(function(){
                alert("服务器出错,查找失败.");
            })
        })
        $("#editBtn").click(function(){
            if(!$("#edit_illness").val()){
                $("#edit_illness").focus();
                return;
            }
            $("#editForm").submit();
        })
    })
</script>
</body>
</html>