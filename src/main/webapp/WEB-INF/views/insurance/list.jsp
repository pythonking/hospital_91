<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                    <span class="title"><i class="fa fa-bars"></i> 医保类型列表</span>
                       <a href="javascript:;" id="newInsurance" class="pull-right" style="color: white"><i class="fa fa-plus"></i> 新建</a>
                </div>
                <div class="box-body">
                    <table class="table">
                        <thead>
                        <tr>
                            <th width="200">医保类型名称</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${insuranceList}" var="insurance">
                            <tr>
                                <th>${insurance.type}</th>
                                <th>
                                    <a class="editLink" rel="${insurance.id}" href="javascript:;">修改</a>
                                    <a class="delLink" rel="${insurance.id}" href="javascript:;">删除</a>
                                </th>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="newInsuranceModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增医保类型</h4>
            </div>
            <div class="modal-body">
                <form id="saveForm" method="post" action="/insurance">
                    <div class="form-group">
                        <label>医保类型</label>
                        <div>
                            <input type="text" name="type" autofocus id="save_type" class="form-control">
                        </div>
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
<div class="modal fade" id="editInsuranceModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">编辑医保类型</h4>
            </div>
            <div class="modal-body">
                <form id="editForm" method="post" action="/insurance/edit">
                    <input id="edit_id" name="id" type="hidden">
                    <div class="form-group">
                        <label>医保类型</label>
                        <div>
                            <input type="text" name="type" autofocus id="edit_type" class="form-control">
                        </div>
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="editBtn">保存</button>
                </div>
            </div>

        </div>
    </div>
</div>
<script src="/static/js/jQuery-2.2.0.min.js"></script>
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script>
    $(function(){
        $(document).delegate(".delLink","click",function(){
            var id = $(this).attr("rel")
            if (confirm("是否确认删除?")){
                window.location.href="/insurance/"+id+"/del"
            }
        })
        $(document).delegate(".editLink","click",function(){
            var id = $(this).attr("rel");
            $("#editInsuranceModal").modal({
                show:true,
                backdrop:"static",
                keyboard:false
            })
            $.get("/insurance/"+id).done(function(result){
                $("#edit_id").val(result.data.id);
                $("#edit_type").val(result.data.type);
            })

        })
        $("#editBtn").click(function(){
            if(!$("#edit_type").val()){
                $("#edit_type").focus();
                return;
            }
            $("#editForm").submit();
            $("#editInsuranceModal").modal("hide");
        })
        $("#newInsurance").click(function(){
            $("#saveForm")[0].reset();
            $("#newInsuranceModal").modal({
                show:true,
                backdrop:"static",
                keyboard:false
            })
        })
        $("#saveBtn").click(function(){
            if(!$("#save_type").val()){
                $("#save_type").focus();
                return;
            }
            $("#saveForm").submit();
            $("#newInsuranceModal").modal("hide");
        })
    })
</script>
</body>
</html>