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
    <jsp:param name="menu" value="patient"/>
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
                        <input type="text" name="name" placeholder="姓名">
                        <input type="text" name="idcard" placeholder="身份证号码">
                        <input type="text" name="telphone" placeholder="电话">
                        <button class="button button-pill button-flat-primary"><i class="fa fa-search"></i> 搜索</button>
                    </form>

                </div>
            </div>

            <div class="box">
                <div class="box-header">
                    <span class="title"><i class="fa fa-medkit"></i> 客户列表</span>
                    <a href="/patient/new" style="color: white" class="pull-right" id="newDisease"><i
                            class="fa fa-plus"></i> 新建</a>
                </div>
                <div class="box-body">
                    <table class="table" id="patientTable">
                        <thead>
                        <tr>
                            <th width="100">姓名</th>
                            <th width="100">性别</th>
                            <th width="200">电话</th>
                            <th width="100">医保类型</th>
                            <th width="350">地址</th>
                            <th width="100">状态</th>
                            <th width="100">创建日期</th>
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


<script src="/static/js/jQuery-2.2.0.min.js"></script>
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script src="/static/plugins/datatable/js/jquery.dataTables.min.js"></script>
<script src="/static/plugins/datatable/js/dataTables.bootstrap.js"></script>
<script>
    $(function () {
        var dataTable = $("#patientTable").DataTable({
            "lengthMenu": [5, 10, 15, 20], //定义每页显示的数量列表
            "ordering": false,//指定默认排序方式
            "serverSide": true, //表示所有的操作都在服务端进行
            "ajax": "/patient/list.json",
            "searching": false,
            "columns": [
                {"data": function(row){
                    return "<a href='/patient/"+row.id+"'><h4 class='text-info'><strong>"+row.name+"</strong></h4></a>";
                }},
                {"data": "sex"},
                {"data": "telphone"},
                {"data": "insurance.type"},
                {"data": "address"},
                {"data": "state"},
                {"data": function(row){
                    return row.creattime.substring(0,10);
                }},
//                {
//                    "data": function (row) {
//                        return row.substring(0, 10)
//                    }
//                },
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
    })
</script>
</body>
</html>